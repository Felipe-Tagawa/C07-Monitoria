-- 1. Banco de Dados
DROP DATABASE IF EXISTS streaming_db;
CREATE DATABASE streaming_db;
USE streaming_db;

-- 2. Tabela
CREATE TABLE Filme (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(20) NOT NULL,
    genero VARCHAR(30),
    ano_lancamento YEAR NOT NULL
);

-- Incluir nova coluna
ALTER TABLE Filme ADD COLUMN classificacao_etaria VARCHAR(10);

-- Aumentar limite do título para 60 caracteres
ALTER TABLE Filme MODIFY COLUMN titulo VARCHAR(60) NOT NULL;

-- Desativar trava de segurança
SET SQL_SAFE_UPDATES = 0;

-- Inserção de 3 filmes
INSERT INTO Filme (titulo, genero, ano_lancamento, classificacao_etaria) VALUES 
('Interestelar', 'Ficção Científica', 2014, '10+'),
('O Poderoso Chefão', 'Drama', 1972, '14+'),
('Shrek', 'Animação', 2001, 'Livre');

-- Atualizar o gênero de um filme
UPDATE Filme SET genero = 'Sci-Fi / Drama' WHERE titulo = 'Interestelar';

-- Deletar o filme com o primeiro ID
DELETE FROM Filme WHERE id = 1;

-- Validar as operações
SELECT * FROM Filme;

-- Visualizar as tabelas existentes
SHOW TABLES;

-- Remover todos os registros 
TRUNCATE TABLE Filme;