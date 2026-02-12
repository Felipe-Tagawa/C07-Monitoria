-- 1
DROP DATABASE IF EXISTS database1;
CREATE DATABASE database1;
-- 2
USE database1;

SET SQL_SAFE_UPDATES = 0; -- Utilizar Updates sem problemas

-- 3
CREATE TABLE Pessoa(

	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(40),
    endereco VARCHAR(45),
    profissao VARCHAR(20) NOT NULL,
    primary key(id)
);

-- 4
INSERT INTO Pessoa VALUES
(default, 'Felipe', 'Rua1', 'Engenheiro'),
(default, 'Samuel', 'Rua2', 'Médico'),
(default, 'Pablo', 'Rua3', 'Jardineiro');

-- 5
ALTER TABLE Pessoa ADD telefone VARCHAR(20);

-- 6
ALTER TABLE Pessoa DROP COLUMN endereco;

-- 7
UPDATE Pessoa SET telefone = '(35)99999-9999' WHERE id = 2;
UPDATE Pessoa SET telefone = '(35)99999-9998' WHERE id = 3;

-- 8
ALTER TABLE Pessoa MODIFY nome VARCHAR(30);

-- 9
DELETE FROM Pessoa Where id = 1;

-- 10
SELECT * FROM Pessoa;

-- 11
TRUNCATE TABLE Pessoa;

