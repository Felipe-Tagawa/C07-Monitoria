-- ==========================================================
-- Banco de Dados — Portal Acadêmico Inatel
-- ==========================================================
DROP DATABASE IF EXISTS portal_inatel;
CREATE DATABASE portal_inatel;
USE portal_inatel;

SET SQL_SAFE_UPDATES = 0;

-- ==========================================================
-- QUESTÃO 1 — Criação das tabelas
-- ==========================================================

CREATE TABLE Professor (
    id_professor  INT          AUTO_INCREMENT,
    cpf           CHAR(14)     NOT NULL,
    nome          VARCHAR(100) NOT NULL,
    email         VARCHAR(100) NOT NULL UNIQUE,
    area          VARCHAR(50)  NOT NULL,
    PRIMARY KEY (id_professor, cpf)
);

CREATE TABLE Aluno (
    id_aluno      INT          AUTO_INCREMENT PRIMARY KEY,
    nome          VARCHAR(100) NOT NULL,
    email         VARCHAR(100) NOT NULL UNIQUE,
    data_ingresso DATE         NOT NULL,
    CONSTRAINT chk_email_inatel CHECK (email LIKE '%@inatel.br')
);

CREATE TABLE Matricula (
    id_matricula  INT  AUTO_INCREMENT PRIMARY KEY,
    id_aluno      INT  NOT NULL,
    id_professor  INT  NOT NULL,
    disciplina    VARCHAR(100) NOT NULL,
    semestre      VARCHAR(10)  NOT NULL,
    status        ENUM('MATRICULADO','TRANCADO','CONCLUIDO','REPROVADO') NOT NULL,
    FOREIGN KEY (id_aluno)     REFERENCES Aluno(id_aluno),
    FOREIGN KEY (id_professor) REFERENCES Professor(id_professor)
);

-- ==========================================================
-- QUESTÃO 2 — Alterações nas tabelas
-- ==========================================================

-- 2a) Adicionar coluna curso em Aluno
ALTER TABLE Aluno
ADD COLUMN curso CHAR(3) NULL;

-- b) Adicionar codigo_externo e atualizar PK (Questão técnica/difícil)
-- Primeiro, adicionamos a coluna
ALTER TABLE Professor ADD COLUMN codigo_externo VARCHAR(20) NOT NULL;

-- Para alterar a PK, é necessário remover a anterior e criar a nova
ALTER TABLE Professor DROP PRIMARY KEY, 
ADD PRIMARY KEY (id_professor, cpf, codigo_externo);

-- ==========================================================
-- QUESTÃO 3a — Popular o banco
-- ==========================================================

INSERT INTO Professor (cpf, nome, email, area, codigo_externo) VALUES
('111.222.333-44', 'Jonas Lopes',  'jonas@inatel.br', 'Software',   'PROF-0001'),
('222.333.444-55', 'Edson Josias', 'soned@inatel.br', 'Redes',      'PROF-0002'),
('333.444.555-66', 'Renan Duque',  'renan@inatel.br', 'Matematica', 'PROF-0003');

INSERT INTO Aluno (nome, email, data_ingresso, curso) VALUES
('Beatriz Ferreira', 'beatriz.f@inatel.br', '2021-02-01', 'GES'),
('Felipe Carvalho',  'felipe.c@inatel.br',  '2021-02-01', 'GEC'),
('Maria Pereira',    'maria.p@inatel.br',   '2022-02-01', 'GEB'),
('Pedro Augusto',    'pedro.a@inatel.br',   '2023-02-01', 'GET');

INSERT INTO Matricula (id_aluno, id_professor, disciplina, semestre, status) VALUES
(1, 1, 'Banco de Dados',   '2024-1', 'MATRICULADO'),
(2, 1, 'Banco de Dados',   '2024-1', 'MATRICULADO'),
(3, 2, 'Redes de Dados I', '2024-1', 'CONCLUIDO'),
(4, 3, 'Calculo I',        '2024-1', 'TRANCADO'),
(1, 2, 'Redes de Dados I', '2024-2', 'REPROVADO');

-- ==========================================================
-- QUESTÃO 3b — INSERT corrigido do Carlos Augusto
-- (falha sem codigo_externo pois é NOT NULL)
-- ==========================================================

INSERT INTO Professor (cpf, nome, email, area, codigo_externo)
VALUES ('444.555.666-77', 'Carlos Augusto', 'carlosa@inatel.br', 'Eletronica', 'PROF-0004');

-- ==========================================================
-- QUESTÃO 4 — Updates
-- ==========================================================

-- 4a) Reativar matrícula id = 4
UPDATE Matricula
SET status = 'MATRICULADO'
WHERE id_matricula = 4;

-- 4b) Concluir todas as matrículas do semestre 2024-1
UPDATE Matricula
SET status = 'CONCLUIDO'
WHERE semestre = '2024-1';

-- 4c) Atualizar email e curso do aluno id = 3
UPDATE Aluno
SET email = 'camila@inatel.br',
    curso = 'GEB'
WHERE id_aluno = 3;

-- ==========================================================
-- QUESTÃO 5 — Deletes
-- ==========================================================

-- 5a) Remover matrícula id = 4
DELETE FROM Matricula
WHERE id_matricula = 4;

-- 5b) Tentativa de remover aluno id = 1
-- Falha pois possui matrículas vinculadas (violação de FK)
-- Para remoção automática das matrículas, a FK deveria ter sido:
-- FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno) ON DELETE CASCADE
DELETE FROM Aluno
WHERE id_aluno = 1;

-- ==========================================================
-- QUESTÃO 6 — Consultas
-- ==========================================================

-- 6a) Alunos com ingresso a partir de 01/01/2022, ordem alfabética
SELECT nome, email
FROM Aluno
WHERE data_ingresso >= '2022-01-01'
ORDER BY nome ASC;

-- 6b) Quantidade de matrículas, semestre mais recente e mais antigo
SELECT
    id_aluno,
    COUNT(*)      AS total_matriculas,
    MAX(semestre) AS semestre_mais_recente,
    MIN(semestre) AS semestre_mais_antigo
FROM Matricula
GROUP BY id_aluno
ORDER BY total_matriculas DESC;

-- 6c) EXTRA — Índice para otimizar as consultas da Q6
CREATE INDEX idx_matricula_aluno_semestre
ON Matricula (id_aluno, semestre);

-- Justificativa:
-- A Q6b agrupa por id_aluno e usa MIN/MAX em semestre.
-- O índice composto (id_aluno, semestre) permite localizar
-- rapidamente as matrículas de cada aluno já ordenadas por
-- semestre, evitando full table scan e filesort.