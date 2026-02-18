-- MySQL dump 10.13  Distrib 8.0.44, for Linux (x86_64)
--
-- Host: localhost    Database: evacuacio_institut
-- ------------------------------------------------------
-- Server version	8.0.44-0ubuntu0.24.04.1

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
DROP DATABASE IF EXISTS evacuacio_institut;
CREATE DATABASE evacuacio_institut;
USE evacuacio_institut;
--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evacuation_responsibles`
--

DROP TABLE IF EXISTS `evacuation_responsibles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evacuation_responsibles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `evacuation_id` bigint unsigned NOT NULL,
  `zone_id` bigint unsigned NOT NULL,
  `email` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `evacuation_responsibles_evacuation_id_foreign` (`evacuation_id`),
  KEY `evacuation_responsibles_zone_id_foreign` (`zone_id`),
  CONSTRAINT `evacuation_responsibles_evacuation_id_foreign` FOREIGN KEY (`evacuation_id`) REFERENCES `evacuations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `evacuation_responsibles_zone_id_foreign` FOREIGN KEY (`zone_id`) REFERENCES `zones` (`id`) ON DELETE CASCADE,
  CONSTRAINT `responsables_evacuacio_id_zona_foreign` FOREIGN KEY (`zone_id`) REFERENCES `zones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evacuation_responsibles`
--

LOCK TABLES `evacuation_responsibles` WRITE;
/*!40000 ALTER TABLE `evacuation_responsibles` DISABLE KEYS */;
INSERT INTO `evacuation_responsibles` VALUES (6,11,5,NULL,'ghizlane','2026-01-02 17:14:53','2026-01-02 17:14:53'),(7,12,5,NULL,'ghizlane','2026-01-03 15:56:21','2026-01-03 15:56:21'),(8,15,5,NULL,'ghizlane','2026-01-09 08:35:18','2026-01-09 08:35:18'),(9,15,3,NULL,'ghizlane','2026-01-09 08:36:06','2026-01-09 08:36:06'),(10,15,2,NULL,'ghizlane','2026-01-09 08:36:18','2026-01-09 08:36:18'),(11,15,1,NULL,'ghizlane','2026-01-09 08:36:39','2026-01-09 08:36:39'),(12,15,4,NULL,'ghizlane','2026-01-09 08:36:54','2026-01-09 08:36:54'),(13,16,5,NULL,'Ghizlane','2026-01-09 09:07:31','2026-01-09 09:07:31'),(14,16,1,NULL,'Ghizlane','2026-01-09 09:08:42','2026-01-09 09:08:42'),(15,17,3,NULL,'Juan','2026-01-16 09:00:59','2026-01-16 09:00:59'),(16,19,1,NULL,'Juan','2026-01-22 16:13:42','2026-01-22 16:13:42');
/*!40000 ALTER TABLE `evacuation_responsibles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evacuations`
--

DROP TABLE IF EXISTS `evacuations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evacuations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `started_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ended_at` timestamp NULL DEFAULT NULL,
  `unverified_spaces_count` int unsigned NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `started_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_started_by` (`started_by`),
  CONSTRAINT `evacuations_started_by_foreign` FOREIGN KEY (`started_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_started_by` FOREIGN KEY (`started_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evacuations`
--

LOCK TABLES `evacuations` WRITE;
/*!40000 ALTER TABLE `evacuations` DISABLE KEYS */;
INSERT INTO `evacuations` VALUES (7,'2026-01-02 16:55:33','2026-01-02 16:15:15',0,0,NULL,'2026-01-02 15:55:33','2026-01-02 16:15:15'),(8,'2026-01-02 16:55:45','2026-01-02 15:55:50',0,0,NULL,'2026-01-02 15:55:45','2026-01-02 15:55:50'),(9,'2026-01-02 17:18:32','2026-01-02 16:18:53',0,0,NULL,'2026-01-02 16:18:32','2026-01-02 16:18:53'),(10,'2026-01-02 17:30:41','2026-01-02 16:30:44',0,0,NULL,'2026-01-02 16:30:41','2026-01-02 16:30:44'),(11,'2026-01-02 18:14:45','2026-01-02 18:13:06',0,0,NULL,'2026-01-02 17:14:45','2026-01-02 18:13:06'),(12,'2026-01-03 16:56:16','2026-01-03 15:56:23',0,0,NULL,'2026-01-03 15:56:16','2026-01-03 15:56:23'),(13,'2026-01-08 15:27:56','2026-01-08 14:28:04',0,0,NULL,'2026-01-08 14:27:56','2026-01-08 14:28:04'),(14,'2026-01-09 08:22:20','2026-01-09 08:27:05',0,0,NULL,'2026-01-09 07:22:20','2026-01-09 08:27:05'),(15,'2026-01-09 08:27:07','2026-01-09 09:04:37',0,0,NULL,'2026-01-09 08:27:07','2026-01-09 09:04:37'),(16,'2026-01-09 09:04:40','2026-01-09 09:24:37',0,0,NULL,'2026-01-09 09:04:40','2026-01-09 09:24:37'),(17,'2026-01-16 08:52:19','2026-01-16 11:31:09',0,0,NULL,'2026-01-16 08:52:19','2026-01-16 11:31:09'),(18,'2026-01-16 11:31:12','2026-01-16 11:31:18',0,0,NULL,'2026-01-16 11:31:12','2026-01-16 11:31:18'),(19,'2026-01-22 16:13:31','2026-01-22 16:14:32',149,0,NULL,'2026-01-22 16:13:31','2026-01-22 16:14:32');
/*!40000 ALTER TABLE `evacuations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
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
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2025_11_07_095700_create_usuaris_table',1),(5,'2025_11_07_095750_create_evacuacios_table',1),(6,'2025_11_07_095750_create_zonas_table',1),(7,'2025_11_07_095751_create_historial_zonas_table',1),(8,'2025_11_07_095751_create_responsable_evacuacios_table',1),(9,'2025_11_10_081738_create_personal_access_tokens_table',1),(10,'2025_11_10_092305_create_personal_access_tokens_table',2),(11,'2025_11_10_110000_create_users_table',3),(12,'2025_11_10_111757_rename_correu_to_email_in_usuaris_table',4),(13,'2025_11_10_113229_rename_columns_in_usuaris_table',5),(14,'2025_11_14_105345_modificar_zones_i_crear_espais',6),(15,'2025_11_14_110233_modificar_taules',7),(16,'2025_11_14_110233_modificar_taules2',8),(18,'2025_11_14_114146_create_users_and_evacuation_tables',9),(19,'2025_11_17_102611_fix_started_by_in_evacuations_table',9),(20,'2025_11_21_102437_add_planta_to_spaces_table',10),(21,'2025_11_25_092630_create_responsible_tokens_table',11),(22,'2025_11_28_085324_rename_responsables_evacuacio_to_evacuation_responsibles',12),(23,'2025_12_15_101938_make_started_by_nullable_in_evacuations_table',13),(24,'2026_01_22_170806_add_unverified_spaces_count_to_evacuations_table',14);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (1,'App\\Models\\Usuari',1,'test','6229f26532d00c76e989f386586f24b363b93e31469438028ac545f4b161a420','[\"*\"]',NULL,NULL,'2025-11-10 08:37:04','2025-11-10 08:37:04'),(2,'App\\Models\\Usuari',1,'auth_token','bb9524c1da1b044753e767d77339fe7f59fd5c56df9c35fe0ebb228766a4deb8','[\"*\"]',NULL,NULL,'2025-11-10 08:38:21','2025-11-10 08:38:21'),(3,'App\\Models\\Usuari',2,'auth_token','74a395d9102e9f3ae96afc338f7718aebab54921f20e4443b5f84b265337b45c','[\"*\"]',NULL,NULL,'2025-11-10 08:42:26','2025-11-10 08:42:26'),(4,'App\\Models\\Usuari',1,'auth_token','4cd9d509b0f17d91acea109de99591f8328e37cf77af58a4ee1e060345284a8e','[\"*\"]',NULL,NULL,'2025-11-11 07:01:52','2025-11-11 07:01:52'),(5,'App\\Models\\Usuari',1,'auth_token','e69f62ff63165b145433b6c339789e4ee0f773388953a9d15812214dfb83953b','[\"*\"]',NULL,NULL,'2025-11-11 08:04:43','2025-11-11 08:04:43'),(6,'App\\Models\\Usuari',1,'auth_token','2629c078fc0990cfe20e3ad63b0f28841066ebf13d5e6ba8907bf0fc09fa1545','[\"*\"]',NULL,NULL,'2025-11-11 08:42:36','2025-11-11 08:42:36'),(7,'App\\Models\\Usuari',1,'auth_token','d620b446413b085e77408f24bfc4b66d247c159e014cbcf57dc0bcbd3ebb2ade','[\"*\"]',NULL,NULL,'2025-11-11 09:12:09','2025-11-11 09:12:09'),(8,'App\\Models\\Usuari',1,'auth_token','9800ba5a382122635069328c30cd98d58c2da89887197858e0db48d6846d0986','[\"*\"]',NULL,NULL,'2025-11-12 07:58:13','2025-11-12 07:58:13'),(9,'App\\Models\\Usuari',1,'auth_token','e5a16974eb4fd9a042f8a493c69a9ccb226dcbf35ad37e33c487e9b973678c91','[\"*\"]',NULL,NULL,'2025-11-13 07:10:00','2025-11-13 07:10:00'),(10,'App\\Models\\User',1,'auth_token','6e926f74f07ea74338d6a548a0a2aa5e124487a16cbc4bc94a52318d01d46183','[\"*\"]',NULL,NULL,'2025-11-17 07:58:44','2025-11-17 07:58:44'),(11,'App\\Models\\User',1,'auth_token','1fce2dc6c1cccc090ac92b2a6fdeb172a9bd1ac154bd0f8f6adba152e6be549f','[\"*\"]',NULL,NULL,'2025-11-21 06:59:42','2025-11-21 06:59:42'),(12,'App\\Models\\User',1,'auth_token','d197eb4958b1eb695eac9f05a579fe08bc6f8a217eee125878e34c73a4eff291','[\"*\"]',NULL,NULL,'2025-12-11 09:15:48','2025-12-11 09:15:48'),(13,'App\\Models\\User',1,'auth_token','a20e7dcc0964c77624d6155dc373856b422e2aaf69db4bf8d7420e05823f631c','[\"*\"]',NULL,NULL,'2025-12-12 07:41:15','2025-12-12 07:41:15'),(14,'App\\Models\\User',1,'auth_token','571564d316389d040853dda5e1268d7370d6b2da9cda6512452bf4f7afc2df4c','[\"*\"]',NULL,NULL,'2025-12-12 08:00:14','2025-12-12 08:00:14'),(15,'App\\Models\\User',1,'auth_token','523bb00248e7b446d25f1fe332d7f346260315a5b54a7c5c3182cb47aff13eba','[\"*\"]',NULL,NULL,'2025-12-12 09:26:09','2025-12-12 09:26:09'),(16,'App\\Models\\User',1,'auth_token','a96a085adc584ea0ecccfa7e8ef6b000a4d5ae90b125f43de7eb5969e772a118','[\"*\"]',NULL,NULL,'2025-12-12 09:28:00','2025-12-12 09:28:00'),(17,'App\\Models\\User',1,'auth_token','a6e603750d7718118172db9deeb51515fe77a7949422eabfe6dcb2d4f827791c','[\"*\"]',NULL,NULL,'2025-12-12 09:28:47','2025-12-12 09:28:47'),(18,'App\\Models\\User',1,'auth_token','cbb2bddf74643e0b857151cbcf2cd91ed96102ef76a0b60752a1effab10dcb46','[\"*\"]',NULL,NULL,'2025-12-12 09:29:00','2025-12-12 09:29:00'),(19,'App\\Models\\User',1,'auth_token','2c6ea0d91ec4bd5ddf85608ed1e6e113299fd25cc10a0e208f69dc824d0d53de','[\"*\"]',NULL,NULL,'2025-12-12 09:34:38','2025-12-12 09:34:38'),(20,'App\\Models\\User',1,'auth_token','cc9145c2c3a8e1836c0ad6d4b6f408d3d7c01bb480cc25dd41f4516cb322c991','[\"*\"]',NULL,NULL,'2025-12-15 08:11:25','2025-12-15 08:11:25'),(21,'App\\Models\\User',1,'auth_token','d30906d4478a67ebf411e2639dd69347121cdbbd95ba5147103650612c170df4','[\"*\"]',NULL,NULL,'2025-12-15 09:33:32','2025-12-15 09:33:32'),(22,'App\\Models\\User',1,'auth_token','199d93496b5d47cba2c3bf8b6ddf95dafcee63138c400e70f362837a61a4eee4','[\"*\"]',NULL,NULL,'2026-01-02 14:06:25','2026-01-02 14:06:25'),(23,'App\\Models\\User',1,'auth_token','1244222f226dde74d71e3df696870553c89e346ebcfe2a90e6da688ef70d7e67','[\"*\"]',NULL,NULL,'2026-01-02 16:40:36','2026-01-02 16:40:36'),(24,'App\\Models\\User',2,'auth_token','1901915e0ee0de6ccd954bb6258283ac86046e66d8cb05e9c49029d82af700e8','[\"*\"]',NULL,NULL,'2026-01-02 16:44:22','2026-01-02 16:44:22'),(25,'App\\Models\\User',2,'auth_token','df1e0e53a5a2a3ddede10d93bfa7e86414fdb145eab199fb36e9a334f67bcf8c','[\"*\"]',NULL,NULL,'2026-01-02 16:45:25','2026-01-02 16:45:25'),(26,'App\\Models\\User',1,'auth_token','f49c9468d79010928f6b788d9cf6d869b7317ba9a8e248879ff7a61c3ad43bfc','[\"*\"]',NULL,NULL,'2026-01-02 16:46:27','2026-01-02 16:46:27'),(27,'App\\Models\\User',1,'auth_token','8f58d6bbce3d88e63a348a9bd28159b6c320088741f710ee4dc2bee716ce9d50','[\"*\"]',NULL,NULL,'2026-01-02 17:14:41','2026-01-02 17:14:41'),(28,'App\\Models\\User',1,'auth_token','62680986d52bd4e9901f26d57903ed3aeb5375e7f6fb9880741f5a4072ab2798','[\"*\"]',NULL,NULL,'2026-01-02 17:36:41','2026-01-02 17:36:41'),(29,'App\\Models\\User',1,'auth_token','faa6be26886066bfc1ef426b31aa29ae5e05321f2cd4a000d201e763971e06ad','[\"*\"]',NULL,NULL,'2026-01-02 17:55:20','2026-01-02 17:55:20'),(30,'App\\Models\\User',1,'auth_token','72ff0803b4238cea5c639523e649677cd5536b82582061324aec576aed5bb89a','[\"*\"]','2026-01-02 18:01:02',NULL,'2026-01-02 17:55:41','2026-01-02 18:01:02'),(31,'App\\Models\\User',1,'auth_token','237a66ac38003aa1eb923571eed938bd4d02d6fdc4f5d751a1e04356b824b44a','[\"*\"]','2026-01-02 18:02:01',NULL,'2026-01-02 18:01:23','2026-01-02 18:02:01'),(32,'App\\Models\\User',1,'auth_token','70cc3acf3adf188e0cb492f367e9f01ee7ba0079f70e54d4223112459b49e72d','[\"*\"]',NULL,NULL,'2026-01-09 07:16:43','2026-01-09 07:16:43'),(33,'App\\Models\\User',1,'auth_token','a26b9ee0f22c4ec60e71ece4d612984d9a15e22eb65d58260a31244d89293b4a','[\"*\"]',NULL,NULL,'2026-01-16 08:51:11','2026-01-16 08:51:11'),(34,'App\\Models\\User',1,'auth_token','91707e7001fda43aea01a057b91bb2e9fb5136cd7fb7a1c6d8f05803c8d195ce','[\"*\"]',NULL,NULL,'2026-01-16 09:57:16','2026-01-16 09:57:16'),(35,'App\\Models\\User',1,'auth_token','1d7885c55baab795bf87537aa9989370e104f1afd26619f7fa3f98eef64945cc','[\"*\"]',NULL,NULL,'2026-01-23 08:47:20','2026-01-23 08:47:20');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('07nIhjRI5rJgYrC7bBKYoeiyed1982Q1OfQILi46',NULL,'127.0.0.1','PostmanRuntime/7.43.0','YTozOntzOjY6Il90b2tlbiI7czo0MDoibVU4T3VxbU1LdEpCQ1JqeGNzc1FKTlJGMFd1TjRNSDZoVmdIcG91eCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1763375308),('67xcUTTOeaDroeY7ATGrrupwne9fDDPlao34JGG7',NULL,'127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiV3AzTkpFMkROSEd5Z2tDTmtwTHh2b2poZzZ6alplSXRCRUwyb2xiTiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1765452401),('nYmGAZcmzKWxHaheWxKuidTti5pAlWLVSj0HJqYv',NULL,'127.0.0.1','PostmanRuntime/7.43.0','YTozOntzOjY6Il90b2tlbiI7czo0MDoieDBsS2Qwa09JM3FjeDloTUkwdVhhRkN6a1doMXNHejc5UlNDUFhzcSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1765794713),('tnTZyUD6itixnJVOPfSaytOazdTCCHKeb5BICNTo',NULL,'127.0.0.1','PostmanRuntime/7.43.0','YTozOntzOjY6Il90b2tlbiI7czo0MDoiRmhYV0dqSFh6ZE1VQld1TTUxcm16SGt1NVNyZUxxOUVaOGhBMXl0TSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMyI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1762766681);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spaces`
--

DROP TABLE IF EXISTS `spaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spaces` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zone_id` bigint unsigned NOT NULL,
  `floor` int DEFAULT NULL,
  `coordinates` json DEFAULT NULL,
  `status` enum('unverified','verified') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unverified',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `spaces_zone_id_foreign` (`zone_id`),
  CONSTRAINT `spaces_zone_id_foreign` FOREIGN KEY (`zone_id`) REFERENCES `zones` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spaces`
--

LOCK TABLES `spaces` WRITE;
/*!40000 ALTER TABLE `spaces` DISABLE KEYS */;
INSERT INTO `spaces` VALUES (33,'B.12',1,-1,'[{\"x\": 0.7456436686980731, \"y\": 0.6668638023487372}, {\"x\": 0.7915416893688144, \"y\": 0.6523638202385553}, {\"x\": 0.7966686941390818, \"y\": 0.6870602060022046}, {\"x\": 0.7497932219537801, \"y\": 0.7015601881123865}]','unverified','2025-11-26 08:49:36','2026-01-19 13:32:13'),(34,'B.20',1,-1,'[{\"x\": 0.6937623841072866, \"y\": 0.6493979033133082}, {\"x\": 0.7175663348263851, \"y\": 0.6416300557542821}, {\"x\": 0.7230595542231002, \"y\": 0.6742550155021912}, {\"x\": 0.6992556035040016, \"y\": 0.6830585760690873}]','unverified','2025-11-26 08:50:03','2026-01-19 13:31:26'),(35,'B.21',1,-1,'[{\"x\": 0.7095096130445364, \"y\": 0.7395049349980094}, {\"x\": 0.7157352616941468, \"y\": 0.776272746777399}, {\"x\": 0.7604134461207624, \"y\": 0.7576299126357366}, {\"x\": 0.754187797471152, \"y\": 0.7244870963838925}]','unverified','2025-11-26 08:50:28','2026-01-22 16:13:57'),(36,'B.11',1,-1,'[{\"x\": 0.7527229389653615, \"y\": 0.7162013923209315}, {\"x\": 0.7999646257771108, \"y\": 0.7011835537068146}, {\"x\": 0.8069227036796166, \"y\": 0.7400227915019444}, {\"x\": 0.7600472314943149, \"y\": 0.7586656256436067}]','unverified','2025-11-26 08:50:47','2026-01-19 13:32:05'),(38,'0.34',5,0,'[{\"x\": 0.5483821904449948, \"y\": 0.27659229970388877}, {\"x\": 0.5861755425976127, \"y\": 0.262920888000003}, {\"x\": 0.5949646942610123, \"y\": 0.3219565294486004}, {\"x\": 0.5576107996915642, \"y\": 0.33500651334776405}]','unverified','2025-11-26 08:52:04','2026-01-23 08:37:18'),(39,'0.24',4,0,'[{\"x\": 0.6569282268991601, \"y\": 0.30269225801998023}, {\"x\": 0.694282121468608, \"y\": 0.29150655753498284}, {\"x\": 0.7043896458815174, \"y\": 0.3499207711788581}, {\"x\": 0.6648384633962197, \"y\": 0.3642136106874659}]','unverified','2025-11-26 08:52:22','2026-01-23 08:27:37'),(40,'0.12',3,0,'[{\"x\": 0.7650347923589742, \"y\": 0.3325207926466399}, {\"x\": 0.8023886869284221, \"y\": 0.3219565199663646}, {\"x\": 0.8129356689245016, \"y\": 0.38037073361023993}, {\"x\": 0.7733844864392038, \"y\": 0.3927992897046815}]','unverified','2025-11-26 08:52:39','2026-01-23 08:25:32'),(41,'1.47',2,1,'[{\"x\": 0.29447801511195626, \"y\": 0.26143586394550367}, {\"x\": 0.33158776392532013, \"y\": 0.24900730732728213}, {\"x\": 0.32279861289057604, \"y\": 0.18548357350081632}, {\"x\": 0.3472129213204207, \"y\": 0.17857881982402654}, {\"x\": 0.3511192106691958, \"y\": 0.20965021136958048}, {\"x\": 0.3828578116279938, \"y\": 0.20136450695743277}, {\"x\": 0.4126432679124043, \"y\": 0.39538808527522507}, {\"x\": 0.3672326542328933, \"y\": 0.4098880679964836}, {\"x\": 0.3603966478725368, \"y\": 0.3760547749802137}, {\"x\": 0.31303288951863817, \"y\": 0.39055475770147224}]','unverified','2025-11-26 08:53:43','2026-01-19 14:13:33'),(42,'1.50',2,1,'[{\"x\": 0.2124459387876782, \"y\": 0.34153100659626495}, {\"x\": 0.2197702313166316, \"y\": 0.397459511378262}, {\"x\": 0.29936087679792517, \"y\": 0.3746738242448558}, {\"x\": 0.29154829810037486, \"y\": 0.31529294262446383}]','unverified','2025-11-26 08:54:04','2025-11-26 08:54:04'),(43,'2.12',1,2,'[{\"x\": 0.13089371371666225, \"y\": 0.4420902599918805}, {\"x\": 0.1676483447190187, \"y\": 0.4319214410185259}, {\"x\": 0.15885919382715086, \"y\": 0.37316826472803327}, {\"x\": 0.1948148111120648, \"y\": 0.36412931452949593}, {\"x\": 0.205601496297539, \"y\": 0.4392655880548375}, {\"x\": 0.1948148111120648, \"y\": 0.4420902599918805}, {\"x\": 0.20000840027544128, \"y\": 0.4872850109845671}, {\"x\": 0.21558916776557063, \"y\": 0.48050579833566415}, {\"x\": 0.22837338724465112, \"y\": 0.5595966125728659}, {\"x\": 0.15206757722888933, \"y\": 0.5804991849069834}]','unverified','2025-11-26 08:55:27','2025-11-26 08:55:27'),(44,'2.11',1,2,'[{\"x\": 0.2543413330615334, \"y\": 0.6200445575447256}, {\"x\": 0.26113294965979494, \"y\": 0.6674990460870467}, {\"x\": 0.30907377270634684, \"y\": 0.6539406207892406}, {\"x\": 0.29988511495575776, \"y\": 0.6030965259224681}]','unverified','2025-11-26 08:55:50','2026-01-19 13:29:01'),(45,'3.12',1,3,'[{\"x\": 0.11731041956023036, \"y\": 0.3895513274820236}, {\"x\": 0.12769759788698326, \"y\": 0.463557732232548}, {\"x\": 0.17443990035737136, \"y\": 0.44830450377251624}, {\"x\": 0.16285420145445464, \"y\": 0.3748630334094004}]','unverified','2025-11-26 08:56:13','2026-01-19 13:47:51'),(46,'3.14',1,3,'[{\"x\": 0.18083201009691163, \"y\": 0.4951940579274287}, {\"x\": 0.19081968156494328, \"y\": 0.5708952658401789}, {\"x\": 0.2363634634591676, \"y\": 0.5567719061549643}, {\"x\": 0.2243782576975296, \"y\": 0.48276550140443986}]','unverified','2025-11-26 08:56:31','2026-01-19 13:48:02'),(47,'4.12',1,4,'[{\"x\": 0.1608566915448119, \"y\": 0.3782526397338519}, {\"x\": 0.20480244600415112, \"y\": 0.3629994112738201}, {\"x\": 0.2155891311896253, \"y\": 0.4375707504117532}, {\"x\": 0.17204288358900732, \"y\": 0.4545187820340107}]','unverified','2025-11-26 08:56:55','2026-01-19 13:49:29'),(48,'4.14',1,4,'[{\"x\": 0.22357926836405065, \"y\": 0.48163563262962267}, {\"x\": 0.23396644669080355, \"y\": 0.5545121686053299}, {\"x\": 0.27711318743270025, \"y\": 0.540953743307524}, {\"x\": 0.26552748852978353, \"y\": 0.4692070761066338}]','unverified','2025-11-26 08:57:10','2026-01-19 13:49:47'),(50,'0.21',4,0,'[{\"x\": 0.6914346004632036, \"y\": 0.474935932308495}, {\"x\": 0.7212066375370322, \"y\": 0.46558045051154223}, {\"x\": 0.7292403618267954, \"y\": 0.526391082191735}, {\"x\": 0.6980506087018322, \"y\": 0.534410066589123}]','unverified','2025-11-26 10:11:09','2026-01-23 08:27:07'),(51,'1.44',1,1,'[{\"x\": 0.3266090213317347, \"y\": 0.4689217042071199}, {\"x\": 0.4003302559907387, \"y\": 0.44887424321364977}, {\"x\": 0.408363980280502, \"y\": 0.4976563982977604}, {\"x\": 0.33322502957036326, \"y\": 0.5197086053905776}]','unverified','2025-11-26 10:11:42','2026-01-19 13:44:17'),(52,'2.12.3',1,2,'[{\"x\": 0.195233968144308, \"y\": 0.36333838924817863}, {\"x\": 0.21413684882610387, \"y\": 0.3573241509501376}, {\"x\": 0.21791742496246305, \"y\": 0.38138110414230175}, {\"x\": 0.19806940024657735, \"y\": 0.3880635911401251}]','unverified','2025-11-26 10:12:22','2026-01-19 13:29:58'),(53,'2.12.2',1,2,'[{\"x\": 0.1971242562124876, \"y\": 0.3867270937405604}, {\"x\": 0.20090483234884676, \"y\": 0.4141252904316363}, {\"x\": 0.22264314513291203, \"y\": 0.4081110521335953}, {\"x\": 0.21791742496246305, \"y\": 0.38004460674273705}]','unverified','2025-11-26 10:12:56','2026-01-19 13:29:49'),(54,'2.12.1',1,2,'[{\"x\": 0.20279512041702635, \"y\": 0.41345704173185394}, {\"x\": 0.20515798050225084, \"y\": 0.43951874102336513}, {\"x\": 0.22500600521813652, \"y\": 0.4335045027253241}, {\"x\": 0.22169800109882223, \"y\": 0.40677455473403057}]','unverified','2025-11-26 10:13:18','2026-01-19 13:29:42'),(55,'3.11',1,3,'[{\"x\": 0.16120878291707538, \"y\": 0.3753668658442607}, {\"x\": 0.20752084058747533, \"y\": 0.35999714574926694}, {\"x\": 0.21933514101359777, \"y\": 0.4375139949240181}, {\"x\": 0.1753859434284223, \"y\": 0.44887422282031786}]','unverified','2025-11-26 10:13:48','2026-01-19 13:47:42'),(56,'B.26',1,-1,'[{\"x\": 0.611870742313474, \"y\": 0.7225237353930709}, {\"x\": 0.6336090567695639, \"y\": 0.7145047503415476}, {\"x\": 0.6481012664069572, \"y\": 0.8022680867387754}, {\"x\": 0.6178566549897886, \"y\": 0.8147420634855894}]','unverified','2025-11-27 08:20:57','2026-01-19 13:35:38'),(60,'B.15',1,-1,'[{\"x\": 0.7839127828890669, \"y\": 0.6415381474676615}, {\"x\": 0.7900725788458257, \"y\": 0.6387667105889921}, {\"x\": 0.7881126437686752, \"y\": 0.6237217675333593}, {\"x\": 0.781672857086609, \"y\": 0.6253054457497417}]','unverified','2026-01-19 11:22:56','2026-01-19 13:31:04'),(61,'B.16',1,-1,'[{\"x\": 0.7721531724261634, \"y\": 0.6451014234545218}, {\"x\": 0.7844727643396813, \"y\": 0.6415381474676615}, {\"x\": 0.7813928663613018, \"y\": 0.6257013653038374}, {\"x\": 0.7696332558983984, \"y\": 0.6292646412906977}]','unverified','2026-01-19 11:23:18','2026-01-19 13:33:18'),(62,'B.17',1,-1,'[{\"x\": 0.7547937474571155, \"y\": 0.6498524581036691}, {\"x\": 0.7724331631514706, \"y\": 0.6443095843463307}, {\"x\": 0.7699132466237056, \"y\": 0.6284728021825066}, {\"x\": 0.7531138031052721, \"y\": 0.6344115954939405}]','unverified','2026-01-19 11:23:38','2026-01-19 13:33:41'),(63,'B.18',1,-1,'[{\"x\": 0.744154099895441, \"y\": 0.6538116536446251}, {\"x\": 0.7547937474571155, \"y\": 0.6498524581036691}, {\"x\": 0.7533937938305794, \"y\": 0.6344115954939405}, {\"x\": 0.741634183367676, \"y\": 0.6375789519267054}]','unverified','2026-01-19 11:23:54','2026-01-19 13:33:59'),(64,'B.19',1,-1,'[{\"x\": 0.7214748511455558, \"y\": 0.6617300447265372}, {\"x\": 0.7435941184448265, \"y\": 0.6542075731987207}, {\"x\": 0.7410742019170615, \"y\": 0.6371830323726098}, {\"x\": 0.7181149624418691, \"y\": 0.6435177452381394}]','unverified','2026-01-19 11:24:13','2026-01-19 13:31:51'),(65,'B.13',1,-1,'[{\"x\": 0.6945957415160623, \"y\": 0.6526238949823383}, {\"x\": 0.699355583846285, \"y\": 0.6839015397558909}, {\"x\": 0.7237147769480136, \"y\": 0.674795390011692}, {\"x\": 0.7214748511455558, \"y\": 0.6633137229429196}, {\"x\": 0.7895125973952113, \"y\": 0.6415381474676615}, {\"x\": 0.7909125510217474, \"y\": 0.6522279754282426}, {\"x\": 0.7455540535219771, \"y\": 0.6664810793756843}, {\"x\": 0.7505938865775071, \"y\": 0.7013220001360974}, {\"x\": 0.7967923562531991, \"y\": 0.6878607352968469}, {\"x\": 0.7998722542315786, \"y\": 0.7017179196901929}, {\"x\": 0.7531138031052721, \"y\": 0.7151791845294434}, {\"x\": 0.754233766006501, \"y\": 0.7219098169490686}, {\"x\": 0.7094352499573452, \"y\": 0.740518035991562}, {\"x\": 0.7161550273647186, \"y\": 0.7765467154142618}, {\"x\": 0.6727564649420988, \"y\": 0.793175336686277}, {\"x\": 0.6514771698187497, \"y\": 0.6633137229429196}]','unverified','2026-01-19 11:25:33','2026-01-22 16:13:52'),(66,'B.23',1,-1,'[{\"x\": 0.6422374758836114, \"y\": 0.6652933207133975}, {\"x\": 0.6447573924113764, \"y\": 0.682713781093604}, {\"x\": 0.6539970863465148, \"y\": 0.678754585552648}, {\"x\": 0.6514771698187497, \"y\": 0.6625218838347283}]','unverified','2026-01-19 11:26:07','2026-01-19 13:35:09'),(67,'B.25',1,-1,'[{\"x\": 0.6301978746954007, \"y\": 0.6870688961886556}, {\"x\": 0.6441974109607619, \"y\": 0.6823178615395085}, {\"x\": 0.6427974573342258, \"y\": 0.6645014816052064}, {\"x\": 0.6276779581676357, \"y\": 0.668856596700258}]','unverified','2026-01-19 11:26:24','2026-01-19 13:37:11'),(68,'B.24',1,-1,'[{\"x\": 0.6495172347415992, \"y\": 0.7112199889884874}, {\"x\": 0.6551170492477437, \"y\": 0.7409139555456575}, {\"x\": 0.6397175593558463, \"y\": 0.7460609097489004}, {\"x\": 0.6352377077509308, \"y\": 0.7159710236376347}]','unverified','2026-01-19 11:26:44','2026-01-19 13:35:18'),(69,'B.22.3',1,-1,'[{\"x\": 0.6397175593558463, \"y\": 0.7472486684111872}, {\"x\": 0.643077448059533, \"y\": 0.7674405656700629}, {\"x\": 0.6587569286767376, \"y\": 0.7622936114668201}, {\"x\": 0.6553970399730509, \"y\": 0.7413098750997532}]','unverified','2026-01-19 11:27:03','2026-01-19 11:27:03'),(70,'B.22.2',1,-1,'[{\"x\": 0.6436374295101475, \"y\": 0.7674405656700629}, {\"x\": 0.6461573460379125, \"y\": 0.7860487847125562}, {\"x\": 0.6621168173804243, \"y\": 0.781297750063409}, {\"x\": 0.659316910127352, \"y\": 0.7634813701291069}]','unverified','2026-01-19 11:27:19','2026-01-19 13:37:04'),(71,'B.22.1',1,-1,'[{\"x\": 0.6461573460379125, \"y\": 0.7860487847125562}, {\"x\": 0.6489572532909847, \"y\": 0.8014896473222847}, {\"x\": 0.6646367339081893, \"y\": 0.7959467735649463}, {\"x\": 0.6621168173804243, \"y\": 0.781297750063409}]','unverified','2026-01-19 11:27:36','2026-01-19 13:36:58'),(72,'B.22',1,-1,'[{\"x\": 0.6495172347415992, \"y\": 0.7108240694343918}, {\"x\": 0.6637967617322676, \"y\": 0.7959467735649463}, {\"x\": 0.6713565113155626, \"y\": 0.7935712562403726}, {\"x\": 0.6584769379514304, \"y\": 0.7080526325557226}]','unverified','2026-01-19 11:27:53','2026-01-19 13:36:42'),(73,'4.11',1,4,'[{\"x\": 0.2049430692153777, \"y\": 0.3645921381849226}, {\"x\": 0.21532817975404564, \"y\": 0.4375853068854572}, {\"x\": 0.2431236226663628, \"y\": 0.42419602741967866}, {\"x\": 0.23884740067985247, \"y\": 0.39525790728396376}, {\"x\": 0.2541196220602465, \"y\": 0.3900749603939849}, {\"x\": 0.24892706679091256, \"y\": 0.3516347709599756}]','unverified','2026-01-19 11:28:48','2026-01-19 13:49:16'),(74,'4..11.1',1,4,'[{\"x\": 0.2385419562522446, \"y\": 0.39525790728396376}, {\"x\": 0.2431236226663628, \"y\": 0.42419602741967866}, {\"x\": 0.25992306618479627, \"y\": 0.42030881725219454}, {\"x\": 0.2544250664878544, \"y\": 0.38964304815315337}]','unverified','2026-01-19 11:29:05','2026-01-19 13:50:06'),(75,'4.13',1,4,'[{\"x\": 0.17806395958588417, \"y\": 0.4945977226752239}, {\"x\": 0.18967084783498364, \"y\": 0.5680228036165902}, {\"x\": 0.23426573426573427, \"y\": 0.5550654363916432}, {\"x\": 0.2241860681546742, \"y\": 0.48164035545027695}]','unverified','2026-01-19 11:29:25','2026-01-19 13:49:39'),(76,'4.21',1,4,'[{\"x\": 0.17256595988894233, \"y\": 0.4539979720370567}, {\"x\": 0.17653673744784476, \"y\": 0.4837999166544348}, {\"x\": 0.18753273684172847, \"y\": 0.4799127064869506}, {\"x\": 0.18386740371043392, \"y\": 0.4505426741104042}]','unverified','2026-01-19 11:29:54','2026-01-19 13:50:14'),(77,'4.23',1,4,'[{\"x\": 0.18539462584847333, \"y\": 0.46609151478034055}, {\"x\": 0.1951688475319255, \"y\": 0.4639319535761827}, {\"x\": 0.19272529211106249, \"y\": 0.4453597272204254}, {\"x\": 0.1841728481380418, \"y\": 0.4492469373879095}]','unverified','2026-01-19 11:30:08','2026-01-19 13:50:24'),(78,'4.22',1,4,'[{\"x\": 0.19730695852518068, \"y\": 0.4781850575236245}, {\"x\": 0.2064702913534171, \"y\": 0.47429784735614033}, {\"x\": 0.20249951379451464, \"y\": 0.4432001660162675}, {\"x\": 0.19272529211106249, \"y\": 0.4453597272204254}]','unverified','2026-01-19 11:30:25','2026-01-19 13:50:32'),(79,'3.13',1,3,'[{\"x\": 0.14110518384533058, \"y\": 0.5559292608733063}, {\"x\": 0.1872272924141206, \"y\": 0.54038042020337}, {\"x\": 0.18111840386196296, \"y\": 0.4950296349160555}, {\"x\": 0.13407996201034933, \"y\": 0.5079870021410025}]','unverified','2026-01-19 11:30:53','2026-01-19 13:48:12'),(80,'3.13.1',1,3,'[{\"x\": 0.1456868502594488, \"y\": 0.5848673810090212}, {\"x\": 0.1921144032558467, \"y\": 0.5688866280982533}, {\"x\": 0.18814362569694423, \"y\": 0.5408123324442015}, {\"x\": 0.1407997394177227, \"y\": 0.5550654363916432}]','unverified','2026-01-19 11:31:08','2026-01-19 13:48:27'),(81,'3.23',1,3,'[{\"x\": 0.14141062827293846, \"y\": 0.4794807942461191}, {\"x\": 0.1392725172796833, \"y\": 0.4639319535761827}, {\"x\": 0.1484358501079197, \"y\": 0.4609085678903618}, {\"x\": 0.15057396110117488, \"y\": 0.47516167183780345}]','unverified','2026-01-19 11:31:27','2026-01-19 13:48:52'),(82,'3.22',1,3,'[{\"x\": 0.15301751652203793, \"y\": 0.4911424247485714}, {\"x\": 0.16340262706070588, \"y\": 0.4876871268219189}, {\"x\": 0.15882096064658768, \"y\": 0.45615753324121455}, {\"x\": 0.14935218339074335, \"y\": 0.46004474340869866}]','unverified','2026-01-19 11:31:44','2026-01-19 13:48:58'),(83,'3.21',1,3,'[{\"x\": 0.14293785041097787, \"y\": 0.49416581043439234}, {\"x\": 0.13835618399685964, \"y\": 0.4617723923720249}, {\"x\": 0.1279710734581917, \"y\": 0.46436386581701433}, {\"x\": 0.1313309621618784, \"y\": 0.498484932842708}]','unverified','2026-01-19 11:31:59','2026-01-19 13:48:41'),(84,'2.12.4',1,2,'[{\"x\": 0.15527804391479533, \"y\": 0.5833769463467142}, {\"x\": 0.1599818880999567, \"y\": 0.6142586715661712}, {\"x\": 0.17342144291470346, \"y\": 0.6104578438468534}, {\"x\": 0.1697255653406481, \"y\": 0.5791010151624817}]','unverified','2026-01-19 12:40:13','2026-01-23 08:22:35'),(85,'2.12.5',1,2,'[{\"x\": 0.1737574317850721, \"y\": 0.6099827403819387}, {\"x\": 0.1687175987295421, \"y\": 0.5786259116975669}, {\"x\": 0.18450907563686952, \"y\": 0.5753001874431639}, {\"x\": 0.18854094208129352, \"y\": 0.6061819126626209}]','unverified','2026-01-19 12:40:31','2026-01-23 08:22:18'),(86,'2.11.2',1,2,'[{\"x\": 0.30378512461774704, \"y\": 0.6190097062153184}, {\"x\": 0.32192852361765517, \"y\": 0.6137835681012564}, {\"x\": 0.3249524234509732, \"y\": 0.6337379136276747}, {\"x\": 0.30546506896959036, \"y\": 0.6380138448119073}]','unverified','2026-01-19 12:40:56','2026-01-19 13:29:26'),(87,'2.11.1',1,2,'[{\"x\": 0.3031131468770097, \"y\": 0.6199599131451479}, {\"x\": 0.300761224784429, \"y\": 0.6061819126626209}, {\"x\": 0.33503208956203323, \"y\": 0.5952545329695822}, {\"x\": 0.342423844710144, \"y\": 0.6456155002505428}, {\"x\": 0.3266323678028165, \"y\": 0.6494163279698606}, {\"x\": 0.3226005013583925, \"y\": 0.612833361171427}]','unverified','2026-01-19 12:41:16','2026-01-19 13:29:16'),(88,'2.20',1,2,'[{\"x\": 0.7694656989487223, \"y\": 0.5154371508639088}, {\"x\": 0.8259118291706588, \"y\": 0.49880852959189353}, {\"x\": 0.8450631947816729, \"y\": 0.6313623963031012}, {\"x\": 0.7882810756893678, \"y\": 0.6465657071803723}]','unverified','2026-01-19 12:41:56','2026-01-19 13:30:22'),(89,'2.21',1,2,'[{\"x\": 0.7553541663932383, \"y\": 0.5211383924428855}, {\"x\": 0.7580420773561876, \"y\": 0.5467939795482806}, {\"x\": 0.7741695431338836, \"y\": 0.5429931518289628}, {\"x\": 0.7711456433005657, \"y\": 0.5159122543288236}]','unverified','2026-01-19 12:42:13','2026-01-19 13:30:31'),(90,'0.36',5,0,'[{\"x\": 0.5210014918255833, \"y\": 0.16326732612017394}, {\"x\": 0.5691598965784258, \"y\": 0.1502019808350191}, {\"x\": 0.578119599788257, \"y\": 0.2068184770706902}, {\"x\": 0.5291212228594928, \"y\": 0.2222593396804187}]','unverified','2026-01-19 12:45:31','2026-01-23 08:37:34'),(91,'0.35',5,0,'[{\"x\": 0.540600842597089, \"y\": 0.21909198324765383}, {\"x\": 0.5786795812388714, \"y\": 0.2068184770706902}, {\"x\": 0.5865193215474738, \"y\": 0.2658104906309349}, {\"x\": 0.5498405365322274, \"y\": 0.2784799163619942}]','unverified','2026-01-19 12:46:22','2026-01-23 08:37:26'),(92,'0.33',5,0,'[{\"x\": 0.5583422719576959, \"y\": 0.33392636908588136}, {\"x\": 0.5665892715031088, \"y\": 0.3922345215981427}, {\"x\": 0.6047698249540938, \"y\": 0.3805728910956905}, {\"x\": 0.5959119365534653, \"y\": 0.3231285630650922}]','unverified','2026-01-19 12:50:47','2026-01-23 08:37:07'),(93,'0.32',5,0,'[{\"x\": 0.5672001603583245, \"y\": 0.3918026093573112}, {\"x\": 0.5748362710485215, \"y\": 0.4492469373879095}, {\"x\": 0.6133222689271145, \"y\": 0.4393129558487835}, {\"x\": 0.6047698249540938, \"y\": 0.37970906661402737}]','unverified','2026-01-19 12:51:13','2026-01-23 08:36:59'),(94,'0.31',5,0,'[{\"x\": 0.5751417154761294, \"y\": 0.44881502514707794}, {\"x\": 0.6124059356442909, \"y\": 0.4388810436079519}, {\"x\": 0.6212638240449194, \"y\": 0.49718919612021334}, {\"x\": 0.583999603876758, \"y\": 0.5084189143818341}]','unverified','2026-01-19 12:51:46','2026-01-23 08:36:52'),(95,'0.36.1',5,0,'[{\"x\": 0.5055003859815326, \"y\": 0.16807206860656002}, {\"x\": 0.5210780517895345, \"y\": 0.1641848584390759}, {\"x\": 0.5247433849208291, \"y\": 0.19139532961146455}, {\"x\": 0.5085548302576114, \"y\": 0.19571445201978024}]','unverified','2026-01-19 12:52:12','2026-01-23 08:37:42'),(96,'0.27',4,0,'[{\"x\": 0.6133222689271145, \"y\": 0.19701018874227497}, {\"x\": 0.6402013785566081, \"y\": 0.1875081194439805}, {\"x\": 0.6447830449707262, \"y\": 0.2181738885430217}, {\"x\": 0.6166821576308013, \"y\": 0.22508448439632672}]','unverified','2026-01-19 12:52:31','2026-01-19 12:52:31'),(97,'0.26',4,0,'[{\"x\": 0.6405068229842159, \"y\": 0.1888038561664752}, {\"x\": 0.6780764875799853, \"y\": 0.1793017868681807}, {\"x\": 0.686628931553006, \"y\": 0.23631420265794745}, {\"x\": 0.6490592669572366, \"y\": 0.2458162719562419}]','unverified','2026-01-19 12:52:51','2026-01-23 08:28:01'),(98,'0.25',4,0,'[{\"x\": 0.6493647113848444, \"y\": 0.24624818419707345}, {\"x\": 0.6869343759806138, \"y\": 0.236746114898779}, {\"x\": 0.6948759310984187, \"y\": 0.2933266184477142}, {\"x\": 0.6576117109302573, \"y\": 0.30455633670933485}]','unverified','2026-01-19 12:53:42','2026-01-19 12:53:42'),(99,'0.23',4,0,'[{\"x\": 0.666164154903278, \"y\": 0.3637283137032594}, {\"x\": 0.7034283750714394, \"y\": 0.35120285871914403}, {\"x\": 0.7119808190444601, \"y\": 0.41037483571306854}, {\"x\": 0.6750220433039065, \"y\": 0.42160455397468927}]','unverified','2026-01-19 12:54:02','2026-01-23 08:27:29'),(100,'0.22',4,0,'[{\"x\": 0.6753274877315143, \"y\": 0.4224683784563524}, {\"x\": 0.7116753746168522, \"y\": 0.41037483571306854}, {\"x\": 0.7211441518726965, \"y\": 0.4665234270211721}, {\"x\": 0.6832690428493192, \"y\": 0.478616969764456}]','unverified','2026-01-19 12:54:21','2026-01-23 08:27:20'),(101,'0.15',3,0,'[{\"x\": 0.7217550407279123, \"y\": 0.22551639663715828}, {\"x\": 0.7486341503574058, \"y\": 0.21731006406135853}, {\"x\": 0.7529103723439161, \"y\": 0.24624818419707345}, {\"x\": 0.7245040405763832, \"y\": 0.25359069229121006}]','unverified','2026-01-19 12:54:51','2026-01-23 08:26:00'),(102,'0.14',3,0,'[{\"x\": 0.7498559280678373, \"y\": 0.2177419763021901}, {\"x\": 0.7868147038083909, \"y\": 0.2065122580405694}, {\"x\": 0.7941453700709801, \"y\": 0.26568423503449395}, {\"x\": 0.7571865943304265, \"y\": 0.27561821657361996}]','unverified','2026-01-19 12:55:23','2026-01-23 08:25:52'),(103,'0.13',3,0,'[{\"x\": 0.7577974831856422, \"y\": 0.2751863043327884}, {\"x\": 0.7944508144985879, \"y\": 0.26438849831199923}, {\"x\": 0.8030032584716086, \"y\": 0.3231285630650922}, {\"x\": 0.766044482731055, \"y\": 0.3334944568450498}]','unverified','2026-01-19 12:55:46','2026-01-23 08:25:40'),(104,'0.11',3,0,'[{\"x\": 0.7742914822764678, \"y\": 0.3909387848756481}, {\"x\": 0.8118611468722371, \"y\": 0.3801409788548589}, {\"x\": 0.82010814641765, \"y\": 0.4384491313671203}, {\"x\": 0.7828439262494884, \"y\": 0.44967884962874105}]','unverified','2026-01-19 12:56:06','2026-01-23 08:25:25'),(105,'0.04.4',1,0,'[{\"x\": 0.8030032584716086, \"y\": 0.4419044292937729}, {\"x\": 0.8191918131348263, \"y\": 0.43715339464462566}, {\"x\": 0.8228571462661208, \"y\": 0.4505426741104042}, {\"x\": 0.8051413694648637, \"y\": 0.45529370875955144}]','unverified','2026-01-19 13:00:51','2026-01-19 13:07:51'),(107,'0.04.3',1,0,'[{\"x\": 0.8096719296173315, \"y\": 0.4530804397181547}, {\"x\": 0.8130318183210181, \"y\": 0.48039888895075133}, {\"x\": 0.8250714195092288, \"y\": 0.4752519347475085}, {\"x\": 0.8225515029814637, \"y\": 0.45110084194767675}]','unverified','2026-01-19 13:02:16','2026-01-19 13:07:37'),(108,'0.04.5',1,0,'[{\"x\": 0.794272439725434, \"y\": 0.4609988308000668}, {\"x\": 0.7909125510217474, \"y\": 0.44753756596081634}, {\"x\": 0.8026721614846508, \"y\": 0.4427865313116691}, {\"x\": 0.805472068737723, \"y\": 0.4554559570427284}]','unverified','2026-01-19 13:02:44','2026-01-19 13:07:21'),(109,'0.04.2',1,0,'[{\"x\": 0.7945524304507413, \"y\": 0.4681253827737876}, {\"x\": 0.8107918925185603, \"y\": 0.4633743481246404}, {\"x\": 0.8135917997716325, \"y\": 0.4784192911802733}, {\"x\": 0.825351410234536, \"y\": 0.47485601519341286}, {\"x\": 0.8292712803888371, \"y\": 0.4954438320063842}, {\"x\": 0.7993122727809642, \"y\": 0.5041540621964874}]','unverified','2026-01-19 13:03:12','2026-01-19 13:03:12'),(110,'0.00',1,0,'[{\"x\": 0.8046320965618013, \"y\": 0.5021744644260094}, {\"x\": 0.8082719759907953, \"y\": 0.527513315888128}, {\"x\": 0.83907095577459, \"y\": 0.5176153270357379}, {\"x\": 0.8357110670709033, \"y\": 0.4958397515604798}]','unverified','2026-01-19 13:03:32','2026-01-19 13:07:03'),(111,'0.03',1,0,'[{\"x\": 0.8189116235524698, \"y\": 0.5239500399012675}, {\"x\": 0.8231114844320782, \"y\": 0.5524562477961509}, {\"x\": 0.8368310299721322, \"y\": 0.5473092935929081}, {\"x\": 0.832911159817831, \"y\": 0.5199908443603115}]','unverified','2026-01-19 13:03:49','2026-01-19 13:08:04'),(112,'0.02',1,0,'[{\"x\": 0.8079919852654881, \"y\": 0.5378072242946136}, {\"x\": 0.8099519203426386, \"y\": 0.5552276846748201}, {\"x\": 0.822831493706771, \"y\": 0.5516644086879597}, {\"x\": 0.8203115771790059, \"y\": 0.5346398678618488}]','unverified','2026-01-19 13:04:06','2026-01-19 13:04:06'),(113,'0.17',1,0,'[{\"x\": 0.7262346934757786, \"y\": 0.4970275102227666}, {\"x\": 0.7612335341391816, \"y\": 0.48673360181628095}, {\"x\": 0.7659933764694045, \"y\": 0.5160316488193555}, {\"x\": 0.7287546100035436, \"y\": 0.5267214767799367}]','unverified','2026-01-19 13:04:31','2026-01-19 13:04:31'),(114,'0.44',1,0,'[{\"x\": 0.714195092287568, \"y\": 0.5710644668386442}, {\"x\": 0.7014555142860893, \"y\": 0.5754195819336958}, {\"x\": 0.6989355977583243, \"y\": 0.5576032019993937}, {\"x\": 0.6692565808757585, \"y\": 0.566313432189497}, {\"x\": 0.6756963675578247, \"y\": 0.6154074568973517}, {\"x\": 0.7190949299804444, \"y\": 0.603133950720388}]','unverified','2026-01-19 13:04:58','2026-01-19 13:09:27'),(115,'0.45',1,0,'[{\"x\": 0.7018755003740501, \"y\": 0.5750236623796002}, {\"x\": 0.699355583846285, \"y\": 0.5576032019993937}, {\"x\": 0.7119551664851101, \"y\": 0.5548317651207245}, {\"x\": 0.714195092287568, \"y\": 0.5714603863927398}]','unverified','2026-01-19 13:05:14','2026-01-19 13:05:14'),(116,'0.46',1,0,'[{\"x\": 0.7111151943091885, \"y\": 0.554435845566629}, {\"x\": 0.7349144059603026, \"y\": 0.5484970522551949}, {\"x\": 0.7374343224880676, \"y\": 0.5647297539731145}, {\"x\": 0.714195092287568, \"y\": 0.5710644668386442}]','unverified','2026-01-19 13:05:28','2026-01-19 13:05:28'),(117,'0.47',1,0,'[{\"x\": 0.7343544245096881, \"y\": 0.5488929718092905}, {\"x\": 0.7371543317627604, \"y\": 0.564333834419019}, {\"x\": 0.7609535434138744, \"y\": 0.5579991215534893}, {\"x\": 0.7592735990620311, \"y\": 0.5401827416191872}]','unverified','2026-01-19 13:05:46','2026-01-19 13:05:46'),(118,'0.01',1,0,'[{\"x\": 0.7144750830128752, \"y\": 0.5710644668386442}, {\"x\": 0.7206348789696342, \"y\": 0.6134278591268737}, {\"x\": 0.7777529869323079, \"y\": 0.5995706747335275}, {\"x\": 0.7718731817008562, \"y\": 0.554435845566629}]','unverified','2026-01-19 13:06:01','2026-01-19 13:06:01'),(119,'1.01',1,1,'[{\"x\": 0.7944508144985879, \"y\": 0.5023721430101921}, {\"x\": 0.83018781252871, \"y\": 0.4911424247485714}, {\"x\": 0.8338531456600046, \"y\": 0.5157614224759707}, {\"x\": 0.796894369919451, \"y\": 0.5256954040150967}]','unverified','2026-01-19 13:10:51','2026-01-19 13:10:51'),(120,'1.27',1,1,'[{\"x\": 0.6182093797688406, \"y\": 0.5231039305701073}, {\"x\": 0.65577904436461, \"y\": 0.5123061245493181}, {\"x\": 0.6597498219235124, \"y\": 0.5429718936483593}, {\"x\": 0.6227910461829588, \"y\": 0.5529058751874854}]','unverified','2026-01-19 13:12:18','2026-01-19 13:12:18'),(121,'1.16',1,1,'[{\"x\": 0.7183951520242255, \"y\": 0.4933019859527292}, {\"x\": 0.7220604851555201, \"y\": 0.5235358428109389}, {\"x\": 0.7602410386065053, \"y\": 0.5131699490309812}, {\"x\": 0.755659372192387, \"y\": 0.4803446187277822}]','unverified','2026-01-19 13:16:24','2026-01-19 13:16:24'),(122,'1.00.1',1,1,'[{\"x\": 0.7767350376973309, \"y\": 0.5308783509050755}, {\"x\": 0.7804003708286253, \"y\": 0.5585207343182957}, {\"x\": 0.8372130343636912, \"y\": 0.5421080691666962}, {\"x\": 0.8335477012323966, \"y\": 0.5148975979943076}]','unverified','2026-01-19 13:16:47','2026-01-19 13:16:47'),(123,'1.00.2',1,1,'[{\"x\": 0.7935344812157643, \"y\": 0.553337787428317}, {\"x\": 0.7981161476298825, \"y\": 0.580116346359874}, {\"x\": 0.8414892563502016, \"y\": 0.5680228036165902}, {\"x\": 0.8369075899360834, \"y\": 0.5408123324442015}]','unverified','2026-01-19 13:17:06','2026-01-19 13:17:06'),(124,'1.00.3',1,1,'[{\"x\": 0.8042250361820401, \"y\": 0.5775248729148846}, {\"x\": 0.8421001452054173, \"y\": 0.5680228036165902}, {\"x\": 0.8460709227643198, \"y\": 0.5956651870298104}, {\"x\": 0.8081958137409425, \"y\": 0.606031080809768}]','unverified','2026-01-19 13:17:36','2026-01-19 13:17:36'),(125,'1.00.4',1,1,'[{\"x\": 0.802086925188785, \"y\": 0.6077587297730942}, {\"x\": 0.8451545894814961, \"y\": 0.5948013625481472}, {\"x\": 0.8500417003232222, \"y\": 0.622875658202199}, {\"x\": 0.8158319244311396, \"y\": 0.631945815259662}, {\"x\": 0.8136938134378844, \"y\": 0.6125097644222415}, {\"x\": 0.8026978140440008, \"y\": 0.615965062348894}]','unverified','2026-01-19 13:18:01','2026-01-19 13:18:01'),(126,'1.00.5',1,1,'[{\"x\": 0.7868147038083909, \"y\": 0.5960970992706419}, {\"x\": 0.7996433697679219, \"y\": 0.5926418013439895}, {\"x\": 0.8026978140440008, \"y\": 0.6163969745897255}, {\"x\": 0.8133883690102766, \"y\": 0.612941676663073}, {\"x\": 0.8155264800035317, \"y\": 0.6310819907779988}, {\"x\": 0.7932290367881564, \"y\": 0.638856411112967}]','unverified','2026-01-19 13:18:25','2026-01-19 13:18:25'),(127,'1.00',1,1,'[{\"x\": 0.7804003708286253, \"y\": 0.5585207343182957}, {\"x\": 0.7932290367881564, \"y\": 0.5542016119099801}, {\"x\": 0.7975052587746667, \"y\": 0.5792525218782109}, {\"x\": 0.8023923696163928, \"y\": 0.5779567851557161}, {\"x\": 0.8057522583200795, \"y\": 0.5922098891031579}, {\"x\": 0.7862038149531752, \"y\": 0.5956651870298104}]','unverified','2026-01-19 13:18:47','2026-01-19 13:18:47'),(128,'1.17',1,1,'[{\"x\": 0.6960977088088502, \"y\": 0.5727738382657374}, {\"x\": 0.7645172605930156, \"y\": 0.5520420507058222}, {\"x\": 0.7709315935727811, \"y\": 0.5978247482339683}, {\"x\": 0.7019011529333999, \"y\": 0.6172607990713886}]','unverified','2026-01-19 13:23:53','2026-01-19 13:23:53'),(129,'1.21',2,1,'[{\"x\": 0.6857125982701823, \"y\": 0.4730021106336456}, {\"x\": 0.7153407077481467, \"y\": 0.4639319535761827}, {\"x\": 0.7226713740107359, \"y\": 0.5226720183292757}, {\"x\": 0.6930432645327714, \"y\": 0.5295826141825808}]','unverified','2026-01-19 13:24:28','2026-01-19 13:59:46'),(130,'1.39',1,1,'[{\"x\": 0.4169215019752471, \"y\": 0.6384244988721354}, {\"x\": 0.4340263899212884, \"y\": 0.7580641895824792}, {\"x\": 0.4648762771096844, \"y\": 0.7494259447658479}, {\"x\": 0.45876738855752675, \"y\": 0.7153048777401542}, {\"x\": 0.4905336090287464, \"y\": 0.7079623696460176}, {\"x\": 0.4777049430692154, \"y\": 0.6215799214797043}]','unverified','2026-01-19 13:25:07','2026-01-19 13:25:07'),(131,'1.56',1,1,'[{\"x\": 0.27122451000628783, \"y\": 0.681615722955292}, {\"x\": 0.4169215019752471, \"y\": 0.6384244988721354}, {\"x\": 0.4343318343488963, \"y\": 0.7610875752683002}, {\"x\": 0.2886348423799371, \"y\": 0.8003915891839727}]','unverified','2026-01-19 13:25:31','2026-01-19 13:25:31'),(132,'1.41',1,1,'[{\"x\": 0.3912641700561851, \"y\": 0.570182364820748}, {\"x\": 0.4367753897697593, \"y\": 0.5576569098366325}, {\"x\": 0.4441060560323485, \"y\": 0.6064629930505996}, {\"x\": 0.3979839474635585, \"y\": 0.618988448034715}]','unverified','2026-01-19 13:25:57','2026-01-19 13:25:57'),(133,'1.40',1,1,'[{\"x\": 0.36774494913037825, \"y\": 0.5762291361923899}, {\"x\": 0.383628059365988, \"y\": 0.5727738382657374}, {\"x\": 0.3879042813524984, \"y\": 0.6051672563281049}, {\"x\": 0.3726320599721043, \"y\": 0.6086225542547573}]','unverified','2026-01-19 13:26:21','2026-01-19 13:26:21'),(134,'1.42',1,1,'[{\"x\": 0.3717157266892807, \"y\": 0.5066912654185077}, {\"x\": 0.4270011680863071, \"y\": 0.49157433698940295}, {\"x\": 0.43646994534215144, \"y\": 0.557224997595801}, {\"x\": 0.3808790595175171, \"y\": 0.573205750506569}]','unverified','2026-01-19 13:26:52','2026-01-19 13:26:52'),(135,'1.60',1,1,'[{\"x\": 0.3634687271438679, \"y\": 0.6125097644222415}, {\"x\": 0.3732429488273201, \"y\": 0.6090544664955889}, {\"x\": 0.3766028375310067, \"y\": 0.6267628683696831}, {\"x\": 0.3649959492819073, \"y\": 0.6289224295738409}]','unverified','2026-01-19 13:28:14','2026-01-19 13:28:14'),(136,'1.55',1,1,'[{\"x\": 0.25350873320503076, \"y\": 0.609918290977252}, {\"x\": 0.2608393994676199, \"y\": 0.6621796721178715}, {\"x\": 0.30635061918119416, \"y\": 0.6474946559295983}, {\"x\": 0.29963084177382077, \"y\": 0.5973928359931366}]','unverified','2026-01-19 13:28:44','2026-01-19 13:28:44'),(137,'1.61',1,1,'[{\"x\": 0.34850195019108177, \"y\": 0.6181246235530519}, {\"x\": 0.3637741715714758, \"y\": 0.6133735889039046}, {\"x\": 0.3649959492819073, \"y\": 0.6280586050921778}, {\"x\": 0.35125095003955265, \"y\": 0.6332415519821566}]','unverified','2026-01-19 13:38:19','2026-01-19 13:38:19'),(138,'1.62',1,1,'[{\"x\": 0.3460583947702187, \"y\": 0.6004162216789576}, {\"x\": 0.36957761569602554, \"y\": 0.5939375380664841}, {\"x\": 0.3720211711168886, \"y\": 0.6103502032180836}, {\"x\": 0.3475856169082581, \"y\": 0.6172607990713886}]','unverified','2026-01-19 13:38:44','2026-01-19 13:38:44'),(139,'1.63',1,1,'[{\"x\": 0.3433093949217478, \"y\": 0.5844354687681896}, {\"x\": 0.3674395047027704, \"y\": 0.5775248729148846}, {\"x\": 0.3698830601236334, \"y\": 0.5948013625481472}, {\"x\": 0.34544750591500295, \"y\": 0.5999843094381261}]','unverified','2026-01-19 13:39:03','2026-01-19 13:39:03'),(140,'1.43',1,1,'[{\"x\": 0.33414606209351133, \"y\": 0.5179209836801285}, {\"x\": 0.37293750439971224, \"y\": 0.507555089900171}, {\"x\": 0.38148994837273287, \"y\": 0.5736376627474005}, {\"x\": 0.34392028377696354, \"y\": 0.5835716442865265}]','unverified','2026-01-19 13:39:25','2026-01-19 13:39:25'),(141,'1.54',1,1,'[{\"x\": 0.28222050940017157, \"y\": 0.5110103878268234}, {\"x\": 0.3188738407131173, \"y\": 0.4993487573243712}, {\"x\": 0.33231339552786404, \"y\": 0.5874588544540106}, {\"x\": 0.29413284207687895, \"y\": 0.5973928359931366}]','unverified','2026-01-19 13:39:49','2026-01-19 13:39:49'),(142,'1.52.1',1,1,'[{\"x\": 0.2483161779356968, \"y\": 0.5783886973965477}, {\"x\": 0.28955117566276073, \"y\": 0.5662951546532639}, {\"x\": 0.29413284207687895, \"y\": 0.5982566604747998}, {\"x\": 0.2532032887774229, \"y\": 0.6103502032180836}]','unverified','2026-01-19 13:40:28','2026-01-19 13:40:28'),(143,'1.54.1',1,1,'[{\"x\": 0.31795750743029366, \"y\": 0.5913460646214947}, {\"x\": 0.32528817369288276, \"y\": 0.6405840600762932}, {\"x\": 0.3399495062180611, \"y\": 0.6362649376679775}, {\"x\": 0.33231339552786404, \"y\": 0.5874588544540106}]','unverified','2026-01-19 13:40:56','2026-01-19 13:40:56'),(145,'1.54.2',1,1,'[{\"x\": 0.2987145084909971, \"y\": 0.5956651870298104}, {\"x\": 0.3036016193327232, \"y\": 0.6280586050921778}, {\"x\": 0.322233729416804, \"y\": 0.6237394826838621}, {\"x\": 0.3188738407131173, \"y\": 0.5909141523806631}]','unverified','2026-01-19 13:41:43','2026-01-19 13:41:43'),(146,'1.52',1,1,'[{\"x\": 0.2321276232724791, \"y\": 0.4704106371886562}, {\"x\": 0.27427895428236665, \"y\": 0.4578851822045408}, {\"x\": 0.2898566200903686, \"y\": 0.5658632424124324}, {\"x\": 0.2483161779356968, \"y\": 0.5783886973965477}]','unverified','2026-01-19 13:43:47','2026-01-19 13:43:47'),(147,'1.53',1,1,'[{\"x\": 0.2736680654271509, \"y\": 0.4578851822045408}, {\"x\": 0.31123773002292027, \"y\": 0.44622355170208855}, {\"x\": 0.31979017399594095, \"y\": 0.498484932842708}, {\"x\": 0.28222050940017157, \"y\": 0.5118742123084866}]','unverified','2026-01-19 13:44:03','2026-01-19 13:44:03'),(148,'1.45',1,1,'[{\"x\": 0.3143683365488518, \"y\": 0.3901292306169541}, {\"x\": 0.3616867691257727, \"y\": 0.3774598048858947}, {\"x\": 0.37372637031398337, \"y\": 0.4570396352591108}, {\"x\": 0.32612794701175524, \"y\": 0.47050090009836126}]','unverified','2026-01-19 13:45:22','2026-01-19 13:45:22'),(149,'1.46',1,1,'[{\"x\": 0.3661666207306883, \"y\": 0.4095292887676385}, {\"x\": 0.4126450811316875, \"y\": 0.39567210437429245}, {\"x\": 0.4190848678137537, \"y\": 0.4431824508657647}, {\"x\": 0.37372637031398337, \"y\": 0.4570396352591108}]','unverified','2026-01-19 13:45:54','2026-01-19 13:45:54'),(150,'1.42.1',1,1,'[{\"x\": 0.3997655077675552, \"y\": 0.44912124417719873}, {\"x\": 0.4185248863631392, \"y\": 0.4435783704198603}, {\"x\": 0.42664461739704873, \"y\": 0.49148463646542817}, {\"x\": 0.40732525735085023, \"y\": 0.4970275102227666}]','unverified','2026-01-19 13:46:56','2026-01-19 13:46:56'),(151,'0.38',2,0,'[{\"x\": 0.5366254117832346, \"y\": 0.5211383924428855}, {\"x\": 0.5581286994868295, \"y\": 0.5149620473989941}, {\"x\": 0.5665284212460462, \"y\": 0.5738748770484198}, {\"x\": 0.5446891446720827, \"y\": 0.5795761186273964}]','unverified','2026-01-19 13:52:29','2026-01-19 13:52:29'),(152,'0.30',2,0,'[{\"x\": 0.5920635753940651, \"y\": 0.5059350815656144}, {\"x\": 0.6212946071161393, \"y\": 0.49690811573223465}, {\"x\": 0.629694328875356, \"y\": 0.5539205315220014}, {\"x\": 0.5997913194125445, \"y\": 0.5619972904255517}]','unverified','2026-01-19 13:53:18','2026-01-19 13:53:18'),(153,'0.42',2,0,'[{\"x\": 0.44691638339480005, \"y\": 0.5748250839782492}, {\"x\": 0.46606774900581416, \"y\": 0.56484791121504}, {\"x\": 0.46942763770950086, \"y\": 0.5876528775309466}, {\"x\": 0.4717795598020816, \"y\": 0.5862275671362025}, {\"x\": 0.47749137059834895, \"y\": 0.6218603270048068}, {\"x\": 0.45363616080217345, \"y\": 0.6294619824434423}]','unverified','2026-01-19 13:54:23','2026-01-19 13:54:23'),(154,'1.31',2,1,'[{\"x\": 0.5853437979866917, \"y\": 0.5016591503813819}, {\"x\": 0.6152468074495032, \"y\": 0.49263218454800217}, {\"x\": 0.6229745514679826, \"y\": 0.551069910732513}, {\"x\": 0.5940795086162771, \"y\": 0.5600968765658928}]','unverified','2026-01-19 13:55:53','2026-01-19 13:55:53'),(155,'1.37',2,1,'[{\"x\": 0.5295696455054927, \"y\": 0.5187628751183119}, {\"x\": 0.5517449109498248, \"y\": 0.5125865300744205}, {\"x\": 0.5601446327090415, \"y\": 0.5719744631887609}, {\"x\": 0.537297389523972, \"y\": 0.5772006013028228}]','unverified','2026-01-19 13:56:15','2026-01-19 13:56:15'),(156,'1.02',2,1,'[{\"x\": 0.7855931647264185, \"y\": 0.4446467345916152}, {\"x\": 0.8154961741892299, \"y\": 0.43371935489857655}, {\"x\": 0.8252398514299214, \"y\": 0.49310728801291687}, {\"x\": 0.7933209087448978, \"y\": 0.5016591503813819}]','unverified','2026-01-19 13:56:37','2026-01-19 13:56:37'),(157,'1.14',2,1,'[{\"x\": 0.7425865893192288, \"y\": 0.21327134717814525}, {\"x\": 0.7795453650597824, \"y\": 0.20329417441493605}, {\"x\": 0.7886170645597365, \"y\": 0.26030659020470276}, {\"x\": 0.7509863110784455, \"y\": 0.2707588664328267}]','unverified','2026-01-19 13:57:21','2026-01-19 13:57:21'),(158,'1.13',2,1,'[{\"x\": 0.7509863110784455, \"y\": 0.27028376296791196}, {\"x\": 0.7882810756893678, \"y\": 0.2588812798099586}, {\"x\": 0.7970167863189532, \"y\": 0.3187443163892137}, {\"x\": 0.7600580105783996, \"y\": 0.330146799547167}]','unverified','2026-01-19 13:57:36','2026-01-19 13:57:36'),(159,'1.12',2,1,'[{\"x\": 0.7600580105783996, \"y\": 0.32872148915242283}, {\"x\": 0.7966807974485846, \"y\": 0.3173190059944695}, {\"x\": 0.8057524969485386, \"y\": 0.3767069391088098}, {\"x\": 0.7681217434672476, \"y\": 0.3881094222667631}]','unverified','2026-01-19 13:57:53','2026-01-19 13:57:53'),(160,'1.11',2,1,'[{\"x\": 0.7674497657265104, \"y\": 0.38763431880184845}, {\"x\": 0.8054165080781699, \"y\": 0.3752816287140657}, {\"x\": 0.8141522187077553, \"y\": 0.434669561828406}, {\"x\": 0.7761854763560957, \"y\": 0.4460720449863594}]','unverified','2026-01-19 13:58:08','2026-01-19 13:58:08'),(161,'1.15',2,1,'[{\"x\": 0.7150355019489979, \"y\": 0.22039789915186608}, {\"x\": 0.7412426338377541, \"y\": 0.21184603678340108}, {\"x\": 0.7466184557636528, \"y\": 0.2417775550730286}, {\"x\": 0.719067368393422, \"y\": 0.24937921051166417}]','unverified','2026-01-19 13:58:34','2026-01-19 13:58:34'),(162,'1.03',2,1,'[{\"x\": 0.7765214652264644, \"y\": 0.44559694152144463}, {\"x\": 0.780889320541257, \"y\": 0.4750533563461574}, {\"x\": 0.7896250311708425, \"y\": 0.4736280459514132}, {\"x\": 0.7852571758560498, \"y\": 0.4408459068722974}]','unverified','2026-01-19 13:58:55','2026-01-19 13:58:55'),(163,'1.22',2,1,'[{\"x\": 0.668607710324141, \"y\": 0.4172854315663736}, {\"x\": 0.706788263775126, \"y\": 0.4056238010639213}, {\"x\": 0.714729818892931, \"y\": 0.4647957780578459}, {\"x\": 0.6771601542971616, \"y\": 0.4760254963194666}]','unverified','2026-01-19 14:00:04','2026-01-19 14:00:04'),(164,'1.23',2,1,'[{\"x\": 0.6600552663511203, \"y\": 0.3589772790541122}, {\"x\": 0.6979303753744975, \"y\": 0.3473156485516599}, {\"x\": 0.7061773749199103, \"y\": 0.4064876255455844}, {\"x\": 0.668607710324141, \"y\": 0.4172854315663736}]','unverified','2026-01-19 14:00:17','2026-01-19 14:00:17'),(165,'1.24',2,1,'[{\"x\": 0.6511973779504917, \"y\": 0.2993733898193561}, {\"x\": 0.6887670425462611, \"y\": 0.28943940828023007}, {\"x\": 0.697014042091674, \"y\": 0.3490432975149862}, {\"x\": 0.6600552663511203, \"y\": 0.35940919129494375}]','unverified','2026-01-19 14:00:33','2026-01-19 14:00:33'),(166,'1.25',2,1,'[{\"x\": 0.6423394895498632, \"y\": 0.24279288627042092}, {\"x\": 0.6792982652904168, \"y\": 0.23285890473129492}, {\"x\": 0.6878507092634375, \"y\": 0.2898713205210616}, {\"x\": 0.6515028223780996, \"y\": 0.3002372143010192}]','unverified','2026-01-19 14:00:52','2026-01-19 14:00:52'),(167,'1.26',2,1,'[{\"x\": 0.6218747129001352, \"y\": 0.1875081194439805}, {\"x\": 0.6713567101726119, \"y\": 0.17282310325570724}, {\"x\": 0.6792982652904168, \"y\": 0.23242699249046336}, {\"x\": 0.6298162680179401, \"y\": 0.24668009643790503}]','unverified','2026-01-19 14:01:11','2026-01-19 14:01:11'),(168,'1.26.1',2,1,'[{\"x\": 0.6056861582369175, \"y\": 0.19225915409312772}, {\"x\": 0.622485601755351, \"y\": 0.1857804704806542}, {\"x\": 0.6267618237418613, \"y\": 0.21601432733886383}, {\"x\": 0.6102678246510357, \"y\": 0.21990153750634792}]','unverified','2026-01-19 14:01:28','2026-01-19 14:01:28'),(169,'1.36.1',2,1,'[{\"x\": 0.49798669169083776, \"y\": 0.16338548336209938}, {\"x\": 0.5252017901906999, \"y\": 0.15483362099363435}, {\"x\": 0.5305776121165986, \"y\": 0.18666555314292077}, {\"x\": 0.5020185581352617, \"y\": 0.19284189818681216}]','unverified','2026-01-19 14:02:41','2026-01-19 14:02:41'),(170,'1.36',2,1,'[{\"x\": 0.5248658013203312, \"y\": 0.15483362099363435}, {\"x\": 0.5299056343758612, \"y\": 0.18571534621309133}, {\"x\": 0.5178100350425893, \"y\": 0.18809086353766497}, {\"x\": 0.5295696455054927, \"y\": 0.2750347976170592}, {\"x\": 0.579967976060793, \"y\": 0.2612567971345322}, {\"x\": 0.5635045214127282, \"y\": 0.14438134476551046}]','unverified','2026-01-19 14:02:59','2026-01-19 14:02:59'),(171,'1.35',2,1,'[{\"x\": 0.542337222579502, \"y\": 0.2712339698977414}, {\"x\": 0.579967976060793, \"y\": 0.2607816936696175}, {\"x\": 0.5927355531348024, \"y\": 0.3482007312139265}, {\"x\": 0.5561127662646175, \"y\": 0.3591281109069651}]','unverified','2026-01-19 14:03:18','2026-01-19 14:03:18'),(172,'1.34',2,1,'[{\"x\": 0.5557767773942488, \"y\": 0.3577028005122209}, {\"x\": 0.5923995642644337, \"y\": 0.34725052428409703}, {\"x\": 0.6014712637643878, \"y\": 0.4071135608633521}, {\"x\": 0.5645124880238342, \"y\": 0.417565837091476}]','unverified','2026-01-19 14:03:36','2026-01-19 14:03:36'),(173,'1.33',2,1,'[{\"x\": 0.5645124880238342, \"y\": 0.4156654232318171}, {\"x\": 0.5682083655978896, \"y\": 0.4465471484512741}, {\"x\": 0.6055031302088119, \"y\": 0.43561976875823544}, {\"x\": 0.6007992860236505, \"y\": 0.40616335393352265}]','unverified','2026-01-19 14:03:51','2026-01-19 14:03:51'),(174,'1.32',2,1,'[{\"x\": 0.5692163322089956, \"y\": 0.4460720449863594}, {\"x\": 0.576944076227475, \"y\": 0.5045097711708703}, {\"x\": 0.6145748297087659, \"y\": 0.49453259840766106}, {\"x\": 0.6055031302088119, \"y\": 0.434669561828406}]','unverified','2026-01-19 14:04:08','2026-01-19 14:04:08'),(175,'1.38',2,1,'[{\"x\": 0.4650597823947082, \"y\": 0.5838520498116289}, {\"x\": 0.4922748808945704, \"y\": 0.576725497837908}, {\"x\": 0.49496279185751973, \"y\": 0.5943043260397528}, {\"x\": 0.4670757156169202, \"y\": 0.6009557745485589}]','unverified','2026-01-19 14:04:59','2026-01-19 14:04:59'),(176,'0.41',2,0,'[{\"x\": 0.4063463835260457, \"y\": 0.24611194625392052}, {\"x\": 0.5113429055162547, \"y\": 0.21582410036560695}, {\"x\": 0.5533415143123384, \"y\": 0.5020739379767274}, {\"x\": 0.44876497841009017, \"y\": 0.532361783865041}]','unverified','2026-01-19 14:06:19','2026-01-19 14:06:19'),(177,'0.41.2',2,0,'[{\"x\": 0.44400404236609664, \"y\": 0.5572072824452982}, {\"x\": 0.464443365313524, \"y\": 0.5516644086879597}, {\"x\": 0.4666832911159818, \"y\": 0.5667093517435926}, {\"x\": 0.44680394961916886, \"y\": 0.5742318232714091}]','unverified','2026-01-19 14:06:48','2026-01-19 14:06:48'),(178,'0.41.1',2,0,'[{\"x\": 0.4641633745882168, \"y\": 0.5512684891338641}, {\"x\": 0.4689232169184396, \"y\": 0.5872971685565639}, {\"x\": 0.4711631427208974, \"y\": 0.5869012490024683}, {\"x\": 0.4739630499739696, \"y\": 0.5999665942876232}, {\"x\": 0.5008421596034631, \"y\": 0.5908604445434243}, {\"x\": 0.4930024192948609, \"y\": 0.5437460176060477}]','unverified','2026-01-19 14:07:16','2026-01-19 14:07:16'),(179,'1.51',2,1,'[{\"x\": 0.2214114157468534, \"y\": 0.3968598630365793}, {\"x\": 0.3000888095581834, \"y\": 0.3738965288990343}, {\"x\": 0.30792854986678564, \"y\": 0.424970151377367}, {\"x\": 0.2527703769812625, \"y\": 0.4408069335411911}, {\"x\": 0.24745055320042525, \"y\": 0.4012149781316309}, {\"x\": 0.2236513415493112, \"y\": 0.4095292887676385}]','unverified','2026-01-19 14:07:59','2026-01-19 14:07:59'),(180,'1.51.1',2,1,'[{\"x\": 0.228411183879534, \"y\": 0.4324926229051835}, {\"x\": 0.25025046045349747, \"y\": 0.4261579100396538}, {\"x\": 0.2527703769812625, \"y\": 0.4392232553248087}, {\"x\": 0.2298111375060701, \"y\": 0.447933485514912}]','unverified','2026-01-19 14:09:39','2026-01-19 14:09:39'),(181,'1.49',2,1,'[{\"x\": 0.23597093346282905, \"y\": 0.2808554336865678}, {\"x\": 0.2844093289409788, \"y\": 0.26501865152274373}, {\"x\": 0.2928090507001956, \"y\": 0.31807187177155444}, {\"x\": 0.21245171253702225, \"y\": 0.34261888412548175}, {\"x\": 0.21077176818517887, \"y\": 0.3291576192862313}, {\"x\": 0.2424107201448952, \"y\": 0.31846779132565}]','unverified','2026-01-19 14:10:22','2026-01-19 14:10:22'),(182,'1.49.1',2,1,'[{\"x\": 0.21077176818517887, \"y\": 0.2883779052143843}, {\"x\": 0.23597093346282905, \"y\": 0.2808554336865678}, {\"x\": 0.2424107201448952, \"y\": 0.32005146954203245}, {\"x\": 0.21749154559255224, \"y\": 0.32717802151575326}]','unverified','2026-01-19 14:10:41','2026-01-19 14:10:41'),(183,'1.47.1',2,1,'[{\"x\": 0.3465672699591826, \"y\": 0.17989594739218925}, {\"x\": 0.3510471215640982, \"y\": 0.2103817530575506}, {\"x\": 0.3835260456997362, \"y\": 0.20325520108382977}, {\"x\": 0.3787662033695134, \"y\": 0.16999795853979918}]','unverified','2026-01-19 14:11:08','2026-01-19 14:11:08'),(184,'1.47.2',2,1,'[{\"x\": 0.2855292918422077, \"y\": 0.19810824688058695}, {\"x\": 0.32276805830806854, \"y\": 0.18583474070362327}, {\"x\": 0.3280878820889058, \"y\": 0.22027974190994068}, {\"x\": 0.290849115623045, \"y\": 0.23294916764099993}]','unverified','2026-01-19 14:11:29','2026-01-19 14:11:29'),(185,'1.47.4',2,1,'[{\"x\": 0.31268839219700845, \"y\": 0.2258226156672791}, {\"x\": 0.3280878820889058, \"y\": 0.22107158101813187}, {\"x\": 0.33200775224320694, \"y\": 0.24918186935891964}, {\"x\": 0.3177282252525385, \"y\": 0.25432882356216246}]','unverified','2026-01-19 14:11:47','2026-01-19 14:11:47'),(186,'1.47.3',2,1,'[{\"x\": 0.290849115623045, \"y\": 0.2317614089787131}, {\"x\": 0.2944889950520389, \"y\": 0.2630390537522657}, {\"x\": 0.3174482345272313, \"y\": 0.25314106489987565}, {\"x\": 0.31352836437293014, \"y\": 0.2254266961131835}]','unverified','2026-01-19 14:12:06','2026-01-19 14:12:06'),(187,'1.48',2,1,'[{\"x\": 0.1950922875679743, \"y\": 0.2242389374508967}, {\"x\": 0.20433198150311271, \"y\": 0.2883779052143843}, {\"x\": 0.2841293382156716, \"y\": 0.26501865152274373}, {\"x\": 0.27992947733606327, \"y\": 0.23294916764099993}, {\"x\": 0.26033012656455756, \"y\": 0.238887960952434}, {\"x\": 0.25585027495964197, \"y\": 0.2072143966247858}]','unverified','2026-01-19 14:12:28','2026-01-19 14:12:28'),(188,'1.48.1',2,1,'[{\"x\": 0.2550103027837203, \"y\": 0.2072143966247858}, {\"x\": 0.2754496257311477, \"y\": 0.20087968375925616}, {\"x\": 0.279649486610756, \"y\": 0.23334508719509556}, {\"x\": 0.260890108015172, \"y\": 0.238887960952434}]','unverified','2026-01-19 14:12:42','2026-01-19 14:12:42'),(189,'1.51.2',2,1,'[{\"x\": 0.22326973487185056, \"y\": 0.40864718674974226}, {\"x\": 0.227240512430753, \"y\": 0.43326618447714155}, {\"x\": 0.25198151106699135, \"y\": 0.4272194131054996}, {\"x\": 0.2467889557976574, \"y\": 0.4017365908964372}]','unverified','2026-01-22 15:42:50','2026-01-22 15:42:50'),(190,'1.48.2',2,1,'[{\"x\": 0.18905995897976788, \"y\": 0.1875081194439805}, {\"x\": 0.19455795867670975, \"y\": 0.22638022111882145}, {\"x\": 0.2287677345687924, \"y\": 0.2142866783755376}, {\"x\": 0.22388062372706632, \"y\": 0.18275708479483324}]','unverified','2026-01-22 15:43:20','2026-01-22 15:43:20'),(191,'0.29',4,0,'[{\"x\": 0.6261509348866455, \"y\": 0.5252634917742651}, {\"x\": 0.6609715996339439, \"y\": 0.5148975979943076}, {\"x\": 0.66585871047567, \"y\": 0.5451314548525171}, {\"x\": 0.6292053791627243, \"y\": 0.5542016119099801}]','unverified','2026-01-23 08:28:36','2026-01-23 08:28:36'),(192,'0.28',4,0,'[{\"x\": 0.6579180502145866, \"y\": 0.48722695469814226}, {\"x\": 0.6713576050293334, \"y\": 0.4830697993801384}, {\"x\": 0.6730375493811768, \"y\": 0.49554126533414994}, {\"x\": 0.65959799456643, \"y\": 0.5020739379767274}]','unverified','2026-01-23 08:36:22','2026-01-23 08:36:22'),(193,'S.00',1,0,'[{\"x\": 0.6324378004978585, \"y\": 0.6561871709691987}, {\"x\": 0.746674016423206, \"y\": 0.6221380893169769}, {\"x\": 0.7682333022718623, \"y\": 0.7389343577751796}, {\"x\": 0.6537170956212075, \"y\": 0.7836732673879826}]','unverified','2026-01-23 08:39:07','2026-01-23 08:39:07');
/*!40000 ALTER TABLE `spaces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('administrator','zone_responsible') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'administrator',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Administrador','admin@institut.cat','$2y$12$rzCJJGcllb5C4uwlQXihPOePjKw6291Ri75ngEhsGcJhIcACQqW3C','administrator','2025-11-17 09:28:06','2026-01-02 18:02:02'),(2,'usuari1','usuari1@gmail.com','$2y$12$GVh9gmFjQks1QRz2KKPNXO2YSyVMCkvXmznHxNjix0PrH2he2I/ke','administrator','2026-01-02 16:44:22','2026-01-02 16:44:22');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zones`
--

DROP TABLE IF EXISTS `zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zones` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zones`
--

LOCK TABLES `zones` WRITE;
/*!40000 ALTER TABLE `zones` DISABLE KEYS */;
INSERT INTO `zones` VALUES (1,'Plaça al C/ Ramon Saera','2025-11-17 08:07:24','2025-11-17 08:07:24'),(2,'Zona de la Llar d\'infants. C/ Concòrdia','2025-11-17 08:09:51','2025-11-17 08:09:51'),(3,'Parc 1. Darrera de la UPC','2025-11-17 08:10:37','2025-11-17 08:10:37'),(4,'Parc 2. Darrera de la UPC','2025-11-17 08:10:43','2025-11-17 08:10:43'),(5,'Parc 3. Darrera de la UPC','2025-11-17 08:10:50','2025-11-17 08:10:50');
/*!40000 ALTER TABLE `zones` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-23  9:51:00
