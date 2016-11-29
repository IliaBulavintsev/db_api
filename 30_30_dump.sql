-- MySQL dump 10.13  Distrib 5.6.28, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: api
-- ------------------------------------------------------
-- Server version	5.6.28-0ubuntu0.15.04.1

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
-- Table structure for table `Followings`
--

DROP TABLE IF EXISTS `Followings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Followings` (
  `followee` varchar(30) NOT NULL,
  `follower` varchar(30) NOT NULL,
  KEY `followee` (`followee`),
  KEY `follower` (`follower`),
  CONSTRAINT `Foll_ibfk_1` FOREIGN KEY (`followee`) REFERENCES `Users` (`email`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Foll_ibfk_2` FOREIGN KEY (`follower`) REFERENCES `Users` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Followings`
--

LOCK TABLES `Followings` WRITE;
/*!40000 ALTER TABLE `Followings` DISABLE KEYS */;
/*!40000 ALTER TABLE `Followings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Forums`
--

DROP TABLE IF EXISTS `Forums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Forums` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `short_name` varchar(50) NOT NULL,
  `user` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `short_name` (`short_name`),
  KEY `user` (`user`),
  CONSTRAINT `Forums_ibfk_1` FOREIGN KEY (`user`) REFERENCES `Users` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Forums`
--

LOCK TABLES `Forums` WRITE;
/*!40000 ALTER TABLE `Forums` DISABLE KEYS */;
INSERT INTO `Forums` VALUES (1,'Forum With Sufficiently Large Name','forumwithsufficientlylargename','example2@mail.ru'),(2,'Forum I','forum1','example3@mail.ru'),(3,'Forum II','forum2','example@mail.ru'),(4,'Форум Три','forum3','example3@mail.ru');
/*!40000 ALTER TABLE `Forums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Posts`
--

DROP TABLE IF EXISTS `Posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `message` mediumtext NOT NULL,
  `parent` int(11) NOT NULL DEFAULT '0',
  `stateMask` tinyint(4) NOT NULL DEFAULT '0',
  `likes` int(11) NOT NULL DEFAULT '0',
  `dislikes` int(11) NOT NULL DEFAULT '0',
  `path` varchar(500) NOT NULL DEFAULT '',
  `root` varchar(7) NOT NULL DEFAULT '',
  `thread` int(11) NOT NULL,
  `user` varchar(30) NOT NULL,
  `forum` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `forum` (`forum`),
  KEY `thread` (`thread`),
  KEY `user` (`user`),
  CONSTRAINT `Posts_ibfk_1` FOREIGN KEY (`forum`) REFERENCES `Forums` (`short_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Posts_ibfk_2` FOREIGN KEY (`thread`) REFERENCES `Threads` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Posts_ibfk_3` FOREIGN KEY (`user`) REFERENCES `Users` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Posts`
--

LOCK TABLES `Posts` WRITE;
/*!40000 ALTER TABLE `Posts` DISABLE KEYS */;
INSERT INTO `Posts` VALUES (1,'2016-06-15 00:38:59','my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0',0,16,0,0,'0000001','0000001',1,'example4@mail.ru','forum1'),(2,'2016-09-11 20:20:53','my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1',1,12,0,0,'0000001.0000002','0000001',1,'richard.nixon@example.com','forum1'),(3,'2016-09-19 17:01:54','my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2',2,25,0,0,'0000001.0000002.0000003','0000001',1,'example3@mail.ru','forum1'),(4,'2016-09-25 17:14:53','my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3',0,0,0,0,'0000004','0000004',1,'example@mail.ru','forum1'),(5,'2016-11-20 18:17:58','my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4',0,24,0,0,'0000005','0000005',1,'example3@mail.ru','forum1'),(6,'2016-11-25 18:22:39','my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5',0,0,0,0,'0000006','0000006',1,'example@mail.ru','forum1'),(7,'2016-11-26 02:01:06','my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6',4,29,0,0,'0000004.0000007','0000004',1,'example4@mail.ru','forum1'),(8,'2016-11-26 08:22:31','my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7',1,8,0,0,'0000001.0000008','0000001',1,'richard.nixon@example.com','forum1'),(9,'2016-11-26 11:37:32','my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8',4,28,0,0,'0000004.0000009','0000004',1,'example3@mail.ru','forum1'),(10,'2016-11-29 16:34:17','my message 9my message 9my message 9my message 9my message 9my message 9my message 9my message 9my message 9my message 9my message 9my message 9my message 9my message 9my message 9my message 9my message 9',6,29,0,0,'0000006.0000010','0000006',1,'example@mail.ru','forum1'),(11,'2016-05-22 02:16:47','my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0',0,0,0,0,'0000011','0000011',2,'example4@mail.ru','forum2'),(12,'2016-08-17 00:15:05','my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1',0,20,0,0,'0000012','0000012',2,'richard.nixon@example.com','forum2'),(13,'2016-10-30 10:36:40','my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2',0,29,0,1,'0000013','0000013',2,'example3@mail.ru','forum2'),(14,'2016-11-24 13:17:18','my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3',0,4,0,0,'0000014','0000014',2,'example@mail.ru','forum2'),(15,'2016-11-28 15:27:49','my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4',0,5,0,0,'0000015','0000015',2,'richard.nixon@example.com','forum2'),(16,'2016-11-29 15:50:55','my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5',11,21,0,0,'0000011.0000016','0000011',2,'example3@mail.ru','forum2'),(17,'2016-11-29 19:37:14','my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6',0,29,0,0,'0000017','0000017',2,'richard.nixon@example.com','forum2'),(18,'2016-11-29 19:47:58','my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7',0,29,0,0,'0000018','0000018',2,'richard.nixon@example.com','forum2'),(19,'2016-11-29 20:45:06','my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8',11,12,0,0,'0000011.0000019','0000011',2,'example2@mail.ru','forum2'),(20,'2016-08-08 09:56:15','my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0',0,8,0,0,'0000020','0000020',3,'example4@mail.ru','forum1'),(21,'2016-11-03 05:43:16','my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1',20,12,0,0,'0000020.0000021','0000020',3,'example2@mail.ru','forum1'),(22,'2016-11-24 21:31:34','my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2',0,5,0,0,'0000022','0000022',3,'example2@mail.ru','forum1'),(23,'2016-11-27 05:46:41','my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3',0,24,0,0,'0000023','0000023',3,'example3@mail.ru','forum1'),(24,'2016-11-29 01:57:23','my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4',23,16,0,0,'0000023.0000024','0000023',3,'example@mail.ru','forum1'),(25,'2016-11-29 19:34:28','my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5',0,16,0,0,'0000025','0000025',3,'example@mail.ru','forum1'),(26,'2016-11-29 21:13:38','my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6',22,4,0,0,'0000022.0000026','0000022',3,'richard.nixon@example.com','forum1'),(27,'2016-11-14 03:30:24','my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0',0,24,0,0,'0000027','0000027',4,'example2@mail.ru','forum2'),(28,'2016-11-21 04:25:50','my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1',27,28,0,0,'0000027.0000028','0000027',4,'richard.nixon@example.com','forum2'),(29,'2016-11-28 17:05:57','my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2',27,21,0,0,'0000027.0000029','0000027',4,'example@mail.ru','forum2'),(30,'2016-11-29 03:34:15','my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3',28,20,0,0,'0000027.0000028.0000030','0000027',4,'example3@mail.ru','forum2'),(31,'2016-11-29 19:53:35','my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4',30,21,0,0,'0000027.0000028.0000030.0000031','0000027',4,'example2@mail.ru','forum2'),(32,'2016-11-29 20:18:31','my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5',0,28,0,0,'0000032','0000032',4,'richard.nixon@example.com','forum2'),(33,'2016-11-29 21:12:07','my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6',32,4,0,0,'0000032.0000033','0000032',4,'example3@mail.ru','forum2');
/*!40000 ALTER TABLE `Posts` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`tp`@`localhost`*/ /*!50003 TRIGGER update_posts_count_onupdate AFTER UPDATE ON Posts FOR EACH ROW
BEGIN
    IF ((NEW.stateMask & 2) != 0  AND (OLD.stateMask & 2) = 0) THEN
        UPDATE Threads SET posts=posts - 1 WHERE id= NEW.thread;
    ELSEIF ((NEW.stateMask & 2) = 0  AND (OLD.stateMask & 2) != 0) THEN
        UPDATE Threads SET posts=posts + 1 WHERE id= NEW.thread;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Subscriptions`
--

DROP TABLE IF EXISTS `Subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Subscriptions` (
  `user` varchar(30) NOT NULL,
  `thread` int(11) NOT NULL,
  KEY `thread` (`thread`),
  KEY `user` (`user`),
  CONSTRAINT `Subs_ibfk_1` FOREIGN KEY (`thread`) REFERENCES `Threads` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Subs_ibfk_2` FOREIGN KEY (`user`) REFERENCES `Users` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Subscriptions`
--

LOCK TABLES `Subscriptions` WRITE;
/*!40000 ALTER TABLE `Subscriptions` DISABLE KEYS */;
INSERT INTO `Subscriptions` VALUES ('example@mail.ru',2),('example3@mail.ru',1),('example@mail.ru',2),('richard.nixon@example.com',4),('example@mail.ru',4);
/*!40000 ALTER TABLE `Subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Threads`
--

DROP TABLE IF EXISTS `Threads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Threads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `forum` varchar(50) NOT NULL,
  `title` varchar(100) NOT NULL,
  `user` varchar(30) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `message` varchar(10000) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `stateMask` tinyint(4) NOT NULL,
  `likes` int(11) NOT NULL,
  `dislikes` int(11) NOT NULL,
  `posts` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `forum` (`forum`),
  KEY `user` (`user`),
  CONSTRAINT `Threads_ibfk_1` FOREIGN KEY (`forum`) REFERENCES `Forums` (`short_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Threads_ibfk_2` FOREIGN KEY (`user`) REFERENCES `Users` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Threads`
--

LOCK TABLES `Threads` WRITE;
/*!40000 ALTER TABLE `Threads` DISABLE KEYS */;
INSERT INTO `Threads` VALUES (1,'forum1','Thread With Sufficiently Large Title','example4@mail.ru','2013-12-31 20:00:01','hey hey hey hey!','Threadwithsufficientlylargetitle',2,0,0,10),(2,'forum2','Thread I','example@mail.ru','2013-12-30 20:01:01','hey!','newslug',0,1,0,9),(3,'forum1','Thread II','richard.nixon@example.com','2013-12-29 20:01:01','hey hey!','thread2',0,0,0,7),(4,'forum2','Тред Три','example4@mail.ru','2013-12-28 20:01:01','hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! ','thread3',0,0,0,7);
/*!40000 ALTER TABLE `Threads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(30) NOT NULL,
  `about` varchar(5000) DEFAULT NULL,
  `isAnonymous` tinyint(4) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `username` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1,'example@mail.ru','hello im user1',0,'John','user1'),(2,'richard.nixon@example.com',NULL,1,NULL,NULL),(3,'example2@mail.ru','Wowowowow',0,'NewName','user2'),(4,'example3@mail.ru','Wowowowow!!!',0,'NewName2','user3'),(5,'example4@mail.ru','hello im user4',0,'Jim','user4');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'api'
--
/*!50003 DROP FUNCTION IF EXISTS `get_followers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tp`@`localhost` FUNCTION `get_followers`(email VARCHAR(30)) RETURNS varchar(255) CHARSET latin1
BEGIN
        DECLARE RES VARCHAR(255);
        SELECT GROUP_CONCAT(follower SEPARATOR ', ') INTO RES FROM Followings  WHERE followee = email;
        IF (RES IS NOT NULL) THEN
            RETURN RES;
        ELSE
            RETURN '';
        END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_followings` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tp`@`localhost` FUNCTION `get_followings`(email VARCHAR(30)) RETURNS varchar(255) CHARSET latin1
BEGIN
        DECLARE RES VARCHAR(255);
        SELECT GROUP_CONCAT(followee SEPARATOR ', ') INTO RES FROM Followings  WHERE follower = email;
        IF (RES IS NOT NULL) THEN
            RETURN RES;
        ELSE
            RETURN '';
        END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_subscriptions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tp`@`localhost` FUNCTION `get_subscriptions`(email VARCHAR(30)) RETURNS varchar(255) CHARSET latin1
BEGIN
        DECLARE RES VARCHAR(255);
        SELECT GROUP_CONCAT(thread SEPARATOR ', ') INTO RES FROM Subscriptions  WHERE user = email;
        IF (RES IS NOT NULL) THEN
            RETURN RES;
        ELSE
            RETURN '';
        END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `insert_post` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tp`@`localhost` FUNCTION `insert_post`(_thread INT,
								_user VARCHAR(30),
                                _forum VARCHAR(50),
                                _parent INT,
                                _date TIMESTAMP,
                                _message VARCHAR(15000),
								_stateMask TINYINT) RETURNS int(11)
BEGIN

    DECLARE parent_path VARCHAR(500);
    DECLARE root_post VARCHAR(7);
    DECLARE new_path VARCHAR(500);
    DECLARE new_id INT(7) ZEROFILL;

     IF (_stateMask & 2) = 0 THEN
            UPDATE Threads SET posts=posts+1 WHERE id= _thread;
     END IF;

    INSERT INTO Posts  (thread,user,forum,parent,date,message,stateMask)
    VALUES (_thread,_user, _forum,_parent,_date, _message, _stateMask);
    SET new_id = LAST_INSERT_ID();
    IF (_parent != 0) THEN
        SELECT path INTO parent_path FROM Posts WHERE id = _parent;
        SELECT root INTO root_post FROM Posts WHERE id = _parent;
		SET new_path = CONCAT(parent_path,'.',CAST(new_id AS CHAR));
    ELSE
        SET new_path = CAST(new_id AS CHAR);
        SET root_post = new_path;
    END IF;

    UPDATE Posts SET path = new_path, root = root_post WHERE id = new_id;
    RETURN new_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `clear` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tp`@`localhost` PROCEDURE `clear`()
BEGIN
     SET foreign_key_checks=0;
     TRUNCATE Posts;
     TRUNCATE Threads;
     TRUNCATE Forums;
     TRUNCATE Followings;
     TRUNCATE Subscriptions;
     SET foreign_key_checks=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_thread` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tp`@`localhost` PROCEDURE `delete_thread`(IN thread_id INT)
BEGIN
  START TRANSACTION;
  update Threads SET stateMask = (stateMask | 1) WHERE id=thread_id;
  update Posts SET stateMask = (stateMask | 2) WHERE thread=thread_id;
  COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `flat_post_list` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`newuser`@`localhost` PROCEDURE `flat_post_list`(IN _thread INT,
                                IN _since TIMESTAMP,
                                IN _order VARCHAR (4),
                                IN _limit INT)
BEGIN
    IF (_order = 'asc') THEN
        SELECT id,date,likes,dislikes,stateMask,forum,message,parent,thread,user FROM Posts
        WHERE thread= _thread AND date >= _since
        ORDER BY date LIMIT _limit;
    ELSE
        SELECT id,date,likes,dislikes,stateMask,forum,message,parent,thread,user FROM Posts
        WHERE thread=_thread and date >= _since
        ORDER BY date DESC LIMIT _limit;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `follow` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tp`@`localhost` PROCEDURE `follow`(IN _followee VARCHAR(30),
                        IN _follower VARCHAR(30))
BEGIN
    DECLARE _wee_id INT;
    DECLARE _wer_id INT;
    SELECT id INTO _wee_id FROM Users where email=_followee;
    SELECT id INTO _wer_id FROM Users where email=_follower;
    INSERT INTO Followings (followee, follower,wee_id,wer_id)
    VALUES (_followee, _follower, _wee_id, _wer_id );
    UPDATE Users SET followers =  get_followers(_followee) where email = _followee;
    UPDATE Users SET followings = get_followings(_follower) where email = _follower;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `forum_posts0` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`newuser`@`localhost` PROCEDURE `forum_posts0`(IN _forum VARCHAR(50),
                            IN _since TIMESTAMP,
                            IN _order VARCHAR (4),
                            IN _limit INT)
BEGIN
IF (_order = 'asc') THEN
    SELECT id,date,likes,dislikes,stateMask,forum,message,parent,thread,user FROM Posts as P
    WHERE forum= _forum AND P.date >= _since
    ORDER BY P.date LIMIT _limit;
ELSE
    SELECT id,date,likes,dislikes,stateMask,forum,message,parent,thread,user FROM Posts as P
    WHERE forum=_forum and P.date >= _since
    ORDER BY P.date DESC LIMIT _limit;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `forum_posts1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`newuser`@`localhost` PROCEDURE `forum_posts1`(IN _forum VARCHAR(50),
                            IN _since TIMESTAMP,
                            IN _order VARCHAR (4),
                            IN _limit INT)
BEGIN
IF (_order = 'asc') THEN
    SELECT * FROM Posts as P INNER JOIN Users as U
    ON U.email = P.user
    WHERE forum= _forum AND P.date >= _since
    ORDER BY date LIMIT _limit;
ELSE
    SELECT * FROM Posts as P INNER JOIN Users as U
    ON U.email = P.user
    WHERE forum=_forum and P.date >= _since
    ORDER BY P.date DESC LIMIT _limit;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `forum_posts2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `forum_posts2`(IN _forum VARCHAR(50),
                            IN _since TIMESTAMP,
                            IN _order VARCHAR (4),
                            IN _limit INT)
BEGIN
IF (_order = 'asc') THEN
    SELECT  STRAIGHT_JOIN P.id as id, P.date as date,P.likes as likes, P.dislikes as dislikes,P.stateMask AS stateMask,
    P.message as message, P.user as user,P.parent as parent,
    U.id as uid, U.email as uemail, U.isAnonymous as uisAnonymous, U.followers as ufollowers, U.followings as ufollowings,
    U.about as uabout, U.name as uname, U.username as uusername, U.subscriptions as usubscriptions
    FROM Posts as P INNER JOIN Users as U
    ON U.email = P.user
    WHERE forum= _forum AND P.date >= _since
    ORDER BY date LIMIT _limit;
ELSE
    SELECT  STRAIGHT_JOIN P.id as id, P.date as date,P.likes as likes, P.dislikes as dislikes,P.stateMask AS stateMask,
    P.message as message, P.user as user, P.parent as parent,
    U.id as uid, U.email as uemail, U.isAnonymous as uisAnonymous, U.followers as ufollowers, U.followings as ufollowings,
    U.about as uabout, U.name as uname, U.username as uusername, U.subscriptions as usubscriptions
    FROM Posts as P INNER JOIN Users as U
    ON U.email = P.user
    WHERE forum=_forum and P.date >= _since
    ORDER BY P.date DESC LIMIT _limit;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `forum_posts3` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`newuser`@`localhost` PROCEDURE `forum_posts3`(IN _forum VARCHAR(50),
                            IN _since TIMESTAMP,
                            IN _order VARCHAR (4),
                            IN _limit INT)
BEGIN
IF (_order = 'asc') THEN
    SELECT * FROM Posts as P INNER JOIN Users as U
    ON U.email = P.user INNER JOIN Forums as F
    ON F.short_name = P.forum
    WHERE forum= _forum AND P.date >= _since
    ORDER BY P.date LIMIT _limit;
ELSE
    SELECT * FROM Posts as P INNER JOIN Users as U
    ON U.email = P.user INNER JOIN Forums as F
    ON F.short_name = P.forum
    WHERE forum=_forum and P.date >= _since
    ORDER BY P.date DESC LIMIT _limit;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `forum_posts4` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `forum_posts4`(IN _forum VARCHAR(50),
                            IN _since TIMESTAMP,
                            IN _order VARCHAR (4),
                            IN _limit INT)
BEGIN
IF (_order = 'asc') THEN
    SELECT  STRAIGHT_JOIN P.id as id, P.date as date,P.likes as likes, P.dislikes as dislikes,P.stateMask AS stateMask,
    P.message as message, P.user as user, P.parent as parent,
    T.id as tid, T.date as tdate, T.likes as tlikes, T.dislikes as tdislikes, T.stateMask as tstateMask,T.forum as tforum,
    T.message as tmessage, T.slug as tslug, T.posts as tposts, T.user as tuser, T.title as ttitle
    FROM Posts as P INNER JOIN Threads as T
    ON T.id = P.thread
    WHERE P.forum= _forum AND P.date >= _since
    ORDER BY P.date LIMIT _limit;
ELSE
    SELECT  STRAIGHT_JOIN P.id as id, P.date as date,P.likes as likes, P.dislikes as dislikes,P.stateMask AS stateMask,
    P.message as message, P.user as user, P.parent as parent,
    T.id as tid, T.date as tdate, T.likes as tlikes, T.dislikes as tdislikes, T.stateMask as tstateMask,T.forum as tforum,
    T.message as tmessage, T.slug as tslug, T.posts as tposts, T.user as tuser, T.title as ttitle
    FROM Posts as P INNER JOIN Threads as T
    ON T.id = P.thread
    WHERE P.forum=_forum and P.date >= _since
    ORDER BY P.date DESC LIMIT _limit;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `forum_posts5` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`newuser`@`localhost` PROCEDURE `forum_posts5`(IN _forum VARCHAR(50),
                            IN _since TIMESTAMP,
                            IN _order VARCHAR (4),
                            IN _limit INT)
BEGIN
IF (_order = 'asc') THEN
    SELECT * FROM Posts as P INNER JOIN Threads as T
    ON T.id = P.thread INNER JOIN Users as U
    ON U.email = P.user
    WHERE P.forum= _forum AND P.date >= _since
    ORDER BY P.date LIMIT _limit;
ELSE
    SELECT * FROM Posts as P INNER JOIN Threads as T
    ON T.id = P.thread  INNER JOIN Users as U
    ON U.email = P.user
    WHERE P.forum=_forum and P.date >= _since
    ORDER BY P.date DESC LIMIT _limit;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `forum_posts6` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`newuser`@`localhost` PROCEDURE `forum_posts6`(IN _forum VARCHAR(50),
                            IN _since TIMESTAMP,
                            IN _order VARCHAR (4),
                            IN _limit INT)
BEGIN
IF (_order = 'asc') THEN
    SELECT * FROM Posts as P INNER JOIN Threads as T
    ON T.id = P.thread INNER JOIN Users as U
    ON U.email = P.user
    WHERE P.forum= _forum AND P.date >= _since
    ORDER BY P.date LIMIT _limit;
ELSE
    SELECT * FROM Posts as P INNER JOIN Threads as T
    ON T.id = P.thread INNER JOIN Users as U
    ON U.email = P.user
    WHERE P.forum=_forum and P.date >= _since
    ORDER BY P.date DESC LIMIT _limit;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `forum_posts7` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`newuser`@`localhost` PROCEDURE `forum_posts7`(IN _forum VARCHAR(50),
                            IN _since TIMESTAMP,
                            IN _order VARCHAR (4),
                            IN _limit INT)
BEGIN
IF (_order = 'asc') THEN
    SELECT * FROM Posts as P INNER JOIN Threads as T
    ON T.id = P.thread INNER JOIN Users as U
    ON U.email = P.user INNER JOIN Forums as F
    ON F.short_name = P.forum
    WHERE P.forum= _forum AND P.date >= _since
    ORDER BY P.date LIMIT _limit;
ELSE
    SELECT * FROM Posts as P INNER JOIN Threads as T
    ON T.id = P.thread INNER JOIN Users as U
    ON U.email = P.user INNER JOIN Forums as F
    ON F.short_name = P.forum
    WHERE P.forum=_forum and P.date >= _since
    ORDER BY P.date DESC LIMIT _limit;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `forum_threads` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`newuser`@`localhost` PROCEDURE `forum_threads`(IN _forum VARCHAR(30),
                                IN _since TIMESTAMP,
                                IN _order VARCHAR (4),
                                IN _limit INT)
BEGIN
    IF (_order = 'asc') THEN
        SELECT id,date,likes,dislikes,stateMask,forum,message,slug,posts,user,title FROM Threads
        WHERE forum= _forum AND date >= _since
        ORDER BY date LIMIT _limit;
    ELSE
        SELECT id,date,likes,dislikes,stateMask,forum,message,slug,posts,user,title FROM Threads
        WHERE forum=_forum and date >= _since
        ORDER BY date DESC LIMIT _limit;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `forum_threads0` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `forum_threads0`(IN _forum VARCHAR(50),
                                IN _since TIMESTAMP,
                                IN _order VARCHAR (4),
                                IN _limit INT)
BEGIN
    IF (_order = 'asc') THEN
        SELECT id,date,likes, dislikes,stateMask,forum, message,slug,posts,user, title FROM Threads
        WHERE forum= _forum AND date >= _since
        ORDER BY date LIMIT _limit;
    ELSE
        SELECT id,date,likes,dislikes,stateMask,forum,message,slug,posts,user,title FROM Threads
        WHERE forum=_forum and date >= _since
        ORDER BY date DESC LIMIT _limit;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `forum_threads1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`newuser`@`localhost` PROCEDURE `forum_threads1`(IN _forum VARCHAR(50),
                                IN _since TIMESTAMP,
                                IN _order VARCHAR (4),
                                IN _limit INT)
BEGIN
    IF (_order = 'asc') THEN
        SELECT *
        FROM Threads as T INNER JOIN Users as U
        ON U.email = T.user
        WHERE forum= _forum AND date >= _since
        ORDER BY date LIMIT _limit;
    ELSE
        SELECT *
        FROM Threads as T INNER JOIN Users as U
        ON U.email = T.user
        WHERE forum=_forum and date >= _since
        ORDER BY date DESC LIMIT _limit;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `forum_threads2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `forum_threads2`(IN _forum VARCHAR(50),
                                IN _since TIMESTAMP,
                                IN _order VARCHAR (4),
                                IN _limit INT)
BEGIN
    IF (_order = 'asc') THEN
        SELECT STRAIGHT_JOIN
        T.id as id, T.date as date, T.likes as likes, T.dislikes as dislikes, T.stateMask as stateMask,T.forum as forum,
        T.message as message, T.slug as slug, T.posts as posts, T.user as user, T.title as title,
        U.id as uid, U.email as uemail, U.isAnonymous as uisAnonymous, U.followers as ufollowers, U.followings as ufollowings,
        U.about as uabout, U.name as uname, U.username as uusername, U.subscriptions as usubscriptions
        FROM Threads as T INNER JOIN Users as U
        ON U.email = T.user
        WHERE forum= _forum AND date >= _since
        ORDER BY date LIMIT _limit;
    ELSE
        SELECT STRAIGHT_JOIN
        T.id as id, T.date as date, T.likes as likes, T.dislikes as dislikes, T.stateMask as stateMask,T.forum as forum,
        T.message as message, T.slug as slug, T.posts as posts, T.user as user, T.title as title,
        U.id as uid, U.email as uemail, U.isAnonymous as uisAnonymous, U.followers as ufollowers, U.followings as ufollowings,
        U.about as uabout, U.name as uname, U.username as uusername, U.subscriptions as usubscriptions
        FROM Threads as T INNER JOIN Users as U
        ON U.email = T.user
        WHERE forum=_forum and date >= _since
        ORDER BY date DESC LIMIT _limit;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `forum_threads3` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`newuser`@`localhost` PROCEDURE `forum_threads3`(IN _forum VARCHAR(50),
                                IN _since TIMESTAMP,
                                IN _order VARCHAR (4),
                                IN _limit INT)
BEGIN
    IF (_order = 'asc') THEN
        SELECT *
        FROM Threads as T INNER JOIN Forums as F
        ON T.forum = F.short_name
        INNER JOIN Users as U
        ON T.user =U.email
        WHERE forum= _forum AND date >= _since
        ORDER BY date LIMIT _limit;
    ELSE
        SELECT *
        FROM Threads as T INNER JOIN Forums as F
        ON T.forum = F.short_name
        INNER JOIN Users as U
        ON T.user =U.email
        WHERE forum=_forum and date >= _since
        ORDER BY date DESC LIMIT _limit;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `forum_users` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `forum_users`(IN _forum VARCHAR(50),
                                IN _since INT,
                                IN _order VARCHAR (4),
                                IN _limit INT)
BEGIN
    IF (_order = 'asc') THEN
        SELECT DISTINCT STRAIGHT_JOIN
        U.id , U.email, U.isAnonymous, U.followers, U.followings, U.subscriptions, U.about,U.name,U.username
        FROM Users as U INNER JOIN Posts as P
        ON (P.user = U.email and P.forum= _forum)
        WHERE U.id >= _since
        ORDER BY U.name LIMIT _limit;
    ELSE
        SELECT DISTINCT STRAIGHT_JOIN
        U.id , U.email, U.isAnonymous, U.followers, U.followings, U.subscriptions, U.about,U.name,U.username
        FROM Users as U INNER JOIN Posts as P
        ON (P.user = U.email and P.forum= _forum)
        WHERE U.id >= _since
        ORDER BY U.name DESC LIMIT _limit;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `init` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tp`@`localhost` PROCEDURE `init`()
BEGIN
SET @POST_IS_APPROVED = 1;
SET @POST_IS_DELETED =2;
SET @POST_IS_EDITED = 4;
SET @POST_IS_HIGHLIGHTED =8;
SET @POST_IS_SPAM=16;
SET @POST_FULL_MASK =31;

SET @THREAD_IS_DELETED = 1;
SET @THREAD_IS_CLOSED = 2;
SET @THREAD_FULL_MASK = 3;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `new_clear` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_clear`()
BEGIN
    START TRANSACTION;
    SET foreign_key_checks=0;

    CREATE TABLE new_Users LIKE Users;
    RENAME TABLE Users TO old_Users, new_Users TO Users;
    DROP TABLE old_Users;

    CREATE TABLE new_Posts LIKE Posts;
    RENAME TABLE Posts TO old_Posts, new_Posts TO Posts;
    DROP TABLE old_Posts;

    CREATE TABLE new_Threads LIKE Threads;
    RENAME TABLE Threads TO old_Threads, new_Threads TO Threads;
    DROP TABLE old_Threads;

    CREATE TABLE new_Forums LIKE Forums;
    RENAME TABLE Forums TO old_Forums, new_Forums TO Forums;
    DROP TABLE old_Forums;

    CREATE TABLE new_Subscriptions LIKE Subscriptions;
    RENAME TABLE Subscriptions TO old_Subscriptions, new_Subscriptions TO Subscriptions;
    DROP TABLE old_Subscriptions;

    CREATE TABLE new_Followings LIKE Followings;
    RENAME TABLE Followings TO old_Followings, new_Followings TO Followings;
    DROP TABLE old_Followings;

    SET foreign_key_checks=1;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `parent_tree_post_list` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tp`@`localhost` PROCEDURE `parent_tree_post_list`(IN _thread INT,
                                       IN _since TIMESTAMP,
                                       IN _order VARCHAR (4),
                                       IN _limit INT)
BEGIN
    IF (_order = 'asc') THEN
        SELECT id FROM Posts as P INNER JOIN
        (SELECT  root FROM Posts WHERE parent=0 AND thread= _thread AND date >= _since ORDER BY root LIMIT  _limit) as T
        ON P.root =T.root
        WHERE P.thread= _thread AND P.date >= _since
        ORDER BY P.path;
    ELSE
        SELECT id FROM Posts as P INNER JOIN
        (SELECT root FROM Posts WHERE parent=0 AND thread= _thread AND date >= _since ORDER BY root DESC LIMIT  _limit ) as T
        ON P.root =T.root
        WHERE P.thread=_thread and P.date >= _since
        ORDER BY P.root DESC , P.path ASC;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `restore_thread` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tp`@`localhost` PROCEDURE `restore_thread`(IN thread_id INT)
BEGIN
  START TRANSACTION;
  update Threads SET stateMask = (stateMask & ~1) WHERE id=thread_id;
  update Posts SET stateMask = (stateMask  & ~2) WHERE thread=thread_id;
  COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `tree_post_list` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`newuser`@`localhost` PROCEDURE `tree_post_list`(IN _thread INT,
                                IN _since TIMESTAMP,
                                IN _order VARCHAR (4),
                                IN _limit INT)
BEGIN
    IF (_order = 'asc') THEN
        SELECT id,date,likes,dislikes,stateMask,forum,message,parent,thread,user FROM Posts
        WHERE thread= _thread AND date >= _since
        ORDER BY path LIMIT _limit;
    ELSE
        SELECT id,date,likes,dislikes,stateMask,forum,message,parent,thread,user FROM Posts
        WHERE thread=_thread and date >= _since
        ORDER BY root DESC , path ASC LIMIT _limit;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `unfollow` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tp`@`localhost` PROCEDURE `unfollow`(IN _followee VARCHAR(30),
                        IN _follower VARCHAR(30))
BEGIN

    DELETE FROM Followings where followee = _followee and follower = _follower;
    UPDATE Users SET followers =  get_followers(_followee) where email = _followee;
    UPDATE Users SET followings = get_followings(_follower) where email = _follower;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `unsubscribe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tp`@`localhost` PROCEDURE `unsubscribe`(IN _user VARCHAR(30),
                        IN _thread INT)
BEGIN
    DELETE FROM Subscriptions where thread = _thread and user = _user;
    UPDATE Users SET subscriptions =  get_subscriptions(_user) where email = _user;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateProfile` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tp`@`localhost` PROCEDURE `updateProfile`( IN _user VARCHAR(30),
                                IN _name VARCHAR(30),
                                IN _about VARCHAR(5000)
)
BEGIN
    UPDATE Users SET name = _name, about= _about where email = _user;
    UPDATE Posts SET uname = _name WHERE user = _user;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tp`@`localhost` PROCEDURE `user_details`(IN user VARCHAR(30))
BEGIN
    SELECT id,email,name,username, isAnonymous, about, GROUP_CONCAT(followee SEPARATOR ', ');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_posts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`newuser`@`localhost` PROCEDURE `user_posts`(IN _user VARCHAR(30),
                                IN _since TIMESTAMP,
                                IN _order VARCHAR (4),
                                IN _limit INT)
BEGIN
    IF (_order = 'asc') THEN
        SELECT id,date,likes,dislikes,stateMask,forum,message,parent,thread,user FROM Posts
        WHERE user= _user AND date >= _since
        ORDER BY date LIMIT _limit;
    ELSE
        SELECT id,date,likes,dislikes,stateMask,forum,message,parent,thread,user FROM Posts
        WHERE user=_user and date >= _since
        ORDER BY date DESC LIMIT _limit;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_threads` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`newuser`@`localhost` PROCEDURE `user_threads`(IN _user VARCHAR(30),
                                IN _since TIMESTAMP,
                                IN _order VARCHAR (4),
                                IN _limit INT)
BEGIN
    IF (_order = 'asc') THEN
        SELECT id,date,likes,dislikes,stateMask,forum,message,slug,posts,user,title FROM Threads
        WHERE user= _user AND date >= _since
        ORDER BY date LIMIT _limit;
    ELSE
        SELECT id,date,likes,dislikes,stateMask,forum,message,slug,posts,user,title FROM Threads
        WHERE user=_user and date >= _since
        ORDER BY date DESC LIMIT _limit;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-11-30  1:46:29
