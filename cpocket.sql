-- MySQL dump 10.13  Distrib 8.0.37, for Linux (x86_64)
--
-- Host: localhost    Database: cpocket
-- ------------------------------------------------------
-- Server version	8.0.37-0ubuntu0.22.04.3

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
-- Table structure for table `activity_logs`
--

DROP TABLE IF EXISTS `activity_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `action` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `source` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip_address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `activity_logs_user_id_foreign` (`user_id`),
  CONSTRAINT `activity_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_logs`
--

LOCK TABLES `activity_logs` WRITE;
/*!40000 ALTER TABLE `activity_logs` DISABLE KEYS */;
INSERT INTO `activity_logs` VALUES (1,2,'1','Web','127.0.0.1','','2024-07-22 12:46:15','2024-07-22 12:46:15'),(2,2,'1','Web','127.0.0.1','','2024-07-22 17:59:38','2024-07-22 17:59:38'),(3,2,'1','Web','127.0.0.1','','2024-07-29 19:13:13','2024-07-29 19:13:13'),(4,2,'1','Web','127.0.0.1','','2024-07-29 19:30:13','2024-07-29 19:30:13'),(5,2,'1','Web','127.0.0.1','','2024-07-29 19:35:34','2024-07-29 19:35:34');
/*!40000 ALTER TABLE `activity_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_give_coin_histories`
--

DROP TABLE IF EXISTS `admin_give_coin_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_give_coin_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `wallet_id` bigint NOT NULL,
  `amount` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_give_coin_histories`
--

LOCK TABLES `admin_give_coin_histories` WRITE;
/*!40000 ALTER TABLE `admin_give_coin_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_give_coin_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_receive_token_transaction_histories`
--

DROP TABLE IF EXISTS `admin_receive_token_transaction_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_receive_token_transaction_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `deposit_id` bigint NOT NULL,
  `unique_code` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `fees` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `to_address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_hash` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_receive_token_transaction_histories_unique_code_unique` (`unique_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_receive_token_transaction_histories`
--

LOCK TABLES `admin_receive_token_transaction_histories` WRITE;
/*!40000 ALTER TABLE `admin_receive_token_transaction_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_receive_token_transaction_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_settings`
--

DROP TABLE IF EXISTS `admin_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_settings`
--

LOCK TABLES `admin_settings` WRITE;
/*!40000 ALTER TABLE `admin_settings` DISABLE KEYS */;
INSERT INTO `admin_settings` VALUES (1,'coin_price','2.50','2022-03-24 07:47:33','2022-03-24 07:47:33'),(2,'coin_name','Cpoket','2022-03-24 07:47:33','2022-03-24 07:47:33'),(3,'app_title','C Poket','2022-03-24 07:47:33','2022-03-24 07:47:33'),(4,'maximum_withdrawal_daily','3','2022-03-24 07:47:33','2022-03-24 07:47:33'),(5,'mail_from','noreply@cpoket.com','2022-03-24 07:47:33','2022-03-24 07:47:33'),(6,'admin_coin_address','address','2022-03-24 07:47:33','2022-03-24 07:47:33'),(7,'base_coin_type','BTC','2022-03-24 07:47:33','2022-03-24 07:47:33'),(8,'minimum_withdrawal_amount','0.005','2022-03-24 07:47:33','2022-03-24 07:47:33'),(9,'maximum_withdrawal_amount','12','2022-03-24 07:47:33','2022-03-24 07:47:33'),(10,'maintenance_mode','no','2022-03-24 07:47:33','2022-03-24 07:47:33'),(11,'logo','','2022-03-24 07:47:33','2022-03-24 07:47:33'),(12,'login_logo','','2022-03-24 07:47:33','2022-03-24 07:47:33'),(13,'landing_logo','','2022-03-24 07:47:33','2022-03-24 07:47:33'),(14,'favicon','','2022-03-24 07:47:33','2022-03-24 07:47:33'),(15,'copyright_text','Copyright@2020','2022-03-24 07:47:33','2022-03-24 07:47:33'),(16,'pagination_count','10','2022-03-24 07:47:33','2022-03-24 07:47:33'),(17,'point_rate','1','2022-03-24 07:47:33','2022-03-24 07:47:33'),(18,'lang','en','2022-03-24 07:47:33','2022-03-24 07:47:33'),(19,'company_name','Test Company','2022-03-24 07:47:33','2022-03-24 07:47:33'),(20,'primary_email','test@email.com','2022-03-24 07:47:33','2022-03-24 07:47:33'),(21,'sms_getway_name','twillo','2022-03-24 07:47:33','2022-03-24 07:47:33'),(22,'twillo_secret_key','test','2022-03-24 07:47:33','2022-03-24 07:47:33'),(23,'twillo_auth_token','test','2022-03-24 07:47:33','2022-03-24 07:47:33'),(24,'twillo_number','test','2022-03-24 07:47:33','2022-03-24 07:47:33'),(25,'ssl_verify','','2022-03-24 07:47:33','2022-03-24 07:47:33'),(26,'mail_driver','SMTP','2022-03-24 07:47:33','2022-03-24 07:47:33'),(27,'mail_host','smtp.mailtrap.io','2022-03-24 07:47:33','2022-03-24 07:47:33'),(28,'mail_port','2525','2022-03-24 07:47:33','2022-03-24 07:47:33'),(29,'mail_username','','2022-03-24 07:47:33','2022-03-24 07:47:33'),(30,'mail_password','','2022-03-24 07:47:33','2022-03-24 07:47:33'),(31,'mail_encryption','null','2022-03-24 07:47:33','2022-03-24 07:47:33'),(32,'mail_from_address','','2022-03-24 07:47:33','2022-03-24 07:47:33'),(33,'braintree_client_token','test','2022-03-24 07:47:33','2022-03-24 07:47:33'),(34,'braintree_environment','sandbox','2022-03-24 07:47:33','2022-03-24 07:47:33'),(35,'braintree_merchant_id','test','2022-03-24 07:47:33','2022-03-24 07:47:33'),(36,'braintree_public_key','test','2022-03-24 07:47:33','2022-03-24 07:47:33'),(37,'braintree_private_key','test','2022-03-24 07:47:33','2022-03-24 07:47:33'),(38,'clickatell_api_key','test','2022-03-24 07:47:33','2022-03-24 07:47:33'),(39,'number_of_confirmation','6','2022-03-24 07:47:33','2022-03-24 07:47:33'),(40,'referral_commission_percentage','10','2022-03-24 07:47:33','2022-03-24 07:47:33'),(41,'referral_signup_reward','10','2022-03-24 07:47:33','2022-03-24 07:47:33'),(42,'max_affiliation_level','10','2022-03-24 07:47:33','2022-03-24 07:47:33'),(43,'coin_api_user','test','2022-03-24 07:47:33','2022-03-24 07:47:33'),(44,'coin_api_pass','test','2022-03-24 07:47:33','2022-03-24 07:47:33'),(45,'coin_api_host','test5','2022-03-24 07:47:33','2022-03-24 07:47:33'),(46,'coin_api_port','test','2022-03-24 07:47:33','2022-03-24 07:47:33'),(47,'send_fees_type','1','2022-03-24 07:47:33','2022-03-24 07:47:33'),(48,'send_fees_fixed','0','2022-03-24 07:47:33','2022-03-24 07:47:33'),(49,'send_fees_percentage','0','2022-03-24 07:47:33','2022-03-24 07:47:33'),(50,'max_send_limit','0','2022-03-24 07:47:33','2022-03-24 07:47:33'),(51,'deposit_time','1','2022-03-24 07:47:33','2022-03-24 07:47:33'),(52,'COIN_PAYMENT_PUBLIC_KEY','test','2022-03-24 07:47:33','2022-03-24 07:47:33'),(53,'COIN_PAYMENT_PRIVATE_KEY','test','2022-03-24 07:47:33','2022-03-24 07:47:33'),(54,'COIN_PAYMENT_CURRENCY','BTC','2022-03-24 07:47:33','2022-03-24 07:47:33'),(55,'ipn_merchant_id','','2022-03-24 07:47:33','2022-03-24 07:47:33'),(56,'ipn_secret','','2022-03-24 07:47:33','2022-03-24 07:47:33'),(57,'payment_method_coin_payment','1','2022-03-24 07:47:33','2022-03-24 07:47:33'),(58,'payment_method_bank_deposit','1','2022-03-24 07:47:33','2022-03-24 07:47:33'),(59,'membership_bonus_type','1','2022-03-24 07:47:33','2022-03-24 07:47:33'),(60,'membership_bonus_fixed','0','2022-03-24 07:47:34','2022-03-24 07:47:34'),(61,'membership_bonus_percentage','0','2022-03-24 07:47:34','2022-03-24 07:47:34'),(62,'chain_link','','2022-03-24 07:47:34','2022-03-24 07:47:34'),(63,'contract_address','','2022-03-24 07:47:34','2022-03-24 07:47:34'),(64,'wallet_address','','2022-03-24 07:47:34','2022-03-24 07:47:34'),(65,'private_key','','2022-03-24 07:47:34','2022-03-24 07:47:34'),(66,'contract_decimal','18','2022-03-24 07:47:34','2022-03-24 07:47:34'),(67,'gas_limit','43000','2022-03-24 07:47:34','2022-03-24 07:47:34'),(68,'contract_coin_name','ETH','2022-03-24 07:47:34','2022-03-24 07:47:34'),(69,'kyc_enable_for_withdrawal','0','2022-03-24 07:47:34','2022-03-24 07:47:34'),(70,'kyc_nid_enable_for_withdrawal','0','2022-03-24 07:47:34','2022-03-24 07:47:34'),(71,'kyc_passport_enable_for_withdrawal','0','2022-03-24 07:47:34','2022-03-24 07:47:34'),(72,'kyc_driving_enable_for_withdrawal','0','2022-03-24 07:47:34','2022-03-24 07:47:34'),(73,'previous_block_count','100','2024-07-22 12:42:49','2024-07-22 12:42:49'),(74,'swap_enabled','1','2024-07-22 12:42:49','2024-07-22 12:42:49'),(75,'plan_minimum_amount','1','2024-07-22 12:42:49','2024-07-22 12:42:49'),(76,'plan_maximum_amount','99999','2024-07-22 12:42:49','2024-07-22 12:42:49'),(77,'admin_send_default_minimum','1','2024-07-22 12:42:49','2024-07-22 12:42:49'),(78,'admin_send_default_maximum','10000','2024-07-22 12:42:49','2024-07-22 12:42:49');
/*!40000 ALTER TABLE `admin_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `affiliation_codes`
--

DROP TABLE IF EXISTS `affiliation_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `affiliation_codes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `code` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `affiliation_codes_code_unique` (`code`),
  KEY `affiliation_codes_user_id_foreign` (`user_id`),
  CONSTRAINT `affiliation_codes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `affiliation_codes`
--

LOCK TABLES `affiliation_codes` WRITE;
/*!40000 ALTER TABLE `affiliation_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `affiliation_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `affiliation_histories`
--

DROP TABLE IF EXISTS `affiliation_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `affiliation_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `child_id` bigint unsigned NOT NULL,
  `amount` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `system_fees` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `transaction_id` bigint DEFAULT NULL,
  `level` int NOT NULL,
  `wallet_id` bigint DEFAULT NULL,
  `coin_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_type` int DEFAULT NULL,
  `status` int NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `affiliation_histories_user_id_foreign` (`user_id`),
  KEY `affiliation_histories_child_id_foreign` (`child_id`),
  CONSTRAINT `affiliation_histories_child_id_foreign` FOREIGN KEY (`child_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `affiliation_histories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `affiliation_histories`
--

LOCK TABLES `affiliation_histories` WRITE;
/*!40000 ALTER TABLE `affiliation_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `affiliation_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banks`
--

DROP TABLE IF EXISTS `banks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `banks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_holder_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_holder_address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `swift_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `iban` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banks`
--

LOCK TABLES `banks` WRITE;
/*!40000 ALTER TABLE `banks` DISABLE KEYS */;
/*!40000 ALTER TABLE `banks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buy_coin_histories`
--

DROP TABLE IF EXISTS `buy_coin_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buy_coin_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` tinyint NOT NULL,
  `user_id` bigint NOT NULL,
  `coin` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `btc` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `doller` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `transaction_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `admin_confirmation` tinyint NOT NULL DEFAULT '0',
  `confirmations` int NOT NULL DEFAULT '0',
  `bank_sleep` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_id` int DEFAULT NULL,
  `coin_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `requested_amount` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `referral_bonus` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `bonus` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `fees` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `referral_level` int DEFAULT NULL,
  `phase_id` bigint DEFAULT NULL,
  `stripe_token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buy_coin_histories`
--

LOCK TABLES `buy_coin_histories` WRITE;
/*!40000 ALTER TABLE `buy_coin_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `buy_coin_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buy_coin_referral_histories`
--

DROP TABLE IF EXISTS `buy_coin_referral_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buy_coin_referral_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `wallet_id` bigint NOT NULL,
  `buy_id` bigint NOT NULL,
  `phase_id` bigint NOT NULL,
  `child_id` bigint NOT NULL,
  `level` int NOT NULL,
  `system_fees` decimal(13,8) NOT NULL DEFAULT '0.00000000',
  `amount` decimal(13,8) NOT NULL DEFAULT '0.00000000',
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buy_coin_referral_histories`
--

LOCK TABLES `buy_coin_referral_histories` WRITE;
/*!40000 ALTER TABLE `buy_coin_referral_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `buy_coin_referral_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_wallet_withdraw_approvals`
--

DROP TABLE IF EXISTS `co_wallet_withdraw_approvals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_wallet_withdraw_approvals` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `temp_withdraw_id` bigint NOT NULL,
  `wallet_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_wallet_withdraw_approvals`
--

LOCK TABLES `co_wallet_withdraw_approvals` WRITE;
/*!40000 ALTER TABLE `co_wallet_withdraw_approvals` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_wallet_withdraw_approvals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coin_requests`
--

DROP TABLE IF EXISTS `coin_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coin_requests` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `amount` decimal(13,8) NOT NULL DEFAULT '0.00000000',
  `sender_user_id` bigint NOT NULL,
  `receiver_user_id` bigint NOT NULL,
  `sender_wallet_id` bigint NOT NULL,
  `receiver_wallet_id` bigint NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coin_requests`
--

LOCK TABLES `coin_requests` WRITE;
/*!40000 ALTER TABLE `coin_requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `coin_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coins`
--

DROP TABLE IF EXISTS `coins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coins` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `is_withdrawal` tinyint NOT NULL DEFAULT '1',
  `is_deposit` tinyint NOT NULL DEFAULT '1',
  `is_buy` tinyint NOT NULL DEFAULT '1',
  `is_sell` tinyint NOT NULL DEFAULT '1',
  `withdrawal_fees` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `maximum_withdrawal` decimal(19,8) NOT NULL DEFAULT '99999999.00000000',
  `minimum_withdrawal` decimal(19,8) NOT NULL DEFAULT '0.00000010',
  `minimum_sell_amount` decimal(19,8) NOT NULL DEFAULT '0.00000010',
  `minimum_buy_amount` decimal(19,8) NOT NULL DEFAULT '0.00000010',
  `sign` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `trade_status` tinyint NOT NULL DEFAULT '1',
  `is_virtual_amount` tinyint(1) NOT NULL DEFAULT '0',
  `is_transferable` tinyint(1) NOT NULL DEFAULT '0',
  `is_wallet` tinyint(1) NOT NULL DEFAULT '0',
  `is_primary` tinyint(1) DEFAULT NULL,
  `is_currency` tinyint(1) NOT NULL DEFAULT '0',
  `is_base` tinyint(1) NOT NULL DEFAULT '1',
  `coin_icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `coins_type_unique` (`type`),
  UNIQUE KEY `coins_is_primary_unique` (`is_primary`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coins`
--

LOCK TABLES `coins` WRITE;
/*!40000 ALTER TABLE `coins` DISABLE KEYS */;
INSERT INTO `coins` VALUES (1,'Bitcoin','BTC',1,1,1,1,1,0.00000000,99999999.00000000,0.00000010,0.00000010,0.00000010,NULL,1,0,0,0,NULL,0,1,NULL,'2022-03-24 07:47:34','2022-03-24 07:47:34'),(2,'Tether USD','USDT',1,1,1,1,1,0.00000000,99999999.00000000,0.00000010,0.00000010,0.00000010,NULL,1,0,0,0,NULL,0,1,NULL,'2022-03-24 07:47:34','2022-03-24 07:47:34'),(3,'Ether','ETH',1,1,1,1,1,0.00000000,99999999.00000000,0.00000010,0.00000010,0.00000010,NULL,1,0,0,0,NULL,0,1,NULL,'2022-03-24 07:47:34','2022-03-24 07:47:34'),(4,'Litecoin','LTC',1,1,1,1,1,0.00000000,99999999.00000000,0.00000010,0.00000010,0.00000010,NULL,1,0,0,0,NULL,0,1,NULL,'2022-03-24 07:47:34','2022-03-24 07:47:34'),(5,'Bitcoin Cash','BCH',1,1,1,1,1,0.00000000,99999999.00000000,0.00000010,0.00000010,0.00000010,NULL,1,0,0,0,NULL,0,1,NULL,'2022-03-24 07:47:34','2022-03-24 07:47:34'),(6,'Dash','DASH',1,1,1,1,1,0.00000000,99999999.00000000,0.00000010,0.00000010,0.00000010,NULL,1,0,0,0,NULL,0,1,NULL,'2022-03-24 07:47:34','2022-03-24 07:47:34'),(7,'Cpoket','Default',1,1,1,1,1,0.00000000,99999999.00000000,0.00000010,0.00000010,0.00000010,NULL,1,0,0,0,NULL,0,1,NULL,'2022-03-24 07:47:34','2022-03-24 07:47:34'),(8,'Ltct coin','LTCT',1,1,1,1,1,0.00000000,99999999.00000000,0.00000010,0.00000010,0.00000010,NULL,1,0,0,0,NULL,0,1,NULL,'2022-03-24 07:47:34','2022-03-24 07:47:34');
/*!40000 ALTER TABLE `coins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_us`
--

DROP TABLE IF EXISTS `contact_us`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_us` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_us`
--

LOCK TABLES `contact_us` WRITE;
/*!40000 ALTER TABLE `contact_us` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact_us` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_pages`
--

DROP TABLE IF EXISTS `custom_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custom_pages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_order` int NOT NULL DEFAULT '0',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_pages`
--

LOCK TABLES `custom_pages` WRITE;
/*!40000 ALTER TABLE `custom_pages` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deposite_transactions`
--

DROP TABLE IF EXISTS `deposite_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deposite_transactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fees` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `sender_wallet_id` bigint DEFAULT NULL,
  `receiver_wallet_id` bigint unsigned NOT NULL,
  `address_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `btc` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `doller` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `transaction_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `updated_by` bigint DEFAULT NULL,
  `from_address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `confirmations` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deposite_transactions`
--

LOCK TABLES `deposite_transactions` WRITE;
/*!40000 ALTER TABLE `deposite_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `deposite_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estimate_gas_fees_transaction_histories`
--

DROP TABLE IF EXISTS `estimate_gas_fees_transaction_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estimate_gas_fees_transaction_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `unique_code` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deposit_id` bigint NOT NULL,
  `wallet_id` bigint NOT NULL,
  `amount` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `fees` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `coin_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BTC',
  `admin_address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_hash` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `estimate_gas_fees_transaction_histories_unique_code_unique` (`unique_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estimate_gas_fees_transaction_histories`
--

LOCK TABLES `estimate_gas_fees_transaction_histories` WRITE;
/*!40000 ALTER TABLE `estimate_gas_fees_transaction_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `estimate_gas_fees_transaction_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faqs`
--

DROP TABLE IF EXISTS `faqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faqs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `question` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `answer` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `author` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faqs`
--

LOCK TABLES `faqs` WRITE;
/*!40000 ALTER TABLE `faqs` DISABLE KEYS */;
/*!40000 ALTER TABLE `faqs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ico_phases`
--

DROP TABLE IF EXISTS `ico_phases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ico_phases` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `phase_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  `fees` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `rate` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `amount` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `bonus` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `status` tinyint NOT NULL DEFAULT '1',
  `affiliation_level` int DEFAULT NULL,
  `affiliation_percentage` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ico_phases`
--

LOCK TABLES `ico_phases` WRITE;
/*!40000 ALTER TABLE `ico_phases` DISABLE KEYS */;
/*!40000 ALTER TABLE `ico_phases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `languages` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `language` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (1,NULL,'en','2022-03-24 07:47:29','2022-03-24 07:47:29');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `membership_bonus_distribution_histories`
--

DROP TABLE IF EXISTS `membership_bonus_distribution_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `membership_bonus_distribution_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `plan_id` bigint NOT NULL,
  `wallet_id` bigint NOT NULL,
  `membership_id` bigint NOT NULL,
  `distribution_date` date NOT NULL,
  `bonus_amount` decimal(13,8) NOT NULL DEFAULT '0.00000000',
  `plan_current_bonus` decimal(13,8) NOT NULL DEFAULT '0.00000000',
  `bonus_type` tinyint NOT NULL DEFAULT '0',
  `bonus_amount_btc` decimal(13,8) NOT NULL DEFAULT '0.00000000',
  `bonus_coin_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Default',
  `status` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membership_bonus_distribution_histories`
--

LOCK TABLES `membership_bonus_distribution_histories` WRITE;
/*!40000 ALTER TABLE `membership_bonus_distribution_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `membership_bonus_distribution_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `membership_bonuses`
--

DROP TABLE IF EXISTS `membership_bonuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `membership_bonuses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `bonus_amount` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membership_bonuses`
--

LOCK TABLES `membership_bonuses` WRITE;
/*!40000 ALTER TABLE `membership_bonuses` DISABLE KEYS */;
/*!40000 ALTER TABLE `membership_bonuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `membership_clubs`
--

DROP TABLE IF EXISTS `membership_clubs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `membership_clubs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `plan_id` bigint DEFAULT NULL,
  `wallet_id` bigint DEFAULT NULL,
  `amount` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membership_clubs`
--

LOCK TABLES `membership_clubs` WRITE;
/*!40000 ALTER TABLE `membership_clubs` DISABLE KEYS */;
/*!40000 ALTER TABLE `membership_clubs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `membership_plans`
--

DROP TABLE IF EXISTS `membership_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `membership_plans` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `plan_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration` int NOT NULL DEFAULT '0',
  `amount` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `image` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bonus_type` tinyint NOT NULL DEFAULT '1',
  `bonus` decimal(13,8) NOT NULL DEFAULT '0.00000000',
  `bonus_coin_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Default',
  `status` tinyint NOT NULL DEFAULT '1',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membership_plans`
--

LOCK TABLES `membership_plans` WRITE;
/*!40000 ALTER TABLE `membership_plans` DISABLE KEYS */;
INSERT INTO `membership_plans` VALUES (1,'Silver',30,500.00000000,NULL,2,2.00000000,'Default',1,NULL,'2022-03-24 07:47:34','2022-03-24 07:47:34'),(2,'Gold',30,1000.00000000,NULL,2,5.00000000,'Default',1,NULL,'2022-03-24 07:47:34','2022-03-24 07:47:34'),(3,'Platinum',30,2000.00000000,NULL,2,10.00000000,'Default',1,NULL,'2022-03-24 07:47:34','2022-03-24 07:47:34');
/*!40000 ALTER TABLE `membership_plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `membership_transaction_histories`
--

DROP TABLE IF EXISTS `membership_transaction_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `membership_transaction_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `club_id` bigint DEFAULT NULL,
  `user_id` bigint NOT NULL,
  `wallet_id` bigint NOT NULL,
  `amount` decimal(13,8) NOT NULL DEFAULT '0.00000000',
  `type` tinyint NOT NULL DEFAULT '1',
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membership_transaction_histories`
--

LOCK TABLES `membership_transaction_histories` WRITE;
/*!40000 ALTER TABLE `membership_transaction_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `membership_transaction_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_11_000000_create_failed_jobs_table',1),(2,'2014_10_12_000000_create_users_table',1),(3,'2014_10_12_100000_create_password_resets_table',1),(4,'2016_06_01_000001_create_oauth_auth_codes_table',1),(5,'2016_06_01_000002_create_oauth_access_tokens_table',1),(6,'2016_06_01_000003_create_oauth_refresh_tokens_table',1),(7,'2016_06_01_000004_create_oauth_clients_table',1),(8,'2016_06_01_000005_create_oauth_personal_access_clients_table',1),(9,'2018_08_29_200844_create_languages_table',1),(10,'2018_08_29_205156_create_translations_table',1),(11,'2019_06_24_092552_create_wallets_table',1),(12,'2019_07_24_092057_create_referrals_table',1),(13,'2019_07_24_092303_create_user_settings_table',1),(14,'2019_07_24_092331_create_admin_settings_table',1),(15,'2019_07_24_092409_create_activity_logs_table',1),(16,'2019_07_24_092511_create_wallet_address_histories_table',1),(17,'2019_07_24_103207_create_user_verification_codes_table',1),(18,'2019_10_17_075927_create_affiliation_codes_table',1),(19,'2019_10_17_080002_create_affiliation_histories_table',1),(20,'2019_10_17_080031_create_referral_users_table',1),(21,'2020_04_29_080822_create_verification_details_table',1),(22,'2020_04_29_081029_create_banks_table',1),(23,'2020_04_29_081134_create_buy_coin_histories_table',1),(24,'2020_04_29_081343_create_deposite_transactions_table',1),(25,'2020_04_29_081451_create_withdraw_histories_table',1),(26,'2020_06_11_133803_create_membership_clubs_table',1),(27,'2020_06_11_134228_create_membership_plans_table',1),(28,'2020_06_11_134611_create_membership_bonuses_table',1),(29,'2020_06_11_134742_create_membership_bonus_distribution_histories_table',1),(30,'2020_06_11_134823_create_membership_transaction_histories_table',1),(31,'2020_06_17_123519_create_faqs_table',1),(32,'2020_06_19_095619_create_send_mail_records_table',1),(33,'2020_06_19_183647_create_notifications_table',1),(34,'2020_06_21_152330_create_referral_sign_bonus_histories_table',1),(35,'2020_06_23_065105_add_wallet_id_at_bonus',1),(36,'2020_06_24_080256_create_websockets_statistics_entries_table',1),(37,'2020_07_01_111249_create_admin_give_coin_histories_table',1),(38,'2020_07_03_092949_create_ico_phases_table',1),(39,'2020_07_03_112940_add_phaseid_at_buy_coin',1),(40,'2020_07_06_053213_create_buy_coin_referral_histories_table',1),(41,'2020_07_26_091257_create_coin_requests_table',1),(42,'2020_09_25_095154_add_coin_type_at_wallets',1),(43,'2020_09_25_105747_create_coins_table',1),(44,'2020_09_29_062329_add_wallet_id_at_membership_clubs',1),(45,'2020_09_30_062649_add_coin_type_at_withdraw',1),(46,'2020_09_30_065234_add_coin_type_at_wallet_address',1),(47,'2020_10_02_060429_add_coin_type_at_plan',1),(48,'2020_10_02_063542_add_coin_type_at_plan_bonus_dis_history',1),(49,'2020_10_20_112652_add_stripe_token_at_buy_coin_histories',1),(50,'2021_01_13_093659_create_custom_pages_table',1),(51,'2021_01_16_064548_create_contact_us_table',1),(52,'2021_03_04_065920_create_wallet_swap_histories_table',1),(53,'2021_04_19_123622_add_columns_in_wallets',1),(54,'2021_04_19_124055_create_wallet_co_users_table',1),(55,'2021_04_19_125002_create_temp_withdraws_table',1),(56,'2021_04_19_125104_create_co_wallet_withdraw_approvals_table',1),(57,'2021_04_21_083450_add_user_id_in_withdraw_histories',1),(58,'2021_04_23_055746_add_column_at_coin',1),(59,'2021_04_26_075520_add_coin_id_at_wallets',1),(60,'2021_10_19_121437_add_new_column_users',1),(61,'2022_01_14_091807_add_pk_at_wallet_address_table',1),(62,'2022_01_27_064540_create_estimate_gas_fees_transaction_histories_table',1),(63,'2022_01_27_072747_create_admin_receive_token_transaction_histories_table',1),(64,'2022_03_24_061547_add_from_address_to_deposit',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notification_body` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_access_tokens`
--

DROP TABLE IF EXISTS `oauth_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int DEFAULT NULL,
  `client_id` int NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_access_tokens`
--

LOCK TABLES `oauth_access_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
INSERT INTO `oauth_access_tokens` VALUES ('b944715c4dc302591b599cfe4efb02b55db5f0e9e4ebfc0954e703eceaf5a13ff5d7b5c2929d1e5f',2,1,'user@email.com','[]',0,'2024-07-29 19:30:13','2024-07-29 19:30:13','2025-07-29 22:30:13'),('d3e7bc5eb683f22cb4e54e77dbff2fd8cd4b0c9066b98bef357d116a4a4384505bd32d02adae58e0',2,1,'user@email.com','[]',0,'2024-07-29 19:35:34','2024-07-29 19:35:34','2025-07-29 22:35:34');
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_auth_codes`
--

DROP TABLE IF EXISTS `oauth_auth_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `client_id` int NOT NULL,
  `scopes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_auth_codes`
--

LOCK TABLES `oauth_auth_codes` WRITE;
/*!40000 ALTER TABLE `oauth_auth_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_auth_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_clients`
--

DROP TABLE IF EXISTS `oauth_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_clients` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_clients`
--

LOCK TABLES `oauth_clients` WRITE;
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
INSERT INTO `oauth_clients` VALUES (1,NULL,'Laravel Personal Access Client','9ycMEgtMVMrmnf8QfBgxDgvgWCUBh7GRctWMATnt','http://localhost',1,0,0,'2024-07-29 19:29:28','2024-07-29 19:29:28'),(2,NULL,'Laravel Password Grant Client','Yw14Nkcxht36Qkw5tbFvQis194UqVJLQWcBn8ujn','http://localhost',0,1,0,'2024-07-29 19:29:28','2024-07-29 19:29:28');
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_personal_access_clients`
--

DROP TABLE IF EXISTS `oauth_personal_access_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_personal_access_clients` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_personal_access_clients_client_id_index` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_personal_access_clients`
--

LOCK TABLES `oauth_personal_access_clients` WRITE;
/*!40000 ALTER TABLE `oauth_personal_access_clients` DISABLE KEYS */;
INSERT INTO `oauth_personal_access_clients` VALUES (1,1,'2024-07-29 19:29:28','2024-07-29 19:29:28');
/*!40000 ALTER TABLE `oauth_personal_access_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_refresh_tokens`
--

DROP TABLE IF EXISTS `oauth_refresh_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_refresh_tokens`
--

LOCK TABLES `oauth_refresh_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_refresh_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_resets` (
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `referral_sign_bonus_histories`
--

DROP TABLE IF EXISTS `referral_sign_bonus_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referral_sign_bonus_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `parent_id` bigint NOT NULL,
  `wallet_id` bigint NOT NULL,
  `amount` decimal(13,8) NOT NULL DEFAULT '0.00000000',
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `referral_sign_bonus_histories`
--

LOCK TABLES `referral_sign_bonus_histories` WRITE;
/*!40000 ALTER TABLE `referral_sign_bonus_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `referral_sign_bonus_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `referral_users`
--

DROP TABLE IF EXISTS `referral_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referral_users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `parent_id` bigint unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `referral_users_user_id_unique` (`user_id`),
  KEY `referral_users_parent_id_foreign` (`parent_id`),
  CONSTRAINT `referral_users_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `referral_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `referral_users`
--

LOCK TABLES `referral_users` WRITE;
/*!40000 ALTER TABLE `referral_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `referral_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `referrals`
--

DROP TABLE IF EXISTS `referrals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referrals` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `parent_user_id` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `referrals_user_id_foreign` (`user_id`),
  CONSTRAINT `referrals_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `referrals`
--

LOCK TABLES `referrals` WRITE;
/*!40000 ALTER TABLE `referrals` DISABLE KEYS */;
/*!40000 ALTER TABLE `referrals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `send_mail_records`
--

DROP TABLE IF EXISTS `send_mail_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `send_mail_records` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `email_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `send_mail_records`
--

LOCK TABLES `send_mail_records` WRITE;
/*!40000 ALTER TABLE `send_mail_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `send_mail_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temp_withdraws`
--

DROP TABLE IF EXISTS `temp_withdraws`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `temp_withdraws` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `wallet_id` bigint NOT NULL,
  `withdraw_id` bigint DEFAULT NULL,
  `amount` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temp_withdraws`
--

LOCK TABLES `temp_withdraws` WRITE;
/*!40000 ALTER TABLE `temp_withdraws` DISABLE KEYS */;
/*!40000 ALTER TABLE `temp_withdraws` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `translations`
--

DROP TABLE IF EXISTS `translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `translations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `language_id` int unsigned NOT NULL,
  `group` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `key` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `translations_language_id_foreign` (`language_id`),
  CONSTRAINT `translations_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `translations`
--

LOCK TABLES `translations` WRITE;
/*!40000 ALTER TABLE `translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_settings`
--

DROP TABLE IF EXISTS `user_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_settings_user_id_foreign` (`user_id`),
  CONSTRAINT `user_settings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_settings`
--

LOCK TABLES `user_settings` WRITE;
/*!40000 ALTER TABLE `user_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_verification_codes`
--

DROP TABLE IF EXISTS `user_verification_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_verification_codes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `expired_at` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_verification_codes`
--

LOCK TABLES `user_verification_codes` WRITE;
/*!40000 ALTER TABLE `user_verification_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_verification_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reset_code` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` int NOT NULL DEFAULT '2',
  `status` int NOT NULL DEFAULT '1',
  `country_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_verified` tinyint NOT NULL DEFAULT '0',
  `country` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` tinyint NOT NULL DEFAULT '1',
  `birth_date` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `g2f_enabled` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `google2fa_secret` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_verified` tinyint NOT NULL DEFAULT '0',
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `language` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en',
  `device_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `device_type` tinyint NOT NULL DEFAULT '1',
  `push_notification_status` tinyint NOT NULL DEFAULT '1',
  `email_notification_status` tinyint NOT NULL DEFAULT '1',
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `verification_codes` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'various verification codes',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_reset_code_unique` (`reset_code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Mr.','Admin','admin@email.com',NULL,1,1,NULL,NULL,0,NULL,1,NULL,NULL,'0',NULL,1,'$2y$10$P2p/Rgv04SmZcs01cpRjquzwhLlhAD4K9qDujoxyd9ve5z4i0piXe','en',NULL,1,1,1,NULL,'2022-03-24 07:47:33','2022-03-24 07:47:33',NULL),(2,'Mr','User','user@email.com',NULL,2,1,NULL,NULL,0,NULL,1,NULL,NULL,'0',NULL,1,'$2y$10$XEIgHJwCg1WeMbmYbyWBjuLAWuN/8pQCbBkypQCpYV.BH/DLXeahy','en',NULL,1,1,1,NULL,'2022-03-24 07:47:33','2022-03-24 07:47:33',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `verification_details`
--

DROP TABLE IF EXISTS `verification_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `verification_details` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `field_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `verification_details_user_id_foreign` (`user_id`),
  CONSTRAINT `verification_details_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `verification_details`
--

LOCK TABLES `verification_details` WRITE;
/*!40000 ALTER TABLE `verification_details` DISABLE KEYS */;
INSERT INTO `verification_details` VALUES (1,2,'nid_front',0,'66a81c70ef9071722293360.png','2024-07-29 19:49:21','2024-07-29 19:49:21'),(2,2,'nid_back',0,'66a81c71058c11722293361.png','2024-07-29 19:49:21','2024-07-29 19:49:21'),(3,2,'pass_front',0,'66a81cc7abb981722293447.png','2024-07-29 19:50:47','2024-07-29 19:50:47'),(4,2,'pass_back',0,'66a81cc7af7f11722293447.png','2024-07-29 19:50:47','2024-07-29 19:50:47'),(5,2,'drive_front',0,'66a81d13b08831722293523.png','2024-07-29 19:52:03','2024-07-29 19:52:03'),(6,2,'drive_back',0,'66a81d13b6cb71722293523.png','2024-07-29 19:52:03','2024-07-29 19:52:03');
/*!40000 ALTER TABLE `verification_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallet_address_histories`
--

DROP TABLE IF EXISTS `wallet_address_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallet_address_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `wallet_id` bigint NOT NULL,
  `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pk` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `coin_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BTC',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallet_address_histories`
--

LOCK TABLES `wallet_address_histories` WRITE;
/*!40000 ALTER TABLE `wallet_address_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `wallet_address_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallet_co_users`
--

DROP TABLE IF EXISTS `wallet_co_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallet_co_users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `wallet_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallet_co_users`
--

LOCK TABLES `wallet_co_users` WRITE;
/*!40000 ALTER TABLE `wallet_co_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `wallet_co_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallet_swap_histories`
--

DROP TABLE IF EXISTS `wallet_swap_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallet_swap_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `from_wallet_id` bigint NOT NULL,
  `to_wallet_id` bigint NOT NULL,
  `from_coin_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `to_coin_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `requested_amount` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `converted_amount` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `rate` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wallet_swap_histories_user_id_foreign` (`user_id`),
  CONSTRAINT `wallet_swap_histories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallet_swap_histories`
--

LOCK TABLES `wallet_swap_histories` WRITE;
/*!40000 ALTER TABLE `wallet_swap_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `wallet_swap_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallets`
--

DROP TABLE IF EXISTS `wallets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallets` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `coin_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Default',
  `coin_id` int DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `is_primary` tinyint NOT NULL DEFAULT '0',
  `balance` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `referral_balance` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `key` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `wallets_user_id_foreign` (`user_id`),
  CONSTRAINT `wallets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallets`
--

LOCK TABLES `wallets` WRITE;
/*!40000 ALTER TABLE `wallets` DISABLE KEYS */;
INSERT INTO `wallets` VALUES (1,1,'BTC Wallet','BTC',1,1,0,0.00000000,0.00000000,'2022-03-24 07:47:34','2022-03-24 07:47:34',NULL,1),(2,1,'USDT Wallet','USDT',2,1,0,0.00000000,0.00000000,'2022-03-24 07:47:34','2022-03-24 07:47:34',NULL,1),(3,1,'ETH Wallet','ETH',3,1,0,0.00000000,0.00000000,'2022-03-24 07:47:34','2022-03-24 07:47:34',NULL,1),(4,1,'LTC Wallet','LTC',4,1,0,0.00000000,0.00000000,'2022-03-24 07:47:34','2022-03-24 07:47:34',NULL,1),(5,1,'BCH Wallet','BCH',5,1,0,0.00000000,0.00000000,'2022-03-24 07:47:34','2022-03-24 07:47:34',NULL,1),(6,1,'DASH Wallet','DASH',6,1,0,0.00000000,0.00000000,'2022-03-24 07:47:34','2022-03-24 07:47:34',NULL,1),(7,1,'Default Wallet','Default',7,1,0,0.00000000,0.00000000,'2022-03-24 07:47:34','2022-03-24 07:47:34',NULL,1),(8,1,'LTCT Wallet','LTCT',8,1,0,0.00000000,0.00000000,'2022-03-24 07:47:34','2022-03-24 07:47:34',NULL,1),(9,2,'BTC Wallet','BTC',1,1,0,0.00000000,0.00000000,'2022-03-24 07:47:34','2022-03-24 07:47:34',NULL,1),(10,2,'USDT Wallet','USDT',2,1,0,0.00000000,0.00000000,'2022-03-24 07:47:34','2022-03-24 07:47:34',NULL,1),(11,2,'ETH Wallet','ETH',3,1,0,0.00000000,0.00000000,'2022-03-24 07:47:34','2022-03-24 07:47:34',NULL,1),(12,2,'LTC Wallet','LTC',4,1,0,0.00000000,0.00000000,'2022-03-24 07:47:34','2022-03-24 07:47:34',NULL,1),(13,2,'BCH Wallet','BCH',5,1,0,0.00000000,0.00000000,'2022-03-24 07:47:34','2022-03-24 07:47:34',NULL,1),(14,2,'DASH Wallet','DASH',6,1,0,0.00000000,0.00000000,'2022-03-24 07:47:34','2022-03-24 07:47:34',NULL,1),(15,2,'Default Wallet','Default',7,1,0,0.00000000,0.00000000,'2022-03-24 07:47:34','2022-03-24 07:47:34',NULL,1),(16,2,'LTCT Wallet','LTCT',8,1,0,0.00000000,0.00000000,'2022-03-24 07:47:34','2022-03-24 07:47:34',NULL,1);
/*!40000 ALTER TABLE `wallets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `websockets_statistics_entries`
--

DROP TABLE IF EXISTS `websockets_statistics_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `websockets_statistics_entries` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `app_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `peak_connection_count` int NOT NULL,
  `websocket_message_count` int NOT NULL,
  `api_message_count` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `websockets_statistics_entries`
--

LOCK TABLES `websockets_statistics_entries` WRITE;
/*!40000 ALTER TABLE `websockets_statistics_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `websockets_statistics_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `withdraw_histories`
--

DROP TABLE IF EXISTS `withdraw_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `withdraw_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `wallet_id` bigint unsigned NOT NULL,
  `amount` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `coin_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BTC',
  `btc` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `doller` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `address_type` tinyint NOT NULL,
  `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_hash` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `receiver_wallet_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `confirmations` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fees` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `used_gas` decimal(19,8) NOT NULL DEFAULT '0.00000000',
  `status` tinyint NOT NULL DEFAULT '0',
  `message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `withdraw_histories_wallet_id_foreign` (`wallet_id`),
  CONSTRAINT `withdraw_histories_wallet_id_foreign` FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `withdraw_histories`
--

LOCK TABLES `withdraw_histories` WRITE;
/*!40000 ALTER TABLE `withdraw_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `withdraw_histories` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-31  2:39:25
