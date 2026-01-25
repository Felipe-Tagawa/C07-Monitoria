DROP DATABASE IF EXISTS empresa_funcionarios;
CREATE DATABASE empresa_funcionarios;
USE empresa_funcionarios;

CREATE TABLE Funcionario (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50),
    idade INT,
    departamento VARCHAR(20),
    email VARCHAR(100)
);

DELIMITER $$

CREATE FUNCTION criaEmailFuncionario(nome VARCHAR(50), departamento VARCHAR(20))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    RETURN CONCAT(nome, '@', departamento, '.empresa.com');
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE insereFuncionario()
BEGIN
    INSERT INTO Funcionario(nome, idade, departamento, email)
    VALUES
        ('Carlos', 30, 'rh', criaEmailFuncionario('Carlos', 'rh')),
        ('Lucia', 27, 'ti', criaEmailFuncionario('Lucia', 'ti')),
        ('Bruno', 35, 'adm', criaEmailFuncionario('Bruno', 'adm'));
END $$

DELIMITER ;

-- Chamando a procedure para inserir os dados
CALL insereFuncionario();

SELECT email FROM Funcionario;