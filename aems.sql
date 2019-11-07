-- MySQL dump 10.13  Distrib 5.7.27, for Linux (x86_64)
--
-- Host: localhost    Database: aems
-- ------------------------------------------------------
-- Server version	5.7.27-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Ambulance`
--

DROP TABLE IF EXISTS `Ambulance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ambulance` (
  `vehicle_no` varchar(20) DEFAULT NULL,
  `tools` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ambulance`
--

LOCK TABLES `Ambulance` WRITE;
/*!40000 ALTER TABLE `Ambulance` DISABLE KEYS */;
INSERT INTO `Ambulance` VALUES ('KA016738','A1'),('KA016738','A2'),('KA016738','B1'),('KA016738','B2'),('KA016738','C1'),('KA052974','A2'),('KA052974','B2'),('KA052974','C1'),('KA052974','C2'),('KA052974','D2'),('KA048321','A1'),('KA048321','A2'),('KA048321','C1'),('KA048321','D1'),('KA048321','D2'),('KA016392','C1'),('KA016392','A1'),('KA075171','B1'),('KA075171','B2'),('KA075171','C2'),('KA075171','D1'),('KA075171','D2'),('KA091347','A2'),('KA091347','B1'),('KA091347','B2'),('KA091347','D1'),('KA016392','C2'),('KA016392','D1'),('KA016392','D2'),('KA075171','C1');
/*!40000 ALTER TABLE `Ambulance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ambulance_driver`
--

DROP TABLE IF EXISTS `Ambulance_driver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ambulance_driver` (
  `vehicle_no` varchar(20) NOT NULL,
  `driver_name` varchar(30) DEFAULT NULL,
  `contact_no` varchar(15) DEFAULT NULL,
  `rating` float DEFAULT NULL,
  PRIMARY KEY (`vehicle_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ambulance_driver`
--

LOCK TABLES `Ambulance_driver` WRITE;
/*!40000 ALTER TABLE `Ambulance_driver` DISABLE KEYS */;
INSERT INTO `Ambulance_driver` VALUES ('KA016392','madhuparna','4204206969',5),('KA016738','Saurabh Agarwala','9876543210',0),('KA048321','Thejaswini DM','1234567890',5),('KA052974','Khatri','9699842088',3),('KA075171','17shashank17','8494626969',5),('KA091347','Apoorva','9696942568',5);
/*!40000 ALTER TABLE `Ambulance_driver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ambulance_loc`
--

DROP TABLE IF EXISTS `Ambulance_loc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ambulance_loc` (
  `vehicle_no` varchar(20) DEFAULT NULL,
  `x` int(11) DEFAULT NULL,
  `y` int(11) DEFAULT NULL,
  `base_fare` int(11) DEFAULT NULL,
  `charge_per_km` float DEFAULT NULL,
  `status` varchar(20) DEFAULT 'Available'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ambulance_loc`
--

LOCK TABLES `Ambulance_loc` WRITE;
/*!40000 ALTER TABLE `Ambulance_loc` DISABLE KEYS */;
INSERT INTO `Ambulance_loc` VALUES ('KA016738',79,32,500,20,'Available'),('KA052974',72,41,500,20,'Available'),('KA048321',45,59,500,20,'Available'),('KA016392',45,54,500,20,'Available'),('KA075171',18,56,500,20,'Available'),('KA091347',7,42,500,20,'Available');
/*!40000 ALTER TABLE `Ambulance_loc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Diseases`
--

DROP TABLE IF EXISTS `Diseases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Diseases` (
  `Disease` varchar(20) DEFAULT NULL,
  `Tools` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Diseases`
--

LOCK TABLES `Diseases` WRITE;
/*!40000 ALTER TABLE `Diseases` DISABLE KEYS */;
INSERT INTO `Diseases` VALUES ('A','A1'),('A','A2'),('B','A1'),('B','B1'),('B','B2'),('C','C1'),('C','C2'),('C','B2'),('D','A1'),('D','C2'),('D','D1'),('D','D2');
/*!40000 ALTER TABLE `Diseases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Hospitals`
--

DROP TABLE IF EXISTS `Hospitals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Hospitals` (
  `x` int(11) DEFAULT NULL,
  `y` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Hospitals`
--

LOCK TABLES `Hospitals` WRITE;
/*!40000 ALTER TABLE `Hospitals` DISABLE KEYS */;
INSERT INTO `Hospitals` VALUES (10,99),(45,87),(15,23),(62,45),(85,8);
/*!40000 ALTER TABLE `Hospitals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Patient_records`
--

DROP TABLE IF EXISTS `Patient_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Patient_records` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `x` int(11) DEFAULT NULL,
  `y` int(11) DEFAULT NULL,
  `disease` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=186 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patient_records`
--

LOCK TABLES `Patient_records` WRITE;
/*!40000 ALTER TABLE `Patient_records` DISABLE KEYS */;
INSERT INTO `Patient_records` VALUES (1,33,77,'A'),(2,89,26,'A'),(3,25,44,'A'),(4,80,30,'A'),(5,38,8,'A'),(6,69,70,'A'),(7,50,96,'A'),(8,79,63,'A'),(9,41,89,'A'),(10,81,79,'A'),(11,44,9,'A'),(12,20,27,'A'),(13,46,41,'A'),(14,83,66,'A'),(15,81,83,'A'),(16,17,88,'A'),(17,42,43,'A'),(18,58,33,'A'),(19,49,47,'A'),(20,38,1,'A'),(21,47,13,'A'),(22,43,58,'A'),(23,12,1,'A'),(24,87,12,'A'),(25,24,38,'A'),(26,55,14,'A'),(27,78,19,'A'),(28,69,58,'A'),(29,33,62,'A'),(30,41,7,'A'),(31,64,6,'A'),(32,7,97,'A'),(33,41,45,'A'),(34,61,69,'A'),(35,11,67,'A'),(36,92,34,'B'),(37,17,13,'B'),(38,55,36,'B'),(39,93,65,'B'),(40,43,51,'B'),(41,36,43,'B'),(42,62,5,'B'),(43,94,84,'B'),(44,86,80,'B'),(45,87,61,'B'),(46,81,35,'B'),(47,86,15,'B'),(48,92,46,'B'),(49,73,58,'B'),(50,2,62,'B'),(51,45,99,'B'),(52,44,50,'B'),(53,48,65,'B'),(54,43,8,'B'),(55,25,49,'B'),(56,0,6,'B'),(57,34,65,'B'),(58,12,25,'B'),(59,16,34,'B'),(60,53,26,'B'),(61,26,51,'B'),(62,61,11,'B'),(63,73,35,'B'),(64,40,69,'B'),(65,5,32,'B'),(66,61,48,'C'),(67,75,94,'C'),(68,21,43,'C'),(69,93,61,'C'),(70,38,45,'C'),(71,43,99,'C'),(72,27,49,'C'),(73,91,12,'C'),(74,51,50,'C'),(75,5,42,'C'),(76,71,30,'C'),(77,13,79,'C'),(78,81,10,'C'),(79,18,35,'C'),(80,87,68,'C'),(81,90,79,'C'),(82,68,22,'C'),(83,7,99,'C'),(84,54,25,'C'),(85,46,67,'C'),(86,59,9,'C'),(87,88,5,'C'),(88,2,7,'C'),(89,92,52,'C'),(90,4,62,'C'),(91,56,81,'C'),(92,22,51,'C'),(93,83,16,'C'),(94,12,94,'C'),(95,28,39,'C'),(96,3,73,'C'),(97,38,16,'C'),(98,59,77,'C'),(99,30,43,'C'),(100,71,78,'D'),(101,88,54,'D'),(102,26,64,'D'),(103,30,90,'D'),(104,86,2,'D'),(105,65,82,'D'),(106,96,93,'D'),(107,66,78,'D'),(108,93,50,'D'),(109,82,9,'D'),(110,53,45,'D'),(111,7,42,'D'),(112,18,67,'D'),(113,39,67,'D'),(114,13,64,'D'),(115,21,27,'D'),(116,1,23,'D'),(117,13,95,'D'),(118,51,35,'D'),(119,9,94,'D'),(120,57,26,'D'),(121,4,75,'C'),(122,99,21,'A'),(123,84,81,'B'),(124,82,13,'A'),(125,84,71,'A'),(126,73,85,'A'),(127,84,96,'A'),(128,15,11,'A'),(129,75,85,'A'),(130,75,85,'A'),(131,75,85,'A'),(132,75,87,'A'),(133,98,15,'A'),(134,96,79,'A'),(135,87,89,'A'),(136,69,71,'A'),(137,90,85,'A'),(138,76,88,'A'),(139,98,12,'A'),(140,98,12,'A'),(141,98,12,'A'),(142,75,97,'A'),(143,87,77,'A'),(144,69,79,'A'),(145,91,86,'A'),(146,80,70,'A'),(147,30,40,'A'),(148,97,84,'A'),(149,97,87,'A'),(150,97,85,'A'),(151,79,84,'B'),(152,11,21,'C'),(153,11,21,'A'),(154,7,3,'D'),(155,54,14,'A'),(156,62,13,'A'),(157,36,54,'A'),(158,96,36,'A'),(159,87,74,'A'),(160,7,36,'A'),(161,96,11,'A'),(162,12,17,'A'),(163,12,17,'A'),(164,19,21,'A'),(165,98,36,'A'),(166,69,13,'A'),(167,98,69,'A'),(168,77,74,'A'),(169,99,12,'A'),(170,99,12,'A'),(171,7,88,'A'),(172,11,17,'A'),(173,82,23,'A'),(174,7,5,'A'),(175,12,32,'A'),(176,1,21,'B'),(177,63,21,'B'),(178,63,21,'A'),(179,63,21,'A'),(180,67,69,'A'),(181,17,32,'A'),(182,17,32,'A'),(183,98,63,'A'),(184,11,12,'A'),(185,78,96,'A');
/*!40000 ALTER TABLE `Patient_records` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-07 22:26:47
