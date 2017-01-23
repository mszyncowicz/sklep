-- MySQL dump 10.13  Distrib 5.7.16, for Win64 (x86_64)
--
-- Host: localhost    Database: sklep
-- ------------------------------------------------------
-- Server version	5.7.16

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
-- Table structure for table `account_address`
--

DROP TABLE IF EXISTS `account_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `city` varchar(50) NOT NULL,
  `address` varchar(255) NOT NULL,
  `zipcode` varchar(150) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_address`
--

LOCK TABLES `account_address` WRITE;
/*!40000 ALTER TABLE `account_address` DISABLE KEYS */;
INSERT INTO `account_address` VALUES (1,'Krk','aojdoas','ejafea');
/*!40000 ALTER TABLE `account_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_koszyk`
--

DROP TABLE IF EXISTS `account_koszyk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_koszyk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `account_koszyk_user_id_ef395f54_fk_account_user_id` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_koszyk`
--

LOCK TABLES `account_koszyk` WRITE;
/*!40000 ALTER TABLE `account_koszyk` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_koszyk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_pracownik`
--

DROP TABLE IF EXISTS `account_pracownik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_pracownik` (
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `account_pracownik_user_id_3d3debd7_fk_account_user_id` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_pracownik`
--

LOCK TABLES `account_pracownik` WRITE;
/*!40000 ALTER TABLE `account_pracownik` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_pracownik` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_user`
--

DROP TABLE IF EXISTS `account_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `email` varchar(255) NOT NULL,
  `date_joined` datetime NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `last_login` datetime,
  `username` varchar(17) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_user_email_0bd7c421_uniq` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_user`
--

LOCK TABLES `account_user` WRITE;
/*!40000 ALTER TABLE `account_user` DISABLE KEYS */;
INSERT INTO `account_user` VALUES (1,'pbkdf2_sha256$30000$niHrQvFt9JOR$lvS8P57PxpQtsJKuX/j6r33WjLLO2zfpnqxVL8xU+u0=','mar@mar.com','2017-01-16 22:35:05',1,0,0,'2017-01-23 22:28:43','mar2'),(2,'pbkdf2_sha256$30000$ggLNWQpgTBnj$wde9Xu3qaQc7Tf1cb8iwjWcSmEkjKOTmc1AlWfN2D+A=','admin@admi.om','2017-01-20 23:38:54',1,1,1,'2017-01-22 00:37:55','Admin');
/*!40000 ALTER TABLE `account_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_user_groups`
--

DROP TABLE IF EXISTS `account_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_user_groups_user_id_4d09af3e_uniq` (`user_id`,`group_id`),
  KEY `account_user_groups_group_id_6c71f749_fk_auth_group_id` (`group_id`),
  CONSTRAINT `account_user_groups_group_id_6c71f749_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `account_user_groups_user_id_14345e7b_fk_account_user_id` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_user_groups`
--

LOCK TABLES `account_user_groups` WRITE;
/*!40000 ALTER TABLE `account_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_user_user_permissions`
--

DROP TABLE IF EXISTS `account_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_user_user_permissions_user_id_48bdd28b_uniq` (`user_id`,`permission_id`),
  KEY `account_user_user_p_permission_id_66c44191_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `account_user_user_p_permission_id_66c44191_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `account_user_user_permission_user_id_cc42d270_fk_account_user_id` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_user_user_permissions`
--

LOCK TABLES `account_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `account_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_usercd`
--

DROP TABLE IF EXISTS `account_usercd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_usercd` (
  `fName` varchar(50) NOT NULL,
  `lName` varchar(50) NOT NULL,
  `birthDate` date NOT NULL,
  `phone` varchar(12) NOT NULL,
  `address_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `account_usercd_address_id_9683b548_uniq` (`address_id`),
  CONSTRAINT `account_usercd_address_id_9683b548_fk_account_address_id` FOREIGN KEY (`address_id`) REFERENCES `account_address` (`id`),
  CONSTRAINT `account_usercd_user_id_cba4e0ba_fk_account_user_id` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_usercd`
--

LOCK TABLES `account_usercd` WRITE;
/*!40000 ALTER TABLE `account_usercd` DISABLE KEYS */;
INSERT INTO `account_usercd` VALUES ('mar','szar','1993-01-16','2438294872',1,1);
/*!40000 ALTER TABLE `account_usercd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_zamowienie`
--

DROP TABLE IF EXISTS `account_zamowienie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_zamowienie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `statustime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `account_zamowienie_user_id_cc5159c7_fk_account_user_id` (`user_id`),
  CONSTRAINT `account_zamowienie_user_id_cc5159c7_fk_account_user_id` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_zamowienie`
--

LOCK TABLES `account_zamowienie` WRITE;
/*!40000 ALTER TABLE `account_zamowienie` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_zamowienie` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp852 */ ;
/*!50003 SET character_set_results = cp852 */ ;
/*!50003 SET collation_connection  = cp852_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER zamowienie_onDelete
BEFORE DELETE
   ON account_zamowienie FOR EACH ROW
BEGIN
    CALL dodaj(OLD.id);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permissi_content_type_id_2f476e4b_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add cors model',6,'add_corsmodel'),(17,'Can change cors model',6,'change_corsmodel'),(18,'Can delete cors model',6,'delete_corsmodel'),(19,'Can add user',7,'add_user'),(20,'Can change user',7,'change_user'),(21,'Can delete user',7,'delete_user'),(22,'Can add pracownik',8,'add_pracownik'),(23,'Can change pracownik',8,'change_pracownik'),(24,'Can delete pracownik',8,'delete_pracownik'),(25,'Can add address',9,'add_address'),(26,'Can change address',9,'change_address'),(27,'Can delete address',9,'delete_address'),(28,'Can add koszyk',10,'add_koszyk'),(29,'Can change koszyk',10,'change_koszyk'),(30,'Can delete koszyk',10,'delete_koszyk'),(31,'Can add user cd',11,'add_usercd'),(32,'Can change user cd',11,'change_usercd'),(33,'Can delete user cd',11,'delete_usercd'),(34,'Can add zamowienie',12,'add_zamowienie'),(35,'Can change zamowienie',12,'change_zamowienie'),(36,'Can delete zamowienie',12,'delete_zamowienie'),(37,'Can add to sell',13,'add_tosell'),(38,'Can change to sell',13,'change_tosell'),(39,'Can delete to sell',13,'delete_tosell'),(40,'Can add procesor',14,'add_procesor'),(41,'Can change procesor',14,'change_procesor'),(42,'Can delete procesor',14,'delete_procesor'),(43,'Can add galeria',15,'add_galeria'),(44,'Can change galeria',15,'change_galeria'),(45,'Can delete galeria',15,'delete_galeria'),(46,'Can add plyta glowna',16,'add_plytaglowna'),(47,'Can change plyta glowna',16,'change_plytaglowna'),(48,'Can delete plyta glowna',16,'delete_plytaglowna'),(49,'Can add produkt',17,'add_produkt'),(50,'Can change produkt',17,'change_produkt'),(51,'Can delete produkt',17,'delete_produkt'),(52,'Can add producent',18,'add_producent'),(53,'Can change producent',18,'change_producent'),(54,'Can delete producent',18,'delete_producent'),(55,'Can add karta graficzna',19,'add_kartagraficzna'),(56,'Can change karta graficzna',19,'change_kartagraficzna'),(57,'Can delete karta graficzna',19,'delete_kartagraficzna'),(58,'Can add kategoria',20,'add_kategoria'),(59,'Can change kategoria',20,'change_kategoria'),(60,'Can delete kategoria',20,'delete_kategoria');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_account_user_id` (`user_id`),
  CONSTRAINT `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_account_user_id` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2017-01-20 23:40:37','2','Procesor',1,'[{\"added\": {}}]',20,2),(2,'2017-01-20 23:40:41','3','Karta graficzna',1,'[{\"added\": {}}]',20,2),(3,'2017-01-20 23:40:43','4','Plyta glowna',1,'[{\"added\": {}}]',20,2),(4,'2017-01-20 23:40:46','5','Inne',1,'[{\"added\": {}}]',20,2),(5,'2017-01-20 23:41:15','1','AMD',1,'[{\"added\": {}}]',18,2),(6,'2017-01-20 23:41:28','2','Intel',1,'[{\"added\": {}}]',18,2),(7,'2017-01-20 23:41:32','3','MSI',1,'[{\"added\": {}}]',18,2),(8,'2017-01-20 23:41:37','4','Nvidia',1,'[{\"added\": {}}]',18,2),(9,'2017-01-20 23:41:41','5','Asus',1,'[{\"added\": {}}]',18,2),(10,'2017-01-20 23:41:50','6','Gigabyte',1,'[{\"added\": {}}]',18,2),(11,'2017-01-20 23:42:36','1','FX-8350',1,'[{\"added\": {}}]',17,2),(12,'2017-01-20 23:43:03','2','i5-4500',1,'[{\"added\": {}}]',17,2),(13,'2017-01-20 23:43:06','2','i5-4500',2,'[]',17,2),(14,'2017-01-20 23:43:42','3','GA-F2A88XM-DS2',1,'[{\"added\": {}}]',17,2),(15,'2017-01-20 23:45:08','4','B150 Gaming M3',1,'[{\"added\": {}}]',17,2),(16,'2017-01-20 23:45:48','5','Asus r9-360X',1,'[{\"added\": {}}]',17,2),(17,'2017-01-20 23:45:50','5','Asus r9-360X',2,'[]',17,2),(18,'2017-01-20 23:46:33','6','GTX 1080',1,'[{\"added\": {}}]',17,2),(19,'2017-01-20 23:46:59','6','KartaGraficzna object',1,'[{\"added\": {}}]',19,2),(20,'2017-01-20 23:47:18','5','KartaGraficzna object',1,'[{\"added\": {}}]',19,2),(21,'2017-01-20 23:47:20','5','KartaGraficzna object',2,'[]',19,2),(22,'2017-01-20 23:49:35','3','PlytaGlowna object',1,'[{\"added\": {}}]',16,2),(23,'2017-01-20 23:49:55','4','PlytaGlowna object',1,'[{\"added\": {}}]',16,2),(24,'2017-01-20 23:50:27','1','Procesor object',1,'[{\"added\": {}}]',14,2),(25,'2017-01-20 23:50:38','2','Procesor object',1,'[{\"added\": {}}]',14,2),(26,'2017-01-20 23:52:03','1','obraz FX-8350',1,'[{\"added\": {}}]',15,2),(27,'2017-01-20 23:52:14','2','obraz i5-4500',1,'[{\"added\": {}}]',15,2),(28,'2017-01-20 23:52:30','3','obraz GA-F2A88XM-DS2',1,'[{\"added\": {}}]',15,2),(29,'2017-01-20 23:52:49','4','obraz B150 Gaming M3',1,'[{\"added\": {}}]',15,2),(30,'2017-01-20 23:52:55','5','obraz GTX 1080',1,'[{\"added\": {}}]',15,2),(31,'2017-01-20 23:53:08','6','obraz Asus r9-360X',1,'[{\"added\": {}}]',15,2),(34,'2017-01-21 01:11:05','4','Zamowienie object',3,'',12,2),(35,'2017-01-21 01:11:28','3','Zamowienie object',3,'',12,2),(36,'2017-01-21 01:11:35','2','Zamowienie object',3,'',12,2),(37,'2017-01-21 01:24:11','5','Zamowienie object',3,'',12,2),(38,'2017-01-21 01:43:12','7','Zamowienie object',3,'',12,2),(39,'2017-01-21 01:43:12','6','Zamowienie object',3,'',12,2),(40,'2017-01-21 01:51:06','8','Zamowienie object',3,'',12,2),(41,'2017-01-22 00:38:07','9','Zamowienie object',2,'[{\"changed\": {\"fields\": [\"user\"]}}]',12,2);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (9,'account','address'),(10,'account','koszyk'),(8,'account','pracownik'),(7,'account','user'),(11,'account','usercd'),(12,'account','zamowienie'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(6,'corsheaders','corsmodel'),(15,'product','galeria'),(19,'product','kartagraficzna'),(20,'product','kategoria'),(16,'product','plytaglowna'),(14,'product','procesor'),(18,'product','producent'),(17,'product','produkt'),(13,'product','tosell'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2017-01-16 18:42:19'),(2,'contenttypes','0002_remove_content_type_name','2017-01-16 18:42:20'),(3,'auth','0001_initial','2017-01-16 18:42:23'),(4,'auth','0002_alter_permission_name_max_length','2017-01-16 18:42:23'),(5,'auth','0003_alter_user_email_max_length','2017-01-16 18:42:23'),(6,'auth','0004_alter_user_username_opts','2017-01-16 18:42:23'),(7,'auth','0005_alter_user_last_login_null','2017-01-16 18:42:23'),(8,'auth','0006_require_contenttypes_0002','2017-01-16 18:42:23'),(9,'auth','0007_alter_validators_add_error_messages','2017-01-16 18:42:23'),(10,'auth','0008_alter_user_username_max_length','2017-01-16 18:42:23'),(11,'account','0001_initial','2017-01-16 18:42:24'),(12,'account','0002_auto_20161227_2309','2017-01-16 18:42:26'),(13,'account','0003_auto_20161227_2314','2017-01-16 18:42:27'),(14,'account','0004_auto_20161227_2320','2017-01-16 18:42:29'),(15,'account','0005_auto_20161228_2216','2017-01-16 18:42:29'),(16,'account','0006_auto_20161229_0136','2017-01-16 18:42:36'),(17,'account','0007_auto_20161229_0149','2017-01-16 18:42:36'),(18,'account','0008_koszyk_zamowienie','2017-01-16 18:42:38'),(19,'account','0009_auto_20170114_0018','2017-01-16 18:42:39'),(20,'account','0010_auto_20170114_1648','2017-01-16 18:42:40'),(21,'account','0011_auto_20170114_1715','2017-01-16 18:42:41'),(22,'admin','0001_initial','2017-01-16 18:42:42'),(23,'admin','0002_logentry_remove_auto_add','2017-01-16 18:42:42'),(24,'product','0001_initial','2017-01-16 18:42:46'),(25,'product','0002_produkt_producent','2017-01-16 18:42:47'),(26,'product','0003_produkt_iloscsztuk','2017-01-16 18:42:47'),(27,'product','0004_kartagraficzna_plytaglowna_procesor','2017-01-16 18:42:50'),(28,'product','0005_auto_20170114_1702','2017-01-16 18:42:50'),(29,'product','0006_produkt_cena','2017-01-16 18:42:51'),(30,'product','0007_auto_20170116_1929','2017-01-16 18:42:51'),(31,'sessions','0001_initial','2017-01-16 18:42:52'),(32,'account','0012_auto_20170120_2356','2017-01-20 22:56:21'),(33,'product','0008_auto_20170120_2356','2017-01-20 22:56:22');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('do3nv70uue7g7mk8tap7rusqkgavb9bc','NTE1YTllNDE5Nzg0MDhiMDExNzVmMDc1M2MyMDdjMjYzZmRhY2ZlZTp7Il9hdXRoX3VzZXJfaGFzaCI6IjQxY2Y4MzJkMzBiOGY0MDFiMDBiNWI3Y2VlNjA5YTFkZTRmNGJmMTAiLCJrb3N6eWtsZW4iOjAsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJrb3N6eWsiOltdfQ==','2017-02-06 23:36:27'),('sf5dh50w9yzh4nzyqtgu3ow2sevsyw26','OGRiZTRiNDA2NWY0OTE3YmE5M2U2YmRhNmIwMGEwZmVmNGZkNTI4MTp7fQ==','2017-01-30 22:35:22');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `karty`
--

DROP TABLE IF EXISTS `karty`;
/*!50001 DROP VIEW IF EXISTS `karty`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `karty` AS SELECT 
 1 AS `nazwa`,
 1 AS `producent`,
 1 AS `cena`,
 1 AS `id`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `plyty`
--

DROP TABLE IF EXISTS `plyty`;
/*!50001 DROP VIEW IF EXISTS `plyty`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `plyty` AS SELECT 
 1 AS `nazwa`,
 1 AS `producent`,
 1 AS `cena`,
 1 AS `id`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `procesory`
--

DROP TABLE IF EXISTS `procesory`;
/*!50001 DROP VIEW IF EXISTS `procesory`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `procesory` AS SELECT 
 1 AS `nazwa`,
 1 AS `producent`,
 1 AS `cena`,
 1 AS `id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `product_galeria`
--

DROP TABLE IF EXISTS `product_galeria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_galeria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `obraz` varchar(4096) NOT NULL,
  `produkt_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_galeria_produkt_id_03dabc4c_fk_product_produkt_id` (`produkt_id`),
  CONSTRAINT `product_galeria_produkt_id_03dabc4c_fk_product_produkt_id` FOREIGN KEY (`produkt_id`) REFERENCES `product_produkt` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_galeria`
--

LOCK TABLES `product_galeria` WRITE;
/*!40000 ALTER TABLE `product_galeria` DISABLE KEYS */;
INSERT INTO `product_galeria` VALUES (1,'fx_g4lfvli.jpg',1),(2,'i5_gNoP5wK.jpg',2),(3,'indeks_y40kxq0.jpg',3),(4,'msi_b168_iMJnQBa.jpg',4),(5,'geforce_gtx_1080_3qtr_front_left_Mr8VuQC.png',6),(6,'P_setting_fff_1_90_end_500.png_961G4yK.jpg',5);
/*!40000 ALTER TABLE `product_galeria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_kartagraficzna`
--

DROP TABLE IF EXISTS `product_kartagraficzna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_kartagraficzna` (
  `produkt_id` int(11) NOT NULL,
  `wyjscia` varchar(255) NOT NULL,
  `zlacze` varchar(255) NOT NULL,
  `TDP` varchar(255) NOT NULL,
  PRIMARY KEY (`produkt_id`),
  CONSTRAINT `product_kartagraficzna_produkt_id_89e9ba42_fk_product_produkt_id` FOREIGN KEY (`produkt_id`) REFERENCES `product_produkt` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_kartagraficzna`
--

LOCK TABLES `product_kartagraficzna` WRITE;
/*!40000 ALTER TABLE `product_kartagraficzna` DISABLE KEYS */;
INSERT INTO `product_kartagraficzna` VALUES (5,'2xDisplay Port, 1xHDMI','PCI-Express 3.0','90W'),(6,'2xDVI, 1xHDMI, 1xDisplay Port','PCI-Express 3.0','110W');
/*!40000 ALTER TABLE `product_kartagraficzna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_kategoria`
--

DROP TABLE IF EXISTS `product_kategoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_kategoria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `liczba` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_kategoria`
--

LOCK TABLES `product_kategoria` WRITE;
/*!40000 ALTER TABLE `product_kategoria` DISABLE KEYS */;
INSERT INTO `product_kategoria` VALUES (2,1),(3,2),(4,3),(5,4);
/*!40000 ALTER TABLE `product_kategoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_plytaglowna`
--

DROP TABLE IF EXISTS `product_plytaglowna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_plytaglowna` (
  `produkt_id` int(11) NOT NULL,
  `sockety` varchar(255) NOT NULL,
  `wyjscia` varchar(255) NOT NULL,
  PRIMARY KEY (`produkt_id`),
  CONSTRAINT `product_plytaglowna_produkt_id_d6e49c53_fk_product_produkt_id` FOREIGN KEY (`produkt_id`) REFERENCES `product_produkt` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_plytaglowna`
--

LOCK TABLES `product_plytaglowna` WRITE;
/*!40000 ALTER TABLE `product_plytaglowna` DISABLE KEYS */;
INSERT INTO `product_plytaglowna` VALUES (3,'AM3+ 2xPCI-express 3.0 3xPCI','4xUSB, 1xHDMI'),(4,'FCLGA1150 4xPCI 2xPCI-Express','4xUSB, 1xHDMI');
/*!40000 ALTER TABLE `product_plytaglowna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_procesor`
--

DROP TABLE IF EXISTS `product_procesor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_procesor` (
  `produkt_id` int(11) NOT NULL,
  `socket` varchar(255) NOT NULL,
  `TDP` varchar(255) NOT NULL,
  PRIMARY KEY (`produkt_id`),
  CONSTRAINT `product_procesor_produkt_id_eef8b50e_fk_product_produkt_id` FOREIGN KEY (`produkt_id`) REFERENCES `product_produkt` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_procesor`
--

LOCK TABLES `product_procesor` WRITE;
/*!40000 ALTER TABLE `product_procesor` DISABLE KEYS */;
INSERT INTO `product_procesor` VALUES (1,'AM3+','84W'),(2,'FCLGA1150','84W');
/*!40000 ALTER TABLE `product_procesor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_producent`
--

DROP TABLE IF EXISTS `product_producent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_producent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nazwa` (`nazwa`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_producent`
--

LOCK TABLES `product_producent` WRITE;
/*!40000 ALTER TABLE `product_producent` DISABLE KEYS */;
INSERT INTO `product_producent` VALUES (1,'AMD'),(5,'Asus'),(6,'Gigabyte'),(2,'Intel'),(3,'MSI'),(4,'Nvidia');
/*!40000 ALTER TABLE `product_producent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_produkt`
--

DROP TABLE IF EXISTS `product_produkt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_produkt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(255) NOT NULL,
  `opis` varchar(600) NOT NULL,
  `producent_id` int(11) NOT NULL,
  `iloscSztuk` int(11) NOT NULL,
  `cena` double NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nazwa` (`nazwa`),
  KEY `product_produkt_producent_id_63ca9e0b_fk_product_producent_id` (`producent_id`),
  KEY `product_produkt_category_id_01d77602_fk_product_kategoria_id` (`category_id`),
  CONSTRAINT `product_produkt_category_id_01d77602_fk_product_kategoria_id` FOREIGN KEY (`category_id`) REFERENCES `product_kategoria` (`id`),
  CONSTRAINT `product_produkt_producent_id_63ca9e0b_fk_product_producent_id` FOREIGN KEY (`producent_id`) REFERENCES `product_producent` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_produkt`
--

LOCK TABLES `product_produkt` WRITE;
/*!40000 ALTER TABLE `product_produkt` DISABLE KEYS */;
INSERT INTO `product_produkt` VALUES (1,'FX-8350','Opis procesor amd FX-8350',1,112,849,2),(2,'i5-4500','Opis procesora intel.',2,12,1229,2),(3,'GA-F2A88XM-DS2','Opis plyty glownej givbabytr',6,12,249,4),(4,'B150 Gaming M3','Opis plyty glownej msi',3,32,299,4),(5,'Asus r9-360X','Opis karty graficznej asus.',5,45,689,3),(6,'GTX 1080','Opis karty graficznej Nvidia',4,126,1099,3);
/*!40000 ALTER TABLE `product_produkt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_tosell`
--

DROP TABLE IF EXISTS `product_tosell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_tosell` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `iloscSztuk` int(11) NOT NULL,
  `produkt_id` int(11) NOT NULL,
  `zamowienie_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_tosell_produkt_id_cb55c119_fk_product_produkt_id` (`produkt_id`),
  KEY `product_tosell_zamowienie_id_70682d11_fk_account_zamowienie_id` (`zamowienie_id`),
  CONSTRAINT `product_tosell_produkt_id_cb55c119_fk_product_produkt_id` FOREIGN KEY (`produkt_id`) REFERENCES `product_produkt` (`id`),
  CONSTRAINT `product_tosell_zamowienie_id_70682d11_fk_account_zamowienie_id` FOREIGN KEY (`zamowienie_id`) REFERENCES `account_zamowienie` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_tosell`
--

LOCK TABLES `product_tosell` WRITE;
/*!40000 ALTER TABLE `product_tosell` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_tosell` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp852 */ ;
/*!50003 SET character_set_results = cp852 */ ;
/*!50003 SET collation_connection  = cp852_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tosell_onDelete
BEFORE DELETE
   ON product_tosell FOR EACH ROW
BEGIN
   CALL product_UPDATE(OLD.produkt_id,OLD.iloscSztuk);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `karty`
--

/*!50001 DROP VIEW IF EXISTS `karty`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp852 */;
/*!50001 SET character_set_results     = cp852 */;
/*!50001 SET collation_connection      = cp852_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `karty` AS select `product_produkt`.`nazwa` AS `nazwa`,`product_producent`.`nazwa` AS `producent`,`product_produkt`.`cena` AS `cena`,`product_produkt`.`id` AS `id` from ((`product_produkt` join `product_kartagraficzna` on((`product_kartagraficzna`.`produkt_id` = `product_produkt`.`id`))) join `product_producent` on((`product_produkt`.`producent_id` = `product_producent`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `plyty`
--

/*!50001 DROP VIEW IF EXISTS `plyty`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp852 */;
/*!50001 SET character_set_results     = cp852 */;
/*!50001 SET collation_connection      = cp852_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `plyty` AS select `product_produkt`.`nazwa` AS `nazwa`,`product_producent`.`nazwa` AS `producent`,`product_produkt`.`cena` AS `cena`,`product_produkt`.`id` AS `id` from ((`product_produkt` join `product_plytaglowna` on((`product_plytaglowna`.`produkt_id` = `product_produkt`.`id`))) join `product_producent` on((`product_produkt`.`producent_id` = `product_producent`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `procesory`
--

/*!50001 DROP VIEW IF EXISTS `procesory`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp852 */;
/*!50001 SET character_set_results     = cp852 */;
/*!50001 SET collation_connection      = cp852_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `procesory` AS select `product_produkt`.`nazwa` AS `nazwa`,`product_producent`.`nazwa` AS `producent`,`product_produkt`.`cena` AS `cena`,`product_produkt`.`id` AS `id` from ((`product_produkt` join `product_procesor` on((`product_procesor`.`produkt_id` = `product_produkt`.`id`))) join `product_producent` on((`product_produkt`.`producent_id` = `product_producent`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-01-24  0:38:17
