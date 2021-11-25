-- add seeds to users table (schema)
INSERT INTO users (name, email_address, password)
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
  title,
  description,
  cover_photo_url,
  thumbnail_photo_url,
  country,
  street,
  city,
  province,
  post_code,
  active,
  owner_id
)
VALUES (
  'Speed Lamp',
  'description',
  'https://images.pexels.com/photos/2086676/pexels-photo-2086676.jpeg',
  'https://images.pexels.com/photos/2086676/pexels-photo-2086676.jpeg?auto=compress&cs=tinysrgb&h=350',
  'Canada',
  '30 Thunder Grove',
  'Toronto',
  'Ontario',
  'M1V 4A3',
  'true',
  1
),
(
  'Blank Corner',
  'description',
  'https://images.pexels.com/photos/2121121/pexels-photo-2121121.jpeg',
  'https://images.pexels.com/photos/2121121/pexels-photo-2121121.jpeg?auto=compress&cs=tinysrgb&h=350',
  'Canada',
  '1211 AppleTree Road',
  'Calgary',
  'Manitoba',
  '123453',
  'true',
  1
),
(
  'Poop Station',
  'description',
  'https://images.pexels.com/photos/2080018/pexels-photo-2080018.jpeg',
  'https://images.pexels.com/photos/2080018/pexels-photo-2080018.jpeg?auto=compress&cs=tinysrgb&h=350',
  'Sweden',
  '33 Poopy Drive',
  'Stockholm',
  'Meatball',
  '125z31',
  'true',
  3
),
(
  'Trail Mix',
  'description',
  'https://images.pexels.com/photos/1475938/pexels-photo-1475938.jpeg',
  'https://images.pexels.com/photos/1172064/pexels-photo-1172064.jpeg?auto=compress&cs=tinysrgb&h=350',
  'Canada',
  '43 Snowden Drive',
  'Vancover',
  'British Colombia',
  'abcde',
  'true',
  2
),
(
  'Game Fill',
  'description',
  'https://images.pexels.com/photos/1756826/pexels-photo-1756826.jpeg',
  'https://images.pexels.com/photos/1756826/pexels-photo-1756826.jpeg?auto=compress&cs=tinysrgb&h=350',
  'Turkey',
  '0011 Iskandar Kebap Road',
  'Trapezon',
  'Kunefe',
  '332df32',
  'true',
  4
);

-- add seeds to reservations table
INSERT INTO reservations (start_date, end_date, guest_id, property_id)
VALUES ('2018-09-11', '2018-09-26', 6, 1),
('2019-01-04', '2019-02-01', 5, 2),
('2021-10-01', '2021-10-14', 7, 1),
('2016-07-17', '2016-08-01', 6, 4),
('2018-03-10', '2018-03-25', 5, 5);

-- add seeds to property_reviews table
INSERT INTO property_reviews (message, rating, guest_id, reservation_id, property_id)
VALUES ('messages', 7, 6, 1, 1),
('messages', 10, 5, 2, 2),
('messages', 5, 7, 3, 1),
('messages', 2, 6, 4, 4),
('messages', 8, 5, 5, 5);