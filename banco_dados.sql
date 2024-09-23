create database programacoes_filmes;
use programacoes_filmes;

CREATE TABLE canal (
num_canal int PRIMARY KEY,
nome varchar(50),
sigla varchar(25),
imagem_url varchar(255)
);

CREATE TABLE filme (
num_filme int PRIMARY KEY,
titulo_original varchar(80) NOT NULL,
titulo_brasil varchar(80),
ano_lancamento year NOT NULL,
pais_origem varchar(30),
categoria varchar(25),
duracao int NOT NULL,
imagem_url varchar(255),
classificacao int
);

CREATE TABLE exibicao (
num_filme int,
num_canal int,
data datetime,
PRIMARY KEY (num_filme, num_canal, data),
FOREIGN KEY (num_filme) REFERENCES filme (num_filme)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (num_canal) REFERENCES canal (num_canal)
ON DELETE CASCADE
ON UPDATE CASCADE
);

INSERT INTO canal (num_canal,nome,sigla,imagem_url)
VALUES
(1,'Home Box Ofice','HBO','https://marcasmais.com.br/wp-content/uploads/2020/07/hbo_max_followup_logo.jpg'),
(2,'Telecine','TC','https://gkpb.com.br/wp-content/uploads/2019/07/novo-logo-telecine-seu-momento-cinema-versao-negativa-1024x1024.jpg'),
(3,'Cinemax','MAX','https://logowik.com/content/uploads/images/cinemax7120.jpg'),
(4,'Cinecanal','CC','https://i.pinimg.com/originals/1f/1f/23/1f1f2398e2763d3df283c7747d2f4925.jpg'),
(5,'Megapix','MP','https://imagem.natelinha.uol.com.br/grande/megapix.jpg'),
(6,'Paramount Channel','PC','https://logowik.com/content/uploads/images/paramount6544.jpg'),
(7,'Discovery Kids','Dk','https://imagem.natelinha.uol.com.br/grande/discoverykids-logo-grande.jpg'),
(8,'Turner Network Television','TNT','https://www.bastidoresdatv.com.br/wp-content/uploads/2017/01/dc58f76e15a157a4e7e807824d5f6d8d.png'),
(9,'American Movie Classics','AMC','https://seeklogo.com/images/A/amc-logo-36BD2C5A01-seeklogo.com.png'),
(10,'Canal Brasil','CB','https://www.escoladarcyribeiro.org.br/wp-content/uploads/2018/02/logo-CB.png'),
(11,'AXN','AXN','https://cdn.mitvstatic.com/channels/co_axn_m.png'),
(12,'Star Channel','Star','https://static.poder360.com.br/2021/02/star_sem_channel.png');

INSERT INTO filme (num_filme,titulo_original,titulo_brasil,ano_lancamento,pais_origem,categoria,duracao,imagem_url,classificacao)
VALUES
(1,'50 First Dates','Como se fosse a primeira vez',2004,'Estados Unidos','comédia romântica',99,'https://br.web.img3.acsta.net/c_310_420/pictures/20/11/23/14/35/4981975.jpg',12),
(2,'Paranormal Activity','Atividade Paranormal',2007,'Estados Unidos','Terror',86,'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/89/84/20028680.jpg',18),
(3,'My Sister\'s Keeper','Uma prova de amor',2004,'Estados Unidos','Drama',107,'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/29/38/19874004.jpg',14),
(4,'Life in a year','A vida em um ano',2021,'Estados Unidos','Romance',107,'https://br.web.img3.acsta.net/c_310_420/pictures/20/12/02/15/57/1426320.jpg',14),
(5,'The Internship','Os estagiários',2013,'Estados Unidos','Comédia',120,'https://br.web.img3.acsta.net/c_310_420/pictures/210/068/21006856_20130517195500909.jpg',16),
(6,'Jojo Rabbit','Jojo Rabbit',2019,'Estados Unidos','Drama',108,'https://br.web.img2.acsta.net/c_310_420/pictures/20/01/28/22/54/2304385.jpg',16),
(7,'Harry Potter and The Chamber of Secrets','Harry Potter e a Câmara Secreta',2002,'Londres','Fantasia',158,'https://br.web.img2.acsta.net/c_310_420/medias/nmedia/18/93/01/50/20230712.jpg',10),
(8,'Superbad - É hoje!','Superbad',2007,'Estados Unidos','Comédia',112,'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/21/42/19873179.jpg',18),
(9,'The Conjuring','Invocação do Mal',2013,'Estados Unidos','Terror',110,'https://br.web.img3.acsta.net/c_310_420/pictures/210/166/21016629_2013062820083878.jpg',18),
(10,'Remember the Titans','Duelo de Titãs',2001,'Estados Unidos','Drama',114,'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/94/62/13/20343423.jpg',12),
(11,'Minha Mãe é uma Peça','Minha Mãe é uma Peça',2013,'Brasil','Comédia',85,'https://br.web.img3.acsta.net/c_310_420/pictures/210/016/21001687_20130426011958954.jpg',14),
(12,'The Imitation Game','O Jogo Da Imitação',2014,'Estados Unidos','Ficção Científica',115,'https://br.web.img3.acsta.net/c_310_420/pictures/14/10/30/19/02/198128.jpg',12),
(13,'John Wick: Chapter 4','John Wick 4: Baba Yaga',2023,'Estados Unidos','Ação',170,'https://br.web.img2.acsta.net/c_310_420/pictures/22/12/05/09/07/2007563.jpg',18),
(14,'Inside Out 2','Divertida Mente 2',2024,'Estados Unidos','Animação',96,'https://br.web.img2.acsta.net/c_310_420/pictures/23/11/09/18/04/2076862.jpg',10),
(15,'The Lion King','O Rei Leão',2019,'Estados Unidos','Fantasia',108,'https://br.web.img3.acsta.net/c_310_420/pictures/19/05/07/20/54/2901026.jpg',10),
(16,'Ice Age','A Era do gelo',2002,'Estados Unidos','Animação',81,'https://br.web.img2.acsta.net/c_310_420/medias/nmedia/18/90/29/80/20109874.jpg',10),
(17,'The Dark Knight','Batman - O Cavaleiro Das Trevas',2008,'Estados Unidos','Ação',152,'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/86/98/32/19870786.jpg',18),
(18,'Avengers: Endgame','Vingadores: Ultimato',2019,'Estados Unidos','Fantasia',241,'https://br.web.img2.acsta.net/c_310_420/pictures/19/04/26/17/30/2428965.jpg',12),
(19,'Rio','Rio',2011,'Estados Unidos','Animação',90,'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/32/32/19874310.jpg',10),
(20,'O Auto da Compadecida','O Auto da Compadecida',2000,'Brasil','Comédia',95,'https://br.web.img2.acsta.net/c_310_420/medias/nmedia/18/87/87/75/19962458.jpg',14),
(21,'1917','1917',2020,'Estados Unidos','Ação',119,'https://br.web.img3.acsta.net/c_310_420/pictures/19/10/04/19/42/5605017.jpg',16);

INSERT INTO exibicao (num_filme,num_canal,data)
VALUES (1,1,'2024-09-25 08:00:00'),
(2,1,'2024-09-26 17:00:00'),
(4,1,'2024-09-28 11:00:00'),
(5,1,'2024-09-29 16:00:00'),
(7,1,'2024-09-25 10:00:00'),
(8,1,'2024-09-26 17:00:00'),
(10,1,'2024-09-28 11:00:00'),
(11,1,'2024-09-29 16:00:00'),
(1,2,'2024-09-25 12:00:00'),
(2,2,'2024-09-26 21:00:00'),
(4,2,'2024-09-28 15:00:00'),
(5,2,'2024-09-29 20:00:00'),
(7,2,'2024-09-25 14:00:00'),
(8,2,'2024-09-26 21:00:00'),
(10,2,'2024-09-28 15:00:00'),
(11,2,'2024-09-29 20:00:00'),
(1,3,'2024-09-25 16:00:00'),
(3,3,'2024-09-27 10:00:00'),
(4,3,'2024-09-28 19:00:00'),
(6,3,'2024-09-30 09:00:00'),
(7,3,'2024-09-25 18:00:00'),
(9,3,'2024-09-27 10:00:00'),
(6,4,'2024-09-30 13:00:00'),
(7,4,'2024-09-25 22:00:00'),
(9,4,'2024-09-27 14:00:00'),
(10,4,'2024-09-28 23:00:00'),
(12,4,'2024-09-30 13:00:00'),
(2,5,'2024-09-26 09:00:00'),
(3,5,'2024-09-27 18:00:00'),
(5,5,'2024-09-29 08:00:00');


DELIMITER //

CREATE TRIGGER verificar_classificacao_filme_insert
BEFORE INSERT ON filme
FOR EACH ROW 
BEGIN
    -- Verifica se a classificação indicativa é maior que 18 no INSERT
    IF NEW.classificacao > 17 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'O filme possui classificação indicativa para maiores de 18 anos';
    END IF;
END;
//

DELIMITER ;


DELIMITER //

CREATE TRIGGER verificar_classificacao_filme_update
BEFORE UPDATE ON filme
FOR EACH ROW 
BEGIN
    -- Verifica se a classificação indicativa é maior que 18 no UPDATE
    IF NEW.classificacao > 17 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'O filme possui classificação indicativa para maiores de 18 anos';
    END IF;
END;
//

DELIMITER ;



