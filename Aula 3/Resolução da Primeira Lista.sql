DROP DATABASE IF EXISTS teste;
CREATE DATABASE teste;
USE teste;

SET SQL_SAFE_UPDATES = 0;

DROP TABLE IF EXISTS Comida;
CREATE TABLE Comida(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(30),
	tipo VARCHAR(20),
	preco DOUBLE
);

DROP TABLE IF EXISTS Lanche;
CREATE TABLE Lanche(
	id INT NOT NULL PRIMARY KEY,
	nome VARCHAR(30),
	preco DOUBLE,
	qntDisp INT
);

-- Questão 1
-- a
INSERT INTO Comida VALUES (default,'Pizza', 'Italiana', '60.00');
INSERT INTO Comida VALUES (default,'Sushi', 'Japonesa', '35.00');
INSERT INTO Comida VALUES (default,'Feijoada', 'Brasileira', '20.00');
-- b
SELECT nome FROM Comida;
-- c
UPDATE Comida SET nome = 'Tiramisu' WHERE id = 1;
-- d
DELETE FROM Comida WHERE preco = '35.00';
-- e
SELECT SUM(preco) from Comida;

-- Questão 2
-- a
INSERT INTO Lanche VALUES (1, 'Empada', 5.60, 2);
INSERT INTO Lanche VALUES (2, 'Coxinha', 6.00, 3);
INSERT INTO Lanche VALUES (4, 'Sanduíche', 7.50, 1);
-- b
SELECT COUNT(qntDisp) FROM Lanche WHERE qntDisp >= 2;
-- c
SELECT AVG(preco) FROM Lanche;
-- d
INSERT INTO Lanche VALUES (3, 'Esfirra', 6.00, 2);
INSERT INTO Lanche VALUES (5, 'Pastel', 5.00, 4);
-- e
SELECT nome FROM Lanche WHERE preco = (SELECT MIN(preco) FROM Lanche);
-- f
UPDATE Lanche SET preco = 6.00 WHERE nome = 'Empada';
-- g
SELECT SUM(preco) FROM Lanche WHERE preco != 6.00;
-- h
SELECT * FROM Lanche WHERE qntDisp < 3;
-- i
SELECT nome FROM Lanche WHERE nome LIKE 'E_____';
-- j
UPDATE Lanche SET preco = 2.00 WHERE qntDisp <= 2;
-- k
DELETE FROM Lanche WHERE preco = 2.00;
SELECT * FROM Lanche;







