-- Apaga o banco se já existir
DROP DATABASE IF EXISTS BD;
CREATE DATABASE BD;
USE BD;

-- Cria a tabela Musica
CREATE TABLE Musica(
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(30) NOT NULL,
    dataLancamento DATE,
    genero VARCHAR(20),
    PRIMARY KEY(id)
);

-- Remove os usuários se já existirem
DROP USER IF EXISTS 'primeiro'@'localhost';
DROP USER IF EXISTS 'segundo'@'localhost';

-- Cria novamente os usuários
CREATE USER 'primeiro'@'localhost' IDENTIFIED BY '1';
CREATE USER 'segundo'@'localhost' IDENTIFIED BY '2';

-- Concede os privilégios
GRANT INSERT, DELETE, DROP ON BD.* TO 'primeiro'@'localhost';
GRANT ALL PRIVILEGES ON BD.* TO 'segundo'@'localhost';
-- Revoga privilégios específicos
REVOKE ALL PRIVILEGES ON BD.* FROM 'primeiro'@'localhost';
REVOKE UPDATE, DELETE ON BD.* FROM 'segundo'@'localhost';

