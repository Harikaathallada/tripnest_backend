package com.example.tripnest.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "destinations")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Destination {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String name;

    @Column(nullable = false)
    private String region; // North, South, East, West, Central

    @Column(nullable = false)
    private String state;

    @Column(length = 500)
    private String description;

    private String tags;         // comma-separated, e.g. "Heritage,UNESCO"
    private String emoji;
    private String bestMonths;   // comma-separated months, e.g. "10,11,12,1,2,3"
}
