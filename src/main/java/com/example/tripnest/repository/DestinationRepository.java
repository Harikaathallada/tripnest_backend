package com.example.tripnest.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.tripnest.model.Destination;

public interface DestinationRepository extends JpaRepository<Destination, Long> {
    Optional<Destination> findByNameIgnoreCase(String name);
    List<Destination> findByRegionIgnoreCase(String region);
}
