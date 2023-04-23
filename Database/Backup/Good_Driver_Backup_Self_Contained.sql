-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: team02-rdsdb.cobd8enwsupz.us-east-1.rds.amazonaws.com    Database: Good_Driver
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `application_state_change`
--

DROP TABLE IF EXISTS `application_state_change`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_state_change` (
  `State_Change_ID` int NOT NULL AUTO_INCREMENT,
  `Application_ID` int NOT NULL,
  `Date_Time` datetime NOT NULL,
  `New_Status` varchar(15) NOT NULL,
  `New_Reason` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`State_Change_ID`),
  KEY `application_state_change_ibfk_1` (`Application_ID`),
  CONSTRAINT `application_state_change_ibfk_1` FOREIGN KEY (`Application_ID`) REFERENCES `driver_application` (`Application_ID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_state_change`
--

LOCK TABLES `application_state_change` WRITE;
/*!40000 ALTER TABLE `application_state_change` DISABLE KEYS */;
INSERT INTO `application_state_change` VALUES (1,9,'2023-03-02 16:16:31','Pending',NULL),(2,10,'2023-03-03 17:09:53','Pending',NULL),(3,11,'2023-03-03 17:09:55','Pending',NULL),(4,12,'2023-03-03 17:09:57','Pending',NULL),(5,13,'2023-03-03 17:09:59','Pending',NULL),(6,9,'2023-03-02 16:16:31','Accepted',NULL),(19,9,'2023-03-02 16:16:31','Accepted','good'),(20,14,'2023-03-04 20:23:58','Pending',NULL),(21,15,'2023-03-07 19:17:48','Pending',NULL),(22,16,'2023-03-07 19:17:51','Pending',NULL),(23,17,'2023-03-07 19:17:52','Pending',NULL),(24,18,'2023-03-07 19:17:55','Pending',NULL),(25,15,'2023-03-07 19:17:48','Rejected',''),(26,11,'2023-03-03 17:09:55','Accepted','u smell'),(27,12,'2023-03-03 17:09:57','Accepted','good'),(28,16,'2023-03-07 19:17:51','Accepted',''),(29,19,'2023-03-09 01:27:10','Pending',NULL),(30,19,'2023-03-09 01:27:10','Accepted','good job'),(31,20,'2023-03-13 14:58:11','Pending',NULL),(32,21,'2023-03-13 15:00:56','Pending',NULL),(33,21,'2023-03-13 15:00:56','Accepted','floop'),(34,22,'2023-03-28 19:58:25','Pending',NULL),(35,22,'2023-03-28 19:58:25','Accepted','good'),(36,23,'2023-03-28 20:41:26','Pending',NULL),(37,23,'2023-03-28 20:41:26','Accepted','bugs'),(38,24,'2023-03-30 02:35:56','Pending',NULL),(39,25,'2023-03-30 02:36:00','Pending',NULL),(40,26,'2023-03-30 02:36:03','Pending',NULL),(41,27,'2023-03-30 02:36:07','Pending',NULL),(42,25,'2023-03-30 02:36:00','Accepted',''),(43,26,'2023-03-30 02:36:03','Rejected','bro your email literally says '),(56,37,'2023-04-17 00:19:28','Pending',NULL),(61,42,'2023-04-21 22:06:49','Pending',NULL),(62,43,'2023-04-21 22:06:52','Pending',NULL),(63,44,'2023-04-21 22:06:54','Pending',NULL),(64,45,'2023-04-21 22:06:57','Pending',NULL),(65,42,'2023-04-21 22:06:49','Accepted','yes');
/*!40000 ALTER TABLE `application_state_change` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add admin user',1,'add_adminuser'),(2,'Can change admin user',1,'change_adminuser'),(3,'Can delete admin user',1,'delete_adminuser'),(4,'Can view admin user',1,'view_adminuser'),(5,'Can add driver application',2,'add_driverapplication'),(6,'Can change driver application',2,'change_driverapplication'),(7,'Can delete driver application',2,'delete_driverapplication'),(8,'Can view driver application',2,'view_driverapplication'),(9,'Can add driver sponsor',3,'add_driversponsor'),(10,'Can change driver sponsor',3,'change_driversponsor'),(11,'Can delete driver sponsor',3,'delete_driversponsor'),(12,'Can view driver sponsor',3,'view_driversponsor'),(13,'Can add driver user',4,'add_driveruser'),(14,'Can change driver user',4,'change_driveruser'),(15,'Can delete driver user',4,'delete_driveruser'),(16,'Can view driver user',4,'view_driveruser'),(17,'Can add item',5,'add_item'),(18,'Can change item',5,'change_item'),(19,'Can delete item',5,'delete_item'),(20,'Can view item',5,'view_item'),(21,'Can add login attempt',6,'add_loginattempt'),(22,'Can change login attempt',6,'change_loginattempt'),(23,'Can delete login attempt',6,'delete_loginattempt'),(24,'Can view login attempt',6,'view_loginattempt'),(25,'Can add points',7,'add_points'),(26,'Can change points',7,'change_points'),(27,'Can delete points',7,'delete_points'),(28,'Can view points',7,'view_points'),(29,'Can add purchase',8,'add_purchase'),(30,'Can change purchase',8,'change_purchase'),(31,'Can delete purchase',8,'delete_purchase'),(32,'Can view purchase',8,'view_purchase'),(33,'Can add purchase item',9,'add_purchaseitem'),(34,'Can change purchase item',9,'change_purchaseitem'),(35,'Can delete purchase item',9,'delete_purchaseitem'),(36,'Can view purchase item',9,'view_purchaseitem'),(37,'Can add sponsor',10,'add_sponsor'),(38,'Can change sponsor',10,'change_sponsor'),(39,'Can delete sponsor',10,'delete_sponsor'),(40,'Can view sponsor',10,'view_sponsor'),(41,'Can add sponsor user',11,'add_sponsoruser'),(42,'Can change sponsor user',11,'change_sponsoruser'),(43,'Can delete sponsor user',11,'delete_sponsoruser'),(44,'Can view sponsor user',11,'view_sponsoruser'),(45,'Can add users',12,'add_users'),(46,'Can change users',12,'change_users'),(47,'Can delete users',12,'delete_users'),(48,'Can view users',12,'view_users'),(49,'Can add log entry',13,'add_logentry'),(50,'Can change log entry',13,'change_logentry'),(51,'Can delete log entry',13,'delete_logentry'),(52,'Can view log entry',13,'view_logentry'),(53,'Can add permission',14,'add_permission'),(54,'Can change permission',14,'change_permission'),(55,'Can delete permission',14,'delete_permission'),(56,'Can view permission',14,'view_permission'),(57,'Can add group',15,'add_group'),(58,'Can change group',15,'change_group'),(59,'Can delete group',15,'delete_group'),(60,'Can view group',15,'view_group'),(61,'Can add content type',16,'add_contenttype'),(62,'Can change content type',16,'change_contenttype'),(63,'Can delete content type',16,'delete_contenttype'),(64,'Can view content type',16,'view_contenttype'),(65,'Can add session',17,'add_session'),(66,'Can change session',17,'change_session'),(67,'Can delete session',17,'delete_session'),(68,'Can view session',17,'view_session');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_users_User_ID` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_users_User_ID` FOREIGN KEY (`user_id`) REFERENCES `users` (`User_ID`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'accounts','adminuser'),(2,'accounts','driverapplication'),(3,'accounts','driversponsor'),(4,'accounts','driveruser'),(5,'accounts','item'),(6,'accounts','loginattempt'),(7,'accounts','points'),(8,'accounts','purchase'),(9,'accounts','purchaseitem'),(10,'accounts','sponsor'),(11,'accounts','sponsoruser'),(12,'accounts','users'),(13,'admin','logentry'),(15,'auth','group'),(14,'auth','permission'),(16,'contenttypes','contenttype'),(17,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-02-27 23:07:20.152975'),(2,'admin','0001_initial','2023-02-27 23:07:20.699654'),(3,'admin','0002_logentry_remove_auto_add','2023-02-27 23:07:20.791571'),(4,'admin','0003_logentry_add_action_flag_choices','2023-02-27 23:07:20.878413'),(5,'contenttypes','0002_remove_content_type_name','2023-02-27 23:07:21.331703'),(6,'auth','0001_initial','2023-02-27 23:07:22.236131'),(7,'auth','0002_alter_permission_name_max_length','2023-02-27 23:07:22.490601'),(8,'auth','0003_alter_user_email_max_length','2023-02-27 23:07:22.596155'),(9,'auth','0004_alter_user_username_opts','2023-02-27 23:07:22.691621'),(10,'auth','0005_alter_user_last_login_null','2023-02-27 23:07:22.782752'),(11,'auth','0006_require_contenttypes_0002','2023-02-27 23:07:22.860589'),(12,'auth','0007_alter_validators_add_error_messages','2023-02-27 23:07:22.974385'),(13,'auth','0008_alter_user_username_max_length','2023-02-27 23:07:23.078446'),(14,'auth','0009_alter_user_last_name_max_length','2023-02-27 23:07:23.230086'),(15,'auth','0010_alter_group_name_max_length','2023-02-27 23:07:23.407081'),(16,'auth','0011_update_proxy_permissions','2023-02-27 23:07:23.625872'),(17,'auth','0012_alter_user_first_name_max_length','2023-02-27 23:07:23.713096'),(18,'sessions','0001_initial','2023-02-27 23:07:24.019886');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('015yhwqmlmzefvgvkwhfhywbi3ny9vwi','.eJxVi0EOwiAQRe_C2jQUSqe4sx6EDDNDMMY2EVgZ7y4mXejyv__eSwVsNYdW5BlurM7KeHX6hRHpLtv3QaK9bbUMByrDtZW6Py7dXQ_rL81Ycu9cmiKQTqSjHpckk1hYkiPPLARpBudS9H0Bz2IJjUGLGmyPRgBm9f4A3jo3Rg:1pZkqk:Mv437hL-GWp2tjWbWYeP446GjrY61qVbwQjlzFndqvw','2023-03-22 03:52:22.205248'),('01le2add2e59g66h1zyj30klovw8lxej','.eJxVizsOwjAMQO-SGVWt7fzYKAeJ3NRWEKKVSDMh7k6ROsD6Pi-TuG0ltSrPdJvN2YA3p184cb7L8jWc89qWrXYHqt211W19XPZ2PKq_tXAt-5cDhcCAMEQkYseCvQJYER89R1FHyFmJ0AbCyVudrfYgblDnBYJ5fwCZBjWZ:1pkSik:uqKe9WhqW8Btaw6XKNT7TJ_rnkQ6ohWHkAxLA6pDaJY','2023-04-20 16:44:22.041013'),('0rf5hq9rzjb3xeg77ba1cmjlalffx65d','.eJxVjkEKwjAQRe-StRRmMkkYd-pBwmSSEhFbMM2qeHcjdKHb99-Dv5sofauxt_KK92zOBp05_cIk-ijLdxHVtS9bmw7Upltv2_q8DPd6WH9plVZHB4LgvRCiZS8JOKCn5JUpZ8wkAlTCzBTAsVUvGSw7CnMoKqGMP-8Pjpk1hg:1pjqD9:lI2Ity9uyxBt-KFVKESiHuhrwpvmLnzH9HWHVHkgQSo','2023-04-18 23:37:11.802084'),('17vl0i1py34pcq1086wxsajfvetvkiud','e30:1pjos6:SlccB39c08pVs28i6jCe-uC4Yd_TRqXzt8UvK6wfDCo','2023-04-18 22:11:22.333134'),('1kggd5yvj8yh9y679dfn9jstx5drj47l','.eJxVjMsOwiAQRf-FtWmAlse4Uz-EzAwQjLFNBFbGf2-bdFG355x7vyJgbyX0mj7hGcVVgBSXMyTkV5p3g8xLn1sdDlSHR69ted-29n5Uf9OCteyPJsUEZBEU4zhp6TRFIPQQVdaU0Sht0NvNOpnNCEyeySGwyWj9JH4rzBQ22Q:1pm2zt:oRDCVVsh69trMa7vmE19q4xw9ue3MNBWHMpxiUbwVZc','2023-04-25 01:40:37.039491'),('4dttkyz4mnexs1mrscwzvxsfj2m4u81k','.eJxVjEEKwjAQRe-StRQymWQYd-pBwmSSEhFbMMmqeHctdKHb99_7m4kyeo2jlVe8Z3M2Fs3pFybRR1n2RVTXsfQ2HahNt9H6-rx83eth_aVVWt0fBWwIggCOgyTLBAFTUMacIaOIxUIzI1nPToNk69gjzVRUqIA37w-NcjWE:1pbkWu:ZEC3aZmDWqFeOAv4shd9qcnreCi0HUoK5-LVM8-5rAI','2023-03-27 15:56:08.655154'),('4m7ysahshcha0m9t8l0zxy6hap8m2iku','.eJxVi80OwiAMgN-Fs1lCKa14Ux-ElMKCMW6JwMn47s5kB71-Py8TZfQaRyvPeMvmZNzRHH5hEr2X5WtEdR1Lb9OO2nQdra-P89Ze9upvrdLq9lkBSyQI4AJJsoGBMJEGzBkyilgsPAdk64NTkmxd8MgzFxUu4M37A5DmNYo:1phx9j:Cqldg8QvX_GyDNGqgAFgD1IunpMU-1zlTkZoP91hu28','2023-04-13 18:37:51.265453'),('5tsrgbvm6iwvznfttt0iesqq6df3b193','.eJxVi80OwiAMgN-Fs1lCKa14Ux-ElMKCMW6JwMn47s5kB71-Py8TZfQaRyvPeMvmZNzRHH5hEr2X5WtEdR1Lb9OO2nQdra-P89Ze9upvrdLq9lkBSyQI4AJJsoGBMJEGzBkyilgsPAdk64NTkmxd8MgzFxUu4M37A5DmNYo:1phxBX:bg0dQFY8KM2sooZD5P6CX2MVnY6QYQ-KYVZldEFwVqg','2023-04-13 18:39:43.568684'),('5xp59ki6mjuoyuknod2mh98t7bq3l5o4','.eJxVi80OwiAMgN-Fs1lCKa14Ux-ElMKCMW6JwMn47s5kB71-Py8TZfQaRyvPeMvmZNzRHH5hEr2X5WtEdR1Lb9OO2nQdra-P89Ze9upvrdLq9lkBSyQI4AJJsoGBMJEGzBkyilgsPAdk64NTkmxd8MgzFxUu4M37A5DmNYo:1phxAe:-aZ9tHDd010bNz8OYHAEFPk7-paGJq6cKKWGQ7ivgoc','2023-04-13 18:38:48.846052'),('7mo6o33owan3t7ayc3fxekhqwbcvvmot','.eJxVizsOwjAMQO-SGVWt7fzYKAeJ3NRWEKKVSDMh7k6ROsD6Pi-TuG0ltSrPdJvN2YA3p184cb7L8jWc89qWrXYHqt211W19XPZ2PKq_tXAt-5cDhcCAMEQkYseCvQJYER89R1FHyFmJ0AbCyVudrfYgblDnBYJ5fwCZBjWZ:1pkQOb:iJJ68qJqXKozEoRBvMgNPM7QpM28pQF2Ag4HonnvXMs','2023-04-20 14:15:25.327488'),('a5wqhpcmvtgpp3xv9547gg0cemdvjvqr','.eJxVjkEKwjAQRe-StRRmMkkYd-pBwmSSEhFbMM2qeHcjdKHb99-Dv5sofauxt_KK92zOBp05_cIk-ijLdxHVtS9bmw7Upltv2_q8DPd6WH9plVZHB4LgvRCiZS8JOKCn5JUpZ8wkAlTCzBTAsVUvGSw7CnMoKqGMP-8Pjpk1hg:1plvkM:86ExuF6Bu07yaGyGeQnmZX4AW4mR_rdZBUgOVoBh-5o','2023-04-24 17:56:06.120777'),('aanbnngk943ry7cfvmxe3j0e4aewfieq','.eJxVizsOwjAMQO-SGVWt7fzYKAeJ3NRWEKKVSDMh7k6ROsD6Pi-TuG0ltSrPdJvN2YA3p184cb7L8jWc89qWrXYHqt211W19XPZ2PKq_tXAt-5cDhcCAMEQkYseCvQJYER89R1FHyFmJ0AbCyVudrfYgblDnBYJ5fwCZBjWZ:1pkUFA:VRXvYHvcJulTMQQg3nB_yCbhH5OF1b3xBfu_5GNi8ws','2023-04-20 18:21:56.484422'),('c1qhdh5dfcn3q4i9o8salij80w0cp12f','.eJxVizsOwjAMQO-SGVWt7fzYKAeJ3NRWEKKVSDMh7k6ROsD6Pi-TuG0ltSrPdJvN2YA3p184cb7L8jWc89qWrXYHqt211W19XPZ2PKq_tXAt-5cDhcCAMEQkYseCvQJYER89R1FHyFmJ0AbCyVudrfYgblDnBYJ5fwCZBjWZ:1ppYoi:8JruIl1uB2ShPtbW99vb6tq7OXLqT-NAPwDT2tNQyg4','2023-05-04 18:15:36.712363'),('cnaag86w0t3ukshf895poewsjidgjomd','.eJxVjkEKwjAQRe-StRRmMkkYd-pBwmSSEhFbMM2qeHcjdKHb99-Dv5sofauxt_KK92zOBp05_cIk-ijLdxHVtS9bmw7Upltv2_q8DPd6WH9plVZHB4LgvRCiZS8JOKCn5JUpZ8wkAlTCzBTAsVUvGSw7CnMoKqGMP-8Pjpk1hg:1ppYwo:PonAnq2gCAj10KnxdgLitFZUexFrYcMJKasOXBTUptk','2023-05-04 18:23:58.634822'),('fr03uyazoboc9ytkhzty0us33i6j6zlc','.eJxVjEEKwjAQRe-StRQymWQYd-pBwmSSEhFbMMmqeHctdKHb99_7m4kyeo2jlVe8Z3M2FszpFybRR1n2RVTXsfQ2HahNt9H6-rx83eth_aVVWt0fBWwIggCOgyTLBAFTUMacIaOIxUIzI1nPToNk69gjzVRUqIA37w-MTDWC:1pppb4:gwIWLhyeTmkgHhORW9zOvOFoFF9PulKAxtmWPdYNcK4','2023-05-05 12:10:38.243680'),('gnv7rlr7cqgja5vtqiq1ozrz8i0olbkl','.eJxVjEEKwjAQRe-StRQymWQYd-pBwmSSEhFbMMmqeHctdKHb99_7m4kyeo2jlVe8Z3M2Fs3pFybRR1n2RVTXsfQ2HahNt9H6-rx83eth_aVVWt0fBWwIggCOgyTLBAFTUMacIaOIxUIzI1nPToNk69gjzVRUqIA37w-NcjWE:1pc9rp:dXT_Kz_iKKD6ctsTpUHzDzKS-t37Gp3CQPyMXPqlAhI','2023-03-28 18:59:25.224710'),('ina0lccvrwlok9oa5on3bvfsyxy1rc1w','.eJxVjEEKwjAQRe-StRQymWQYd-pBwmSSEhFbMMmqeHctdKHb99_7m4kyeo2jlVe8Z3M2FszpFybRR1n2RVTXsfQ2HahNt9H6-rx83eth_aVVWt0fBWwIggCOgyTLBAFTUMacIaOIxUIzI1nPToNk69gjzVRUqIA37w-MTDWC:1ppYEV:-RZwT2MZq9ohtVe5VWDSyHK8S9ya02WrZ7BmI-yOWlI','2023-05-04 17:38:11.674264'),('joe4ymzxf798w78l95xxsd6yser8wgwh','.eJxVjkEKwjAQRe-StRRmMkkYd-pBwmSSEhFbMM2qeHcjdKHb99-Dv5sofauxt_KK92zOBp05_cIk-ijLdxHVtS9bmw7Upltv2_q8DPd6WH9plVZHB4LgvRCiZS8JOKCn5JUpZ8wkAlTCzBTAsVUvGSw7CnMoKqGMP-8Pjpk1hg:1paU9d:Bt4KCEksCAsAeeXKvFgQuEEFiyYrNLvPbsloPkIEFa4','2023-03-24 04:14:53.458471'),('kfnqzcqltpowmg50x04jskecduqqwbg9','e30:1pjob2:rtUGNicy1TaQ8989NmcnDE7DmpkvKaONe3SoleuvuYg','2023-04-18 21:53:44.314358'),('mduqmrmzvpsqdxymbhgbc13wx1tkq2iu','e30:1pjovo:_08ihCdmImOMTaA-Kt4Lfs5vSO1lzJNrpx4siwRKNhI','2023-04-18 22:15:12.963841'),('mp96dzwbqxkcm25uyl12cljsx3n1xyjd','e30:1pXYtX:OIkge2vOOyfMVXiIF7sX-QNhSEo8Nh4mlJk0gU5s5Ho','2023-03-16 02:42:11.578122'),('q4kdaykdjlhom762wyirat0ux8fk1cjh','.eJxVizsOwjAMQO-SGVWt7fzYKAeJ3NRWEKKVSDMh7k6ROsD6Pi-TuG0ltSrPdJvN2YA3p184cb7L8jWc89qWrXYHqt211W19XPZ2PKq_tXAt-5cDhcCAMEQkYseCvQJYER89R1FHyFmJ0AbCyVudrfYgblDnBYJ5fwCZBjWZ:1pmzmS:12Z7srcc9VWwYqccewV-ziiKmfOufgU8LYWHxKy1Bak','2023-04-27 16:26:40.596837'),('sjlyndp8tnq0cofi3i4798dabhdp51br','.eJxVjEEKwjAQRe-StRQymWQYd-pBwmSSEhFbMMmqeHctdKHb99_7m4kyeo2jlVe8Z3M2FszpFybRR1n2RVTXsfQ2HahNt9H6-rx83eth_aVVWt0fBWwIggCOgyTLBAFTUMacIaOIxUIzI1nPToNk69gjzVRUqIA37w-MTDWC:1ppznk:L4Cvx6j3msC3oMxPnl6ES3mQ4hSA6FedQh65W8R8z5w','2023-05-05 23:04:24.608674'),('tz1w4zsgl24bh0ukuv19k2h3apm6vyje','.eJxVizsOwjAMQO-SGVWt7fzYKAeJ3NRWEKKVSDMh7k6ROsD6Pi-TuG0ltSrPdJvN2YA3p184cb7L8jWc89qWrXYHqt211W19XPZ2PKq_tXAt-5cDhcCAMEQkYseCvQJYER89R1FHyFmJ0AbCyVudrfYgblDnBYJ5fwCZBjWZ:1plKGt:mptC9i11oTkkw7-paPx2ikd0EIVjF24PBHxZYNW7hDw','2023-04-23 01:55:11.037145'),('ywolyxjrg0992zh4ps6c4go86tvz9jgp','.eJxVjs1uwyAQhN-FcxXZmN_empzyFGhhoUaNjcXayaHquwdHPqS31cx8s_PLHGzr6DaK1WVkn0wr9vEuegg_cd4dCKFs80qnQ6LTZaO1TF8tez5S_9ARaGwcgtfRpC4G2yewCoQ1Vg4mScHRdil1aKTQYHvFBwjJRoNcdMpYDCH5vpWWmr_zDDcXJ8i31klLmanU9O4tQPQodZ8qk2js4CWAVhJVj2bgGqM3hrcHtmF5WkpbXx3WfI913_k6rofOJft7AhakX6w:1pk6yd:wGlBWgW59LBjByVexWqb3GPV_DCDIpL4RpszgKuYzgs','2023-04-19 17:31:19.279040');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `driver_application`
--

DROP TABLE IF EXISTS `driver_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `driver_application` (
  `Application_ID` int NOT NULL AUTO_INCREMENT,
  `Driver_ID` int NOT NULL,
  `Sponsor_ID` int NOT NULL,
  `Date_Time` datetime NOT NULL,
  `Status` varchar(15) NOT NULL,
  `Reason` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`Application_ID`),
  KEY `driver_application_ibfk_1` (`Driver_ID`),
  KEY `driver_application_ibfk_2` (`Sponsor_ID`),
  CONSTRAINT `driver_application_ibfk_1` FOREIGN KEY (`Driver_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `driver_application_ibfk_2` FOREIGN KEY (`Sponsor_ID`) REFERENCES `sponsor` (`Sponsor_ID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `driver_application`
--

LOCK TABLES `driver_application` WRITE;
/*!40000 ALTER TABLE `driver_application` DISABLE KEYS */;
INSERT INTO `driver_application` VALUES (8,27,1,'2023-03-02 15:46:58','Pending',NULL),(9,27,2,'2023-03-02 16:16:31','Accepted','good'),(10,11,1,'2023-03-03 17:09:53','Pending',NULL),(11,11,2,'2023-03-03 17:09:55','Accepted','u smell'),(12,11,3,'2023-03-03 17:09:57','Accepted','good'),(13,11,4,'2023-03-03 17:09:59','Pending',NULL),(14,27,4,'2023-03-04 20:23:58','Pending',NULL),(15,28,2,'2023-03-07 19:17:48','Rejected',''),(16,28,3,'2023-03-07 19:17:51','Accepted',''),(17,28,1,'2023-03-07 19:17:52','Pending',NULL),(18,28,4,'2023-03-07 19:17:55','Pending',NULL),(19,27,3,'2023-03-09 01:27:10','Accepted','good job'),(20,30,1,'2023-03-13 14:58:11','Pending',NULL),(21,30,2,'2023-03-13 15:00:56','Accepted','floop'),(22,27,2,'2023-03-28 19:58:25','Accepted','good'),(23,27,3,'2023-03-28 20:41:26','Accepted','bugs'),(24,38,1,'2023-03-30 02:35:56','Pending',NULL),(25,38,2,'2023-03-30 02:36:00','Accepted',''),(26,38,3,'2023-03-30 02:36:03','Rejected','bro your email literally says '),(27,38,4,'2023-03-30 02:36:07','Pending',NULL),(37,103,2,'2023-04-17 00:19:28','Pending',NULL),(42,130,7,'2023-04-21 22:06:49','Accepted','yes'),(43,130,2,'2023-04-21 22:06:52','Pending',NULL),(44,130,4,'2023-04-21 22:06:54','Pending',NULL),(45,130,1,'2023-04-21 22:06:57','Pending',NULL);
/*!40000 ALTER TABLE `driver_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `driver_sponsor`
--

DROP TABLE IF EXISTS `driver_sponsor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `driver_sponsor` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `User_ID` int NOT NULL,
  `Sponsor_ID` int NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `driver_sponsor_ibfk_2` (`Sponsor_ID`),
  KEY `driver_sponsor_ibfk_1` (`User_ID`),
  CONSTRAINT `driver_sponsor_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `driver_sponsor_ibfk_2` FOREIGN KEY (`Sponsor_ID`) REFERENCES `sponsor` (`Sponsor_ID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `driver_sponsor`
--

LOCK TABLES `driver_sponsor` WRITE;
/*!40000 ALTER TABLE `driver_sponsor` DISABLE KEYS */;
INSERT INTO `driver_sponsor` VALUES (1,27,2),(2,30,2),(3,37,2),(4,11,3),(5,28,3),(8,27,3),(9,38,2),(35,11,4),(42,11,2),(49,11,1),(65,119,3),(70,130,7),(74,130,2);
/*!40000 ALTER TABLE `driver_sponsor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_attempt`
--

DROP TABLE IF EXISTS `login_attempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login_attempt` (
  `Attempt_ID` int NOT NULL AUTO_INCREMENT,
  `User_ID` int NOT NULL,
  `Date_Time` datetime NOT NULL,
  `Was_Accepted` bit(1) NOT NULL,
  PRIMARY KEY (`Attempt_ID`),
  KEY `login_attempt_ibfk_1` (`User_ID`),
  CONSTRAINT `login_attempt_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=635 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_attempt`
--

LOCK TABLES `login_attempt` WRITE;
/*!40000 ALTER TABLE `login_attempt` DISABLE KEYS */;
INSERT INTO `login_attempt` VALUES (1,27,'2023-03-02 02:56:32',_binary ''),(2,27,'2023-03-02 02:57:35',_binary ''),(3,27,'2023-03-01 22:21:48',_binary ''),(4,27,'2023-03-01 22:22:53',_binary ''),(5,27,'2023-03-01 22:25:11',_binary '\0'),(6,12,'2023-03-02 04:04:00',_binary ''),(7,14,'2023-03-02 04:05:19',_binary ''),(8,12,'2023-03-02 05:10:28',_binary ''),(9,27,'2023-03-02 05:28:35',_binary ''),(10,27,'2023-03-02 19:10:41',_binary ''),(11,27,'2023-03-02 19:46:54',_binary ''),(12,12,'2023-03-02 19:47:18',_binary ''),(13,12,'2023-03-02 20:01:18',_binary ''),(14,14,'2023-03-02 21:23:10',_binary ''),(15,11,'2023-03-03 22:09:43',_binary ''),(16,14,'2023-03-03 22:10:18',_binary ''),(17,12,'2023-03-03 23:54:25',_binary ''),(18,14,'2023-03-03 23:54:51',_binary ''),(19,27,'2023-03-05 01:23:35',_binary ''),(20,12,'2023-03-06 20:20:50',_binary ''),(21,12,'2023-03-07 09:58:54',_binary '\0'),(22,11,'2023-03-03 22:09:43',_binary ''),(23,11,'2023-03-07 15:19:24',_binary ''),(24,12,'2023-03-07 15:19:42',_binary ''),(25,11,'2023-03-07 15:19:24',_binary ''),(26,14,'2023-03-07 19:12:55',_binary ''),(27,28,'2023-03-07 19:17:39',_binary ''),(28,14,'2023-03-07 19:18:12',_binary ''),(29,27,'2023-03-07 19:39:10',_binary ''),(30,27,'2023-03-07 19:41:42',_binary ''),(31,27,'2023-03-07 19:44:37',_binary ''),(32,29,'2023-03-07 19:47:53',_binary ''),(33,12,'2023-03-07 19:51:01',_binary ''),(34,29,'2023-03-07 19:47:53',_binary ''),(35,29,'2023-03-07 20:04:04',_binary '\0'),(36,29,'2023-03-08 01:04:17',_binary ''),(37,12,'2023-03-07 19:51:01',_binary ''),(38,12,'2023-03-07 19:51:01',_binary ''),(39,12,'2023-03-07 19:51:01',_binary ''),(40,12,'2023-03-07 19:51:01',_binary ''),(41,12,'2023-03-07 19:51:01',_binary ''),(42,12,'2023-03-07 20:34:27',_binary ''),(43,12,'2023-03-07 20:34:32',_binary ''),(44,12,'2023-03-08 00:03:05',_binary ''),(45,29,'2023-03-08 03:52:22',_binary ''),(46,30,'2023-03-08 13:47:35',_binary ''),(47,12,'2023-03-08 13:47:59',_binary ''),(48,12,'2023-03-08 13:47:59',_binary ''),(49,12,'2023-03-08 13:47:59',_binary ''),(50,12,'2023-03-08 13:47:59',_binary ''),(51,12,'2023-03-08 13:47:59',_binary ''),(52,12,'2023-03-08 13:47:59',_binary ''),(53,12,'2023-03-08 13:47:59',_binary ''),(54,12,'2023-03-08 13:47:59',_binary ''),(55,30,'2023-03-08 13:47:35',_binary ''),(56,30,'2023-03-08 13:47:35',_binary ''),(57,30,'2023-03-08 13:47:35',_binary ''),(58,30,'2023-03-08 13:47:35',_binary ''),(59,30,'2023-03-08 13:47:35',_binary ''),(60,27,'2023-03-07 19:44:37',_binary ''),(61,27,'2023-03-07 19:44:37',_binary ''),(62,27,'2023-03-07 19:44:37',_binary ''),(63,27,'2023-03-07 19:44:37',_binary ''),(64,27,'2023-03-07 19:44:37',_binary ''),(123,31,'2023-03-08 22:30:06',_binary ''),(124,31,'2023-03-08 22:15:06',_binary ''),(125,31,'2023-03-08 18:04:14',_binary '\0'),(126,31,'2023-03-08 18:04:17',_binary '\0'),(127,27,'2023-03-09 01:59:50',_binary ''),(128,14,'2023-03-09 02:08:40',_binary ''),(129,27,'2023-03-09 02:43:58',_binary ''),(130,14,'2023-03-09 02:44:40',_binary ''),(131,14,'2023-03-09 05:23:33',_binary ''),(132,27,'2023-03-09 05:25:13',_binary ''),(133,14,'2023-03-09 05:25:35',_binary ''),(134,12,'2023-03-09 05:25:45',_binary ''),(135,27,'2023-03-09 05:26:08',_binary ''),(136,27,'2023-03-09 06:27:03',_binary ''),(137,25,'2023-03-09 06:28:02',_binary ''),(138,27,'2023-03-09 06:28:27',_binary ''),(139,25,'2023-03-09 06:28:42',_binary ''),(140,27,'2023-03-09 06:29:58',_binary ''),(141,14,'2023-03-09 06:44:03',_binary ''),(142,12,'2023-03-09 06:44:34',_binary ''),(143,29,'2023-03-09 14:23:47',_binary ''),(144,27,'2023-03-09 18:56:50',_binary ''),(145,27,'2023-03-09 18:57:18',_binary ''),(146,27,'2023-03-09 18:57:58',_binary ''),(147,27,'2023-03-09 18:58:12',_binary ''),(148,14,'2023-03-09 19:01:19',_binary ''),(149,25,'2023-03-09 19:01:55',_binary ''),(150,12,'2023-03-09 19:22:27',_binary ''),(151,27,'2023-03-09 19:27:55',_binary ''),(152,29,'2023-03-09 19:35:09',_binary '\0'),(153,29,'2023-03-09 19:35:14',_binary ''),(154,12,'2023-03-09 14:35:53',_binary '\0'),(155,12,'2023-03-09 19:35:59',_binary ''),(156,25,'2023-03-09 19:42:40',_binary ''),(157,30,'2023-03-09 19:45:24',_binary ''),(158,27,'2023-03-10 03:39:55',_binary ''),(159,25,'2023-03-10 04:14:53',_binary ''),(160,12,'2023-03-13 11:23:03',_binary ''),(161,14,'2023-03-13 13:55:44',_binary ''),(162,12,'2023-03-13 14:50:28',_binary ''),(163,30,'2023-03-13 14:57:57',_binary ''),(164,30,'2023-03-13 15:00:46',_binary ''),(165,14,'2023-03-13 15:01:10',_binary ''),(166,11,'2023-03-13 15:03:48',_binary ''),(167,14,'2023-03-13 15:04:19',_binary ''),(168,25,'2023-03-13 15:17:01',_binary ''),(169,14,'2023-03-13 15:21:35',_binary ''),(170,12,'2023-03-13 15:52:54',_binary ''),(171,14,'2023-03-13 15:56:09',_binary ''),(172,12,'2023-03-14 18:10:52',_binary ''),(173,27,'2023-03-14 18:46:02',_binary ''),(174,27,'2023-03-14 14:46:05',_binary '\0'),(175,27,'2023-03-14 14:46:10',_binary '\0'),(176,27,'2023-03-14 18:48:26',_binary ''),(177,14,'2023-03-14 14:48:58',_binary '\0'),(178,14,'2023-03-14 18:49:14',_binary ''),(179,14,'2023-03-14 18:59:25',_binary ''),(180,30,'2023-03-14 19:01:33',_binary '\0'),(181,30,'2023-03-14 19:01:43',_binary '\0'),(182,12,'2023-03-14 19:01:51',_binary ''),(183,12,'2023-03-14 22:32:25',_binary ''),(184,14,'2023-03-14 22:35:32',_binary ''),(185,11,'2023-03-15 13:51:18',_binary ''),(186,27,'2023-03-15 14:05:38',_binary ''),(187,25,'2023-03-15 14:06:12',_binary ''),(188,27,'2023-03-15 14:09:32',_binary ''),(189,25,'2023-03-15 14:12:22',_binary ''),(190,12,'2023-03-15 14:13:54',_binary ''),(191,27,'2023-03-16 18:36:18',_binary ''),(192,25,'2023-03-16 18:50:26',_binary ''),(193,27,'2023-03-16 18:56:34',_binary ''),(194,25,'2023-03-16 18:58:28',_binary ''),(195,12,'2023-03-27 17:08:35',_binary '\0'),(196,12,'2023-03-27 17:08:39',_binary '\0'),(197,12,'2023-03-27 21:09:01',_binary ''),(198,22,'2023-03-27 21:13:09',_binary ''),(199,28,'2023-03-27 21:14:27',_binary ''),(200,27,'2023-03-27 22:12:10',_binary ''),(201,25,'2023-03-27 23:26:13',_binary ''),(202,27,'2023-03-27 23:39:13',_binary ''),(203,12,'2023-03-27 23:39:51',_binary ''),(204,27,'2023-03-27 23:58:35',_binary ''),(205,27,'2023-03-28 00:00:36',_binary ''),(206,27,'2023-03-28 00:08:10',_binary ''),(207,27,'2023-03-28 00:30:12',_binary ''),(208,25,'2023-03-28 18:27:29',_binary ''),(209,12,'2023-03-28 18:36:24',_binary ''),(210,12,'2023-03-28 20:24:29',_binary ''),(211,27,'2023-03-28 20:32:34',_binary ''),(212,27,'2023-03-28 20:32:44',_binary ''),(213,27,'2023-03-28 20:41:21',_binary ''),(214,12,'2023-03-28 21:32:53',_binary ''),(215,12,'2023-03-28 23:50:35',_binary ''),(216,25,'2023-03-28 23:51:07',_binary ''),(217,27,'2023-03-28 23:51:34',_binary ''),(218,25,'2023-03-28 23:58:39',_binary ''),(219,14,'2023-03-28 23:59:21',_binary ''),(220,25,'2023-03-29 00:03:52',_binary ''),(221,11,'2023-03-29 00:04:49',_binary ''),(222,27,'2023-03-29 00:41:14',_binary ''),(223,25,'2023-03-29 00:41:38',_binary ''),(224,27,'2023-03-29 00:42:26',_binary ''),(225,27,'2023-03-29 14:06:41',_binary ''),(226,12,'2023-03-29 14:40:40',_binary ''),(227,27,'2023-03-29 14:41:16',_binary ''),(228,22,'2023-03-29 20:34:28',_binary ''),(229,14,'2023-03-29 20:36:16',_binary ''),(230,25,'2023-03-29 20:37:45',_binary ''),(231,27,'2023-03-29 20:38:05',_binary ''),(232,28,'2023-03-29 20:42:07',_binary ''),(233,14,'2023-03-29 21:16:10',_binary ''),(234,14,'2023-03-29 21:30:58',_binary ''),(235,28,'2023-03-29 21:43:32',_binary ''),(236,14,'2023-03-29 17:46:20',_binary '\0'),(237,14,'2023-03-29 21:46:27',_binary ''),(238,12,'2023-03-29 21:47:26',_binary ''),(239,14,'2023-03-29 23:19:52',_binary ''),(240,27,'2023-03-29 23:20:17',_binary ''),(241,27,'2023-03-30 00:40:33',_binary ''),(242,11,'2023-03-30 00:49:19',_binary ''),(243,22,'2023-03-30 00:50:27',_binary ''),(244,22,'2023-03-30 00:54:00',_binary ''),(245,27,'2023-03-30 00:59:37',_binary ''),(246,11,'2023-03-30 01:33:36',_binary ''),(247,14,'2023-03-30 01:35:01',_binary ''),(248,30,'2023-03-30 01:35:37',_binary ''),(249,14,'2023-03-30 01:47:43',_binary ''),(250,30,'2023-03-30 01:51:07',_binary ''),(251,14,'2023-03-30 02:34:36',_binary ''),(252,25,'2023-03-30 02:35:06',_binary ''),(253,14,'2023-03-30 02:40:46',_binary ''),(254,38,'2023-03-30 02:43:15',_binary ''),(255,14,'2023-03-30 02:44:06',_binary ''),(256,25,'2023-03-30 02:44:23',_binary '\0'),(257,25,'2023-03-30 02:44:29',_binary ''),(258,38,'2023-03-30 02:44:55',_binary ''),(259,12,'2023-03-30 18:06:04',_binary ''),(260,28,'2023-03-30 18:06:37',_binary ''),(261,25,'2023-03-30 18:13:33',_binary ''),(262,27,'2023-03-30 18:19:26',_binary ''),(263,27,'2023-03-30 18:36:15',_binary ''),(264,30,'2023-03-30 18:37:30',_binary '\0'),(265,30,'2023-03-30 18:37:40',_binary '\0'),(266,30,'2023-03-30 18:37:45',_binary '\0'),(267,38,'2023-03-30 18:37:51',_binary ''),(268,38,'2023-03-30 18:38:49',_binary ''),(269,38,'2023-03-30 18:39:44',_binary ''),(270,25,'2023-03-30 18:42:34',_binary '\0'),(271,14,'2023-03-30 18:42:39',_binary ''),(272,25,'2023-03-30 18:42:41',_binary ''),(273,28,'2023-03-30 18:43:50',_binary ''),(274,27,'2023-03-30 18:44:16',_binary ''),(275,27,'2023-04-03 01:39:22',_binary ''),(276,27,'2023-04-03 01:59:39',_binary ''),(277,25,'2023-04-03 02:01:01',_binary ''),(278,12,'2023-04-03 02:01:47',_binary ''),(279,11,'2023-04-03 02:05:53',_binary ''),(280,12,'2023-04-03 22:04:41',_binary ''),(281,14,'2023-04-03 22:07:55',_binary ''),(282,14,'2023-04-04 17:00:45',_binary ''),(283,12,'2023-04-04 18:13:21',_binary ''),(284,14,'2023-04-04 18:13:39',_binary ''),(285,27,'2023-04-04 18:20:14',_binary ''),(286,25,'2023-04-04 18:21:19',_binary ''),(287,27,'2023-04-04 18:24:02',_binary ''),(288,14,'2023-04-04 18:25:06',_binary ''),(289,14,'2023-04-04 18:32:45',_binary ''),(290,14,'2023-04-04 18:33:59',_binary ''),(291,14,'2023-04-04 18:41:27',_binary ''),(292,14,'2023-04-04 18:43:24',_binary ''),(293,30,'2023-04-04 18:44:02',_binary ''),(294,14,'2023-04-04 18:46:12',_binary ''),(295,14,'2023-04-04 18:49:12',_binary ''),(296,14,'2023-04-04 18:49:18',_binary ''),(297,14,'2023-04-04 18:51:41',_binary ''),(298,14,'2023-04-04 18:53:39',_binary ''),(299,25,'2023-04-04 18:57:00',_binary ''),(300,14,'2023-04-04 19:12:04',_binary ''),(301,25,'2023-04-04 19:13:09',_binary ''),(302,14,'2023-04-04 20:02:22',_binary ''),(303,14,'2023-04-04 20:04:20',_binary ''),(304,14,'2023-04-04 20:06:31',_binary ''),(305,14,'2023-04-04 20:08:09',_binary ''),(306,14,'2023-04-04 20:10:30',_binary ''),(307,14,'2023-04-04 20:14:15',_binary ''),(308,14,'2023-04-04 20:28:26',_binary ''),(309,12,'2023-04-04 20:41:52',_binary ''),(310,12,'2023-04-04 21:58:50',_binary ''),(311,12,'2023-04-04 22:12:46',_binary ''),(312,12,'2023-04-04 22:15:13',_binary ''),(313,12,'2023-04-04 22:17:33',_binary ''),(314,12,'2023-04-04 22:17:41',_binary ''),(315,12,'2023-04-04 22:44:36',_binary ''),(316,12,'2023-04-04 22:45:35',_binary ''),(317,12,'2023-04-04 22:46:21',_binary ''),(318,12,'2023-04-04 22:47:54',_binary ''),(319,25,'2023-04-04 23:26:29',_binary ''),(320,25,'2023-04-04 23:37:12',_binary ''),(321,12,'2023-04-04 23:40:53',_binary ''),(322,38,'2023-04-05 11:51:04',_binary '\0'),(323,69,'2023-04-05 12:33:43',_binary '\0'),(324,69,'2023-04-05 12:33:49',_binary '\0'),(325,38,'2023-04-05 12:33:59',_binary ''),(326,69,'2023-04-05 12:34:20',_binary '\0'),(327,69,'2023-04-05 12:34:29',_binary ''),(328,12,'2023-04-05 15:39:42',_binary ''),(329,12,'2023-04-05 15:39:56',_binary ''),(330,12,'2023-04-05 17:17:50',_binary ''),(331,12,'2023-04-05 17:20:58',_binary ''),(332,14,'2023-04-05 17:27:46',_binary ''),(333,14,'2023-04-05 17:28:34',_binary ''),(334,12,'2023-04-05 17:29:01',_binary ''),(335,12,'2023-04-05 17:29:39',_binary ''),(336,25,'2023-04-05 17:30:45',_binary ''),(337,68,'2023-04-05 17:30:59',_binary ''),(338,25,'2023-04-05 17:32:09',_binary ''),(339,25,'2023-04-05 17:36:03',_binary ''),(340,30,'2023-04-05 17:39:21',_binary ''),(341,25,'2023-04-05 17:40:09',_binary ''),(342,23,'2023-04-05 17:47:31',_binary ''),(343,14,'2023-04-05 17:47:35',_binary ''),(344,30,'2023-04-05 17:48:02',_binary ''),(345,12,'2023-04-05 17:49:02',_binary ''),(346,23,'2023-04-05 17:50:54',_binary ''),(347,23,'2023-04-05 17:57:06',_binary ''),(348,12,'2023-04-05 18:06:10',_binary ''),(349,12,'2023-04-05 18:07:04',_binary ''),(350,27,'2023-04-05 19:11:56',_binary '\0'),(351,27,'2023-04-05 19:12:01',_binary '\0'),(352,27,'2023-04-05 19:12:08',_binary '\0'),(353,23,'2023-04-05 21:02:37',_binary ''),(354,25,'2023-04-05 21:04:18',_binary ''),(355,25,'2023-04-05 21:20:35',_binary ''),(356,12,'2023-04-05 21:20:44',_binary ''),(357,12,'2023-04-05 21:20:59',_binary ''),(358,25,'2023-04-05 21:24:40',_binary ''),(359,25,'2023-04-05 21:24:48',_binary ''),(360,27,'2023-04-06 00:58:59',_binary ''),(361,25,'2023-04-06 00:59:17',_binary ''),(362,25,'2023-04-06 00:59:55',_binary ''),(363,25,'2023-04-06 03:04:07',_binary ''),(364,25,'2023-04-06 03:18:46',_binary ''),(365,27,'2023-04-06 14:09:05',_binary ''),(366,25,'2023-04-06 14:13:36',_binary ''),(367,25,'2023-04-06 14:14:05',_binary ''),(368,27,'2023-04-06 14:15:25',_binary ''),(369,25,'2023-04-06 16:37:06',_binary ''),(370,27,'2023-04-06 16:40:31',_binary ''),(371,27,'2023-04-06 16:44:22',_binary ''),(372,27,'2023-04-06 18:21:56',_binary ''),(373,38,'2023-04-06 18:51:41',_binary ''),(374,12,'2023-04-06 18:53:55',_binary ''),(375,25,'2023-04-07 22:55:27',_binary ''),(376,27,'2023-04-09 00:35:14',_binary ''),(377,12,'2023-04-09 00:35:47',_binary ''),(378,27,'2023-04-09 01:55:11',_binary ''),(379,38,'2023-04-09 23:39:19',_binary ''),(380,25,'2023-04-09 23:40:56',_binary ''),(381,14,'2023-04-09 23:42:50',_binary ''),(382,38,'2023-04-09 23:43:23',_binary ''),(383,12,'2023-04-09 23:43:57',_binary ''),(384,27,'2023-04-10 03:48:24',_binary ''),(385,25,'2023-04-10 03:58:43',_binary ''),(386,12,'2023-04-10 04:06:49',_binary ''),(387,12,'2023-04-10 14:11:29',_binary ''),(389,25,'2023-04-10 14:22:25',_binary ''),(390,12,'2023-04-10 14:24:02',_binary ''),(394,25,'2023-04-10 14:31:11',_binary ''),(397,12,'2023-04-10 14:36:54',_binary ''),(398,12,'2023-04-10 14:38:30',_binary ''),(399,12,'2023-04-10 14:39:00',_binary ''),(400,12,'2023-04-10 14:40:49',_binary ''),(401,25,'2023-04-10 16:05:11',_binary ''),(402,25,'2023-04-10 16:05:25',_binary ''),(403,28,'2023-04-10 16:06:36',_binary ''),(404,25,'2023-04-10 17:51:57',_binary ''),(407,25,'2023-04-10 17:56:06',_binary ''),(408,25,'2023-04-10 17:56:07',_binary ''),(409,25,'2023-04-11 00:09:18',_binary ''),(410,12,'2023-04-11 00:16:30',_binary ''),(411,25,'2023-04-11 00:21:58',_binary ''),(412,12,'2023-04-11 00:22:26',_binary '\0'),(413,12,'2023-04-11 00:22:33',_binary ''),(414,25,'2023-04-11 00:44:43',_binary '\0'),(415,25,'2023-04-11 00:44:53',_binary ''),(416,12,'2023-04-11 01:05:48',_binary ''),(417,25,'2023-04-11 01:37:29',_binary ''),(419,12,'2023-04-11 01:48:32',_binary ''),(420,25,'2023-04-11 01:52:16',_binary ''),(421,25,'2023-04-11 03:45:48',_binary ''),(422,12,'2023-04-11 03:50:04',_binary ''),(423,12,'2023-04-11 03:50:21',_binary ''),(424,12,'2023-04-11 03:59:45',_binary ''),(425,25,'2023-04-11 18:28:54',_binary ''),(426,12,'2023-04-11 18:32:02',_binary ''),(427,25,'2023-04-11 18:32:44',_binary ''),(428,12,'2023-04-11 18:35:54',_binary ''),(429,25,'2023-04-11 18:47:36',_binary ''),(430,12,'2023-04-11 18:58:25',_binary ''),(431,12,'2023-04-11 20:13:27',_binary ''),(433,25,'2023-04-11 20:33:42',_binary ''),(434,12,'2023-04-11 20:37:54',_binary ''),(435,28,'2023-04-11 23:20:08',_binary ''),(436,25,'2023-04-12 00:35:35',_binary ''),(437,25,'2023-04-12 01:01:42',_binary ''),(438,12,'2023-04-12 01:35:57',_binary ''),(439,25,'2023-04-12 01:40:18',_binary ''),(440,28,'2023-04-12 16:10:27',_binary ''),(441,25,'2023-04-12 16:25:58',_binary ''),(442,25,'2023-04-12 17:11:06',_binary ''),(443,25,'2023-04-12 17:13:02',_binary ''),(444,28,'2023-04-12 17:24:08',_binary ''),(445,25,'2023-04-12 17:30:15',_binary '\0'),(446,25,'2023-04-12 17:30:21',_binary '\0'),(447,25,'2023-04-12 17:30:26',_binary ''),(448,12,'2023-04-12 17:40:04',_binary ''),(449,12,'2023-04-12 17:42:04',_binary ''),(450,28,'2023-04-12 17:42:51',_binary ''),(451,23,'2023-04-12 17:43:23',_binary ''),(452,28,'2023-04-12 17:45:07',_binary ''),(453,12,'2023-04-12 17:45:54',_binary ''),(454,25,'2023-04-12 17:53:53',_binary ''),(455,12,'2023-04-12 18:24:40',_binary ''),(456,25,'2023-04-12 19:37:00',_binary ''),(457,14,'2023-04-12 20:00:53',_binary ''),(458,12,'2023-04-12 20:06:00',_binary ''),(459,25,'2023-04-12 20:08:53',_binary ''),(460,12,'2023-04-12 20:17:16',_binary ''),(461,12,'2023-04-12 20:18:51',_binary ''),(462,25,'2023-04-12 20:26:16',_binary ''),(463,12,'2023-04-12 20:31:31',_binary ''),(464,28,'2023-04-12 20:32:21',_binary ''),(465,28,'2023-04-12 20:50:20',_binary ''),(466,28,'2023-04-12 20:50:39',_binary ''),(467,28,'2023-04-12 20:50:53',_binary ''),(468,12,'2023-04-12 21:18:23',_binary ''),(469,12,'2023-04-12 21:33:24',_binary ''),(470,25,'2023-04-12 22:05:55',_binary ''),(471,27,'2023-04-12 23:18:37',_binary ''),(472,12,'2023-04-13 00:52:50',_binary ''),(473,12,'2023-04-13 01:11:55',_binary ''),(474,14,'2023-04-13 01:12:32',_binary ''),(475,25,'2023-04-13 01:23:47',_binary ''),(476,12,'2023-04-13 01:38:20',_binary ''),(477,25,'2023-04-13 01:52:53',_binary ''),(478,12,'2023-04-13 02:24:13',_binary ''),(479,25,'2023-04-13 15:16:05',_binary ''),(480,27,'2023-04-13 15:17:46',_binary ''),(481,25,'2023-04-13 15:18:24',_binary ''),(482,25,'2023-04-13 15:19:15',_binary ''),(483,27,'2023-04-13 16:24:13',_binary ''),(484,25,'2023-04-13 16:24:41',_binary ''),(485,27,'2023-04-13 16:26:41',_binary ''),(486,12,'2023-04-13 17:56:36',_binary ''),(487,12,'2023-04-13 18:06:39',_binary ''),(488,25,'2023-04-13 18:09:55',_binary ''),(489,12,'2023-04-13 18:14:37',_binary ''),(490,12,'2023-04-13 18:16:03',_binary ''),(491,25,'2023-04-13 18:16:07',_binary ''),(492,12,'2023-04-13 18:19:19',_binary ''),(493,12,'2023-04-13 18:21:37',_binary ''),(494,25,'2023-04-13 18:24:56',_binary ''),(495,12,'2023-04-13 18:28:23',_binary ''),(496,25,'2023-04-13 18:28:49',_binary ''),(497,12,'2023-04-13 18:30:55',_binary ''),(498,12,'2023-04-13 18:38:22',_binary ''),(499,25,'2023-04-13 18:38:41',_binary ''),(500,14,'2023-04-13 18:44:33',_binary ''),(501,14,'2023-04-13 18:44:40',_binary ''),(502,25,'2023-04-13 18:45:44',_binary ''),(503,12,'2023-04-13 18:47:35',_binary ''),(504,25,'2023-04-13 18:49:27',_binary ''),(505,14,'2023-04-13 18:50:31',_binary ''),(506,12,'2023-04-13 18:53:07',_binary ''),(507,12,'2023-04-13 19:02:21',_binary ''),(508,12,'2023-04-13 19:02:24',_binary ''),(509,12,'2023-04-13 19:02:36',_binary ''),(510,28,'2023-04-13 19:02:46',_binary ''),(511,27,'2023-04-13 19:02:48',_binary ''),(512,28,'2023-04-13 19:06:05',_binary '\0'),(513,28,'2023-04-13 19:06:14',_binary ''),(514,12,'2023-04-14 19:47:39',_binary ''),(515,25,'2023-04-14 21:58:38',_binary ''),(516,12,'2023-04-14 22:20:29',_binary ''),(517,25,'2023-04-14 23:21:36',_binary ''),(518,12,'2023-04-15 00:03:19',_binary ''),(519,25,'2023-04-15 00:05:44',_binary ''),(520,30,'2023-04-16 13:28:22',_binary ''),(521,14,'2023-04-16 13:30:10',_binary ''),(522,12,'2023-04-16 13:30:49',_binary ''),(523,27,'2023-04-18 18:34:17',_binary ''),(524,12,'2023-04-18 18:38:21',_binary ''),(525,12,'2023-04-18 18:41:17',_binary ''),(526,25,'2023-04-18 18:46:50',_binary ''),(527,25,'2023-04-18 18:58:56',_binary ''),(528,25,'2023-04-18 19:05:02',_binary ''),(529,25,'2023-04-18 19:54:13',_binary ''),(530,12,'2023-04-18 21:45:48',_binary ''),(531,12,'2023-04-19 02:08:04',_binary ''),(532,27,'2023-04-19 02:55:38',_binary ''),(533,25,'2023-04-19 02:56:55',_binary ''),(534,12,'2023-04-19 03:01:45',_binary ''),(535,25,'2023-04-19 03:27:15',_binary ''),(536,27,'2023-04-19 03:29:15',_binary ''),(537,25,'2023-04-19 04:16:35',_binary ''),(538,25,'2023-04-19 04:16:44',_binary ''),(539,12,'2023-04-19 04:20:25',_binary ''),(540,12,'2023-04-19 16:55:13',_binary ''),(541,12,'2023-04-19 17:08:28',_binary ''),(542,28,'2023-04-19 18:05:01',_binary ''),(543,12,'2023-04-19 18:13:15',_binary '\0'),(544,12,'2023-04-19 18:13:20',_binary ''),(545,12,'2023-04-19 18:13:44',_binary ''),(546,28,'2023-04-19 18:14:32',_binary '\0'),(547,28,'2023-04-19 18:14:37',_binary ''),(548,25,'2023-04-19 18:28:42',_binary ''),(549,12,'2023-04-19 18:39:18',_binary ''),(550,25,'2023-04-19 18:52:36',_binary ''),(551,25,'2023-04-19 18:56:48',_binary ''),(552,12,'2023-04-19 18:57:13',_binary ''),(553,12,'2023-04-19 18:59:12',_binary ''),(554,25,'2023-04-19 18:59:26',_binary ''),(555,25,'2023-04-19 19:00:27',_binary ''),(556,25,'2023-04-19 19:00:52',_binary ''),(557,25,'2023-04-19 19:03:03',_binary ''),(558,28,'2023-04-19 19:04:02',_binary ''),(559,25,'2023-04-19 19:07:50',_binary ''),(560,12,'2023-04-19 19:07:58',_binary ''),(561,12,'2023-04-19 19:09:26',_binary ''),(562,25,'2023-04-19 19:10:35',_binary ''),(563,12,'2023-04-19 19:11:06',_binary ''),(564,25,'2023-04-19 19:12:34',_binary ''),(565,12,'2023-04-19 19:17:18',_binary ''),(566,25,'2023-04-19 19:18:21',_binary ''),(567,27,'2023-04-19 19:25:31',_binary ''),(568,12,'2023-04-19 19:27:12',_binary '\0'),(569,12,'2023-04-19 19:27:16',_binary ''),(570,25,'2023-04-19 19:27:42',_binary ''),(571,28,'2023-04-19 19:27:57',_binary ''),(572,28,'2023-04-19 19:28:17',_binary ''),(573,12,'2023-04-19 20:30:45',_binary ''),(574,12,'2023-04-19 20:31:44',_binary ''),(575,12,'2023-04-19 20:32:15',_binary ''),(576,28,'2023-04-19 20:32:29',_binary ''),(577,25,'2023-04-19 20:32:51',_binary ''),(578,23,'2023-04-19 20:33:13',_binary ''),(579,28,'2023-04-19 20:47:37',_binary ''),(580,12,'2023-04-19 20:48:24',_binary ''),(581,25,'2023-04-19 21:39:06',_binary ''),(582,12,'2023-04-19 21:45:26',_binary ''),(583,12,'2023-04-19 21:46:58',_binary ''),(584,12,'2023-04-19 21:47:23',_binary ''),(585,12,'2023-04-19 21:48:14',_binary ''),(586,12,'2023-04-19 21:48:26',_binary ''),(587,25,'2023-04-19 21:54:36',_binary ''),(588,25,'2023-04-19 22:02:08',_binary ''),(589,25,'2023-04-19 22:16:05',_binary '\0'),(590,25,'2023-04-19 22:16:15',_binary '\0'),(591,25,'2023-04-19 22:16:25',_binary ''),(592,12,'2023-04-19 22:19:30',_binary ''),(593,12,'2023-04-19 22:37:49',_binary ''),(594,12,'2023-04-20 14:56:54',_binary '\0'),(595,12,'2023-04-20 14:56:57',_binary ''),(596,12,'2023-04-20 14:58:18',_binary ''),(597,12,'2023-04-20 14:58:34',_binary ''),(598,25,'2023-04-20 14:58:43',_binary ''),(599,25,'2023-04-20 14:58:53',_binary ''),(600,28,'2023-04-20 14:59:01',_binary ''),(601,103,'2023-04-20 17:37:33',_binary ''),(602,12,'2023-04-20 17:38:08',_binary '\0'),(603,12,'2023-04-20 17:38:12',_binary ''),(604,27,'2023-04-20 18:15:37',_binary ''),(605,12,'2023-04-20 18:18:44',_binary ''),(606,25,'2023-04-20 18:23:59',_binary ''),(607,28,'2023-04-20 18:51:50',_binary ''),(608,12,'2023-04-20 21:49:53',_binary ''),(609,12,'2023-04-20 22:04:03',_binary ''),(610,28,'2023-04-20 22:04:16',_binary ''),(611,12,'2023-04-20 22:26:24',_binary ''),(612,12,'2023-04-20 22:26:55',_binary ''),(613,12,'2023-04-20 22:27:38',_binary ''),(614,25,'2023-04-21 04:30:08',_binary ''),(615,12,'2023-04-21 11:21:55',_binary ''),(616,12,'2023-04-21 11:22:16',_binary ''),(617,12,'2023-04-21 11:23:32',_binary ''),(618,28,'2023-04-21 11:48:20',_binary ''),(619,12,'2023-04-21 12:10:38',_binary ''),(620,23,'2023-04-21 12:16:16',_binary '\0'),(621,23,'2023-04-21 12:16:20',_binary ''),(622,12,'2023-04-21 12:17:01',_binary '\0'),(623,12,'2023-04-21 12:17:05',_binary ''),(624,12,'2023-04-21 22:02:19',_binary ''),(625,12,'2023-04-21 22:02:31',_binary ''),(626,12,'2023-04-21 22:03:03',_binary ''),(627,131,'2023-04-21 22:23:46',_binary ''),(628,131,'2023-04-21 22:24:07',_binary ''),(629,130,'2023-04-21 22:47:07',_binary '\0'),(630,130,'2023-04-21 22:47:18',_binary ''),(631,12,'2023-04-21 23:00:30',_binary ''),(632,12,'2023-04-21 23:01:11',_binary ''),(633,12,'2023-04-21 23:01:44',_binary ''),(634,12,'2023-04-21 23:04:24',_binary '');
/*!40000 ALTER TABLE `login_attempt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `Order_ID` int NOT NULL AUTO_INCREMENT,
  `User_ID` int NOT NULL,
  `Sponsor_ID` int NOT NULL,
  `date_time` datetime NOT NULL,
  `Status` varchar(20) NOT NULL,
  `Price` float NOT NULL,
  `Points` int NOT NULL,
  `Item_ID` varchar(20) NOT NULL,
  `Item_Name` varchar(100) NOT NULL,
  PRIMARY KEY (`Order_ID`),
  KEY `orders_ibfk_2` (`Sponsor_ID`),
  KEY `orders_ibfk_1` (`User_ID`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`Sponsor_ID`) REFERENCES `sponsor` (`Sponsor_ID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,27,3,'2023-03-29 20:39:21','Delivered',9.99,999,'i fucked it up',''),(2,27,2,'2023-03-29 23:20:52','Cancelled',500,2000,'110553905135',''),(3,27,2,'2023-03-30 00:14:46','Cancelled',500,2000,'110553905469',''),(4,27,2,'2023-03-30 18:22:27','Cancelled',427.92,1712,'110553895288',''),(5,27,2,'2023-04-03 02:00:24','Cancelled',9.99,40,'110553900553',''),(6,27,2,'2023-04-03 22:36:41','Delivered',15.99,64,'110553903573',''),(7,27,2,'2023-04-04 01:12:55','Delivered',15.99,64,'110553903573','Car Rear View Reverse Camera 8 LED Waterproof License Plate Camera Night Vision'),(8,27,2,'2023-04-04 01:32:58','Delivered',229.99,920,'110553905454','Pokemon  game card'),(9,27,2,'2023-04-06 16:42:46','Delivered',9.99,40,'110553900553','Apple iPhone 7 - 32GB - Black (AT&T) A1778 (GSM)'),(10,27,2,'2023-04-06 16:44:38','Delivered',500,2000,'110553903057','Apple MacBook Pro MB990LL/A'),(11,27,2,'2023-04-06 18:22:13','Delivered',66.88,268,'110553904293','Study Desk Wood Computer Table Office Furniture PC Laptop Workstation Black USA'),(12,27,2,'2023-04-06 18:51:13','Cancelled',18.59,75,'110553903930','Type C Charger 87W for Apple Macbook Pro 15\' Power Adapter'),(13,38,2,'2023-04-09 23:43:41','Delivered',91,364,'110553900290','Modern Dsw Side Chair With Wood Legs For Kitchen,living Dining Room, Set Of 1'),(15,28,3,'2023-04-10 16:10:04','Cancelled',66.88,1,'110553904293','Study Desk Wood Computer Table Office Furniture PC Laptop Workstation Black USA'),(16,27,3,'2023-04-13 16:30:27','Delivered',57.57,1,'110553904796','Handheld Vacuum, Car Vacuum Cleaner Cordless, Orange (VL189)'),(17,27,2,'2023-04-13 16:33:08','Delivered',18.59,75,'110553903930','Type C Charger 87W for Apple Macbook Pro 15\' Power Adapter'),(18,28,3,'2023-04-13 18:17:01','Delivered',14.99,1,'110553905454','Pokemon  game card'),(19,28,3,'2023-04-13 18:17:22','Delivered',18.59,1,'110553903930','Type C Charger 87W for Apple Macbook Pro 15\' Power Adapter'),(20,27,2,'2023-04-20 20:23:16','Delivered',1.29,6,'1376116249','Queen by Shawn Mendes'),(21,27,2,'2023-04-20 20:24:19','Delivered',1.29,6,'275496141','Low (feat. T-Pain) by Flo Rida'),(22,27,2,'2023-04-20 20:24:41','Delivered',0.99,4,'41757289','Car by Built to Spill'),(23,27,2,'2023-04-20 20:25:15','Delivered',1.29,6,'585128671','Car Radio by twenty one pilots'),(24,28,3,'2023-04-20 22:07:06','Cancelled',1.29,2,'1524801580','cardigan by Taylor Swift'),(25,130,7,'2023-04-21 22:17:44','Cancelled',1.29,129,'275496141','Low (feat. T-Pain) by Flo Rida'),(26,130,7,'2023-04-21 22:17:51','Delivered',0.99,99,'41757289','Car by Built to Spill');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_changes`
--

DROP TABLE IF EXISTS `password_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_changes` (
  `Change_ID` int NOT NULL AUTO_INCREMENT,
  `Date_Time` datetime NOT NULL,
  `User_ID` int NOT NULL,
  `Type_Of_Change` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`Change_ID`),
  KEY `password_changes_ibfk_1` (`User_ID`),
  CONSTRAINT `password_changes_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_changes`
--

LOCK TABLES `password_changes` WRITE;
/*!40000 ALTER TABLE `password_changes` DISABLE KEYS */;
INSERT INTO `password_changes` VALUES (1,'2023-03-28 20:32:13',27,'Admin'),(2,'2023-03-28 20:32:28',27,'Admin'),(3,'2023-03-28 20:32:53',27,'User'),(4,'2023-04-05 11:58:44',69,'User'),(5,'2023-04-05 11:59:05',69,'User'),(6,'2023-04-05 12:00:03',69,'User'),(7,'2023-04-05 12:00:49',69,'User'),(8,'2023-04-05 12:01:14',69,'User'),(9,'2023-04-05 12:01:32',69,'User'),(10,'2023-04-05 12:02:04',69,'User'),(11,'2023-04-05 12:02:35',69,'User'),(12,'2023-04-05 12:36:03',69,'User'),(16,'2023-04-12 20:48:16',28,'User'),(17,'2023-04-12 20:50:39',28,'User'),(18,'2023-04-12 20:50:53',28,'User');
/*!40000 ALTER TABLE `password_changes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `points`
--

DROP TABLE IF EXISTS `points`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `points` (
  `Points_ID` int NOT NULL AUTO_INCREMENT,
  `User_ID` int NOT NULL,
  `Sponsor_ID` int NOT NULL,
  `Point_Total` int NOT NULL,
  PRIMARY KEY (`Points_ID`),
  KEY `points_ibfk_2` (`Sponsor_ID`),
  KEY `points_ibfk_1` (`User_ID`),
  CONSTRAINT `points_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `points_ibfk_2` FOREIGN KEY (`Sponsor_ID`) REFERENCES `sponsor` (`Sponsor_ID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `points`
--

LOCK TABLES `points` WRITE;
/*!40000 ALTER TABLE `points` DISABLE KEYS */;
INSERT INTO `points` VALUES (1,27,2,9997691),(2,27,3,506),(3,28,3,2147483153),(4,30,2,-16),(5,11,3,1285),(43,38,2,9655),(47,11,1,0),(48,37,2,19),(49,11,2,19),(50,11,4,0),(61,119,3,103),(65,130,7,401),(68,130,2,10);
/*!40000 ALTER TABLE `points` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `points_history`
--

DROP TABLE IF EXISTS `points_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `points_history` (
  `Change_ID` int NOT NULL AUTO_INCREMENT,
  `User_ID` int NOT NULL,
  `Sponsor_ID` int NOT NULL,
  `Point_Change` int NOT NULL,
  `Date_Time` datetime NOT NULL,
  `Reason` varchar(50) NOT NULL,
  `Sponsor_User_ID` int DEFAULT NULL,
  PRIMARY KEY (`Change_ID`),
  KEY `points_history_ibfk_2` (`Sponsor_ID`),
  KEY `points_history_ibfk_1` (`User_ID`),
  KEY `points_history_ibfk_3` (`Sponsor_User_ID`),
  CONSTRAINT `points_history_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `points_history_ibfk_2` FOREIGN KEY (`Sponsor_ID`) REFERENCES `sponsor` (`Sponsor_ID`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `points_history_ibfk_3` FOREIGN KEY (`Sponsor_User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `points_history`
--

LOCK TABLES `points_history` WRITE;
/*!40000 ALTER TABLE `points_history` DISABLE KEYS */;
INSERT INTO `points_history` VALUES (3,27,2,100,'2023-03-09 04:56:16','did very good',NULL),(4,27,2,-10,'2023-03-09 04:58:40','was very stinky today',NULL),(5,27,2,25,'2023-03-09 04:59:22','cleaned himself up',NULL),(6,27,3,1000,'2023-03-09 06:28:57','based',NULL),(7,28,3,-500,'2023-03-09 06:29:10','cringe',NULL),(8,28,3,10,'2023-03-09 06:29:18','ok',NULL),(9,27,3,-500,'2023-03-09 06:29:35','cringe',NULL),(10,27,3,10,'2023-03-09 06:29:49','ok',NULL),(11,30,2,-50,'2023-03-14 19:04:39','Test doodoo',NULL),(12,27,2,1000,'2023-03-29 20:36:35','adding for testing',NULL),(13,27,3,1000,'2023-03-29 20:37:57','testing orders',NULL),(14,27,3,-999,'2023-03-29 20:39:21','Item Ordered',NULL),(15,27,2,10000000,'2023-03-29 23:20:08','Large Points for testing',NULL),(16,27,2,-2000,'2023-03-29 23:20:52','Item Ordered',NULL),(17,27,2,2000,'2023-03-29 19:47:46','Order Cancelled',NULL),(18,27,2,-2000,'2023-03-30 00:14:46','Item Ordered',NULL),(19,27,2,2000,'2023-03-30 00:15:02','Order Cancelled',NULL),(20,30,2,15,'2023-03-30 01:35:26','This is a test reason. No action is required.',NULL),(21,27,2,-1712,'2023-03-30 18:22:27','Item Ordered',NULL),(22,27,2,1712,'2023-03-30 18:23:04','Order Cancelled',NULL),(23,28,3,2147483647,'2023-03-30 18:43:43','He\'s got a gun to my head',NULL),(24,27,2,-40,'2023-04-03 02:00:24','Item Ordered',NULL),(25,27,2,40,'2023-04-03 02:00:40','Order Cancelled',NULL),(26,27,2,-64,'2023-04-03 22:36:41','Item Ordered',NULL),(27,27,2,-64,'2023-04-04 01:12:55','Item Ordered',NULL),(28,27,2,-920,'2023-04-04 01:32:58','Item Ordered',NULL),(29,11,3,-69,'2023-04-06 14:14:45','nice...',NULL),(30,27,2,-40,'2023-04-06 16:42:46','Item Ordered',NULL),(31,27,2,-2000,'2023-04-06 16:44:38','Item Ordered',NULL),(32,27,2,-268,'2023-04-06 18:22:13','Item Ordered',NULL),(33,27,2,-75,'2023-04-06 18:51:13','Item Ordered',NULL),(34,27,2,75,'2023-04-06 18:51:46','Order Cancelled',NULL),(35,38,2,10000,'2023-04-09 23:43:13','testing',NULL),(36,38,2,-364,'2023-04-09 23:43:41','Item Ordered',NULL),(39,28,3,-1,'2023-04-10 16:10:04','Item Ordered',NULL),(40,28,3,1,'2023-04-10 16:10:31','Order Cancelled',NULL),(41,28,3,-5,'2023-04-12 17:58:05','Yuh',NULL),(42,27,3,-7,'2023-04-12 20:00:18','testing new sponsorid col',25),(43,27,2,12,'2023-04-12 20:01:11','test sponID col',14),(44,11,1,0,'2023-04-12 22:58:39','Automatic Reward',NULL),(45,11,1,0,'2023-04-12 23:07:05','Automatic Reward',NULL),(46,30,2,1,'2023-04-12 23:07:05','Automatic Reward',NULL),(47,37,2,1,'2023-04-12 23:07:05','Automatic Reward',NULL),(48,38,2,1,'2023-04-12 23:07:05','Automatic Reward',NULL),(49,11,2,1,'2023-04-12 23:07:05','Automatic Reward',NULL),(50,11,1,0,'2023-04-12 23:10:42','Automatic Reward',NULL),(51,30,2,1,'2023-04-12 23:10:42','Automatic Reward',NULL),(52,37,2,1,'2023-04-12 23:10:42','Automatic Reward',NULL),(53,38,2,1,'2023-04-12 23:10:42','Automatic Reward',NULL),(54,11,2,1,'2023-04-12 23:10:42','Automatic Reward',NULL),(55,11,1,0,'2023-04-12 23:13:04','Automatic Reward',NULL),(56,27,2,1,'2023-04-12 23:13:04','Automatic Reward',NULL),(57,30,2,1,'2023-04-12 23:13:04','Automatic Reward',NULL),(58,37,2,1,'2023-04-12 23:13:04','Automatic Reward',NULL),(59,38,2,1,'2023-04-12 23:13:04','Automatic Reward',NULL),(60,11,2,1,'2023-04-12 23:13:04','Automatic Reward',NULL),(61,11,3,0,'2023-04-12 23:13:04','Automatic Reward',NULL),(62,28,3,0,'2023-04-12 23:13:04','Automatic Reward',NULL),(63,27,3,0,'2023-04-12 23:13:04','Automatic Reward',NULL),(64,11,4,0,'2023-04-12 23:13:04','Automatic Reward',NULL),(65,11,1,0,'2023-04-12 23:19:34','Automatic Reward',NULL),(66,27,2,1,'2023-04-12 23:19:34','Automatic Reward',NULL),(67,30,2,1,'2023-04-12 23:19:34','Automatic Reward',NULL),(68,37,2,1,'2023-04-12 23:19:34','Automatic Reward',NULL),(69,38,2,1,'2023-04-12 23:19:34','Automatic Reward',NULL),(70,11,2,1,'2023-04-12 23:19:34','Automatic Reward',NULL),(71,11,3,0,'2023-04-12 23:19:34','Automatic Reward',NULL),(72,28,3,0,'2023-04-12 23:19:34','Automatic Reward',NULL),(73,27,3,0,'2023-04-12 23:19:34','Automatic Reward',NULL),(74,11,4,0,'2023-04-12 23:19:34','Automatic Reward',NULL),(75,27,3,-1,'2023-04-13 16:30:27','Item Ordered by Sponsor',25),(76,27,2,-75,'2023-04-13 16:33:08','Item Ordered',NULL),(77,28,3,-1,'2023-04-13 18:17:01','Item Ordered by Sponsor',25),(78,28,3,-1,'2023-04-13 18:17:22','Item Ordered by Sponsor',25),(79,11,3,1,'2023-04-19 04:17:05','No reason',25),(80,11,3,50,'2023-04-19 21:39:59','Very nice parallel parking',25),(81,11,3,400,'2023-04-19 22:02:48','Good driver',25),(82,11,3,400,'2023-04-19 22:05:23','More',25),(83,119,3,100,'2023-04-20 18:24:18','Good boi',25),(84,27,2,-6,'2023-04-20 20:23:16','Item Ordered',NULL),(85,27,2,-6,'2023-04-20 20:24:19','Item Ordered',NULL),(86,27,2,-4,'2023-04-20 20:24:41','Item Ordered',NULL),(87,27,2,-6,'2023-04-20 20:25:15','Item Ordered',NULL),(88,28,3,-2,'2023-04-20 22:07:06','Item Ordered',NULL),(89,28,3,2,'2023-04-20 22:07:44','Order Cancelled',NULL),(90,11,1,0,'2023-04-21 12:00:00','Automatic Reward',NULL),(91,27,2,5,'2023-04-21 12:00:00','Automatic Reward',NULL),(92,30,2,5,'2023-04-21 12:00:00','Automatic Reward',NULL),(93,37,2,5,'2023-04-21 12:00:01','Automatic Reward',NULL),(94,38,2,5,'2023-04-21 12:00:01','Automatic Reward',NULL),(95,11,2,5,'2023-04-21 12:00:01','Automatic Reward',NULL),(96,11,3,1,'2023-04-21 12:00:01','Automatic Reward',NULL),(97,28,3,1,'2023-04-21 12:00:01','Automatic Reward',NULL),(98,27,3,1,'2023-04-21 12:00:01','Automatic Reward',NULL),(99,119,3,1,'2023-04-21 12:00:01','Automatic Reward',NULL),(100,11,4,0,'2023-04-21 12:00:01','Automatic Reward',NULL),(101,130,7,500,'2023-04-21 22:15:07','Sign on bonus',131),(102,130,7,-129,'2023-04-21 22:17:44','Item Ordered',NULL),(103,130,7,-99,'2023-04-21 22:17:51','Item Ordered',NULL),(104,130,7,129,'2023-04-21 22:18:07','Order Cancelled',NULL),(105,11,1,0,'2023-04-22 12:00:01','Automatic Reward',NULL),(106,27,2,5,'2023-04-22 12:00:01','Automatic Reward',NULL),(107,30,2,5,'2023-04-22 12:00:01','Automatic Reward',NULL),(108,37,2,5,'2023-04-22 12:00:01','Automatic Reward',NULL),(109,38,2,5,'2023-04-22 12:00:01','Automatic Reward',NULL),(110,11,2,5,'2023-04-22 12:00:01','Automatic Reward',NULL),(111,130,2,5,'2023-04-22 12:00:01','Automatic Reward',NULL),(112,11,3,1,'2023-04-22 12:00:01','Automatic Reward',NULL),(113,28,3,1,'2023-04-22 12:00:01','Automatic Reward',NULL),(114,27,3,1,'2023-04-22 12:00:01','Automatic Reward',NULL),(115,119,3,1,'2023-04-22 12:00:01','Automatic Reward',NULL),(116,11,4,0,'2023-04-22 12:00:01','Automatic Reward',NULL),(117,130,7,0,'2023-04-22 12:00:01','Automatic Reward',NULL),(118,11,1,0,'2023-04-23 12:00:01','Automatic Reward',NULL),(119,27,2,5,'2023-04-23 12:00:01','Automatic Reward',NULL),(120,30,2,5,'2023-04-23 12:00:01','Automatic Reward',NULL),(121,37,2,5,'2023-04-23 12:00:01','Automatic Reward',NULL),(122,38,2,5,'2023-04-23 12:00:01','Automatic Reward',NULL),(123,11,2,5,'2023-04-23 12:00:01','Automatic Reward',NULL),(124,130,2,5,'2023-04-23 12:00:01','Automatic Reward',NULL),(125,11,3,1,'2023-04-23 12:00:01','Automatic Reward',NULL),(126,28,3,1,'2023-04-23 12:00:01','Automatic Reward',NULL),(127,27,3,1,'2023-04-23 12:00:01','Automatic Reward',NULL),(128,119,3,1,'2023-04-23 12:00:01','Automatic Reward',NULL),(129,11,4,0,'2023-04-23 12:00:01','Automatic Reward',NULL),(130,130,7,0,'2023-04-23 12:00:01','Automatic Reward',NULL);
/*!40000 ALTER TABLE `points_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sponsor`
--

DROP TABLE IF EXISTS `sponsor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sponsor` (
  `Sponsor_ID` int NOT NULL AUTO_INCREMENT,
  `Point_Value` decimal(10,2) NOT NULL,
  `Name` varchar(40) NOT NULL,
  `Auto_Points` int NOT NULL DEFAULT '0',
  `Max_Price` decimal(10,2) NOT NULL DEFAULT '9999999.00',
  PRIMARY KEY (`Sponsor_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sponsor`
--

LOCK TABLES `sponsor` WRITE;
/*!40000 ALTER TABLE `sponsor` DISABLE KEYS */;
INSERT INTO `sponsor` VALUES (1,420.00,'Test Sponsor',0,999999.00),(2,0.25,'New Sponsah',5,999998.00),(3,1.00,'hello sponsor',1,12.00),(4,2.00,'Django Themselves',0,999999.00),(5,4.00,'MeJay Heffner',3,5.00),(6,0.01,'asdasd',0,9999999.00),(7,0.02,'PreDemo Sponsor Org',0,500000.00),(8,1.00,'asdfasfdasfd',0,99999999.00);
/*!40000 ALTER TABLE `sponsor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sponsor_user`
--

DROP TABLE IF EXISTS `sponsor_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sponsor_user` (
  `User_ID` int NOT NULL,
  `Sponsor_ID` int NOT NULL,
  PRIMARY KEY (`User_ID`),
  KEY `sponsor_user_ibfk_2` (`Sponsor_ID`),
  CONSTRAINT `sponsor_user_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `sponsor_user_ibfk_2` FOREIGN KEY (`Sponsor_ID`) REFERENCES `sponsor` (`Sponsor_ID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sponsor_user`
--

LOCK TABLES `sponsor_user` WRITE;
/*!40000 ALTER TABLE `sponsor_user` DISABLE KEYS */;
INSERT INTO `sponsor_user` VALUES (14,2),(25,3),(26,3),(95,3),(120,6),(131,7),(132,7);
/*!40000 ALTER TABLE `sponsor_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `User_ID` int NOT NULL AUTO_INCREMENT,
  `First_Name` varchar(20) NOT NULL,
  `Last_Name` varchar(20) NOT NULL,
  `Street_Address` varchar(80) DEFAULT NULL,
  `Street_Address_2` varchar(80) DEFAULT NULL,
  `City` varchar(30) DEFAULT NULL,
  `ZIP_Code` int DEFAULT NULL,
  `Phone_Number` varchar(15) DEFAULT NULL,
  `User_Type` varchar(15) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_impersonation` tinyint(1) DEFAULT '0',
  `Security_Question_Answer` varchar(35) NOT NULL,
  PRIMARY KEY (`User_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (0,'User Not','Found','Foreign','Keys','That',0,'Be found','Sponsor','!','!5f4dcc3b5aa765d61d8327deb882cf99','2023-04-03 02:05:53',0,'5f4dcc3b5aa765d61d8327deb882cf99'),(11,'TJ','Heffner','The Retreat','The Retreat','Clemson',29631,'555-555-5555','Driver','TJHeff12','5f4dcc3b5aa765d61d8327deb882cf99','2023-04-03 02:05:53',0,'5f4dcc3b5aa765d61d8327deb882cf99'),(12,'hehehe','Her','124 Grove Street','Admin','clempkin',696969696,'tester123','Admin','Admin','5f4dcc3b5aa765d61d8327deb882cf99','2023-04-21 23:04:24',0,'5f4dcc3b5aa765d61d8327deb882cf99'),(13,'adminAdd','adminAdd','adminAdd','adminAdd','adminAdd',1111,'adminAdd','Admin','adminAdd','5f4dcc3b5aa765d61d8327deb882cf99',NULL,0,'5f4dcc3b5aa765d61d8327deb882cf99'),(14,'sponsor','sponsor','1234 Fake Address Dr','sponsor','sponsor',1111,'sponsor','Sponsor','sponsor','5f4dcc3b5aa765d61d8327deb882cf99','2023-04-16 13:30:10',0,'5f4dcc3b5aa765d61d8327deb882cf99'),(15,'sponsor2','sponsor2','sponso2','sponso2','sponsor2',1111,'sponsor2','Sponsor','sponsor2','5f4dcc3b5aa765d61d8327deb882cf99',NULL,0,'5f4dcc3b5aa765d61d8327deb882cf99'),(16,'sponsor3','sponsor3','sponsor3','sponsor3','sponsor3',1111,'sponsor3','Sponsor','sponsor3','5f4dcc3b5aa765d61d8327deb882cf99',NULL,0,'5f4dcc3b5aa765d61d8327deb882cf99'),(17,'sponsor4','sponsor4','sponsor4','sponsor4','sponsor4',1111,'sponsor4','Sponsor','sponsor4','5f4dcc3b5aa765d61d8327deb882cf99',NULL,0,'5f4dcc3b5aa765d61d8327deb882cf99'),(18,'sponsor5','sponsor5','sponsor5','sponsor5','sponsor5',1111,'sponsor5','Sponsor','sponsor5','5f4dcc3b5aa765d61d8327deb882cf99',NULL,0,'5f4dcc3b5aa765d61d8327deb882cf99'),(19,'sponsor6','sponsor6','sponsor6','sponsor6','sponsor6',1111,'sponsor6','Sponsor','sponsor6','5f4dcc3b5aa765d61d8327deb882cf99',NULL,0,'5f4dcc3b5aa765d61d8327deb882cf99'),(21,'testd','testd','testd','testd','testd',1111,'testd','Driver','testd','5f4dcc3b5aa765d61d8327deb882cf99','2023-03-14 18:47:56',0,'5f4dcc3b5aa765d61d8327deb882cf99'),(22,'driverd','driverd','driverd','driverd','driverd',111,'driverd','Driver','driverd','5f4dcc3b5aa765d61d8327deb882cf99','2023-03-30 00:54:00',0,'5f4dcc3b5aa765d61d8327deb882cf99'),(23,'sponsord','sponsord','sponsord','sponsord','sponsord',1111,'sponsord','Sponsor','sponsord','5f4dcc3b5aa765d61d8327deb882cf99','2023-04-21 12:16:20',0,'5f4dcc3b5aa765d61d8327deb882cf99'),(24,'sponsore','sponsore','sponsore','sponsore','sponsore',111,'sponsore','Driver','sponsore','5f4dcc3b5aa765d61d8327deb882cf99',NULL,0,'5f4dcc3b5aa765d61d8327deb882cf99'),(25,'you','you','you','sponsorf','sponsorf',111,'92929292','Sponsor','sponsorf','5f4dcc3b5aa765d61d8327deb882cf99','2023-04-21 04:30:08',0,'5f4dcc3b5aa765d61d8327deb882cf99'),(26,'sponsorg','sponsorg','sponsorg','sponsorg','sponsorg',111,'sponsorg','Sponsor','sponsorg','5f4dcc3b5aa765d61d8327deb882cf99',NULL,0,'5f4dcc3b5aa765d61d8327deb882cf99'),(27,'bee','two','your mom','a','also city',234,'190000','Driver','test2','098f6bcd4621d373cade4e832627b4f6','2023-04-20 18:15:37',0,'098f6bcd4621d373cade4e832627b4f6'),(28,'haden','hahhden','test','2','3',4,'1','Driver','hayden','0cef1fb10f60529028a71f58e54ed07b','2023-04-21 11:48:20',0,'5f4dcc3b5aa765d61d8327deb882cf99'),(29,'pass change test','pass change test','1','1','1',1,'1','Driver','passchange','5e9d11a14ad1c8dd77e98ef9b53fd1ba','2023-03-09 19:35:14',0,'5e9d11a14ad1c8dd77e98ef9b53fd1ba'),(30,'Josiah','Lamoont','310 Tillman Hall','310 Tillman Hall','Clemsooner',29631,'123-456-7890','Driver','jdlamon@clemson.edu','9e563fd86bdd3ccbc39ea80efd22ac18','2023-04-16 13:28:22',0,'9e563fd86bdd3ccbc39ea80efd22ac18'),(31,'fdsf','d','d','d','d',1,'5','Driver','test3','098f6bcd4621d373cade4e832627b4f6','2023-03-08 22:15:06',0,'098f6bcd4621d373cade4e832627b4f6'),(37,'sponsorAddDriver','sponsorAddDriver','sponsorAddDriver','sponsorAddDriver','sponsorAddDriver',111,'sponsorAddDrive','Driver','sponsorAddDriver','5f4dcc3b5aa765d61d8327deb882cf99',NULL,0,'5f4dcc3b5aa765d61d8327deb882cf99'),(38,'fake','email','1234','1234','1234',12334,'1234','Driver','fake@email.com','5f4dcc3b5aa765d61d8327deb882cf99','2023-04-09 23:43:23',0,'5f4dcc3b5aa765d61d8327deb882cf99'),(68,'fake','email','fake address','fake address','fake city',12345,'1234567890','Driver','fake2@email.com','5f4dcc3b5aa765d61d8327deb882cf99','2023-04-05 17:30:59',0,'5f4dcc3b5aa765d61d8327deb882cf99'),(69,'fake3','fake3','fake3','fake3','fake3',12376,'1235467890','Driver','fake3@email.com','5f4dcc3b5aa765d61d8327deb882cf99','2023-04-05 12:34:29',0,'5f4dcc3b5aa765d61d8327deb882cf99'),(70,'fake4','fake4','fake4','fake4','fake4',13245,'1234567890','Driver','fake4@email.com','5f4dcc3b5aa765d61d8327deb882cf99',NULL,0,'5f4dcc3b5aa765d61d8327deb882cf99'),(93,'1234','1234','1234','1234','1234',1234,'1234','Admin','1234','81dc9bdb52d04dc20036dbd8313ed055',NULL,0,''),(95,'test','test','test','test','test',1,'1','Sponsor','testsponsor','098f6bcd4621d373cade4e832627b4f6',NULL,0,''),(99,'testPasswordStrength','testPasswordStrength','testPasswordStrength','testPasswordStrength','testPasswordStrength',1,'1','Driver','testPasswordStrength','0cef1fb10f60529028a71f58e54ed07b','2023-04-12 20:04:54',0,'baceebebc179d3cdb726f5cbfaa81dfe'),(103,'now','u know','111 abc st.','111 abc st.','abc',22222,'1234567','Driver','abc@test.com','161ebd7d45089b3446ee4e0d86dbcf92','2023-04-20 17:37:33',0,'8ff32489f92f33416694be8fdc2d4c22'),(119,'billy','bob','kwjhsfsdf','kwjhsfsdf','dfsd',123123,'12312312','Driver','asdasd','0cef1fb10f60529028a71f58e54ed07b',NULL,0,''),(120,'sdfsd','asfasd','sdfsd','sdfsd','sdfsd',312312,'12312','Sponsor','szdf','25db76677e17b4d70d4341069affd51f',NULL,0,'b8e7be5dfa2ce0714d21dcfc7d72382c'),(130,'predemo','driver','clemson raod','a','clemson',222,'2','Driver','predemodriver','6964f527f011df8756f87c3e8a76884f','2023-04-21 22:47:18',0,'5f4dcc3b5aa765d61d8327deb882cf99'),(131,'predemo','sponsor','c','c','d',3,'4','Sponsor','predemosponsor','6964f527f011df8756f87c3e8a76884f','2023-04-21 22:24:07',0,'5f4dcc3b5aa765d61d8327deb882cf99'),(132,'a','b','a','a','c',2,'2','Sponsor','predemosponsor2','6964f527f011df8756f87c3e8a76884f',NULL,0,'');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-23 18:57:39
