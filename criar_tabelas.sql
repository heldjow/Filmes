USE programacoes_filmes;

CREATE TABLE canal
(num_canal int primary key,
nome varchar(50),
sigla varchar(25));

CREATE TABLE filme
(num_filme int primary key,
titulo_original varchar(80) not null,
titulo_brasil varchar(80),
ano_lancamento year not null,
pais_origem varchar(30),
categoria varchar(25),
duracao (int not null),
imagem_url varchar(255));

CREATE TABLE exibicao
(num_filme int,
num_canal int,
data datetime,
primary key (num_filme, num_canal, data),
foreign key (num_filme) references filme (num_filme),
foreign key (num_canal) references canal (num_canal));
