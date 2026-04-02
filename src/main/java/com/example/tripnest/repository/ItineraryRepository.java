package com.example.tripnest.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.tripnest.model.Itinerary;

public interface ItineraryRepository extends JpaRepository<Itinerary, Long> {
    List<Itinerary> findTop10ByOrderByCreatedAtDesc();
}
