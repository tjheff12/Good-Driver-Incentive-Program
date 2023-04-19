CREATE DATABASE `Good_Driver` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE Good_Driver;

CREATE TABLE `sponsor` (
  `Sponsor_ID` int NOT NULL AUTO_INCREMENT,
  `Point_Value` decimal(10,2) NOT NULL,
  `Name` varchar(40) NOT NULL,
  `Auto_Points` int DEFAULT '0',
  `Max_Price` decimal(10,2) DEFAULT '999999.00',
  PRIMARY KEY (`Sponsor_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*User Subtypes*/
CREATE TABLE `sponsor_user` (
  `User_ID` int NOT NULL,
  `Sponsor_ID` int NOT NULL,
  PRIMARY KEY (`User_ID`),
  KEY `sponsor_user_ibfk_2` (`Sponsor_ID`),
  CONSTRAINT `sponsor_user_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `sponsor_user_ibfk_2` FOREIGN KEY (`Sponsor_ID`) REFERENCES `sponsor` (`Sponsor_ID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `driver_sponsor` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `User_ID` int NOT NULL,
  `Sponsor_ID` int NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `driver_sponsor_ibfk_2` (`Sponsor_ID`),
  KEY `driver_sponsor_ibfk_1` (`User_ID`),
  CONSTRAINT `driver_sponsor_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `driver_sponsor_ibfk_2` FOREIGN KEY (`Sponsor_ID`) REFERENCES `sponsor` (`Sponsor_ID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `login_attempt` (
  `Attempt_ID` int NOT NULL AUTO_INCREMENT,
  `User_ID` int NOT NULL,
  `Date_Time` datetime NOT NULL,
  `Was_Accepted` bit(1) NOT NULL,
  PRIMARY KEY (`Attempt_ID`),
  KEY `login_attempt_ibfk_1` (`User_ID`),
  CONSTRAINT `login_attempt_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=540 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `password_changes` (
  `Change_ID` int NOT NULL AUTO_INCREMENT,
  `Date_Time` datetime NOT NULL,
  `User_ID` int NOT NULL,
  `Type_Of_Change` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`Change_ID`),
  KEY `password_changes_ibfk_1` (`User_ID`),
  CONSTRAINT `password_changes_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `application_state_change` (
  `State_Change_ID` int NOT NULL AUTO_INCREMENT,
  `Application_ID` int NOT NULL,
  `Date_Time` datetime NOT NULL,
  `New_Status` varchar(15) NOT NULL,
  `New_Reason` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`State_Change_ID`),
  KEY `application_state_change_ibfk_1` (`Application_ID`),
  CONSTRAINT `application_state_change_ibfk_1` FOREIGN KEY (`Application_ID`) REFERENCES `driver_application` (`Application_ID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/* Django auto-generated tables through migration */
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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

CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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

CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
