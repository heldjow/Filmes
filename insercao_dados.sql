USE programacoes_filmes;
-- Exemplo de inserção de dados

INSERT INTO canal (num_canal, nome, sigla) VALUES
(1, 'Home Box Ofice', 'HBO'),
(2, 'Telecine', 'TC'),
(3, 'Cinemax', 'MAX'),
(4, 'Cinecanal', 'CC'),
(5, 'Megapix', 'MP'),
(6, 'Paramount Channel', 'PC'),
(7, 'CineBrasilTV', 'CBT'),
(8, 'Turner Network Television', 'TNT'),
(9, 'American Movie Classics', 'AMC'),
(10, 'Canal Brasil', 'CB'),
(11, 'AXN', 'AXN'),
(12, 'Star Channel', 'Star');
INSERT INTO filme VALUES (1, '50 First Dates', 'Como se fosse a primeira vez', 2004, 'Estados Unidos',
'comédia romântica', 99, 'https://br.web.img3.acsta.net/c_310_420/pictures/20/11/23/14/35/4981975.jpg'),(2,'Paranormal Activity','Atividade Paranormal',2007,'Estados Unidos','Terror',86,'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/89/84/20028680.jpg'),(3,'My Sister\'s Keeper','Uma prova de amor',2004,'Estados Unidos','Drama',107,'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/29/38/19874004.jpg'),(4,'Life in a year','A vida em um ano',2021,'Estados Unidos','Romance',107,'https://br.web.img3.acsta.net/c_310_420/pictures/20/12/02/15/57/1426320.jpg'),(5,'The Internship','Os estagiários',2013,'Estados Unidos','Comédia',120,'https://br.web.img3.acsta.net/c_310_420/pictures/210/068/21006856_20130517195500909.jpg'),(6,'Jojo Rabbit','Jojo Rabbit',2019,'Estados Unidos','Drama',108,'https://br.web.img2.acsta.net/c_310_420/pictures/20/01/28/22/54/2304385.jpg');
INSERT INTO exibicao VALUES (1, 1, '2024-09-10');

