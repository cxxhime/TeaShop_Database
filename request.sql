CREATE DATABASE  IF NOT EXISTS `projet_revendeur_the` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `projet_revendeur_the`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: projet_revendeur_the
-- ------------------------------------------------------
-- Server version	8.0.41

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

--
-- Table structure for table `adresses`
--

DROP TABLE IF EXISTS `adresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adresses` (
  `adresse_id` int NOT NULL AUTO_INCREMENT,
  `adresse` varchar(255) NOT NULL,
  `adresse2` varchar(255) DEFAULT NULL,
  `code_postal` varchar(10) NOT NULL,
  `ville` varchar(50) NOT NULL,
  `pays` varchar(50) NOT NULL,
  PRIMARY KEY (`adresse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `client_id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) DEFAULT NULL,
  `mail` varchar(80) DEFAULT NULL,
  `tel` varchar(20) DEFAULT NULL,
  `type_client` enum('personne_physique','personne_morale') NOT NULL,
  `adresse_id` int NOT NULL,
  PRIMARY KEY (`client_id`),
  KEY `adresse_id` (`adresse_id`),
  CONSTRAINT `clients_ibfk_1` FOREIGN KEY (`adresse_id`) REFERENCES `adresses` (`adresse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `produits`
--

DROP TABLE IF EXISTS `produits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produits` (
  `produit_id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `prix_gramme` decimal(10,2) NOT NULL,
  PRIMARY KEY (`produit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `suivi_fidelisation_clients`
--

DROP TABLE IF EXISTS `suivi_fidelisation_clients`;
/*!50001 DROP VIEW IF EXISTS `suivi_fidelisation_clients`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `suivi_fidelisation_clients` AS SELECT 
 1 AS `nom`,
 1 AS `prenom`,
 1 AS `sum(vente_produits.quantite * produits.prix_gramme)`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `suivi_quotidient_ventes`
--

DROP TABLE IF EXISTS `suivi_quotidient_ventes`;
/*!50001 DROP VIEW IF EXISTS `suivi_quotidient_ventes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `suivi_quotidient_ventes` AS SELECT 
 1 AS `date_vente`,
 1 AS `count(ventes.vente_id)`,
 1 AS `sum(vente_produits.quantite * produits.prix_gramme)`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `vente_produits`
--

DROP TABLE IF EXISTS `vente_produits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vente_produits` (
  `vente_produit_id` int NOT NULL AUTO_INCREMENT,
  `vente_id` int NOT NULL,
  `produit_id` int NOT NULL,
  `quantite` int NOT NULL,
  PRIMARY KEY (`vente_produit_id`),
  KEY `vente_id` (`vente_id`),
  KEY `produit_id` (`produit_id`),
  CONSTRAINT `vente_produits_ibfk_1` FOREIGN KEY (`vente_id`) REFERENCES `ventes` (`vente_id`),
  CONSTRAINT `vente_produits_ibfk_2` FOREIGN KEY (`produit_id`) REFERENCES `produits` (`produit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3530 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ventes`
--

DROP TABLE IF EXISTS `ventes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventes` (
  `vente_id` int NOT NULL AUTO_INCREMENT,
  `client_id` int NOT NULL,
  `date_vente` date NOT NULL,
  PRIMARY KEY (`vente_id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `ventes_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `suivi_fidelisation_clients`
--

/*!50001 DROP VIEW IF EXISTS `suivi_fidelisation_clients`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `suivi_fidelisation_clients` AS select `clients`.`nom` AS `nom`,`clients`.`prenom` AS `prenom`,sum((`vente_produits`.`quantite` * `produits`.`prix_gramme`)) AS `sum(vente_produits.quantite * produits.prix_gramme)` from (((`ventes` join `vente_produits` on((`ventes`.`vente_id` = `vente_produits`.`vente_id`))) join `produits` on((`vente_produits`.`produit_id` = `produits`.`produit_id`))) join `clients` on((`ventes`.`client_id` = `clients`.`client_id`))) where (`ventes`.`date_vente` >= (curdate() - interval 6 month)) group by `clients`.`client_id` order by sum((`vente_produits`.`quantite` * `produits`.`prix_gramme`)) desc limit 5 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `suivi_quotidient_ventes`
--

/*!50001 DROP VIEW IF EXISTS `suivi_quotidient_ventes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `suivi_quotidient_ventes` AS select `ventes`.`date_vente` AS `date_vente`,count(`ventes`.`vente_id`) AS `count(ventes.vente_id)`,sum((`vente_produits`.`quantite` * `produits`.`prix_gramme`)) AS `sum(vente_produits.quantite * produits.prix_gramme)` from ((`ventes` join `vente_produits` on((`ventes`.`vente_id` = `vente_produits`.`vente_id`))) join `produits` on((`vente_produits`.`produit_id` = `produits`.`produit_id`))) group by `ventes`.`date_vente` order by `ventes`.`date_vente` */;
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

-- Dump completed on 2025-02-18 17:21:56
