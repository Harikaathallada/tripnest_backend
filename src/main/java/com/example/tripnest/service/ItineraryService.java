package com.example.tripnest.service;

import com.example.tripnest.dto.ItineraryRequest;
import com.example.tripnest.dto.ItineraryResponse;
import com.example.tripnest.dto.ItineraryResponse.ActivityDTO;
import com.example.tripnest.dto.ItineraryResponse.DayPlan;
import com.example.tripnest.model.Attraction;
import com.example.tripnest.model.Destination;
import com.example.tripnest.model.Itinerary;
import com.example.tripnest.repository.AttractionRepository;
import com.example.tripnest.repository.DestinationRepository;
import com.example.tripnest.repository.ItineraryRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class ItineraryService {

    private static final int MAX_ACTIVITIES_PER_DAY = 4;
    private static final int MIN_TRIP_DAYS = 2;
    private static final int MAX_TRIP_DAYS = 5;

    // Suggested time slots per activity slot index
    private static final String[] TIME_SLOTS = {
        "9:00 AM", "11:30 AM", "2:00 PM", "4:30 PM"
    };

    private final DestinationRepository destinationRepo;
    private final AttractionRepository attractionRepo;
    private final ItineraryRepository itineraryRepo;
    private final ObjectMapper objectMapper;

    /**
     * Generate a day-by-day itinerary for the given request.
     */
    public ItineraryResponse generate(ItineraryRequest req) {
        // Validate dates
        long days = ChronoUnit.DAYS.between(req.getStartDate(), req.getEndDate());
        if (days < MIN_TRIP_DAYS || days > MAX_TRIP_DAYS) {
            throw new IllegalArgumentException(
                "Trip duration must be between " + MIN_TRIP_DAYS + " and " + MAX_TRIP_DAYS + " days. Got: " + days);
        }

        // Resolve destination
        Destination destination = destinationRepo
            .findByNameIgnoreCase(req.getDestination())
            .orElseThrow(() -> new IllegalArgumentException(
                "Destination not found: " + req.getDestination()));

        // Load & filter attractions
        List<Attraction> all = attractionRepo.findByDestinationIdOrderByPopularityRankAsc(destination.getId());
        int travelMonth = req.getStartDate().getMonthValue();
        List<Attraction> suitable = filterBySeason(all, travelMonth);

        // Distribute attractions across days
        int intDays = (int) days;
        List<DayPlan> dayPlans = buildDayPlans(suitable, intDays, req.getStartDate());

        ItineraryResponse response = ItineraryResponse.builder()
            .destination(destination.getName())
            .region(destination.getRegion())
            .startDate(req.getStartDate())
            .endDate(req.getEndDate())
            .durationDays(intDays)
            .days(dayPlans)
            .build();

        // Persist the generated itinerary
        persist(destination, req.getStartDate(), req.getEndDate(), intDays, response);

        return response;
    }

    /**
     * Filter attractions that are suitable for the given travel month.
     * Attractions with empty goodForMonths are considered year-round.
     */
    private List<Attraction> filterBySeason(List<Attraction> attractions, int month) {
        return attractions.stream()
            .filter(a -> {
                String months = a.getGoodForMonths();
                if (months == null || months.isBlank()) return true;
                return Arrays.stream(months.split(","))
                    .map(String::trim)
                    .anyMatch(m -> m.equals(String.valueOf(month)));
            })
            .collect(Collectors.toList());
    }

    /**
     * Build day plans using geo-cluster grouping and time-slot assignment.
     */
    private List<DayPlan> buildDayPlans(List<Attraction> attractions, int days, LocalDate start) {
        // Group by cluster so nearby spots end up on the same day
        LinkedHashMap<String, List<Attraction>> clusters = new LinkedHashMap<>();
        for (Attraction a : attractions) {
            String cluster = (a.getCluster() == null || a.getCluster().isBlank()) ? "General" : a.getCluster();
            clusters.computeIfAbsent(cluster, k -> new ArrayList<>()).add(a);
        }

        // Flatten clusters into a day-aware list
        List<List<Attraction>> buckets = new ArrayList<>();
        for (int i = 0; i < days; i++) buckets.add(new ArrayList<>());

        // Fill buckets round-robin by cluster
        int dayIdx = 0;
        for (List<Attraction> clusterAttractions : clusters.values()) {
            for (Attraction a : clusterAttractions) {
                if (buckets.get(dayIdx).size() < MAX_ACTIVITIES_PER_DAY) {
                    buckets.get(dayIdx).add(a);
                } else {
                    dayIdx = (dayIdx + 1) % days;
                    buckets.get(dayIdx).add(a);
                }
            }
            dayIdx = (dayIdx + 1) % days;
        }

        // Convert buckets to DayPlan DTOs
        List<DayPlan> plans = new ArrayList<>();
        String[] dayThemes = {"Arrival & Highlights", "Deep Exploration", "Culture & Cuisine", "Hidden Gems", "Farewell & Leisure"};
        for (int i = 0; i < days; i++) {
            List<Attraction> dayAttractions = buckets.get(i);
            // Sort: morning → afternoon → evening within the day
            dayAttractions.sort(Comparator.comparing(a -> timeOfDayOrder(a.getBestTimeOfDay())));

            List<ActivityDTO> activities = new ArrayList<>();
            for (int j = 0; j < dayAttractions.size(); j++) {
                Attraction a = dayAttractions.get(j);
                activities.add(ActivityDTO.builder()
                    .name(a.getName())
                    .description(a.getDescription())
                    .type(a.getType())
                    .emoji(a.getEmoji() != null ? a.getEmoji() : "📍")
                    .suggestedTime(j < TIME_SLOTS.length ? TIME_SLOTS[j] : "")
                    .durationMins(a.getVisitDurationMins() > 0 ? a.getVisitDurationMins() : 60)
                    .build());
            }

            plans.add(DayPlan.builder()
                .dayNumber(i + 1)
                .date(start.plusDays(i))
                .theme(i < dayThemes.length ? dayThemes[i] : "Exploration")
                .activities(activities)
                .build());
        }
        return plans;
    }

    private int timeOfDayOrder(String tod) {
        if (tod == null) return 1;
        return switch (tod.toLowerCase()) {
            case "morning"   -> 0;
            case "afternoon" -> 1;
            case "evening"   -> 2;
            default          -> 1;
        };
    }

    private void persist(Destination dest, LocalDate start, LocalDate end, int days, ItineraryResponse response) {
        try {
            String json = objectMapper.writeValueAsString(response);
            Itinerary entity = Itinerary.builder()
                .destination(dest)
                .startDate(start)
                .endDate(end)
                .durationDays(days)
                .planJson(json)
                .build();
            itineraryRepo.save(entity);
        } catch (Exception ex) {
            log.warn("Could not persist itinerary: {}", ex.getMessage());
        }
    }
}
