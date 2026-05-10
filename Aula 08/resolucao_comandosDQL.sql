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
    id_professor  INT          AUTO_INCREMENT PRIMARY KEY, 
    cpf           CHAR(14)     NOT NULL UNIQUE,    
    nome          VARCHAR(100) NOT NULL,
    email         VARCHAR(100) NOT NULL UNIQUE,
    area          VARCHAR(50)  NOT NULL
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
-- QUESTÃO 3a — Popular o banco
-- ==========================================================

INSERT INTO Professor (cpf, nome, email, area) VALUES
('111.222.333-44', 'Jonas Lopes',  'jonas@inatel.br', 'Software'),
('222.333.444-55', 'Edson Josias', 'soned@inatel.br', 'Redes'),
('333.444.555-66', 'Renan Duque',  'renan@inatel.br', 'Matematica');

INSERT INTO Aluno (nome, email, data_ingresso) VALUES
('Beatriz Ferreira', 'beatriz.f@inatel.br', '2021-02-01'),
('Felipe Carvalho',  'felipe.c@inatel.br',  '2021-02-01'),
('Maria Pereira',    'maria.p@inatel.br',   '2022-02-01'),
('Pedro Augusto',    'pedro.a@inatel.br',   '2023-02-01');

INSERT INTO Matricula (id_aluno, id_professor, disciplina, semestre, status) VALUES
(1, 1, 'Banco de Dados',   '2024-1', 'MATRICULADO'),
(2, 1, 'Banco de Dados',   '2024-1', 'MATRICULADO'),
(3, 2, 'Redes de Dados I', '2024-1', 'CONCLUIDO'),
(4, 3, 'Calculo I',        '2024-1', 'TRANCADO'),
(1, 2, 'Redes de Dados I', '2024-2', 'REPROVADO');

INSERT INTO Professor (cpf, nome, email, area)
VALUES ('444.555.666-77', 'Carlos Augusto', 'carlosa@inatel.br', 'Eletronica');

-- Consultas das Questões (Suas lógicas estão perfeitas)

-- Q1
SELECT A.nome AS nomeAluno, M.disciplina, M.status
FROM Aluno A
JOIN Matricula M ON A.id_aluno = M.id_aluno;

-- Q2
SELECT A.nome AS nomeAluno, COUNT(M.id_matricula) AS totalDisciplinas
FROM Aluno A
JOIN Matricula M ON A.id_aluno = M.id_aluno
GROUP BY A.nome
HAVING totalDisciplinas >= 2;

-- Q3
SELECT P.nome AS nomeProfessor, P.area, M.disciplina, A.nome AS nomeAluno
FROM Professor P
JOIN Matricula M ON P.id_professor = M.id_professor
JOIN Aluno A ON M.id_aluno = A.id_aluno
WHERE M.status = 'MATRICULADO';