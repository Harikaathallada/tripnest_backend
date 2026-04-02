-- ================================================================
--  TripNest Database Schema + Seed Data
--  Database: tripnest_db
--  Run this file ONCE before starting the Spring Boot application
-- ================================================================

CREATE DATABASE IF NOT EXISTS tripnest_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE tripnest_db;

-- ── DESTINATIONS ────────────────────────────────────────────────
DROP TABLE IF EXISTS attractions;
DROP TABLE IF EXISTS itineraries;
DROP TABLE IF EXISTS destinations;

CREATE TABLE destinations (
  id          BIGINT AUTO_INCREMENT PRIMARY KEY,
  name        VARCHAR(100) NOT NULL UNIQUE,
  region      VARCHAR(50)  NOT NULL,
  state       VARCHAR(100) NOT NULL,
  description VARCHAR(500),
  tags        VARCHAR(200),
  emoji       VARCHAR(10),
  best_months VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ── ATTRACTIONS ─────────────────────────────────────────────────
CREATE TABLE attractions (
  id                  BIGINT AUTO_INCREMENT PRIMARY KEY,
  name                VARCHAR(200) NOT NULL,
  description         VARCHAR(500),
  type                VARCHAR(50),
  emoji               VARCHAR(10),
  visit_duration_mins INT DEFAULT 60,
  popularity_rank     INT DEFAULT 99,
  cluster             VARCHAR(100),
  best_time_of_day    VARCHAR(20),
  good_for_months     VARCHAR(50),
  destination_id      BIGINT NOT NULL,
  FOREIGN KEY (destination_id) REFERENCES destinations(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ── ITINERARIES ─────────────────────────────────────────────────
CREATE TABLE itineraries (
  id             BIGINT AUTO_INCREMENT PRIMARY KEY,
  destination_id BIGINT NOT NULL,
  start_date     DATE   NOT NULL,
  end_date       DATE   NOT NULL,
  duration_days  INT    NOT NULL,
  plan_json      TEXT,
  created_at     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (destination_id) REFERENCES destinations(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ================================================================
--  SEED: DESTINATIONS
-- ================================================================
INSERT INTO destinations (name, region, state, description, tags, emoji, best_months) VALUES
-- North India
('Agra',       'North', 'Uttar Pradesh',  'Home of the iconic Taj Mahal and grand Mughal-era monuments.',           'Heritage,UNESCO,Mughal',       '🕌', '10,11,12,1,2,3'),
('Jaipur',     'North', 'Rajasthan',      'The Pink City — palaces, forts, vibrant bazaars and royal history.',     'Royalty,Culture,Forts',        '🏯', '10,11,12,1,2,3'),
('Delhi',      'North', 'Delhi',          'India\'s capital blends ancient monuments with a buzzing modern city.',  'Metro,History,Food',           '🕍', '10,11,12,1,2,3'),
('Varanasi',   'North', 'Uttar Pradesh',  'The spiritual heart of India, on the banks of the sacred Ganga.',       'Spiritual,Ghats,Pilgrimage',   '🪔', '10,11,12,1,2,3'),
('Shimla',     'North', 'Himachal Pradesh','Colonial hill station with stunning Himalayan views and cool air.',     'Hills,Heritage,Nature',        '🏔️', '3,4,5,6,9,10,11'),
('Manali',     'North', 'Himachal Pradesh','Adventure hub for trekking, river rafting, and snowy Himalayan peaks.', 'Adventure,Snow,Nature',       '❄️', '4,5,6,9,10'),
('Amritsar',   'North', 'Punjab',         'Golden Temple city — a spiritual and cultural landmark of Punjab.',      'Spiritual,Culture,Sikh',       '🛕', '10,11,12,1,2,3'),
('Rishikesh',  'North', 'Uttarakhand',    'Yoga capital of the world with white-water rafting on the Ganga.',      'Yoga,Adventure,Spiritual',     '🌊', '2,3,4,5,9,10,11'),

-- South India
('Goa',        'South', 'Goa',            'Sun-kissed beaches, historic forts, and vibrant nightlife.',             'Beach,Forts,Nightlife',        '🏖️', '11,12,1,2,3'),
('Munnar',     'South', 'Kerala',         'Rolling tea gardens and misty peaks in the Western Ghats.',             'Nature,Tea,Hills',             '🌿', '9,10,11,12,1,2'),
('Ooty',       'South', 'Tamil Nadu',     'The Queen of Hill Stations — lakes, botanical gardens, and cool air.',  'Hills,Nature,Gardens',         '🌸', '3,4,5,9,10,11'),
('Mysore',     'South', 'Karnataka',      'City of palaces, sandalwood, and the grand Dasara festival.',           'Royalty,Culture,Palaces',      '👑', '9,10,11,12,1,2,3'),
('Hampi',      'South', 'Karnataka',      'UNESCO World Heritage ruined city of the Vijayanagara Empire.',         'Heritage,UNESCO,Ruins',        '🏛️', '10,11,12,1,2,3'),
('Pondicherry','South', 'Puducherry',     'French colonial charm meets Tamil culture on the Coromandel Coast.',    'Colonial,Beach,Culture',       '🥐', '10,11,12,1,2,3'),
('Alleppey',   'South', 'Kerala',         'Backwater houseboats, rice paddies, and serene canals.',                'Backwaters,Nature,Houseboat',  '🚤', '9,10,11,12,1,2'),
('Coorg',      'South', 'Karnataka',      'Coffee hills, waterfalls, and misty forests of South India.',           'Nature,Coffee,Hills',          '☕', '9,10,11,12,1,2'),

-- East India
('Darjeeling', 'East',  'West Bengal',    'Tea gardens at sunrise, Kanchenjunga views, and the toy train.',        'Tea,Hills,Scenic',             '🍵', '3,4,5,9,10,11'),
('Kolkata',    'East',  'West Bengal',    'The City of Joy — art, literature, food, and colonial grandeur.',       'Culture,Art,Food',             '🎭', '10,11,12,1,2,3'),
('Puri',       'East',  'Odisha',         'Sacred Jagannath Temple and the golden shores of the Bay of Bengal.',   'Spiritual,Beach,Temple',       '🌅', '10,11,12,1,2,3'),
('Gangtok',    'East',  'Sikkim',         'Mountain town with Buddhist monasteries and panoramic Himalayan vistas.','Hills,Buddhist,Scenic',       '🏔️', '3,4,5,9,10,11'),

-- West India
('Mumbai',     'West',  'Maharashtra',    'India\'s maximum city — Bollywood, colonial heritage, and street food.', 'Metro,Bollywood,Food',        '🌆', '10,11,12,1,2,3'),
('Udaipur',    'West',  'Rajasthan',      'The City of Lakes — romantic palaces, vibrant culture, and sunset views.','Royalty,Lakes,Romance',      '🏰', '9,10,11,12,1,2,3'),
('Pushkar',    'West',  'Rajasthan',      'Holy lake town famous for its Brahma temple and camel fair.',            'Spiritual,Desert,Culture',    '🐪', '9,10,11,12,1,2'),
('Ajanta-Ellora','West','Maharashtra',    'UNESCO rock-cut caves with stunning Buddhist, Hindu, and Jain art.',     'Heritage,UNESCO,Caves',       '🪨', '10,11,12,1,2,3'),

-- Central India
('Khajuraho',  'Central','Madhya Pradesh','UNESCO temples famous for intricate medieval sculptures and carvings.',  'Heritage,UNESCO,Temples',     '🛕', '10,11,12,1,2,3'),
('Pachmarhi',  'Central','Madhya Pradesh','Only hill station of MP, with waterfalls, caves, and dense forests.',   'Nature,Hills,Adventure',      '🌲', '10,11,12,1,2,3');

-- ================================================================
--  SEED: ATTRACTIONS
-- ================================================================

-- ── AGRA ────────────────────────────────────────────────────────
SET @agra = (SELECT id FROM destinations WHERE name = 'Agra');
INSERT INTO attractions (name, description, type, emoji, visit_duration_mins, popularity_rank, cluster, best_time_of_day, good_for_months, destination_id) VALUES
('Taj Mahal',          'One of the Seven Wonders of the World, this ivory-white marble mausoleum is a masterpiece of Mughal architecture.', 'monument', '🕌', 120, 1,  'Central Agra', 'morning',   '', @agra),
('Agra Fort',          'A UNESCO-listed red sandstone fort that served as the main residence of the Mughal emperors.',                       'fort',     '🏯', 90,  2,  'Central Agra', 'afternoon', '', @agra),
('Mehtab Bagh',        'Moonlit gardens across the river offering the best sunset view of the Taj Mahal.',                                   'garden',   '🌿', 60,  3,  'Riverfront',   'evening',   '', @agra),
('Fatehpur Sikri',     'A perfectly preserved Mughal ghost city declared a UNESCO World Heritage Site.',                                     'heritage', '🏛️', 120, 4,  'Outskirts',    'morning',   '', @agra),
('Itmad-ud-Daulah',    'Called the "Baby Taj", this jewel-box mausoleum is the first Mughal structure built entirely in marble.',            'monument', '✨', 60,  5,  'Riverfront',   'afternoon', '', @agra),
('Kinari Bazaar',      'Agra\'s oldest market famous for marble inlay work, leather goods, and the famous Agra petha sweet.',               'market',   '🛍️', 60,  6,  'Central Agra', 'afternoon', '', @agra);

-- ── JAIPUR ──────────────────────────────────────────────────────
SET @jaipur = (SELECT id FROM destinations WHERE name = 'Jaipur');
INSERT INTO attractions (name, description, type, emoji, visit_duration_mins, popularity_rank, cluster, best_time_of_day, good_for_months, destination_id) VALUES
('Amber Fort',         'Majestic hilltop fort overlooking Maota Lake, famous for its artistic Hindu style elements.',                        'fort',     '🏯', 120, 1,  'North Jaipur', 'morning',   '', @jaipur),
('City Palace',        'A stunning blend of Mughal and Rajput architecture, still home to the royal family of Jaipur.',                     'palace',   '🏰', 90,  2,  'Walled City',  'morning',   '', @jaipur),
('Hawa Mahal',         'The iconic Palace of Winds with 953 windows, built for royal ladies to observe street festivals.',                   'palace',   '👁️', 45,  3,  'Walled City',  'morning',   '', @jaipur),
('Nahargarh Fort',     'Hillside fort with panoramic views of the Pink City and a stunning sunset backdrop.',                               'fort',     '🌅', 90,  4,  'North Jaipur', 'evening',   '', @jaipur),
('Jantar Mantar',      'UNESCO-listed astronomical observatory with massive stone instruments built in the 18th century.',                   'heritage', '🔭', 60,  5,  'Walled City',  'morning',   '', @jaipur),
('Albert Hall Museum', 'The oldest museum of Rajasthan displaying a rich collection of art, carpets, ivory, and crystal.',                  'museum',   '🏛️', 75,  6,  'Central',      'afternoon', '', @jaipur),
('Jal Mahal',          'The "Water Palace" appears to float on the Man Sagar Lake — best admired from the shore.',                         'palace',   '💧', 45,  7,  'Central',      'evening',   '', @jaipur),
('Johri Bazaar',       'Jaipur\'s premier jewellery market famous for Kundan, Meenakari, and gemstone work.',                              'market',   '💎', 60,  8,  'Walled City',  'afternoon', '', @jaipur);

-- ── DELHI ───────────────────────────────────────────────────────
SET @delhi = (SELECT id FROM destinations WHERE name = 'Delhi');
INSERT INTO attractions (name, description, type, emoji, visit_duration_mins, popularity_rank, cluster, best_time_of_day, good_for_months, destination_id) VALUES
('Red Fort',           'UNESCO-listed Mughal fortress on the banks of the Yamuna, symbol of India\'s sovereignty.',                        'fort',     '🏯', 90,  1,  'Old Delhi',    'morning',   '', @delhi),
('Qutub Minar',        'UNESCO-listed 73-metre minaret, the tallest brick minaret in the world, built in 1193.',                           'monument', '🗼', 75,  2,  'South Delhi',  'morning',   '', @delhi),
("Humayun's Tomb",     'A UNESCO World Heritage garden-tomb that inspired the design of the Taj Mahal.',                                   'monument', '🕌', 90,  3,  'Central Delhi','morning',   '', @delhi),
('India Gate',         'War memorial arch commemorating 82,000 soldiers of the Indian Army who died in World War I.',                      'monument', '🏛️', 45,  4,  'Central Delhi','evening',   '', @delhi),
('Jama Masjid',        'India\'s largest mosque, built by Mughal Emperor Shah Jahan, accommodating 25,000 worshippers.',                  'mosque',   '🕌', 60,  5,  'Old Delhi',    'morning',   '', @delhi),
('Chandni Chowk',      'One of the oldest and busiest markets in Delhi, famous for street food, spices, and textiles.',                   'market',   '🛒', 90,  6,  'Old Delhi',    'morning',   '', @delhi),
('Lotus Temple',       'A Bahai House of Worship shaped like a blooming lotus, welcoming people of all faiths.',                          'temple',   '🪷', 60,  7,  'South Delhi',  'afternoon', '', @delhi),
('Hauz Khas Village',  'Medieval water tank complex surrounded by trendy cafes, boutiques, and a deer park.',                             'heritage', '☕', 75,  8,  'South Delhi',  'afternoon', '', @delhi);

-- ── VARANASI ────────────────────────────────────────────────────
SET @varanasi = (SELECT id FROM destinations WHERE name = 'Varanasi');
INSERT INTO attractions (name, description, type, emoji, visit_duration_mins, popularity_rank, cluster, best_time_of_day, good_for_months, destination_id) VALUES
('Dashashwamedh Ghat', 'The main ghat of Varanasi where the spectacular Ganga Aarti ceremony takes place every evening.',                 'ghat',     '🪔', 90,  1,  'Main Ghats',   'evening',   '', @varanasi),
('Kashi Vishwanath',   'One of the twelve Jyotirlinga temples, dedicated to Lord Shiva and the holiest temple in Varanasi.',             'temple',   '🛕', 60,  2,  'Old City',     'morning',   '', @varanasi),
('Assi Ghat',          'Southernmost and most popular ghat, where the Assi River meets the Ganga.',                                      'ghat',     '🌅', 60,  3,  'South Ghats',  'morning',   '', @varanasi),
('Sarnath',            'Buddhist archaeological site where the Buddha delivered his first sermon after attaining enlightenment.',         'heritage', '☮️', 90,  4,  'Outskirts',    'morning',   '', @varanasi),
('Manikarnika Ghat',   'The most sacred of Varanasi\'s ghats, where cremations have taken place continuously for centuries.',            'ghat',     '🔥', 45,  5,  'Main Ghats',   'morning',   '', @varanasi),
('Boat Ride on Ganga', 'A sunrise boat ride along the ghats is the most iconic Varanasi experience.',                                    'activity', '🚣', 60,  6,  'Main Ghats',   'morning',   '', @varanasi),
('Tulsi Manas Temple', 'A white marble temple where the Hindi epic Ramcharitmanas was composed by poet Tulsidas.',                       'temple',   '📜', 45,  7,  'Old City',     'afternoon', '', @varanasi),
('BHU Vishwanath',     'A grand temple inside Banaras Hindu University campus — excellent example of modern Hindu architecture.',         'temple',   '🏛️', 60,  8,  'South',        'afternoon', '', @varanasi);

-- ── GOA ─────────────────────────────────────────────────────────
SET @goa = (SELECT id FROM destinations WHERE name = 'Goa');
INSERT INTO attractions (name, description, type, emoji, visit_duration_mins, popularity_rank, cluster, best_time_of_day, good_for_months, destination_id) VALUES
('Calangute Beach',    'The largest beach in Goa, known as the "Queen of Beaches" with water sports and beach shacks.',                  'beach',    '🏖️', 120, 1,  'North Goa',    'morning',   '11,12,1,2,3', @goa),
('Fort Aguada',        'A well-preserved 17th-century Portuguese fort overlooking the Arabian Sea.',                                     'fort',     '🏯', 60,  2,  'North Goa',    'afternoon', '11,12,1,2,3', @goa),
('Basilica of Bom Jesus','A UNESCO World Heritage Church housing the mortal remains of St. Francis Xavier.',                             'church',   '⛪', 60,  3,  'Old Goa',      'morning',   '', @goa),
('Anjuna Beach',       'Famous for its flea market and trance parties, with a backdrop of dramatic red laterite cliffs.',                'beach',    '🛍️', 90,  4,  'North Goa',    'afternoon', '11,12,1,2,3', @goa),
('Dudhsagar Falls',    'A spectacular four-tiered waterfall on the Mandovi River, surrounded by dense forest.',                         'waterfall','💧', 120, 5,  'East Goa',     'morning',   '10,11,12,1', @goa),
('Panjim Latin Quarter','Colourful Portuguese-era heritage houses, charming cafes, and the Fontainhas gallery quarter.',                 'heritage', '🎨', 75,  6,  'Panjim',       'afternoon', '', @goa),
('Vagator Beach',      'Dramatic cliffs and a crescent-shaped beach with stunning sunset views.',                                       'beach',    '🌅', 90,  7,  'North Goa',    'evening',   '11,12,1,2,3', @goa),
('Dona Paula',         'A scenic headland where the Mandovi and Zuari rivers meet the sea, with sailing views.',                        'viewpoint','👁️', 45,  8,  'South Goa',    'evening',   '', @goa);

-- ── MUNNAR ──────────────────────────────────────────────────────
SET @munnar = (SELECT id FROM destinations WHERE name = 'Munnar');
INSERT INTO attractions (name, description, type, emoji, visit_duration_mins, popularity_rank, cluster, best_time_of_day, good_for_months, destination_id) VALUES
('Tea Plantations',    'Endless carpets of green tea gardens stretching across misty Munnar hills.',                                     'nature',   '🌿', 90,  1,  'Central',      'morning',   '', @munnar),
('Eravikulam NP',      'National park home to the endangered Nilgiri Tahr and stunning mountain vistas.',                               'nature',   '🦌', 120, 2,  'North',        'morning',   '9,10,11,12,1,2', @munnar),
('Mattupetty Dam',     'Scenic reservoir surrounded by thick forests and tea gardens, popular for boating.',                            'lake',     '🚤', 75,  3,  'North',        'afternoon', '', @munnar),
('Echo Point',         'A beautiful lake where your voice echoes across the water — a must-visit natural wonder.',                      'nature',   '🔊', 45,  4,  'North',        'morning',   '', @munnar),
('Top Station',        'The highest point in Munnar offering breathtaking views of the Western Ghats.',                                 'viewpoint','🏔️', 60,  5,  'South',        'morning',   '', @munnar),
('Attukad Waterfalls', 'A picturesque waterfall set among tea gardens and spice plantations.',                                          'waterfall','💦', 60,  6,  'Central',      'morning',   '6,7,8,9,10', @munnar),
('Lockhart Gap',       'A windy mountain pass with sweeping views across the Munnar valley and Western Ghats.',                         'viewpoint','🌬️', 45,  7,  'West',         'afternoon', '', @munnar);

-- ── SHIMLA ──────────────────────────────────────────────────────
SET @shimla = (SELECT id FROM destinations WHERE name = 'Shimla');
INSERT INTO attractions (name, description, type, emoji, visit_duration_mins, popularity_rank, cluster, best_time_of_day, good_for_months, destination_id) VALUES
('The Ridge',          'The heart of Shimla — a large open space with panoramic Himalayan views and the Christ Church.',               'viewpoint','⛪', 60,  1,  'Central',      'morning',   '', @shimla),
('Mall Road',          'The iconic promenade of Shimla lined with colonial-era shops, restaurants, and cafes.',                       'market',   '🛍️', 60,  2,  'Central',      'afternoon', '', @shimla),
('Jakhu Temple',       'Ancient Hanuman temple atop Jakhu Hill (2455m), accessible by ropeway or trek.',                             'temple',   '🛕', 75,  3,  'East',         'morning',   '', @shimla),
('Kufri',              'Popular hill resort near Shimla with yak rides, snow activities, and the Himalayan Wildlife Zoo.',            'nature',   '❄️', 90,  4,  'Outskirts',    'morning',   '12,1,2,3', @shimla),
('Chadwick Falls',     'A 67-metre waterfall hidden within a thick forest near the Glen Forest.',                                    'waterfall','💧', 60,  5,  'West',         'afternoon', '7,8,9', @shimla),
('Kalka-Shimla Railway','UNESCO World Heritage toy train journey through 102 tunnels and stunning mountain scenery.',                 'heritage', '🚂', 240, 6,  'Outskirts',    'morning',   '', @shimla);

-- ── AMRITSAR ────────────────────────────────────────────────────
SET @amritsar = (SELECT id FROM destinations WHERE name = 'Amritsar');
INSERT INTO attractions (name, description, type, emoji, visit_duration_mins, popularity_rank, cluster, best_time_of_day, good_for_months, destination_id) VALUES
('Golden Temple',      'The holiest shrine in Sikhism — a breathtaking gilded gurdwara set in the middle of the Amrit Sarovar lake.',  'temple',   '🪙', 120, 1,  'Old City',     'morning',   '', @amritsar),
('Wagah Border',       'The spectacular daily flag-lowering ceremony at the India-Pakistan border — a patriotic spectacle.',          'heritage', '🇮🇳', 90,  2,  'Outskirts',    'evening',   '', @amritsar),
('Jallianwala Bagh',   'A public garden and memorial to the victims of the 1919 Jallianwala Bagh massacre.',                         'heritage', '🕊️', 60,  3,  'Old City',     'morning',   '', @amritsar),
('Durgiana Temple',    'A beautiful Sikh temple set in the middle of a sacred tank, resembling the Golden Temple.',                  'temple',   '🛕', 60,  4,  'Old City',     'morning',   '', @amritsar),
('Lawrence Road',      'Amritsar\'s bustling market for Punjabi suits, handicrafts, and the famous Amritsari kulcha.',              'market',   '🛒', 75,  5,  'Central',      'afternoon', '', @amritsar);

-- ── MYSORE ──────────────────────────────────────────────────────
SET @mysore = (SELECT id FROM destinations WHERE name = 'Mysore');
INSERT INTO attractions (name, description, type, emoji, visit_duration_mins, popularity_rank, cluster, best_time_of_day, good_for_months, destination_id) VALUES
('Mysore Palace',      'One of the most visited monuments in India — a stunning Indo-Saracenic royal palace.',                        'palace',   '👑', 120, 1,  'Central',      'morning',   '', @mysore),
('Chamundi Hills',     'Sacred hill with the Chamundeshwari Temple, giant Nandi statue, and panoramic city views.',                  'temple',   '🛕', 90,  2,  'South',        'morning',   '', @mysore),
('Brindavan Gardens',  'Musical dancing fountains and tiered gardens at the foot of the KRS Dam.',                                   'garden',   '💦', 90,  3,  'Outskirts',    'evening',   '', @mysore),
('Jaganmohan Palace',  'A 19th-century palace housing a stunning art gallery with Ravi Varma paintings.',                            'museum',   '🎨', 60,  4,  'Central',      'afternoon', '', @mysore),
('Devaraja Market',    'A century-old market overflowing with flowers, spices, incense, and local produce.',                        'market',   '🌸', 60,  5,  'Central',      'morning',   '', @mysore);

-- ── KOLKATA ─────────────────────────────────────────────────────
SET @kolkata = (SELECT id FROM destinations WHERE name = 'Kolkata');
INSERT INTO attractions (name, description, type, emoji, visit_duration_mins, popularity_rank, cluster, best_time_of_day, good_for_months, destination_id) VALUES
('Victoria Memorial',  'A magnificent marble building dedicated to Queen Victoria, now a museum of Indian colonial history.',         'monument', '🏛️', 90,  1,  'South',        'morning',   '', @kolkata),
('Howrah Bridge',      'The iconic cantilever bridge over the Hooghly — one of the busiest bridges in the world.',                  'monument', '🌉', 45,  2,  'Central',      'morning',   '', @kolkata),
('Dakshineswar Temple','Sprawling temple complex dedicated to goddess Kali, on the banks of the Hooghly river.',                    'temple',   '🛕', 90,  3,  'North',        'morning',   '', @kolkata),
('Indian Museum',      'The largest and oldest museum in India with impressive natural history and art collections.',               'museum',   '🏺', 90,  4,  'Central',      'morning',   '', @kolkata),
('New Market',         'A bustling Victorian-era covered market selling everything from saris to street food.',                     'market',   '🛍️', 75,  5,  'Central',      'afternoon', '', @kolkata),
('Park Street',        'Kolkata\'s cultural spine lined with restaurants, bookshops, and iconic eateries.',                         'heritage', '🍽️', 60,  6,  'South',        'evening',   '', @kolkata);

-- ── UDAIPUR ─────────────────────────────────────────────────────
SET @udaipur = (SELECT id FROM destinations WHERE name = 'Udaipur');
INSERT INTO attractions (name, description, type, emoji, visit_duration_mins, popularity_rank, cluster, best_time_of_day, good_for_months, destination_id) VALUES
('City Palace',        'The largest palace complex in Rajasthan, overlooking Lake Pichola with stunning lake views.',               'palace',   '🏰', 120, 1,  'Lakeside',     'morning',   '', @udaipur),
('Lake Pichola',       'A beautiful artificial lake with islands, palaces, and the famous Lake Palace hotel.',                      'lake',     '🚤', 90,  2,  'Lakeside',     'evening',   '', @udaipur),
('Jag Mandir',         'An island palace on Lake Pichola that served as a refuge for the Mughal Prince Khurram.',                  'palace',   '✨', 75,  3,  'Lakeside',     'afternoon', '', @udaipur),
('Saheliyon ki Bari',  'A beautiful garden built for royal ladies with fountains, kiosks, and marble pavilions.',                  'garden',   '🌹', 60,  4,  'North',        'morning',   '', @udaipur),
('Fateh Sagar Lake',   'A picturesque lake surrounded by the Aravalli Hills with a small island hosting a solar observatory.',    'lake',     '🔭', 60,  5,  'North',        'evening',   '', @udaipur),
('Bagore Ki Haveli',   'A magnificent 18th-century haveli with the world\'s largest turban and folk dance performances.',          'heritage', '🎭', 75,  6,  'Lakeside',     'afternoon', '', @udaipur);

-- ── MUMBAI ──────────────────────────────────────────────────────
SET @mumbai = (SELECT id FROM destinations WHERE name = 'Mumbai');
INSERT INTO attractions (name, description, type, emoji, visit_duration_mins, popularity_rank, cluster, best_time_of_day, good_for_months, destination_id) VALUES
('Gateway of India',   'An iconic triumphal arch built during the British Raj, overlooking the Arabian Sea.',                       'monument', '🏛️', 60,  1,  'South Mumbai', 'morning',   '', @mumbai),
('Elephanta Caves',    'UNESCO-listed rock-cut cave temples dedicated to Lord Shiva on Elephanta Island.',                         'cave',     '🪨', 150, 2,  'Harbour',      'morning',   '10,11,12,1,2,3', @mumbai),
('Marine Drive',       'A 3.6 km curved boulevard along the Arabian Sea, famous as the "Queen\'s Necklace" at night.',           'viewpoint','🌊', 60,  3,  'South Mumbai', 'evening',   '', @mumbai),
('Chhatrapati Terminus','UNESCO-listed Victorian Gothic railway station — the most iconic railway building in India.',             'heritage', '🚂', 60,  4,  'South Mumbai', 'morning',   '', @mumbai),
('Dharavi',            'One of Asia\'s largest urban settlements, with a thriving economy of leather, pottery, and recycling.',   'heritage', '🏘️', 90,  5,  'Central',      'morning',   '', @mumbai),
('Bandra-Worli Sea Link','An iconic cable-stayed bridge offering sweeping views of the Mumbai skyline.',                          'monument', '🌉', 30,  6,  'West',         'evening',   '', @mumbai),
('Crawford Market',    'A Victorian-era market and heritage building where you can find fresh produce and imported goods.',        'market',   '🛒', 60,  7,  'South Mumbai', 'morning',   '', @mumbai);

-- ── DARJEELING ──────────────────────────────────────────────────
SET @darjeeling = (SELECT id FROM destinations WHERE name = 'Darjeeling');
INSERT INTO attractions (name, description, type, emoji, visit_duration_mins, popularity_rank, cluster, best_time_of_day, good_for_months, destination_id) VALUES
('Tiger Hill',         'The most popular sunrise viewpoint in Darjeeling with breathtaking views of Kanchenjunga.',              'viewpoint','🌄', 90,  1,  'South',        'morning',   '', @darjeeling),
('Darjeeling Toy Train','UNESCO-listed narrow gauge railway offering scenic rides through tea gardens and hill stations.',       'heritage', '🚂', 120, 2,  'Central',      'morning',   '', @darjeeling),
('Batasia Loop',       'A spiral rail loop with a war memorial and stunning panoramas of the Himalayan range.',                  'viewpoint','🌀', 45,  3,  'Central',      'morning',   '', @darjeeling),
('Happy Valley Tea',   'One of the oldest tea estates in Darjeeling — a guided walk through the rolling gardens.',              'nature',   '🍵', 90,  4,  'North',        'morning',   '3,4,5,9,10', @darjeeling),
('Peace Pagoda',       'A Buddhist peace pagoda atop a hill with spectacular views of the town and snow-capped peaks.',         'temple',   '☮️', 60,  5,  'Central',      'afternoon', '', @darjeeling),
('Mahakal Temple',     'A Hindu and Buddhist temple complex on Observatory Hill with colourful prayer flags.',                  'temple',   '🏔️', 60,  6,  'Central',      'morning',   '', @darjeeling);

-- ── RISHIKESH ───────────────────────────────────────────────────
SET @rishikesh = (SELECT id FROM destinations WHERE name = 'Rishikesh');
INSERT INTO attractions (name, description, type, emoji, visit_duration_mins, popularity_rank, cluster, best_time_of_day, good_for_months, destination_id) VALUES
('Laxman Jhula',       'An iconic iron suspension bridge over the Ganga — the most photographed spot in Rishikesh.',            'heritage', '🌉', 60,  1,  'Central',      'morning',   '', @rishikesh),
('Ganga Aarti',        'The spectacular evening ritual at Triveni Ghat where hundreds of diyas are floated on the Ganga.',     'spiritual','🪔', 60,  2,  'Central',      'evening',   '', @rishikesh),
('White Water Rafting','Thrilling grade 2-4 rapids on the Ganga — one of India\'s most popular adventure activities.',         'adventure','🚣', 180, 3,  'Outskirts',    'morning',   '2,3,4,9,10,11', @rishikesh),
('Parmarth Niketan',   'One of the largest ashrams in Rishikesh offering yoga, meditation, and the daily Ganga Aarti.',        'spiritual','🧘', 90,  4,  'North',        'morning',   '', @rishikesh),
('Neelkanth Mahadev',  'A sacred Shiva temple at 1330m amidst dense forests, accessible by trek or taxi.',                   'temple',   '🛕', 120, 5,  'Outskirts',    'morning',   '', @rishikesh),
('Beatles Ashram',     'The ruined Maharishi Mahesh Yogi ashram where the Beatles stayed in 1968 — now covered in murals.',   'heritage', '🎸', 75,  6,  'South',        'afternoon', '', @rishikesh);

-- ── ALLEPPEY ────────────────────────────────────────────────────
SET @alleppey = (SELECT id FROM destinations WHERE name = 'Alleppey');
INSERT INTO attractions (name, description, type, emoji, visit_duration_mins, popularity_rank, cluster, best_time_of_day, good_for_months, destination_id) VALUES
('Houseboat Cruise',   'A night aboard a traditional kettuvallam (rice boat) through the serene Kerala backwaters.',           'activity', '🚤', 480, 1,  'Backwaters',   'morning',   '', @alleppey),
('Vembanad Lake',      'The longest lake in India — a tranquil expanse of water with islands and bird sanctuaries.',          'lake',     '🐦', 90,  2,  'Backwaters',   'morning',   '', @alleppey),
('Alappuzha Beach',    'A wide, quiet beach with a historic pier and lighthouse dating back to 1762.',                        'beach',    '🌊', 60,  3,  'Coast',        'evening',   '', @alleppey),
('Krishnapuram Palace','An 18th-century palace museum with Kerala murals and the famous Gajendra Moksham painting.',          'palace',   '🏛️', 75,  4,  'South',        'morning',   '', @alleppey),
('Pathiramanal Island','A tiny island accessible only by boat, home to over 50 species of migratory birds.',                 'nature',   '🦜', 90,  5,  'Backwaters',   'morning',   '', @alleppey);

-- ── KHAJURAHO ───────────────────────────────────────────────────
SET @khajuraho = (SELECT id FROM destinations WHERE name = 'Khajuraho');
INSERT INTO attractions (name, description, type, emoji, visit_duration_mins, popularity_rank, cluster, best_time_of_day, good_for_months, destination_id) VALUES
('Western Group Temples','UNESCO World Heritage temples with exquisite erotic and devotional sculptures — the iconic Khajuraho group.', 'temple', '🛕', 120, 1, 'West Group',  'morning',   '', @khajuraho),
('Eastern Group Temples','Jain and Hindu temples in the village showcasing refined medieval artistry.',                        'temple',   '🛕', 75,  2,  'East Group',   'morning',   '', @khajuraho),
('Sound & Light Show',  'A spectacular show at the Western Group of Temples narrating the history of Chandela dynasty.',      'activity', '🎇', 60,  3,  'West Group',   'evening',   '', @khajuraho),
('Raneh Falls',         'A stunning gorge with Ken River flowing through crystallised lava rock formations.',                  'waterfall','💧', 90,  4,  'Outskirts',    'morning',   '7,8,9,10', @khajuraho),
('Ajaigarh Fort',       'A hilltop fort with panoramic views, ruins, and a temple — a rewarding half-day excursion.',         'fort',     '🏯', 120, 5,  'Outskirts',    'morning',   '', @khajuraho);

-- ── HAMPI ───────────────────────────────────────────────────────
SET @hampi = (SELECT id FROM destinations WHERE name = 'Hampi');
INSERT INTO attractions (name, description, type, emoji, visit_duration_mins, popularity_rank, cluster, best_time_of_day, good_for_months, destination_id) VALUES
('Virupaksha Temple',  'The holiest temple in Hampi, dedicated to Lord Shiva, continuously used since the 7th century.',     'temple',   '🛕', 90,  1,  'Hampi Bazaar', 'morning',   '', @hampi),
('Vittala Temple',     'Famous for its iconic stone chariot and the musical pillars that emit different notes when tapped.',  'temple',   '🎵', 90,  2,  'East Group',   'morning',   '', @hampi),
('Elephant Stables',   'A long, impressive building with domed chambers that once housed the royal war elephants.',           'heritage', '🐘', 60,  3,  'Royal Centre', 'afternoon', '', @hampi),
('Hampi Bazaar',       'The main street of ancient Hampi lined with monolithic sculptures and a vibrant weekly market.',     'market',   '🛒', 60,  4,  'Hampi Bazaar', 'morning',   '', @hampi),
('Matanga Hill',       'The highest point in Hampi offering the best panoramic sunrise views over the boulder landscape.',   'viewpoint','🌄', 90,  5,  'Central',      'morning',   '', @hampi),
('Lotus Mahal',        'A delicate palace pavilion blending Hindu and Islamic architecture in the Zenana Enclosure.',        'palace',   '🪷', 45,  6,  'Royal Centre', 'afternoon', '', @hampi);

-- ── PONDICHERRY ─────────────────────────────────────────────────
SET @pondi = (SELECT id FROM destinations WHERE name = 'Pondicherry');
INSERT INTO attractions (name, description, type, emoji, visit_duration_mins, popularity_rank, cluster, best_time_of_day, good_for_months, destination_id) VALUES
('French Quarter',     'Immaculate French colonial streets with bougainvillea-draped villas and chic cafes.',                'heritage', '🥐', 90,  1,  'White Town',   'morning',   '', @pondi),
('Auroville',          'An experimental township dedicated to human unity and sustainable living, founded in 1968.',         'heritage', '☮️', 120, 2,  'Outskirts',    'morning',   '', @pondi),
('Sri Aurobindo Ashram','A world-renowned spiritual community founded by Sri Aurobindo and The Mother.',                    'spiritual','🧘', 75,  3,  'White Town',   'morning',   '', @pondi),
('Promenade Beach',    'A scenic seaside boulevard perfect for morning jogs and watching the sunrise over the Bay of Bengal.','beach',  '🌅', 60,  4,  'Coast',        'morning',   '', @pondi),
('Basilica of Sacred Heart','A beautiful neo-Gothic church with stunning stained glass windows.',                           'church',   '⛪', 45,  5,  'White Town',   'morning',   '', @pondi),
('Paradise Beach',     'An isolated beach accessible only by ferry — pristine sands and turquoise waters.',                 'beach',    '🏖️', 90,  6,  'South',        'afternoon', '11,12,1,2,3', @pondi);

-- ── MANALI ──────────────────────────────────────────────────────
SET @manali = (SELECT id FROM destinations WHERE name = 'Manali');
INSERT INTO attractions (name, description, type, emoji, visit_duration_mins, popularity_rank, cluster, best_time_of_day, good_for_months, destination_id) VALUES
('Solang Valley',      'Adventure hub for skiing, zorbing, and cable car rides with Himalayan glacier backdrop.',            'adventure','⛷️', 180, 1,  'North',        'morning',   '12,1,2,3,4,5', @manali),
('Rohtang Pass',       'A breathtaking mountain pass at 3978m offering access to Lahaul valley and snow fields.',           'viewpoint','🏔️', 120, 2,  'North',        'morning',   '5,6,9,10', @manali),
('Hadimba Temple',     'A unique wooden temple dedicated to Hadimba Devi, surrounded by a cedar forest.',                  'temple',   '🌲', 60,  3,  'Central',      'morning',   '', @manali),
('Old Manali',         'The original village with apple orchards, guesthouses, and a laid-back hippie vibe.',               'heritage', '🍎', 75,  4,  'Central',      'afternoon', '', @manali),
('Beas River Rafting', 'Grade 3 rapids on the Beas River — a thrilling two-hour rafting adventure.',                       'adventure','🚣', 120, 5,  'South',        'morning',   '5,6,7,9,10', @manali),
('Jogini Waterfall',   'A scenic 2km trek from Vashisht village leading to a beautiful multi-tiered waterfall.',           'waterfall','💦', 120, 6,  'East',         'morning',   '5,6,7,8,9', @manali);

-- ── OOTY ────────────────────────────────────────────────────────
SET @ooty = (SELECT id FROM destinations WHERE name = 'Ooty');
INSERT INTO attractions (name, description, type, emoji, visit_duration_mins, popularity_rank, cluster, best_time_of_day, good_for_months, destination_id) VALUES
('Ooty Lake',          'A man-made lake offering pedal boat rides surrounded by eucalyptus trees.',                         'lake',     '🚤', 75,  1,  'Central',      'afternoon', '', @ooty),
('Botanical Gardens',  'A spectacular 22-hectare garden with 650 plant species and a fossil tree trunk.',                  'garden',   '🌸', 90,  2,  'Central',      'morning',   '', @ooty),
('Doddabetta Peak',    'The highest peak of the Nilgiris at 2637m, with a telescope observatory at the summit.',           'viewpoint','🔭', 60,  3,  'East',         'morning',   '', @ooty),
('Nilgiri Toy Train',  'UNESCO-listed rack railway from Mettupalayam to Ooty through stunning mountain forests.',          'heritage', '🚂', 300, 4,  'Outskirts',    'morning',   '', @ooty),
('Rose Garden',        'Asia\'s largest rose garden with over 20,000 varieties spread across terraced slopes.',           'garden',   '🌹', 60,  5,  'Central',      'morning',   '1,2,3,4,5', @ooty),
('Pykara Falls',       'A scenic waterfall and lake in a forest area 21km from Ooty, popular for boating.',               'waterfall','💧', 90,  6,  'West',         'morning',   '', @ooty);

-- ── COORG ───────────────────────────────────────────────────────
SET @coorg = (SELECT id FROM destinations WHERE name = 'Coorg');
INSERT INTO attractions (name, description, type, emoji, visit_duration_mins, popularity_rank, cluster, best_time_of_day, good_for_months, destination_id) VALUES
('Abbey Falls',        'A picturesque waterfall surrounded by coffee and spice estates, 10km from Madikeri.',             'waterfall','💦', 60,  1,  'North',        'morning',   '7,8,9,10', @coorg),
('Raja\'s Seat',       'A garden and viewpoint where Coorg\'s kings watched the sunset over the Western Ghats.',         'viewpoint','🌅', 60,  2,  'Central',      'evening',   '', @coorg),
('Namdroling Monastery','A stunning golden Tibetan Buddhist monastery known as the Golden Temple of Coorg.',             'temple',   '☮️', 90,  3,  'South',        'morning',   '', @coorg),
('Coffee Estate Walk', 'A guided tour of a Coorg coffee plantation — smell, pick, and taste freshly harvested coffee.',  'nature',   '☕', 90,  4,  'Central',      'morning',   '10,11,12', @coorg),
('Dubare Elephant Camp','An elephant camp on the Cauvery River where you can bathe and interact with elephants.',        'activity', '🐘', 120, 5,  'East',         'morning',   '', @coorg),
('Talacauvery',        'The sacred source of the Cauvery River, high in the Brahmagiri Hills.',                          'spiritual','🌊', 90,  6,  'South',        'morning',   '', @coorg);

-- ── PURI ────────────────────────────────────────────────────────
SET @puri = (SELECT id FROM destinations WHERE name = 'Puri');
INSERT INTO attractions (name, description, type, emoji, visit_duration_mins, popularity_rank, cluster, best_time_of_day, good_for_months, destination_id) VALUES
('Jagannath Temple',   'One of the four sacred Dhams of Hinduism, famous for the annual Rath Yatra chariot festival.',   'temple',   '🛕', 90,  1,  'Central',      'morning',   '', @puri),
('Puri Beach',         'A wide golden beach on the Bay of Bengal, famous for its sand art and Chilika Lake nearby.',     'beach',    '🏖️', 90,  2,  'Coast',        'morning',   '10,11,12,1,2', @puri),
('Chilika Lake',       'Asia\'s largest coastal lagoon, home to Irrawaddy dolphins and millions of migratory birds.',   'lake',     '🐬', 120, 3,  'South',        'morning',   '11,12,1,2', @puri),
('Konark Sun Temple',  'A UNESCO World Heritage Site — the 13th-century Sun Temple in the shape of a giant chariot.',   'temple',   '☀️', 90,  4,  'Outskirts',    'morning',   '', @puri),
('Raghurajpur Village','A heritage village of Pattachitra artists, with every house decorated with traditional painting.','heritage','🎨', 75,  5,  'Outskirts',    'afternoon', '', @puri);

-- ── GANGTOK ─────────────────────────────────────────────────────
SET @gangtok = (SELECT id FROM destinations WHERE name = 'Gangtok');
INSERT INTO attractions (name, description, type, emoji, visit_duration_mins, popularity_rank, cluster, best_time_of_day, good_for_months, destination_id) VALUES
('Rumtek Monastery',   'The largest monastery in Sikkim — a major seat of the Karma Kagyu school of Tibetan Buddhism.',  'temple',   '☮️', 90,  1,  'West',         'morning',   '', @gangtok),
('Tsomgo Lake',        'A glacial lake at 3753m — sacred to the local people and surrounded by snow-capped peaks.',      'lake',     '🏔️', 90,  2,  'East',         'morning',   '3,4,5,9,10,11', @gangtok),
('Nathu La Pass',      'A mountain pass on the Indo-China border at 4310m, offering dramatic Himalayan scenery.',        'viewpoint','🌄', 60,  3,  'East',         'morning',   '5,6,9,10', @gangtok),
('MG Road',            'Gangtok\'s pedestrian promenade lined with shops, cafes, and street food stalls.',               'market',   '🛍️', 60,  4,  'Central',      'afternoon', '', @gangtok),
('Enchey Monastery',   'A 200-year-old monastery perched on a spur above Gangtok, offering city and mountain views.',   'temple',   '🙏', 60,  5,  'North',        'morning',   '', @gangtok);

-- ── PUSHKAR ─────────────────────────────────────────────────────
SET @pushkar = (SELECT id FROM destinations WHERE name = 'Pushkar');
INSERT INTO attractions (name, description, type, emoji, visit_duration_mins, popularity_rank, cluster, best_time_of_day, good_for_months, destination_id) VALUES
('Pushkar Lake',       'A sacred lake with 52 ghats — believed to have appeared when Lord Brahma dropped a lotus flower.','lake',    '🪷', 90,  1,  'Central',      'morning',   '', @pushkar),
('Brahma Temple',      'One of very few temples in the world dedicated to Lord Brahma — a unique pilgrimage site.',      'temple',   '🛕', 60,  2,  'Central',      'morning',   '', @pushkar),
('Savitri Mata Temple','Hilltop temple reached by a 3km trek or ropeway with spectacular desert panoramas.',             'temple',   '🌅', 90,  3,  'Hills',        'morning',   '', @pushkar),
('Pushkar Bazaar',     'A vibrant market selling silver jewellery, tie-dye textiles, and Rajasthani handicrafts.',       'market',   '🛍️', 75,  4,  'Central',      'afternoon', '', @pushkar),
('Desert Camp',        'A camel safari into the sand dunes with folk music and stargazing — a magical desert evening.',  'activity', '🐪', 120, 5,  'Outskirts',    'evening',   '10,11,12,1,2,3', @pushkar);

-- ── AJANTA-ELLORA ────────────────────────────────────────────────
SET @ajanta = (SELECT id FROM destinations WHERE name = 'Ajanta-Ellora');
INSERT INTO attractions (name, description, type, emoji, visit_duration_mins, popularity_rank, cluster, best_time_of_day, good_for_months, destination_id) VALUES
('Ajanta Caves',       'UNESCO-listed Buddhist cave monasteries with exquisite 2nd-century BC murals and sculptures.',   'cave',     '🪨', 180, 1,  'Ajanta',       'morning',   '', @ajanta),
('Ellora Caves',       'UNESCO World Heritage caves with Hindu, Buddhist and Jain temples carved into a 2km long cliff.','cave',    '🏛️', 180, 2,  'Ellora',       'morning',   '', @ajanta),
('Kailasa Temple',     'The world\'s largest monolithic rock sculpture — a complete temple carved top-down from a cliff.','cave',   '⛰️', 90,  3,  'Ellora',       'morning',   '', @ajanta),
('Daulatabad Fort',    'A medieval hilltop fort with ingenious defences — one of the most impregnable forts in India.',  'fort',     '🏯', 90,  4,  'Outskirts',    'morning',   '', @ajanta),
('Bibi Ka Maqbara',    'Known as the "Taj of the Deccan" — a Mughal mausoleum built in 1679 in nearby Aurangabad.',     'monument', '✨', 75,  5,  'Outskirts',    'morning',   '', @ajanta);

-- ── PACHMARHI ───────────────────────────────────────────────────
SET @pachmarhi = (SELECT id FROM destinations WHERE name = 'Pachmarhi');
INSERT INTO attractions (name, description, type, emoji, visit_duration_mins, popularity_rank, cluster, best_time_of_day, good_for_months, destination_id) VALUES
('Bee Falls',          'A spectacular 35m waterfall — the most popular attraction in Pachmarhi.',                        'waterfall','💧', 75,  1,  'Central',      'morning',   '', @pachmarhi),
('Pandav Caves',       'Ancient cave dwellings believed to have been the hideout of the Pandavas from the Mahabharata.','cave',     '🪨', 60,  2,  'Central',      'morning',   '', @pachmarhi),
('Dhoopgarh',          'The highest point in the Satpura Range at 1350m — famous for spectacular sunrises.',            'viewpoint','🌄', 60,  3,  'West',         'morning',   '', @pachmarhi),
('Satpura National Park','A biosphere reserve teeming with leopards, gaur, sloth bears, and the endangered wild dog.',  'nature',   '🐆', 120, 4,  'Outskirts',    'morning',   '10,11,12,1,2,3', @pachmarhi),
('Jata Shankar Cave',  'A natural cave with Shiva lingam formations in a lush gorge — a sacred and scenic spot.',       'cave',     '🛕', 60,  5,  'North',        'morning',   '', @pachmarhi);
