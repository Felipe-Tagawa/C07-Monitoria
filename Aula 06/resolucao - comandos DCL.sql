DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE produtos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT NOT NULL,
    descricao TEXT
);

-- Parte 1:

-- Questão a)
CREATE USER 'dev_junior'@'%' IDENTIFIED BY 'senha_segura';
-- Questão b)
GRANT SELECT ON ecommerce.* TO 'dev_junior'@'%';
-- Questão c)
GRANT INSERT ON ecommerce.produtos TO 'dev_junior'@'%';
-- Questão d)
REVOKE INSERT ON ecommerce.produtos FROM 'dev_junior'@'%';

-- Parte 2:

-- Questão a)
CREATE ROLE 'role_vendas';
-- Questão b)
GRANT SELECT (nome, preco) ON ecommerce.produtos TO 'role_vendas';
-- Questão c)
CREATE USER 'vendedor_1'@'%' IDENTIFIED BY 'senha_vendedor';
GRANT 'role_vendas' TO 'vendedor_1'@'%';

-- Definir a role como padrão para o usuário 
-- para que ela fique ativa ao logar:
SET DEFAULT ROLE 'role_vendas' TO 'vendedor_1'@'%';

-- Questão d)
-- O comando irá falhar com um erro de acesso negado.

SHOW GRANTS FOR 'role_vendas';
SHOW GRANTS FOR 'dev_junior'@'%';
