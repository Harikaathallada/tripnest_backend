package com.example.tripnest.controller;

import com.example.tripnest.dto.ItineraryRequest;
import com.example.tripnest.dto.ItineraryResponse;
import com.example.tripnest.service.ItineraryService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/itinerary")
@RequiredArgsConstructor
@CrossOrigin(origins = {"http://localhost:5173", "http://localhost:3000"})
public class ItineraryController {

    private final ItineraryService itineraryService;

    @PostMapping("/generate")
    public ResponseEntity<?> generate(@RequestBody ItineraryRequest request) {
        try {
            ItineraryResponse response = itineraryService.generate(request);
            return ResponseEntity.ok(response);
        } catch (IllegalArgumentException ex) {
            return ResponseEntity.badRequest().body(Map.of("error", ex.getMessage()));
        }
    }
}
