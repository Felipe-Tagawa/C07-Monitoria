-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS monitoria_db;

USE monitoria_db;

-- Tabela de estudantes
CREATE TABLE IF NOT EXISTS estudantes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    idade INT NOT NULL,
    curso VARCHAR(100) NOT NULL,
    nota DECIMAL(3, 1) NOT NULL
);

-- Inserir dados de exemplo
INSERT INTO
    estudantes (nome, idade, curso, nota)
VALUES (
        'João Silva',
        20,
        'Ciência da Computação',
        8.5
    ),
    (
        'Maria Santos',
        19,
        'Engenharia',
        9.2
    ),
    (
        'Pedro Costa',
        21,
        'Matemática',
        7.8
    ),
    (
        'Ana Oliveira',
        20,
        'Ciência da Computação',
        9.5
    ),
    (
        'Lucas Ferreira',
        22,
        'Física',
        8.9
    );