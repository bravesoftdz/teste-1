CREATE TABLE contato(
id int(2) NOT NULL AUTO_INCREMENT,
nome VARCHAR(50)NOT NULL,
endereco VARCHAR(50) NOT NULL,
telefone VARCHAR(10),
email VARCHAR(30),
sexo VARCHAR(1),
PRIMARY KEY(id)
);

INSERT INTO `contato`(`id`, `nome`, `endereco`, `telefone`, `email`, `sexo`) 
VALUES (01,"Cilandro","Dr.Godoy","5199884466","www.eu@gmt.com","M")
