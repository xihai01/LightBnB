-- add seeds to users table (schema)
INSERT INTO users (name, email, password)
-- owners
VALUES ('Xihai Luo', 'xihai.luo01@gmail.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u'),
('Eva Stanley', 'sebastianguerra@ymail.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u'),
('Sue Lana', 'jasonvince@msn.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u'),
('Keqing Li', 'rexlapissimp@yuheng.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u'),
-- guests
('Evan Su', 'helloworld@hotmail.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u'), --5
('Susan Lame', 'jascee@yaho.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u'), --6
('Ganyu Work', 'keqingsimp@yuheng.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u'); --7

-- add seeds to properties table
INSERT INTO properties (
  owner_id,
  title,
  description,
  thumbnail_photo_url,
  cover_photo_url,
  country,
  street,
  city,
  province,
  post_code,
  active
)
VALUES (
  1,
  'Speed Lamp',
  'description',
  'https://images.pexels.com/photos/2086676/pexels-photo-2086676.jpeg?auto=compress&cs=tinysrgb&h=350',
  'https://images.pexels.com/photos/2086676/pexels-photo-2086676.jpeg',
  'Canada',
  '30 Thunder Grove',
  'Toronto',
  'Ontario',
  'M1V 4A3',
  'true'
),
(
  1,
  'Blank Corner',
  'description',
  'https://images.pexels.com/photos/2121121/pexels-photo-2121121.jpeg?auto=compress&cs=tinysrgb&h=350',
  'https://images.pexels.com/photos/2121121/pexels-photo-2121121.jpeg',
  'Canada',
  '1211 AppleTree Road',
  'Calgary',
  'Manitoba',
  '123453',
  'true'
),
(
  3,
  'Poop Station',
  'description',
  'https://images.pexels.com/photos/2080018/pexels-photo-2080018.jpeg?auto=compress&cs=tinysrgb&h=350',
  'https://images.pexels.com/photos/2080018/pexels-photo-2080018.jpeg',
  'Sweden',
  '33 Poopy Drive',
  'Stockholm',
  'Meatball',
  '125z31',
  'true'
),
(
  2,
  'Trail Mix',
  'description',
  'https://images.pexels.com/photos/1172064/pexels-photo-1172064.jpeg?auto=compress&cs=tinysrgb&h=350',
  'https://images.pexels.com/photos/1475938/pexels-photo-1475938.jpeg',
  'Canada',
  '43 Snowden Drive',
  'Vancover',
  'British Colombia',
  'abcde',
  'true'
),
(
  4,
  'Game Fill',
  'description',
  'https://images.pexels.com/photos/1756826/pexels-photo-1756826.jpeg?auto=compress&cs=tinysrgb&h=350',
  'https://images.pexels.com/photos/1756826/pexels-photo-1756826.jpeg',
  'Turkey',
  '0011 Iskandar Kebap Road',
  'Trapezon',
  'Kunefe',
  '332df32',
  'true'
);

-- add seeds to reservations table
INSERT INTO reservations (start_date, end_date, property_id, guest_id)
VALUES ('2018-09-11', '2018-09-26', 1, 6),
('2019-01-04', '2019-02-01', 2, 5),
('2021-10-01', '2021-10-14', 1, 7),
('2016-07-17', '2016-08-01', 4, 6),
('2018-03-10', '2018-03-25', 5, 5);

-- add seeds to property_reviews table
INSERT INTO property_reviews (guest_id, property_id, reservation_id, rating, message)
VALUES (6, 1, 1, 7, 'messages'),
(5, 2, 2, 10, 'messages'),
(7, 1, 3, 5, 'messages'),
(6, 4, 4, 2, 'messages'),
(5, 5, 5, 8, 'messages');