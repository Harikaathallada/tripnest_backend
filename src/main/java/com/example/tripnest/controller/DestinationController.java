package com.example.tripnest.controller;

import com.example.tripnest.dto.DestinationDTO;
import com.example.tripnest.service.DestinationService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/destinations")
@RequiredArgsConstructor
@CrossOrigin(origins = {"http://localhost:5173", "http://localhost:3000"})
public class DestinationController {

    private final DestinationService destinationService;

    @GetMapping
    public ResponseEntity<List<DestinationDTO>> getAll(
            @RequestParam(required = false) String region) {
        if (region != null && !region.isBlank()) {
            return ResponseEntity.ok(destinationService.getByRegion(region));
        }
        return ResponseEntity.ok(destinationService.getAllDestinations());
    }
}
