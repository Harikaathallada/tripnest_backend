# TripNest – Spring Boot Backend

## Tech Stack
- Java 17
- Spring Boot 3
- Spring Data JPA (Hibernate)
- MySQL 8+
- Lombok

---

## Setup Instructions

### 1. Create the MySQL database
Open MySQL Workbench or any MySQL client and run:

```sql
CREATE DATABASE tripnest_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

Then run the full seed script:
```
src/main/resources/schema.sql
```

This creates all tables and inserts 26 destinations + 200+ attractions.

---

### 2. Configure database credentials
Edit `src/main/resources/application.properties`:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/tripnest_db?useSSL=false&serverTimezone=UTC
spring.datasource.username=root
spring.datasource.password=YOUR_PASSWORD_HERE
```

---

### 3. Run the application
```bash
./mvnw spring-boot:run
```

The API will start on **http://localhost:8080**

---

## API Endpoints

| Method | URL                          | Description                  |
|--------|------------------------------|------------------------------|
| GET    | `/api/destinations`          | Get all destinations         |
| GET    | `/api/destinations?region=North` | Filter by region         |
| POST   | `/api/itinerary/generate`    | Generate a trip itinerary    |

### POST /api/itinerary/generate

**Request body:**
```json
{
  "destination": "Jaipur",
  "startDate": "2025-12-01",
  "endDate": "2025-12-04"
}
```

**Response:**
```json
{
  "destination": "Jaipur",
  "region": "North",
  "startDate": "2025-12-01",
  "endDate": "2025-12-04",
  "durationDays": 3,
  "days": [
    {
      "dayNumber": 1,
      "date": "2025-12-01",
      "theme": "Arrival & Highlights",
      "activities": [
        {
          "name": "Amber Fort",
          "description": "...",
          "type": "fort",
          "emoji": "🏯",
          "suggestedTime": "9:00 AM",
          "durationMins": 120
        }
      ]
    }
  ]
}
```

---

## CORS
The backend allows requests from `http://localhost:5173` (Vite) and `http://localhost:3000`.
To change allowed origins, edit `src/main/java/com/example/tripnest/config/WebConfig.java`.

---

## Project Structure
```
src/main/java/com/example/tripnest/
├── TripnestApplication.java
├── config/
│   └── WebConfig.java
├── controller/
│   ├── DestinationController.java
│   └── ItineraryController.java
├── dto/
│   ├── DestinationDTO.java
│   ├── ItineraryRequest.java
│   └── ItineraryResponse.java
├── model/
│   ├── Attraction.java
│   ├── Destination.java
│   └── Itinerary.java
├── repository/
│   ├── AttractionRepository.java
│   ├── DestinationRepository.java
│   └── ItineraryRepository.java
└── service/
    ├── DestinationService.java
    └── ItineraryService.java
```
