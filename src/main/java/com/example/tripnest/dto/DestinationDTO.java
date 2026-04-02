package com.example.tripnest.dto;

import lombok.Builder;
import lombok.Data;
import java.util.List;

@Data
@Builder
public class DestinationDTO {
    private Long id;
    private String name;
    private String region;
    private String state;
    private String description;
    private List<String> tags;
    private String emoji;
    private List<Integer> bestMonths;
}
