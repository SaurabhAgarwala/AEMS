-- Database export via SQLPro (https://www.sqlprostudio.com/allapps.html)
-- Exported by adityakaria at 03-11-2019 20:39.
-- WARNING: This file may contain descructive statements such as DROPs.
-- Please ensure that you are running the script at the proper location.
-- BEGIN TABLE Ambulance
DROP TABLE IF EXISTS Ambulance;
CREATE TABLE `Ambulance` (
  `vehicle_no` varchar(20) DEFAULT NULL,
  `tools` varchar(20) DEFAULT NULL
);
-- Inserting 26 rows into Ambulance
-- Insert batch #1
INSERT INTO Ambulance (vehicle_no, tools)
VALUES
  ('KA016738', 'A1'),
  ('KA016738', 'A2'),
  ('KA016738', 'B1'),
  ('KA016738', 'B2'),
  ('KA016738', 'C1'),
  ('KA052974', 'A2'),
  ('KA052974', 'B2'),
  ('KA052974', 'C1'),
  ('KA052974', 'C2'),
  ('KA052974', 'D2'),
  ('KA048321', 'A1'),
  ('KA048321', 'A2'),
  ('KA048321', 'C1'),
  ('KA048321', 'D1'),
  ('KA048321', 'D2'),
  ('KA016392', 'C1'),
  ('KA016392', 'A1'),
  ('KA075171', 'B1'),
  ('KA075171', 'B2'),
  ('KA075171', 'C2'),
  ('KA075171', 'D1'),
  ('KA075171', 'D2'),
  ('KA091347', 'A2'),
  ('KA091347', 'B1'),
  ('KA091347', 'B2'),
  ('KA091347', 'D1');
-- END TABLE Ambulance
  -- BEGIN TABLE Ambulance_loc
  DROP TABLE IF EXISTS Ambulance_loc;
CREATE TABLE `Ambulance_loc` (
    `vehicle_no` varchar(20) DEFAULT NULL,
    `x` int(11) DEFAULT NULL,
    `y` int(11) DEFAULT NULL
  );
-- Inserting 6 rows into Ambulance_loc
  -- Insert batch #1
INSERT INTO Ambulance_loc (vehicle_no, x, y)
VALUES
  ('KA016738', 23, 84),
  ('KA052974', 45, 12),
  ('KA048321', 77, 59),
  ('KA016392', 96, 44),
  ('KA075171', 61, 32),
  ('KA091347', 7, 42);
-- END TABLE Ambulance_loc
  -- BEGIN TABLE Diseases
  DROP TABLE IF EXISTS Diseases;
CREATE TABLE `Diseases` (
    `Disease` varchar(20) DEFAULT NULL,
    `Tools` varchar(20) DEFAULT NULL
  );
-- Inserting 12 rows into Diseases
  -- Insert batch #1
INSERT INTO Diseases (Disease, Tools)
VALUES
  ('A', 'A1'),
  ('A', 'A2'),
  ('B', 'A1'),
  ('B', 'B1'),
  ('B', 'B2'),
  ('C', 'C1'),
  ('C', 'C2'),
  ('C', 'B2'),
  ('D', 'A1'),
  ('D', 'C2'),
  ('D', 'D1'),
  ('D', 'D2');
-- END TABLE Diseases
  -- BEGIN TABLE Hospitals
  DROP TABLE IF EXISTS Hospitals;
CREATE TABLE `Hospitals` (
    `x` int(11) DEFAULT NULL,
    `y` int(11) DEFAULT NULL
  );
-- Inserting 5 rows into Hospitals
  -- Insert batch #1
INSERT INTO Hospitals (x, y)
VALUES
  (10, 99),
  (45, 87),
  (15, 23),
  (62, 45),
  (85, 8);
-- END TABLE Hospitals
  -- BEGIN TABLE Patient_records
  DROP TABLE IF EXISTS Patient_records;
CREATE TABLE `Patient_records` (
    `x` int(11) DEFAULT NULL,
    `y` int(11) DEFAULT NULL,
    `disease` varchar(20) DEFAULT NULL
  );
-- Inserting 122 rows into Patient_records
  -- Insert batch #1
INSERT INTO Patient_records (x, y, disease)
VALUES
  (33, 77, 'A'),
  (89, 26, 'A'),
  (25, 44, 'A'),
  (80, 30, 'A'),
  (38, 8, 'A'),
  (69, 70, 'A'),
  (50, 96, 'A'),
  (79, 63, 'A'),
  (41, 89, 'A'),
  (81, 79, 'A'),
  (44, 9, 'A'),
  (20, 27, 'A'),
  (46, 41, 'A'),
  (83, 66, 'A'),
  (81, 83, 'A'),
  (17, 88, 'A'),
  (42, 43, 'A'),
  (58, 33, 'A'),
  (49, 47, 'A'),
  (38, 1, 'A'),
  (47, 13, 'A'),
  (43, 58, 'A'),
  (12, 1, 'A'),
  (87, 12, 'A'),
  (24, 38, 'A'),
  (55, 14, 'A'),
  (78, 19, 'A'),
  (69, 58, 'A'),
  (33, 62, 'A'),
  (41, 7, 'A'),
  (64, 6, 'A'),
  (7, 97, 'A'),
  (41, 45, 'A'),
  (61, 69, 'A'),
  (11, 67, 'A'),
  (92, 34, 'B'),
  (17, 13, 'B'),
  (55, 36, 'B'),
  (93, 65, 'B'),
  (43, 51, 'B'),
  (36, 43, 'B'),
  (62, 5, 'B'),
  (94, 84, 'B'),
  (86, 80, 'B'),
  (87, 61, 'B'),
  (81, 35, 'B'),
  (86, 15, 'B'),
  (92, 46, 'B'),
  (73, 58, 'B'),
  (2, 62, 'B'),
  (45, 99, 'B'),
  (44, 50, 'B'),
  (48, 65, 'B'),
  (43, 8, 'B'),
  (25, 49, 'B'),
  (0, 6, 'B'),
  (34, 65, 'B'),
  (12, 25, 'B'),
  (16, 34, 'B'),
  (53, 26, 'B'),
  (26, 51, 'B'),
  (61, 11, 'B'),
  (73, 35, 'B'),
  (40, 69, 'B'),
  (5, 32, 'B'),
  (61, 48, 'C'),
  (75, 94, 'C'),
  (21, 43, 'C'),
  (93, 61, 'C'),
  (38, 45, 'C'),
  (43, 99, 'C'),
  (27, 49, 'C'),
  (91, 12, 'C'),
  (51, 50, 'C'),
  (5, 42, 'C'),
  (71, 30, 'C'),
  (13, 79, 'C'),
  (81, 10, 'C'),
  (18, 35, 'C'),
  (87, 68, 'C'),
  (90, 79, 'C'),
  (68, 22, 'C'),
  (7, 99, 'C'),
  (54, 25, 'C'),
  (46, 67, 'C'),
  (59, 9, 'C'),
  (88, 5, 'C'),
  (2, 7, 'C'),
  (92, 52, 'C'),
  (4, 62, 'C'),
  (56, 81, 'C'),
  (22, 51, 'C'),
  (83, 16, 'C'),
  (12, 94, 'C'),
  (28, 39, 'C'),
  (3, 73, 'C'),
  (38, 16, 'C'),
  (59, 77, 'C'),
  (30, 43, 'C'),
  (71, 78, 'D'),
  (88, 54, 'D'),
  (26, 64, 'D'),
  (30, 90, 'D'),
  (86, 2, 'D'),
  (65, 82, 'D'),
  (96, 93, 'D'),
  (66, 78, 'D'),
  (93, 50, 'D'),
  (82, 9, 'D'),
  (53, 45, 'D'),
  (7, 42, 'D'),
  (18, 67, 'D'),
  (39, 67, 'D'),
  (13, 64, 'D'),
  (21, 27, 'D'),
  (1, 23, 'D'),
  (13, 95, 'D'),
  (51, 35, 'D'),
  (9, 94, 'D'),
  (57, 26, 'D'),
  (33, 72, 'A'),
  (50, 49, 'A');
-- END TABLE Patient_records
