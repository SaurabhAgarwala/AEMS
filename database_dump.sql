-- Exported at at 03-11-2019 18:56.
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
    `ID` int(11) DEFAULT NULL,
    `x` int(11) DEFAULT NULL,
    `y` int(11) DEFAULT NULL
  );
-- Inserting 5 rows into Hospitals
  -- Insert batch #1
INSERT INTO Hospitals (ID, x, y)
VALUES
  (1, 10, 99),
  (2, 45, 87),
  (3, 15, 23),
  (4, 62, 45),
  (5, 85, 8);
-- END TABLE Hospitals
  -- BEGIN TABLE Patient_records
  DROP TABLE IF EXISTS Patient_records;
CREATE TABLE `Patient_records` (
    `ID` int(11) DEFAULT NULL,
    `x` int(11) DEFAULT NULL,
    `y` int(11) DEFAULT NULL,
    `disease` varchar(20) DEFAULT NULL
  );
-- Inserting 120 rows into Patient_records
  -- Insert batch #1
INSERT INTO Patient_records (ID, x, y, disease)
VALUES
  (1, 33, 77, 'A'),
  (2, 89, 26, 'A'),
  (3, 25, 44, 'A'),
  (4, 80, 30, 'A'),
  (5, 38, 8, 'A'),
  (6, 69, 70, 'A'),
  (7, 50, 96, 'A'),
  (8, 79, 63, 'A'),
  (9, 41, 89, 'A'),
  (10, 81, 79, 'A'),
  (11, 44, 9, 'A'),
  (12, 20, 27, 'A'),
  (13, 46, 41, 'A'),
  (14, 83, 66, 'A'),
  (15, 81, 83, 'A'),
  (16, 17, 88, 'A'),
  (17, 42, 43, 'A'),
  (18, 58, 33, 'A'),
  (19, 49, 47, 'A'),
  (20, 38, 1, 'A'),
  (21, 47, 13, 'A'),
  (22, 43, 58, 'A'),
  (23, 12, 1, 'A'),
  (24, 87, 12, 'A'),
  (25, 24, 38, 'A'),
  (26, 55, 14, 'A'),
  (27, 78, 19, 'A'),
  (28, 69, 58, 'A'),
  (29, 33, 62, 'A'),
  (30, 41, 7, 'A'),
  (31, 64, 6, 'A'),
  (32, 7, 97, 'A'),
  (33, 41, 45, 'A'),
  (34, 61, 69, 'A'),
  (35, 11, 67, 'A'),
  (36, 92, 34, 'B'),
  (37, 17, 13, 'B'),
  (38, 55, 36, 'B'),
  (39, 93, 65, 'B'),
  (40, 43, 51, 'B'),
  (41, 36, 43, 'B'),
  (42, 62, 5, 'B'),
  (43, 94, 84, 'B'),
  (44, 86, 80, 'B'),
  (45, 87, 61, 'B'),
  (46, 81, 35, 'B'),
  (47, 86, 15, 'B'),
  (48, 92, 46, 'B'),
  (49, 73, 58, 'B'),
  (50, 2, 62, 'B'),
  (51, 45, 99, 'B'),
  (52, 44, 50, 'B'),
  (53, 48, 65, 'B'),
  (54, 43, 8, 'B'),
  (55, 25, 49, 'B'),
  (56, 0, 6, 'B'),
  (57, 34, 65, 'B'),
  (58, 12, 25, 'B'),
  (59, 16, 34, 'B'),
  (60, 53, 26, 'B'),
  (61, 26, 51, 'B'),
  (62, 61, 11, 'B'),
  (63, 73, 35, 'B'),
  (64, 40, 69, 'B'),
  (65, 5, 32, 'B'),
  (66, 61, 48, 'C'),
  (67, 75, 94, 'C'),
  (68, 21, 43, 'C'),
  (69, 93, 61, 'C'),
  (70, 38, 45, 'C'),
  (71, 43, 99, 'C'),
  (72, 27, 49, 'C'),
  (73, 91, 12, 'C'),
  (74, 51, 50, 'C'),
  (75, 5, 42, 'C'),
  (76, 71, 30, 'C'),
  (77, 13, 79, 'C'),
  (78, 81, 10, 'C'),
  (79, 18, 35, 'C'),
  (80, 87, 68, 'C'),
  (81, 90, 79, 'C'),
  (82, 68, 22, 'C'),
  (83, 7, 99, 'C'),
  (84, 54, 25, 'C'),
  (85, 46, 67, 'C'),
  (86, 59, 9, 'C'),
  (87, 88, 5, 'C'),
  (88, 2, 7, 'C'),
  (89, 92, 52, 'C'),
  (90, 4, 62, 'C'),
  (91, 56, 81, 'C'),
  (92, 22, 51, 'C'),
  (93, 83, 16, 'C'),
  (94, 12, 94, 'C'),
  (95, 28, 39, 'C'),
  (96, 3, 73, 'C'),
  (97, 38, 16, 'C'),
  (98, 59, 77, 'C'),
  (99, 30, 43, 'C'),
  (100, 71, 78, 'D'),
  (101, 88, 54, 'D'),
  (102, 26, 64, 'D'),
  (103, 30, 90, 'D'),
  (104, 86, 2, 'D'),
  (105, 65, 82, 'D'),
  (106, 96, 93, 'D'),
  (107, 66, 78, 'D'),
  (108, 93, 50, 'D'),
  (109, 82, 9, 'D'),
  (110, 53, 45, 'D'),
  (111, 7, 42, 'D'),
  (112, 18, 67, 'D'),
  (113, 39, 67, 'D'),
  (114, 13, 64, 'D'),
  (115, 21, 27, 'D'),
  (116, 1, 23, 'D'),
  (117, 13, 95, 'D'),
  (118, 51, 35, 'D'),
  (119, 9, 94, 'D'),
  (120, 57, 26, 'D');
-- END TABLE Patient_records
