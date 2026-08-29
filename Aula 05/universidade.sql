CREATE DATABASE IF NOT EXISTS universidade;
USE universidade;

CREATE TABLE Alunos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    matricula VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE Cursos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    duracao INT NOT NULL,
    modalidade ENUM('Presencial', 'EAD', 'Híbrido') NOT NULL
);

CREATE TABLE Professores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    email VARCHAR(100)
);

CREATE TABLE Disciplinas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    carga_horaria INT NOT NULL,
    id_curso INT NOT NULL,
    id_professor INT,
    CHECK (carga_horaria > 0),
    FOREIGN KEY (id_curso) 
    REFERENCES Cursos(id),
    FOREIGN KEY (id_professor) 
    REFERENCES Professores(id)
);

CREATE TABLE Matriculas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT NOT NULL,
    id_disciplina INT NOT NULL,
    data_matricula DATE NOT NULL DEFAULT '2020-01-01',
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_aluno) 
    REFERENCES Alunos(id),
    FOREIGN KEY (id_disciplina)
    REFERENCES Disciplinas(id)
);

ALTER TABLE Alunos ADD COLUMN nota INT;
ALTER TABLE Alunos MODIFY nota DECIMAL(10,2) NOT NULL;

ALTER TABLE Professores
MODIFY COLUMN email VARCHAR(100) NOT NULL UNIQUE;

SHOW TABLES;

DESCRIBE EXTENDED Alunos;