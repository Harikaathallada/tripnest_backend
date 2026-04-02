package com.example.tripnest.dto;

import lombok.Builder;
import lombok.Data;
import java.time.LocalDate;
import java.util.List;

@Data
@Builder
public class ItineraryResponse {
    private Long id;
    private String destination;
    private String region;
    private LocalDate startDate;
    private LocalDate endDate;
    private int durationDays;
    private List<DayPlan> days;

    @Data
    @Builder
    public static class DayPlan {
        private int dayNumber;
        private LocalDate date;
        private String theme;
        private List<ActivityDTO> activities;
    }

    @Data
    @Builder
    public static class ActivityDTO {
        private String name;
        private String description;
        private String type;
        private String emoji;
        private String suggestedTime;   // e.g. "9:00 AM"
        private int durationMins;
    }
}
