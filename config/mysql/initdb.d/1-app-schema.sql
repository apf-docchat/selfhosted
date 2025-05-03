-- MySQL dump 10.13  Distrib 8.0.41, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: app
-- ------------------------------------------------------
-- Server version	8.4.4

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
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alembic_version` (
                                   `version_num` varchar(32) NOT NULL,
                                   PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collections`
--

DROP TABLE IF EXISTS `collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collections` (
                               `collection_id` int NOT NULL AUTO_INCREMENT,
                               `collection_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                               `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
                               `sharing_level` enum('ORG','PRIVATE','LIMITED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ORG',
                               `shared_with` json DEFAULT NULL,
                               `user_id` int DEFAULT NULL,
                               `metatadata_prompt_prelude` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
                               `metatadata_prompt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
                               `custom_instructions` mediumtext COLLATE utf8mb4_unicode_ci,
                               `collection_rule` json DEFAULT NULL,
                               `defaul_module` int NOT NULL DEFAULT '1',
                               `org_id` int DEFAULT NULL,
                               `module_id` int DEFAULT NULL,
                               `type` enum('file','db','file-db','googlesheet') COLLATE utf8mb4_unicode_ci DEFAULT 'file-db',
                               `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                               `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                               `credential_id` int DEFAULT NULL,
                               PRIMARY KEY (`collection_id`),
                               KEY `fk_user_id` (`user_id`),
                               KEY `fk_collections_credential` (`credential_id`),
                               CONSTRAINT `fk_collections_credential` FOREIGN KEY (`credential_id`) REFERENCES `collections_credentials` (`id`),
                               CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=237 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collections_credentials`
--

DROP TABLE IF EXISTS `collections_credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collections_credentials` (
                                           `id` int NOT NULL AUTO_INCREMENT,
                                           `service_type` varchar(50) NOT NULL,
                                           `credentials_json` json NOT NULL,
                                           `description` varchar(255) DEFAULT NULL,
                                           `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                                           `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                           PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collections_faq`
--

DROP TABLE IF EXISTS `collections_faq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collections_faq` (
                                   `faq_id` int NOT NULL AUTO_INCREMENT,
                                   `collection_id` int DEFAULT NULL,
                                   `query` text NOT NULL,
                                   `script` text,
                                   `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                                   `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                   `user_id` int DEFAULT NULL,
                                   PRIMARY KEY (`faq_id`),
                                   KEY `collection_id` (`collection_id`),
                                   CONSTRAINT `collections_faq_ibfk_1` FOREIGN KEY (`collection_id`) REFERENCES `collections` (`collection_id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collections_insights`
--

DROP TABLE IF EXISTS `collections_insights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collections_insights` (
                                        `id` int NOT NULL AUTO_INCREMENT,
                                        `collection_id` int NOT NULL,
                                        `query` varchar(2000) DEFAULT NULL,
                                        `script` text,
                                        `order_number` int DEFAULT NULL,
                                        `title` varchar(45) DEFAULT NULL,
                                        `creator_user_id` int DEFAULT NULL,
                                        `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                        `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                        `updater_user_id` int DEFAULT NULL,
                                        `is_active` tinyint(1) NOT NULL DEFAULT '1',
                                        `file_path_uuid` varchar(36) DEFAULT NULL,
                                        PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docchat_faq`
--

DROP TABLE IF EXISTS `docchat_faq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docchat_faq` (
                               `faq_id` int NOT NULL AUTO_INCREMENT,
                               `faq_question` text NOT NULL,
                               `faq_answer` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                               `collection_id` int NOT NULL,
                               `org_id` int NOT NULL,
                               PRIMARY KEY (`faq_id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docchat_metadata`
--

DROP TABLE IF EXISTS `docchat_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docchat_metadata` (
                                    `org_id` int NOT NULL,
                                    `collection_id` int NOT NULL,
                                    `file_id` int NOT NULL,
                                    `schema_id` int NOT NULL,
                                    `field` varchar(256) NOT NULL,
                                    `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                    PRIMARY KEY (`org_id`,`collection_id`,`file_id`,`schema_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docchat_metadata_schema`
--

DROP TABLE IF EXISTS `docchat_metadata_schema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docchat_metadata_schema` (
                                           `schema_id` int NOT NULL AUTO_INCREMENT,
                                           `org_id` int NOT NULL,
                                           `collection_id` int NOT NULL,
                                           `field` varchar(256) NOT NULL,
                                           `description` text NOT NULL,
                                           `order_number` int NOT NULL,
                                           PRIMARY KEY (`schema_id`),
                                           UNIQUE KEY `uq_docchat_metadata_schema_collection_id_field` (`collection_id`,`field`),
                                           UNIQUE KEY `uq_docchat_metadata_schema_collection_id_order_number` (`collection_id`,`order_number`)
) ENGINE=InnoDB AUTO_INCREMENT=369 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docguide_faq`
--

DROP TABLE IF EXISTS `docguide_faq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docguide_faq` (
                                `faq_id` int NOT NULL AUTO_INCREMENT,
                                `faq_title` varchar(256) NOT NULL,
                                `faq_content` text NOT NULL,
                                `file_id` int NOT NULL,
                                `org_id` int NOT NULL,
                                PRIMARY KEY (`faq_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docguide_files`
--

DROP TABLE IF EXISTS `docguide_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docguide_files` (
                                  `file_id` int NOT NULL AUTO_INCREMENT,
                                  `file_name` varchar(255) NOT NULL,
                                  `file_path` varchar(255) DEFAULT NULL,
                                  `org_id` int NOT NULL,
                                  `upload_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                  `doc_file_id` int NOT NULL,
                                  PRIMARY KEY (`file_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docguide_sections`
--

DROP TABLE IF EXISTS `docguide_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docguide_sections` (
                                     `section_id` int NOT NULL AUTO_INCREMENT,
                                     `section_title` varchar(64) NOT NULL,
                                     `section_content` text NOT NULL,
                                     `order_number` int NOT NULL,
                                     `file_id` int NOT NULL,
                                     `org_id` int NOT NULL,
                                     PRIMARY KEY (`section_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docguide_sections_learned_status`
--

DROP TABLE IF EXISTS `docguide_sections_learned_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docguide_sections_learned_status` (
                                                    `org_id` int NOT NULL,
                                                    `user_id` int NOT NULL,
                                                    `section_id` int NOT NULL,
                                                    `learned_status` enum('INITIAL','PARTIAL','FULL') NOT NULL,
                                                    `assessment_score` int NOT NULL DEFAULT '0',
                                                    PRIMARY KEY (`org_id`,`user_id`,`section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docguide_sessions`
--

DROP TABLE IF EXISTS `docguide_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docguide_sessions` (
                                     `user_id` int NOT NULL,
                                     `file_id` int DEFAULT NULL,
                                     `section_id` int DEFAULT NULL,
                                     `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                     `platform` enum('WEB','WHATSAPP','TELEGRAM') NOT NULL,
                                     `thread_id` varchar(36) DEFAULT NULL,
                                     `stage_id` enum('INITIAL_CHAT','CONVERSATION','TIMED_OUT','COMPLETED','CONTINUE_SECTION','ASSESS_ME') DEFAULT NULL,
                                     PRIMARY KEY (`user_id`),
                                     KEY `idx_file` (`file_id`),
                                     KEY `idx_section` (`section_id`),
                                     KEY `idx_updated_at` (`updated_at`),
                                     KEY `idx_platform` (`platform`),
                                     CONSTRAINT `docguide_sessions_ibfk_1` FOREIGN KEY (`file_id`) REFERENCES `docguide_files` (`file_id`) ON DELETE SET NULL ON UPDATE CASCADE,
                                     CONSTRAINT `docguide_sessions_ibfk_2` FOREIGN KEY (`section_id`) REFERENCES `docguide_sections` (`section_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entities`
--

DROP TABLE IF EXISTS `entities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entities` (
                            `id` bigint NOT NULL AUTO_INCREMENT,
                            `type` varchar(50) NOT NULL,
                            `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
                            `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                            `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                            PRIMARY KEY (`id`),
                            CONSTRAINT `entities_chk_1` CHECK (json_valid(`data`))
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entity_configurations`
--

DROP TABLE IF EXISTS `entity_configurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entity_configurations` (
                                         `id` bigint NOT NULL AUTO_INCREMENT,
                                         `type` varchar(50) NOT NULL,
                                         `config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
                                         `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                         `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                         PRIMARY KEY (`id`),
                                         UNIQUE KEY `uq_entity_configurations_type` (`type`),
                                         CONSTRAINT `entity_configurations_chk_1` CHECK (json_valid(`config`))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `files` (
                         `file_id` int NOT NULL AUTO_INCREMENT,
                         `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                         `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                         `upload_datetime` datetime DEFAULT CURRENT_TIMESTAMP,
                         `collection_id` int DEFAULT NULL,
                         `file_url` text COLLATE utf8mb4_unicode_ci,
                         PRIMARY KEY (`file_id`),
                         KEY `fk_collection_id` (`collection_id`),
                         CONSTRAINT `fk_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `collections` (`collection_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1175 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `files_bm25_meta`
--

DROP TABLE IF EXISTS `files_bm25_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `files_bm25_meta` (
                                   `file_id` int NOT NULL,
                                   `avg_doc_len` float NOT NULL,
                                   PRIMARY KEY (`file_id`),
                                   CONSTRAINT `files_bm25_meta_ibfk_1` FOREIGN KEY (`file_id`) REFERENCES `files` (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `files_bm25_terms`
--

DROP TABLE IF EXISTS `files_bm25_terms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `files_bm25_terms` (
                                    `id` int NOT NULL AUTO_INCREMENT,
                                    `file_id` int NOT NULL,
                                    `term` varchar(255) NOT NULL,
                                    `idf` float NOT NULL,
                                    PRIMARY KEY (`id`),
                                    KEY `file_id` (`file_id`),
                                    CONSTRAINT `files_bm25_terms_ibfk_1` FOREIGN KEY (`file_id`) REFERENCES `files` (`file_id`)
) ENGINE=InnoDB AUTO_INCREMENT=391741 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `files_collections`
--

DROP TABLE IF EXISTS `files_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `files_collections` (
                                     `file_id` int NOT NULL,
                                     `collection_id` int NOT NULL,
                                     PRIMARY KEY (`file_id`,`collection_id`),
                                     KEY `collection_id` (`collection_id`),
                                     CONSTRAINT `files_collections_ibfk_1` FOREIGN KEY (`file_id`) REFERENCES `files` (`file_id`),
                                     CONSTRAINT `files_collections_ibfk_2` FOREIGN KEY (`collection_id`) REFERENCES `collections` (`collection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `files_metadata`
--

DROP TABLE IF EXISTS `files_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `files_metadata` (
                                  `id` int NOT NULL AUTO_INCREMENT,
                                  `file_id` int NOT NULL,
                                  `file_name` varchar(300) NOT NULL,
                                  `title` varchar(255) DEFAULT NULL,
                                  `summary_short` varchar(500) DEFAULT NULL,
                                  `summary_long` varchar(4000) DEFAULT NULL,
                                  `questions` text,
                                  `sections` text,
                                  `file_description` text,
                                  `training` tinyint(1) DEFAULT NULL,
                                  `handout` tinyint(1) DEFAULT NULL,
                                  `media` tinyint(1) DEFAULT NULL,
                                  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1413 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `files_metadata_plus`
--

DROP TABLE IF EXISTS `files_metadata_plus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `files_metadata_plus` (
                                       `id` int NOT NULL AUTO_INCREMENT,
                                       `file_id` int NOT NULL,
                                       `metadata` text NOT NULL,
                                       PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1513 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `files_pages`
--

DROP TABLE IF EXISTS `files_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `files_pages` (
                               `id` int NOT NULL AUTO_INCREMENT,
                               `file_id` int NOT NULL,
                               `page_number` int NOT NULL,
                               `tokens` text NOT NULL,
                               PRIMARY KEY (`id`),
                               KEY `file_id` (`file_id`),
                               CONSTRAINT `files_pages_ibfk_1` FOREIGN KEY (`file_id`) REFERENCES `files` (`file_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8349 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
                        `id` int NOT NULL AUTO_INCREMENT,
                        `steps` text,
                        `order_number` int DEFAULT NULL,
                        `title` varchar(255) DEFAULT NULL,
                        `creator_username` varchar(50) DEFAULT NULL,
                        `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                        `updater_username` varchar(50) DEFAULT NULL,
                        `is_active` tinyint(1) DEFAULT '1',
                        `org_id` int DEFAULT NULL,
                        `job_collection_id` int DEFAULT NULL,
                        `query` varchar(1000) DEFAULT NULL,
                        `file_path_uuid` varchar(200) DEFAULT NULL,
                        `api_endpoint` varchar(300) DEFAULT NULL,
                        PRIMARY KEY (`id`),
                        KEY `fk_jobs_job_collection_id` (`job_collection_id`),
                        CONSTRAINT `fk_jobs_job_collection_id` FOREIGN KEY (`job_collection_id`) REFERENCES `collections` (`collection_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jobs_run`
--

DROP TABLE IF EXISTS `jobs_run`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs_run` (
                            `id` bigint NOT NULL AUTO_INCREMENT,
                            `job_id` int NOT NULL,
                            `status` varchar(50) DEFAULT NULL,
                            `start_time` timestamp NULL DEFAULT NULL,
                            `end_time` timestamp NULL DEFAULT NULL,
                            `input_params` json DEFAULT NULL,
                            `schedule_info` json DEFAULT NULL,
                            `user_id` bigint DEFAULT NULL,
                            `context_specific_config` json DEFAULT NULL,
                            `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                            `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                            `is_active` tinyint(1) NOT NULL DEFAULT '1',
                            PRIMARY KEY (`id`),
                            KEY `job_id` (`job_id`),
                            CONSTRAINT `jobs_run_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_ai_calls`
--

DROP TABLE IF EXISTS `log_ai_calls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_ai_calls` (
                                `id` int NOT NULL AUTO_INCREMENT,
                                `timestamp_start` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                `username` varchar(255) DEFAULT NULL,
                                `user_content` text,
                                `system_content` text,
                                `response` text,
                                `timestamp_end` timestamp NULL DEFAULT NULL,
                                PRIMARY KEY (`id`),
                                KEY `username` (`username`),
                                KEY `ix_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=12821 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `modules`
--

DROP TABLE IF EXISTS `modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modules` (
                           `id` int NOT NULL AUTO_INCREMENT,
                           `name` varchar(150) NOT NULL,
                           `button_text` varchar(150) NOT NULL,
                           `description` text,
                           `form_action` varchar(100) NOT NULL,
                           `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                           `updated_at` timestamp NULL DEFAULT NULL,
                           PRIMARY KEY (`id`),
                           UNIQUE KEY `uq_modules_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `organization`
--

DROP TABLE IF EXISTS `organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organization` (
                                `org_id` int NOT NULL AUTO_INCREMENT,
                                `org_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
                                `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                `created_by_user_id` int DEFAULT NULL,
                                `admin_user_id` int DEFAULT NULL,
                                `status` enum('ACTIVE','INACTIVE','SUSPENDED') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'ACTIVE',
                                `logo_url` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                `home_module_function_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                `vector_provider` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                `clientid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                PRIMARY KEY (`org_id`),
                                UNIQUE KEY `uq_organization_org_name` (`org_name`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `organization_collections`
--

DROP TABLE IF EXISTS `organization_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organization_collections` (
                                            `org_id` int NOT NULL,
                                            `collection_id` int NOT NULL,
                                            PRIMARY KEY (`org_id`,`collection_id`),
                                            UNIQUE KEY `uq_organization_collections_org_id_collection_id` (`org_id`,`collection_id`),
                                            KEY `collection_id` (`collection_id`),
                                            CONSTRAINT `organization_collections_ibfk_1` FOREIGN KEY (`org_id`) REFERENCES `organization` (`org_id`),
                                            CONSTRAINT `organization_collections_ibfk_2` FOREIGN KEY (`collection_id`) REFERENCES `collections` (`collection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `organization_modules`
--

DROP TABLE IF EXISTS `organization_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organization_modules` (
                                        `org_id` int NOT NULL,
                                        `module_id` int NOT NULL,
                                        `subscribed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                        PRIMARY KEY (`org_id`,`module_id`),
                                        KEY `module_id` (`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `organization_popupbot`
--

DROP TABLE IF EXISTS `organization_popupbot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organization_popupbot` (
                                         `id` int NOT NULL AUTO_INCREMENT,
                                         `org_id` int NOT NULL,
                                         `allowed_domains` text,
                                         `url_slug` varchar(255) NOT NULL,
                                         `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                                         `chat_mode` varchar(100) DEFAULT NULL,
                                         PRIMARY KEY (`id`),
                                         UNIQUE KEY `url_slug` (`url_slug`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prompts`
--

DROP TABLE IF EXISTS `prompts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prompts` (
                           `id` int NOT NULL AUTO_INCREMENT,
                           `prompt_type` varchar(300) NOT NULL,
                           `prompt_name` varchar(300) NOT NULL,
                           `name_label` varchar(300) NOT NULL,
                           `prompt_text` text NOT NULL,
                           `description` text,
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prompts_archive`
--

DROP TABLE IF EXISTS `prompts_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prompts_archive` (
                                   `id` int NOT NULL AUTO_INCREMENT,
                                   `datetime_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                   `prompt_id` int NOT NULL,
                                   `prompt_type` varchar(300) NOT NULL,
                                   `prompt_name` varchar(300) NOT NULL,
                                   `name_label` varchar(300) NOT NULL,
                                   `prompt_text` text NOT NULL,
                                   `description` text,
                                   PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_organization`
--

DROP TABLE IF EXISTS `user_organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_organization` (
                                     `user_id` int NOT NULL DEFAULT '0',
                                     `org_id` int NOT NULL DEFAULT '0',
                                     `role` enum('MEMBER','ADMIN','GUEST','SUPER_USER') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'MEMBER',
                                     `join_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                     PRIMARY KEY (`user_id`,`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_role_current`
--

DROP TABLE IF EXISTS `user_role_current`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_role_current` (
                                     `id` int NOT NULL AUTO_INCREMENT,
                                     `user_id` int NOT NULL,
                                     `user_role_id` int NOT NULL,
                                     `selected_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                                     `is_primary` tinyint(1) DEFAULT '0',
                                     PRIMARY KEY (`id`),
                                     KEY `user_role_id` (`user_role_id`),
                                     KEY `user_id` (`user_id`),
                                     CONSTRAINT `user_role_current_ibfk_1` FOREIGN KEY (`user_role_id`) REFERENCES `user_roles` (`id`),
                                     CONSTRAINT `user_role_current_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_role_history`
--

DROP TABLE IF EXISTS `user_role_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_role_history` (
                                     `id` int NOT NULL AUTO_INCREMENT,
                                     `user_id` int NOT NULL,
                                     `user_role_id` int NOT NULL,
                                     `started_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                                     `ended_at` timestamp NULL DEFAULT NULL,
                                     PRIMARY KEY (`id`),
                                     KEY `user_role_id` (`user_role_id`),
                                     KEY `user_id` (`user_id`),
                                     CONSTRAINT `user_role_history_ibfk_1` FOREIGN KEY (`user_role_id`) REFERENCES `user_roles` (`id`),
                                     CONSTRAINT `user_role_history_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
                              `id` int NOT NULL AUTO_INCREMENT,
                              `user_id` int NOT NULL,
                              `role_name` varchar(100) NOT NULL,
                              `details` varchar(300) DEFAULT NULL,
                              `objectives` varchar(300) DEFAULT NULL,
                              `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                              `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                              `is_active` tinyint(1) DEFAULT '1',
                              PRIMARY KEY (`id`),
                              KEY `ix_user_roles_user_id_role_name` (`user_id`,`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
                         `id` int NOT NULL AUTO_INCREMENT,
                         `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                         `password_hash` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                         `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                         `first_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                         `last_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                         `date_of_birth` date DEFAULT NULL,
                         `date_joined` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         `last_login` timestamp NULL DEFAULT NULL,
                         `is_active` tinyint(1) DEFAULT '1',
                         `is_admin` tinyint(1) DEFAULT '0',
                         `profile_picture_url` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                         `phone_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                         PRIMARY KEY (`id`),
                         UNIQUE KEY `uq_users_email` (`email`),
                         UNIQUE KEY `uq_users_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-30 22:33:10
