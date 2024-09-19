-- MySQL dump 10.13  Distrib 8.0.39, for Linux (x86_64)
--
-- Host: localhost    Database: programacoes_filmes
-- ------------------------------------------------------
-- Server version	8.0.39-0ubuntu0.22.04.1

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
-- Table structure for table `canal`
--

DROP TABLE IF EXISTS `canal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `canal` (
  `num_canal` int NOT NULL,
  `nome` varchar(50) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `sigla` varchar(25) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `imagem_url` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`num_canal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canal`
--

LOCK TABLES `canal` WRITE;
/*!40000 ALTER TABLE `canal` DISABLE KEYS */;
INSERT INTO `canal` VALUES (1,'Home Box Ofice','HBO','https://marcasmais.com.br/wp-content/uploads/2020/07/hbo_max_followup_logo.jpg'),(2,'Telecine','TC','https://gkpb.com.br/wp-content/uploads/2019/07/novo-logo-telecine-seu-momento-cinema-versao-negativa-1024x1024.jpg'),(3,'Cinemax','MAX','https://logowik.com/content/uploads/images/cinemax7120.jpg'),(4,'Cinecanal','CC','https://i.pinimg.com/originals/1f/1f/23/1f1f2398e2763d3df283c7747d2f4925.jpg'),(5,'Megapix','MP','https://imagem.natelinha.uol.com.br/grande/megapix.jpg'),(6,'Paramount Channel','PC','https://logowik.com/content/uploads/images/paramount6544.jpg'),(7,'Discovery Kids','Dk','https://imagem.natelinha.uol.com.br/grande/discoverykids-logo-grande.jpg'),(8,'Turner Network Television','TNT','https://www.bastidoresdatv.com.br/wp-content/uploads/2017/01/dc58f76e15a157a4e7e807824d5f6d8d.png'),(9,'American Movie Classics','AMC','https://seeklogo.com/images/A/amc-logo-36BD2C5A01-seeklogo.com.png'),(10,'Canal Brasil','CB','https://www.escoladarcyribeiro.org.br/wp-content/uploads/2018/02/logo-CB.png'),(11,'AXN','AXN','https://cdn.mitvstatic.com/channels/co_axn_m.png'),(12,'Star Channel','Star','https://static.poder360.com.br/2021/02/star_sem_channel.png');
/*!40000 ALTER TABLE `canal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exibicao`
--

DROP TABLE IF EXISTS `exibicao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exibicao` (
  `num_filme` int NOT NULL,
  `num_canal` int NOT NULL,
  `data` datetime NOT NULL,
  PRIMARY KEY (`num_filme`,`num_canal`,`data`),
  KEY `num_canal` (`num_canal`),
  CONSTRAINT `exibicao_ibfk_1` FOREIGN KEY (`num_filme`) REFERENCES `filme` (`num_filme`),
  CONSTRAINT `exibicao_ibfk_2` FOREIGN KEY (`num_canal`) REFERENCES `canal` (`num_canal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exibicao`
--

LOCK TABLES `exibicao` WRITE;
/*!40000 ALTER TABLE `exibicao` DISABLE KEYS */;
INSERT INTO `exibicao` VALUES (1,1,'2024-09-25 08:00:00'),(2,1,'2024-09-26 17:00:00'),(4,1,'2024-09-28 11:00:00'),(5,1,'2024-09-29 16:00:00'),(7,1,'2024-09-25 10:00:00'),(8,1,'2024-09-26 17:00:00'),(10,1,'2024-09-28 11:00:00'),(11,1,'2024-09-29 16:00:00'),(1,2,'2024-09-25 12:00:00'),(2,2,'2024-09-26 21:00:00'),(4,2,'2024-09-28 15:00:00'),(5,2,'2024-09-29 20:00:00'),(7,2,'2024-09-25 14:00:00'),(8,2,'2024-09-26 21:00:00'),(10,2,'2024-09-28 15:00:00'),(11,2,'2024-09-29 20:00:00'),(1,3,'2024-09-25 16:00:00'),(3,3,'2024-09-27 10:00:00'),(4,3,'2024-09-28 19:00:00'),(6,3,'2024-09-30 09:00:00'),(7,3,'2024-09-25 18:00:00'),(9,3,'2024-09-27 10:00:00'),(10,3,'2024-09-28 19:00:00'),(12,3,'2024-09-30 09:00:00'),(1,4,'2024-09-25 20:00:00'),(3,4,'2024-09-27 14:00:00'),(4,4,'2024-09-28 23:00:00'),(6,4,'2024-09-30 13:00:00'),(7,4,'2024-09-25 22:00:00'),(9,4,'2024-09-27 14:00:00'),(10,4,'2024-09-28 23:00:00'),(12,4,'2024-09-30 13:00:00'),(2,5,'2024-09-26 09:00:00'),(3,5,'2024-09-27 18:00:00'),(5,5,'2024-09-29 08:00:00'),(6,5,'2024-09-30 17:00:00'),(8,5,'2024-09-26 09:00:00'),(9,5,'2024-09-27 18:00:00'),(11,5,'2024-09-29 08:00:00'),(12,5,'2024-09-30 17:00:00'),(2,6,'2024-09-26 13:00:00'),(3,6,'2024-09-27 22:00:00'),(5,6,'2024-09-29 12:00:00'),(6,6,'2024-09-30 21:00:00'),(8,6,'2024-09-26 13:00:00'),(9,6,'2024-09-27 22:00:00'),(11,6,'2024-09-29 12:00:00'),(12,6,'2024-09-30 21:00:00'),(13,7,'2024-09-25 08:00:00'),(14,7,'2024-09-26 17:00:00'),(16,7,'2024-09-28 11:00:00'),(17,7,'2024-09-29 16:00:00'),(19,7,'2024-09-25 10:00:00'),(20,7,'2024-09-26 17:00:00'),(13,8,'2024-09-25 12:00:00'),(14,8,'2024-09-26 21:00:00'),(16,8,'2024-09-28 15:00:00'),(17,8,'2024-09-29 20:00:00'),(19,8,'2024-09-25 14:00:00'),(20,8,'2024-09-26 21:00:00'),(13,9,'2024-09-25 16:00:00'),(15,9,'2024-09-27 10:00:00'),(16,9,'2024-09-28 19:00:00'),(18,9,'2024-09-30 09:00:00'),(19,9,'2024-09-25 18:00:00'),(21,9,'2024-09-27 10:00:00'),(13,10,'2024-09-25 20:00:00'),(15,10,'2024-09-27 14:00:00'),(16,10,'2024-09-28 23:00:00'),(18,10,'2024-09-30 13:00:00'),(19,10,'2024-09-25 22:00:00'),(21,10,'2024-09-27 14:00:00'),(14,11,'2024-09-26 09:00:00'),(15,11,'2024-09-27 18:00:00'),(17,11,'2024-09-29 08:00:00'),(18,11,'2024-09-30 17:00:00'),(20,11,'2024-09-26 09:00:00'),(21,11,'2024-09-27 18:00:00'),(14,12,'2024-09-26 13:00:00'),(15,12,'2024-09-27 22:00:00'),(17,12,'2024-09-29 12:00:00'),(18,12,'2024-09-30 21:00:00'),(20,12,'2024-09-26 13:00:00'),(21,12,'2024-09-27 22:00:00');
/*!40000 ALTER TABLE `exibicao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filme`
--

DROP TABLE IF EXISTS `filme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `filme` (
  `num_filme` int NOT NULL,
  `titulo_original` varchar(80) COLLATE utf8mb3_unicode_ci NOT NULL,
  `titulo_brasil` varchar(80) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `ano_lancamento` year NOT NULL,
  `pais_origem` varchar(30) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `categoria` varchar(25) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `duracao` int NOT NULL,
  `imagem_url` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`num_filme`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filme`
--

ALTER TABLE filme ADD COLUMN classificacao varchar(5);

UPDATE filme
SET classificacao = 16
WHERE num_filme = 1;

UPDATE filme
SET classificacao = CASE num_filme
    WHEN 2 THEN 'livre'
    WHEN 3 THEN '16'
    WHEN 4 THEN '18'
	WHEN 5 THEN '18'
	WHEN 6 THEN '18'
	WHEN 7 THEN 'livre'
	WHEN 8 THEN '16'
	WHEN 9 THEN '10'
	WHEN 10 THEN '10'
	WHEN 11 THEN '10'
	WHEN 12 THEN 'livre'
	WHEN 13 THEN '18'
	WHEN 14 THEN '18'
	WHEN 15 THEN '18'
	WHEN 16 THEN '14'
	WHEN 17 THEN '16'
  WHEN 18 THEN '16'
  WHEN 19 THEN '16'
  WHEN 20 THEN '10'
  WHEN 21 THEN '18'
    -- Adicione mais condições conforme necessário
    ELSE classificacao -- Mantém o valor atual para registros não especificados
END;

SET SQL_SAFE_UPDATES = 0;

SET SQL_SAFE_UPDATES = 1;

DELIMITER //

CREATE TRIGGER trigger_alerta_classificacao
BEFORE INSERT ON exibicao
FOR EACH ROW 
BEGIN
    DECLARE classificacao varchar(5);

    -- Seleciona a classificação do filme correspondente
    SELECT classificacao INTO classificacao
    FROM filme
    WHERE filme.num_filme = NEW.num_filme;
    
    -- Verifica se a classificação é maior que 18
    IF classificacao > 18 THEN
        -- Gera um sinal de erro com uma mensagem personalizada
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Alerta: Filme com classificação indicativa para maiores de 18 anos.';
    END IF;
END;
//

DELIMITER ;


LOCK TABLES `filme` WRITE;
/*!40000 ALTER TABLE `filme` DISABLE KEYS */;
INSERT INTO `filme` VALUES (1,'50 First Dates','Como se fosse a primeira vez',2004,'Estados Unidos','comédia romântica',99,'https://br.web.img3.acsta.net/c_310_420/pictures/20/11/23/14/35/4981975.jpg'),(2,'Paranormal Activity','Atividade Paranormal',2007,'Estados Unidos','Terror',86,'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/89/84/20028680.jpg'),(3,'My Sister\'s Keeper','Uma prova de amor',2004,'Estados Unidos','Drama',107,'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/29/38/19874004.jpg'),(4,'Life in a year','A vida em um ano',2021,'Estados Unidos','Romance',107,'https://br.web.img3.acsta.net/c_310_420/pictures/20/12/02/15/57/1426320.jpg'),(5,'The Internship','Os estagiários',2013,'Estados Unidos','Comédia',120,'https://br.web.img3.acsta.net/c_310_420/pictures/210/068/21006856_20130517195500909.jpg'),(6,'Jojo Rabbit','Jojo Rabbit',2019,'Estados Unidos','Drama',108,'https://br.web.img2.acsta.net/c_310_420/pictures/20/01/28/22/54/2304385.jpg'),(7,'Harry Potter and The Chamber of Secrets','Harry Potter e a Câmara Secreta',2002,'Londres','Fantasia',158,'https://br.web.img2.acsta.net/c_310_420/medias/nmedia/18/93/01/50/20230712.jpg'),(8,'Superbad - É hoje!','Superbad',2007,'Estados Unidos','Comédia',112,'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/21/42/19873179.jpg'),(9,'The Conjuring','Invocação do Mal',2013,'Estados Unidos','Terror',110,'https://br.web.img3.acsta.net/c_310_420/pictures/210/166/21016629_2013062820083878.jpg'),(10,'Remember the Titans','Duelo de Titãs',2001,'Estados Unidos','Drama',114,'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/94/62/13/20343423.jpg'),(11,'Minha Mãe é uma Peça','Minha Mãe é uma Peça',2013,'Brasil','Comédia',85,'https://br.web.img3.acsta.net/c_310_420/pictures/210/016/21001687_20130426011958954.jpg'),(12,'The Imitation Game','O Jogo Da Imitação',2014,'Estados Unidos','Ficção Científica',115,'https://br.web.img3.acsta.net/c_310_420/pictures/14/10/30/19/02/198128.jpg'),(13,'John Wick: Chapter 4','John Wick 4: Baba Yaga',2023,'Estados Unidos','Ação',170,'https://br.web.img2.acsta.net/c_310_420/pictures/22/12/05/09/07/2007563.jpg'),(14,'Inside Out 2','Divertida Mente 2',2024,'Estados Unidos','Animação',96,'https://br.web.img2.acsta.net/c_310_420/pictures/23/11/09/18/04/2076862.jpg'),(15,'The Lion King','O Rei Leão',2019,'Estados Unidos','Fantasia',108,'https://br.web.img3.acsta.net/c_310_420/pictures/19/05/07/20/54/2901026.jpg'),(16,'Ice Age','A Era do gelo',2002,'Estados Unidos','Animação',81,'https://br.web.img2.acsta.net/c_310_420/medias/nmedia/18/90/29/80/20109874.jpg'),(17,'The Dark Knight','Batman - O Cavaleiro Das Trevas',2008,'Estados Unidos','Ação',152,'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/86/98/32/19870786.jpg'),(18,'Avengers: Endgame','Vingadores: Ultimato',2019,'Estados Unidos','Fantasia',241,'https://br.web.img2.acsta.net/c_310_420/pictures/19/04/26/17/30/2428965.jpg'),(19,'Rio','Rio',2011,'Estados Unidos','Animação',90,'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/32/32/19874310.jpg'),(20,'O Auto da Compadecida','O Auto da Compadecida',2000,'Brasil','Comédia',95,'https://br.web.img2.acsta.net/c_310_420/medias/nmedia/18/87/87/75/19962458.jpg'),(21,'1917','1917',2020,'Estados Unidos','Ação',119,'https://br.web.img3.acsta.net/c_310_420/pictures/19/10/04/19/42/5605017.jpg');





/*!40000 ALTER TABLE `filme` ENABLE KEYS */;
UNLOCK TABLES;



/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-16 17:54:18
