DROP DATABASE IF EXISTS myDatabase;
CREATE DATABASE myDatabase;
USE myDatabase;

SET SQL_SAFE_UPDATES = 0;

DROP TABLE IF EXISTS investigacao;
CREATE TABLE investigacao (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    idade INT,
    profissao VARCHAR(100),
    cidade VARCHAR(100),
    estava_na_sala_do_cofre BOOLEAN,
    horario_visto TIME,
    possui_alibi BOOLEAN,
    quantidade_evidencias INT,
    nivel_suspeita INT
);

-- Inserções:

INSERT INTO investigacao VALUES
(1, 'Arthur Carvalho', 45, 'Empresário', 'São Paulo', TRUE, '23:00:00', FALSE, 3, 4);

INSERT INTO investigacao VALUES
(2, 'Beatriz Moura', 34, 'Curadora de Arte', 'Campinas', FALSE, '22:45:00', TRUE, 1, 2);

INSERT INTO investigacao VALUES
(3, 'Carlos Nogueira', 52, 'Colecionador', 'São Paulo', TRUE, '23:00:00', FALSE, 4, 5);

INSERT INTO investigacao VALUES
(4, 'Daniela Rocha', 29, 'Jornalista', 'Santos', FALSE, '23:10:00', FALSE, 2, 3);

INSERT INTO investigacao VALUES
(5, 'Eduardo Lima', 41, 'Advogado', 'Campinas', TRUE, '22:55:00', FALSE, 2, 4);

INSERT INTO investigacao VALUES
(6, 'Fernanda Alves', 38, 'Arquiteta', 'Santos', FALSE, '22:40:00', TRUE, 0, 1);

INSERT INTO investigacao VALUES
(7, 'Gustavo Prado', 47, 'Artista', 'São Paulo', TRUE, '23:00:00', FALSE, 3, 4);

INSERT INTO investigacao VALUES
(8, 'Helena Duarte', 31, 'Restauradora de Arte', 'Campinas', FALSE, '22:50:00', FALSE, 1, 2);

-- Atualizações

-- Atualizando o nível de suspeita de um convidado:
UPDATE investigacao SET nivel_suspeita = 1 
WHERE id = 2;

-- Atualizando a cidade de um registro
UPDATE investigacao SET cidade = "Santa Rita do Sapucaí" 
WHERE nome = "Helena Duarte";

-- Atualizando o nível de suspeita para quem estava na sala do cofre
UPDATE investigacao
SET nivel_suspeita = nivel_suspeita + 1
WHERE estava_na_sala_do_cofre = TRUE;

-- Remoções:

-- Removendo um convidado que comprovou inocência (Álibi + Nível de suspeita baixo + Sem Evidências)
DELETE FROM investigacao
WHERE possui_alibi = TRUE
AND quantidade_evidencias = 0
AND nivel_suspeita = 1;

-- Removendo todos os convidados com nível de suspeita igual a 1:
DELETE FROM investigacao
WHERE nivel_suspeita = 1;

-- Consultas:

-- Listar todos os Registros:
SELECT * FROM investigacao;

-- Listar apenas nome e profissao:
SELECT nome, profissao FROM investigacao;

-- Listar os convidados ordenados por idade:
SELECT * FROM investigacao
ORDER BY idade DESC;

-- Listar todos os convidados com nível de suspeita maior que 3:
SELECT * FROM investigacao WHERE nivel_suspeita > 3;

-- Listar os convidados com idade (30 <= idade <= 50):
SELECT * FROM investigacao WHERE idade BETWEEN 30 AND 50;

-- Listar os convidados cujo nome começa com 'A':
SELECT * FROM investigacao WHERE nome LIKE 'A%';

-- Listar os convidados cujo nome termina com 'o':
SELECT * FROM investigacao WHERE nome LIKE '%o';

-- Listar os convidados cuja profissão contenha a palavra 'Art':
SELECT * FROM investigacao WHERE profissao LIKE '%Art%';

-- Listar os convidados das cidades: 'São Paulo', 'Campinas' ou 'Santos':
SELECT * FROM investigacao WHERE cidade IN ('São Paulo', 'Campinas', 'Santos');

-- Mostrar a quantidade total de convidados:
SELECT COUNT(*) FROM investigacao;

-- Mostrar o mínimo e o máximo de nível de suspeita:
SELECT MIN(nivel_suspeita) FROM investigacao;
SELECT MAX(nivel_suspeita) FROM investigacao;

-- Mostrar a soma da quantidade de evidências:
SELECT SUM(quantidade_evidencias) FROM investigacao;

-- Mostrar a quantidade de cada profissão:
SELECT profissao, COUNT(*)
FROM investigacao
GROUP BY profissao;

-- Mostrar a média de nível de suspeita das cidades:
SELECT cidade, AVG(nivel_suspeita)
FROM investigacao
GROUP BY cidade;

-- Desafio Final:
SELECT * FROM investigacao
WHERE estava_na_sala_do_cofre = TRUE 
AND possui_alibi = FALSE
AND nivel_suspeita > 3
AND quantidade_evidencias >= 2
AND (nome LIKE 'A%' OR nome LIKE 'C%')
AND nivel_suspeita = (
    SELECT MAX(nivel_suspeita)
    FROM investigacao
);







 
