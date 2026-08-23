-- MySQL dump 10.13  Distrib 26.7.0, for macos15 (arm64)
--
-- Host: localhost    Database: cyber_risk_assessment
-- ------------------------------------------------------
-- Server version	26.7.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `answers`
--

DROP TABLE IF EXISTS `answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question_id` int NOT NULL,
  `selected_option` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `question_id` (`question_id`),
  CONSTRAINT `answers_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answers`
--

LOCK TABLES `answers` WRITE;
/*!40000 ALTER TABLE `answers` DISABLE KEYS */;
INSERT INTO `answers` VALUES (1,1,'No'),(2,2,'Yes'),(3,3,'Yes'),(4,4,'No'),(5,5,'Yes'),(6,6,'Yes'),(7,7,'No'),(8,8,'Yes'),(9,9,'Yes'),(19,1,'Yes'),(20,2,'No'),(21,3,'Yes'),(22,4,'No'),(23,5,'No'),(24,6,'No'),(25,7,'Yes'),(26,8,'Yes'),(27,9,'No'),(28,1,'Yes'),(29,2,'No'),(30,3,'No'),(31,4,'Yes'),(32,5,'Yes'),(33,6,'No'),(34,7,'Yes'),(35,8,'Yes'),(36,9,'No'),(37,1,'Yes'),(38,2,'Yes'),(39,3,'Yes'),(40,4,'Yes'),(41,5,'No'),(42,6,'No'),(43,7,'Yes'),(44,8,'Yes'),(45,9,'No'),(46,1,'Yes'),(47,2,'Yes'),(48,3,'Yes'),(49,4,'No'),(50,5,'No'),(51,6,'Yes'),(52,7,'Yes'),(53,8,'No'),(54,9,'No'),(55,1,'No'),(56,2,'No'),(57,3,'No'),(58,4,'No'),(59,5,'No'),(60,6,'No'),(61,7,'No'),(62,8,'No'),(63,9,'No'),(64,1,'No'),(65,2,'No'),(66,3,'No'),(67,4,'No'),(68,5,'No'),(69,6,'No'),(70,7,'No'),(71,8,'No'),(72,9,'No'),(73,1,'Yes'),(74,2,'Yes'),(75,3,'No'),(76,4,'Yes'),(77,5,'Yes'),(78,6,'No'),(79,7,'Yes'),(80,8,'Yes'),(81,9,'Yes'),(82,1,'No'),(83,2,'Yes'),(84,3,'No'),(85,4,'Yes'),(86,5,'Yes'),(87,6,'Yes'),(88,7,'No'),(89,8,'No'),(90,9,'No'),(91,1,'Yes'),(92,2,'No'),(93,3,'No'),(94,4,'No'),(95,5,'Yes'),(96,6,'Yes'),(97,7,'Yes'),(98,8,'No'),(99,9,'Yes'),(100,1,'Yes'),(101,2,'No'),(102,3,'No'),(103,4,'Yes'),(104,5,'Yes'),(105,6,'Yes'),(106,7,'Yes'),(107,8,'No'),(108,9,'Yes'),(109,1,'Yes'),(110,2,'Yes'),(111,3,'Yes'),(112,4,'No'),(113,5,'No'),(114,6,'Yes'),(115,7,'Yes'),(116,8,'Yes'),(117,9,'No'),(118,1,'Yes'),(119,2,'Yes'),(120,3,'Yes'),(121,4,'Yes'),(122,5,'Yes'),(123,6,'No'),(124,7,'No'),(125,8,'No'),(126,9,'No'),(127,1,'Yes'),(128,2,'No'),(129,3,'No'),(130,4,'No'),(131,5,'Yes'),(132,6,'Yes'),(133,7,'Yes'),(134,8,'Yes'),(135,9,'Yes'),(136,1,'Yes'),(137,2,'Yes'),(138,3,'Yes'),(139,4,'Yes'),(140,5,'Yes'),(141,6,'Yes'),(142,7,'Yes'),(143,8,'Yes'),(144,9,'No'),(145,1,'Yes'),(146,2,'No'),(147,3,'Yes'),(148,4,'Yes'),(149,5,'Yes'),(150,6,'Yes'),(151,7,'No'),(152,8,'No'),(153,9,'Yes'),(154,1,'Yes'),(155,2,'Yes'),(156,3,'Yes'),(157,4,'No'),(158,5,'Yes'),(159,6,'Yes'),(160,7,'Yes'),(161,8,'No'),(162,9,'Yes');
/*!40000 ALTER TABLE `answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assessments`
--

DROP TABLE IF EXISTS `assessments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assessments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `business_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `business_id` (`business_id`),
  CONSTRAINT `assessments_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessments`
--

LOCK TABLES `assessments` WRITE;
/*!40000 ALTER TABLE `assessments` DISABLE KEYS */;
INSERT INTO `assessments` VALUES (1,1,'2026-08-20 20:36:10'),(2,1,'2026-08-20 20:42:16'),(3,1,'2026-08-20 20:58:00'),(4,1,'2026-08-20 21:01:56'),(5,1,'2026-08-20 21:05:45'),(6,1,'2026-08-21 04:11:43'),(7,1,'2026-08-21 04:31:28'),(8,1,'2026-08-21 04:48:16'),(9,1,'2026-08-21 04:51:53'),(10,2,'2026-08-21 05:30:17'),(11,2,'2026-08-21 05:47:19'),(12,3,'2026-08-21 06:51:18'),(13,3,'2026-08-21 07:05:50'),(14,4,'2026-08-21 07:16:42'),(15,3,'2026-08-21 12:58:32'),(16,5,'2026-08-21 13:10:24');
/*!40000 ALTER TABLE `assessments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `businesses`
--

DROP TABLE IF EXISTS `businesses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `businesses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `industry` varchar(80) NOT NULL,
  `user_id` int NOT NULL,
  `employees` int DEFAULT NULL,
  `digital_services` text,
  `data_handled` text,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `businesses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `businesses`
--

LOCK TABLES `businesses` WRITE;
/*!40000 ALTER TABLE `businesses` DISABLE KEYS */;
INSERT INTO `businesses` VALUES (1,'ABC Computers','IT Services',52,10,'Website, Email, Cloud','Customer information'),(2,'Test Cyber Business','Small Business',53,10,'yes','Customer Information'),(3,'Demo Cyber Solutions','IT Services',54,10,'Website, Email, Online Payments','Customer information and business data'),(4,'Final Business Test','Engineering',55,12,'Online services','customer details'),(5,'clare waffles','bakery',57,5,'online delivery , online payment ,customer service','payment , customer data ');
/*!40000 ALTER TABLE `businesses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `text` text NOT NULL,
  `category` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (1,'Does your business use strong passwords?','Password Security'),(2,'Is Multi-Factor Authentication enabled?','MFA'),(3,'Is a firewall used to protect your business network?','Firewall'),(4,'Is antivirus software installed and regularly updated?','Antivirus'),(5,'Are regular backups of important business data maintained?','Data Backup'),(6,'Do employees receive cybersecurity awareness training?','Employee Training'),(7,'Is access to sensitive data restricted to authorized employees?','Access Control'),(8,'Is sensitive business data properly protected?','Data Protection'),(9,'Does your business have an incident response plan?','Incident Response');
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recommendations`
--

DROP TABLE IF EXISTS `recommendations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recommendations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assessment_id` int NOT NULL,
  `action_item` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `assessment_id` (`assessment_id`),
  CONSTRAINT `recommendations_ibfk_1` FOREIGN KEY (`assessment_id`) REFERENCES `assessments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recommendations`
--

LOCK TABLES `recommendations` WRITE;
/*!40000 ALTER TABLE `recommendations` DISABLE KEYS */;
INSERT INTO `recommendations` VALUES (1,7,'Configure and maintain a firewall to protect the business network.'),(2,7,'Provide regular cybersecurity awareness training to employees.'),(3,8,'Use strong and unique passwords for all business accounts.'),(4,8,'Configure and maintain a firewall to protect the business network.'),(5,8,'Restrict access to sensitive data to authorized employees.'),(6,8,'Use appropriate security controls to protect sensitive business data.'),(7,8,'Create and maintain a cybersecurity incident response plan.'),(8,9,'Enable Multi-Factor Authentication for important accounts.'),(9,9,'Configure and maintain a firewall to protect the business network.'),(10,9,'Install and regularly update antivirus software.'),(11,9,'Use appropriate security controls to protect sensitive business data.'),(12,10,'Enable Multi-Factor Authentication for important accounts.'),(13,10,'Configure and maintain a firewall to protect the business network.'),(14,10,'Use appropriate security controls to protect sensitive business data.'),(15,11,'Install and regularly update antivirus software.'),(16,11,'Maintain regular backups of important business data.'),(17,11,'Create and maintain a cybersecurity incident response plan.'),(18,12,'Provide regular cybersecurity awareness training to employees.'),(19,12,'Restrict access to sensitive data to authorized employees.'),(20,12,'Use appropriate security controls to protect sensitive business data.'),(21,12,'Create and maintain a cybersecurity incident response plan.'),(22,13,'Enable Multi-Factor Authentication for important accounts.'),(23,13,'Configure and maintain a firewall to protect the business network.'),(24,13,'Install and regularly update antivirus software.'),(25,14,'Create and maintain a cybersecurity incident response plan.'),(26,15,'Enable Multi-Factor Authentication for important accounts.'),(27,15,'Restrict access to sensitive data to authorized employees.'),(28,15,'Use appropriate security controls to protect sensitive business data.'),(29,16,'Install and regularly update antivirus software.'),(30,16,'Use appropriate security controls to protect sensitive business data.');
/*!40000 ALTER TABLE `recommendations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `risks`
--

DROP TABLE IF EXISTS `risks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `risks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assessment_id` int NOT NULL,
  `description` text NOT NULL,
  `severity` varchar(50) NOT NULL,
  `likelihood` int NOT NULL,
  `impact` int NOT NULL,
  `risk_score` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `assessment_id` (`assessment_id`),
  CONSTRAINT `risks_ibfk_1` FOREIGN KEY (`assessment_id`) REFERENCES `assessments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `risks`
--

LOCK TABLES `risks` WRITE;
/*!40000 ALTER TABLE `risks` DISABLE KEYS */;
INSERT INTO `risks` VALUES (1,1,'Cybersecurity assessment has 5 security weaknesses.','MEDIUM',0,0,0),(2,2,'Cybersecurity assessment has 4 security weaknesses.','MEDIUM',0,0,0),(3,3,'Lack of Data Backup','HIGH',3,5,15),(4,3,'Lack of Employee Training','HIGH',4,4,16),(5,3,'No Incident Response Plan','HIGH',3,4,12),(6,4,'Inadequate Antivirus Protection','HIGH',4,4,16),(7,4,'Lack of Data Backup','HIGH',3,5,15),(8,4,'Poor Data Protection','HIGH',4,5,20),(9,4,'No Incident Response Plan','HIGH',3,4,12),(10,5,'Weak Passwords','HIGH',4,4,16),(11,5,'No Multi-Factor Authentication','CRITICAL',5,5,25),(12,5,'Inadequate Firewall Protection','HIGH',4,5,20),(13,5,'Inadequate Antivirus Protection','HIGH',4,4,16),(14,5,'Lack of Data Backup','HIGH',3,5,15),(15,5,'Lack of Employee Training','HIGH',4,4,16),(16,5,'Poor Access Control','HIGH',4,5,20),(17,5,'Poor Data Protection','HIGH',4,5,20),(18,5,'No Incident Response Plan','HIGH',3,4,12),(19,6,'Weak Passwords','HIGH',4,4,16),(20,6,'No Multi-Factor Authentication','CRITICAL',5,5,25),(21,6,'Inadequate Firewall Protection','HIGH',4,5,20),(22,6,'Inadequate Antivirus Protection','HIGH',4,4,16),(23,6,'Lack of Data Backup','HIGH',3,5,15),(24,6,'Lack of Employee Training','HIGH',4,4,16),(25,6,'Poor Access Control','HIGH',4,5,20),(26,6,'Poor Data Protection','HIGH',4,5,20),(27,6,'No Incident Response Plan','HIGH',3,4,12),(28,7,'Inadequate Firewall Protection','HIGH',4,5,20),(29,7,'Lack of Employee Training','HIGH',4,4,16),(30,8,'Weak Passwords','HIGH',4,4,16),(31,8,'Inadequate Firewall Protection','HIGH',4,5,20),(32,8,'Poor Access Control','HIGH',4,5,20),(33,8,'Poor Data Protection','HIGH',4,5,20),(34,8,'No Incident Response Plan','HIGH',3,4,12),(35,9,'No Multi-Factor Authentication','CRITICAL',5,5,25),(36,9,'Inadequate Firewall Protection','HIGH',4,5,20),(37,9,'Inadequate Antivirus Protection','HIGH',4,4,16),(38,9,'Poor Data Protection','HIGH',4,5,20),(39,10,'No Multi-Factor Authentication','CRITICAL',5,5,25),(40,10,'Inadequate Firewall Protection','HIGH',4,5,20),(41,10,'Poor Data Protection','HIGH',4,5,20),(42,11,'Inadequate Antivirus Protection','HIGH',4,4,16),(43,11,'Lack of Data Backup','HIGH',3,5,15),(44,11,'No Incident Response Plan','HIGH',3,4,12),(45,12,'Lack of Employee Training','HIGH',4,4,16),(46,12,'Poor Access Control','HIGH',4,5,20),(47,12,'Poor Data Protection','HIGH',4,5,20),(48,12,'No Incident Response Plan','HIGH',3,4,12),(49,13,'No Multi-Factor Authentication','CRITICAL',5,5,25),(50,13,'Inadequate Firewall Protection','HIGH',4,5,20),(51,13,'Inadequate Antivirus Protection','HIGH',4,4,16),(52,14,'No Incident Response Plan','HIGH',3,4,12),(53,15,'No Multi-Factor Authentication','CRITICAL',5,5,25),(54,15,'Poor Access Control','HIGH',4,5,20),(55,15,'Poor Data Protection','HIGH',4,5,20),(56,16,'Inadequate Antivirus Protection','HIGH',4,4,16),(57,16,'Poor Data Protection','HIGH',4,5,20);
/*!40000 ALTER TABLE `risks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Test User','test@example.com','Test123','2026-08-20 14:13:49'),(52,'tester','tester@123.com','scrypt:32768:8:1$KUDkGdwiBpvdMGTI$93b81748149b74018fd312b89f16ecafb9e653f8bdef8203e70d2770a959e56faca19939b322562df322ab6d47c487426de2ac6f5b68e5cfd599871744ecd616','2026-08-20 19:06:16'),(53,'Login Test','logintest@example.com','scrypt:32768:8:1$MOJGvusbSC4V0gS2$e342fa8b1adbacac787b1c3828bae0e4e27258435dd2c222121719add572d10c77d10bcad004c21c28e3d4835061ce361cc57307dea76c369e8adff846be5401','2026-08-20 19:24:17'),(54,'Demo User','demo@example.com','scrypt:32768:8:1$yofq2nzVm1IgPSJW$b02b9330729742c04c3c426eb268991f17054c5eba5b9be338a330c82ba24df03d23dd93f1d3212df7169485677b830094b7582032bf0b14715549b098ea014a','2026-08-21 06:44:39'),(55,'Final Test User','useanewemail@12.com','scrypt:32768:8:1$ml4qID78nWT5qFIG$e152c4c9bf2907fa0fa6d8e53c482b08180cc01a19daaaedf1267ffc3bbb9d1ca4e6033f7adb6b0e4ddb40914978cd67ed9cc97577bc6921295d285999cb55ab','2026-08-21 07:14:02'),(57,'clare collins','clare134@gmail.com','scrypt:32768:8:1$nUAoslD2fBq4LrGo$d8454cdb05990f90dd6c2f7715ab70ef6a116ce98c649c1f0005f556cba2dbfe527a470ea0b3535ec8e1dfb2b7dc214290f72ab6cabb5be104295beb02637789','2026-08-21 13:06:06');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'cyber_risk_assessment'
--

--
-- Dumping routines for database 'cyber_risk_assessment'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-21 19:00:34
