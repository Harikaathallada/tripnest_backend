package com.example.tripnest.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.tripnest.model.Attraction;

public interface AttractionRepository extends JpaRepository<Attraction, Long> {
    List<Attraction> findByDestinationIdOrderByPopularityRankAsc(Long destinationId);
}
