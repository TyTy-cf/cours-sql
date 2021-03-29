CREATE DATABASE  IF NOT EXISTS `cours` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `cours`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: cours
-- ------------------------------------------------------
-- Server version	5.5.5-10.2.9-MariaDB

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
-- Table structure for table `etudiant`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `students` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `last_name` varchar(255) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `height` int(3) DEFAULT NULL,
  `sex` enum('M','F') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etudiant`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `etudiant` DISABLE KEYS */;
INSERT INTO `students` VALUES (1,'Parker','Candace',168,'M'),(2,'Sawayn','Esther',157,'M'),(3,'Swaniawski','Arlo',165,'F'),(4,'Casper','Jasper',137,'M'),(5,'Huel','Mateo',125,'M'),(6,'Corkery','Bernard',127,'F'),(7,'Douglas','May',144,'M'),(8,'Stracke','Maxine',140,'F'),(9,'Jones','Dante',123,'F'),(10,'White','Gregg',197,'M'),(11,'Keebler','Kaitlyn',170,'F'),(12,'Emard','Gabriella',207,'F'),(13,'Franecki','Bud',139,'M'),(14,'Cronin','Barrett',176,'M'),(15,'Ernser','Alexandro',176,'M'),(16,'Bernhard','Aleen',194,'F'),(17,'Stoltenberg','Andres',176,'F'),(18,'Predovic','Susie',210,'F'),(19,'Hirthe','Bradley',179,'F'),(20,'Okuneva','Carroll',184,'F'),(21,'Johnson','Eleonore',181,'F'),(22,'Champlin','Jolie',121,'M'),(23,'Reynolds','Uriel',124,'M'),(24,'Hermann','Santina',187,'F'),(25,'Kassulke','Augustine',196,'F'),(26,'Harvey','Carolyn',127,'F'),(27,'Kohler','Edyth',186,'M'),(28,'Kulas','Imogene',187,'F'),(29,'Dooley','Korey',188,'M'),(30,'Wintheiser','Aubrey',139,'M'),(31,'Torphy','Jerel',171,'F'),(32,'Stamm','Jany',176,'M'),(33,'Kuhlman','Laila',194,'F'),(34,'Orn','Chadd',156,'F'),(35,'Gusikowski','Bernadette',135,'F'),(36,'Jacobson','Ephraim',148,'M'),(37,'Bradtke','Reta',133,'F'),(38,'Muller','Lavon',201,'F'),(39,'Turner','Lilla',166,'M'),(40,'Emard','Annabell',190,'M'),(41,'Pollich','Kitty',191,'F'),(42,'Bednar','Elyse',124,'F'),(43,'Rodriguez','Estefania',210,'F'),(44,'Hane','Estefania',191,'M'),(45,'Greenfelder','Bernice',175,'M'),(46,'Heaney','Golden',135,'M'),(47,'Champlin','Lionel',186,'M'),(48,'Dare','Jadon',124,'M'),(49,'Ortiz','Jaylon',138,'M'),(50,'Emmerich','Leanna',191,'M'),(51,'Hagenes','Isadore',172,'M'),(52,'Funk','Nathanael',194,'M'),(53,'Kessler','Madyson',171,'F'),(54,'Davis','Kaylah',197,'M'),(55,'Bradtke','General',136,'F'),(56,'Koss','Ruby',166,'F'),(57,'Schaefer','Lamont',172,'M'),(58,'Kuhlman','Gracie',194,'M'),(59,'O\'Connell','Tyra',201,'F'),(60,'Boehm','Domenico',144,'M');
/*!40000 ALTER TABLE `etudiant` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-11-08 14:15:45
