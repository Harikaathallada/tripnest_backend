package com.example.tripnest.service;

import com.example.tripnest.dto.DestinationDTO;
import com.example.tripnest.model.Destination;
import com.example.tripnest.repository.DestinationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class DestinationService {

    private final DestinationRepository destinationRepo;

    public List<DestinationDTO> getAllDestinations() {
        return destinationRepo.findAll().stream()
            .map(this::toDTO)
            .collect(Collectors.toList());
    }

    public List<DestinationDTO> getByRegion(String region) {
        return destinationRepo.findByRegionIgnoreCase(region).stream()
            .map(this::toDTO)
            .collect(Collectors.toList());
    }

    private DestinationDTO toDTO(Destination d) {
        List<String> tags = (d.getTags() == null || d.getTags().isBlank())
            ? List.of()
            : Arrays.stream(d.getTags().split(",")).map(String::trim).collect(Collectors.toList());

        List<Integer> bestMonths = (d.getBestMonths() == null || d.getBestMonths().isBlank())
            ? List.of()
            : Arrays.stream(d.getBestMonths().split(","))
                .map(String::trim).map(Integer::parseInt).collect(Collectors.toList());

        return DestinationDTO.builder()
            .id(d.getId())
            .name(d.getName())
            .region(d.getRegion())
            .state(d.getState())
            .description(d.getDescription())
            .tags(tags)
            .emoji(d.getEmoji())
            .bestMonths(bestMonths)
            .build();
    }
}
