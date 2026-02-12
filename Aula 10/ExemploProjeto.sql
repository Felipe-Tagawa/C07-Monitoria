DROP DATABASE IF EXISTS ExemploProjeto;
CREATE DATABASE ExemploProjeto;
USE ExemploProjeto;

DROP TABLE IF EXISTS usuarios;
CREATE TABLE usuarios (
-- id: Chave primária, auto-incrementável (gerado automaticamente pelo MySQL)
id INT AUTO_INCREMENT PRIMARY KEY,
-- nome: Nome do usuário (não pode ser nulo)
nome VARCHAR(100) NOT NULL,
-- email: Email do usuário (deve ser único e não pode ser nulo)
email VARCHAR(100) NOT NULL UNIQUE,
-- data_criacao: Registra quando o usuário foi criado (default é o momento da inserção)
data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

SELECT * FROM usuarios LIMIT 10;