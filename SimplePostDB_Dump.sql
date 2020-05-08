-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: simplepostdb
-- ------------------------------------------------------
-- Server version	8.0.17

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
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(200) NOT NULL,
  `title` varchar(200) NOT NULL,
  `textbox` text NOT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,'admin','Is that Lorem Ipsum?','Id sumo nostrud suavitate mea, in vis graeco philosophia, in affert urbanitas pro. Id est graece quidam appareat, cum ei simul elitr. Nec in modo invenire, et quas perpetua sed, cu usu aliquip debitis nusquam. An quo ponderum ullamcorper, eu qui inciderint reprehendunt.','2019-08-31 23:28:19'),(2,'admin','Another Lorem Ipsum','Qui vero tempor tacimates te, pri at sonet soleat sapientem, quo melius quaeque equidem ut. Prima habemus et per, id harum soleat mea, ne nostrum percipitur voluptatibus qui. Mea appetere tacimates at. Nec albucius offendit no. Salutandi posidonium duo cu.\r\n\r\nEx novum populo apeirian cum. Viris exerci suavitate no has. Unum probatus ea vis, alia augue prodesset at eam. Quas praesent mei id. Ullum salutandi corrumpit ea sed. Te quando putant constituam ius, no corpora vituperata eos.\r\n\r\nPri tale perfecto ne, solum scripserit vis et. Pri eu nullam debitis consectetuer. Tritani accumsan senserit cu pro, cu wisi rebum vocent sea. Ea nec consul torquatos, graeci habemus voluptaria an vel. Ei sed viderer delicata intellegebat.','2019-08-31 23:28:37'),(3,'admin','Lorem Upsum all over the world!','Eu ignota dolorem dissentiet eos. At usu erant animal interesset, laudem alienum ea pri. Mei te habeo integre diceret, in duo novum denique salutatus, ad mea officiis repudiandae. In sit phaedrum adolescens, ad nibh animal eam. Nec ad sumo rebum, an ceteros constituto est. Ei eum possim epicurei.\r\n\r\nVivendo omittam eloquentiam duo no. Cu vim animal invenire cotidieque. Cu meis dicat philosophia vim, option facilisis pri ei. Vel persius mandamus consectetuer ut. Mei volumus adipiscing ne.','2019-08-31 23:29:09'),(4,'admin','Test Post','This is a post saved in the data base so all the user can see it. Even those that are not login.','2019-08-31 23:29:44');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `type` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','1234','admin');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-08-31 23:53:43
