package com.example.tripnest.dto;

import lombok.Data;
import java.time.LocalDate;

@Data
public class ItineraryRequest {
    private String destination;
    private LocalDate startDate;
    private LocalDate endDate;
}
