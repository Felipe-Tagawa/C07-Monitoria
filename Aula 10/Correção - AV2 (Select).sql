-- 1. Remoção e Criação do Database
DROP DATABASE IF EXISTS sistema_pedidos;
CREATE DATABASE sistema_pedidos;
USE sistema_pedidos;

-- 2. Criação das Tabelas

-- Tabela CLIENTES
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(50)
);

-- Tabela PEDIDOS
CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    data_pedido DATE,
    valor_total DECIMAL(10, 2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Tabela PRODUTOS
CREATE TABLE produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL
);

-- Tabela intermediária ITENS_PEDIDO
CREATE TABLE itens_pedido (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Tabela PAGAMENTOS
CREATE TABLE pagamentos (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    valor_pago DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- 3. Inserção de Dados

-- Inserir Clientes
INSERT INTO clientes (nome, cidade) VALUES
('Ana Silva', 'São Paulo'),       -- Cliente 1 
('Bruno Costa', 'Rio de Janeiro'),  -- Cliente 2 
('Carlos Lima', 'Belo Horizonte'), -- Cliente 3 
('Diana Souza', 'São Paulo'),      -- Cliente 4 
('Eva Ferreira', 'Curitiba');      -- Cliente 5

-- Inserir Produtos
INSERT INTO produtos (nome_produto, preco) VALUES
('Notebook Gamer', 5500.00),
('Mouse Sem Fio', 75.50),
('Monitor 27 Polegadas', 1200.00),
('Teclado Mecânico', 350.00),
('Webcam HD', 150.00);

-- Inserir Pedidos
INSERT INTO pedidos (id_cliente, data_pedido, valor_total) VALUES
(1, '2023-10-01', 5825.50), -- Pedido 1 (Ana)
(2, '2023-10-02', 2400.00), -- Pedido 2 (Bruno)
(1, '2023-10-05', 500.00),  -- Pedido 3 (Ana)
(3, '2023-10-07', 350.00),  -- Pedido 4 (Carlos)
(4, '2023-10-08', 600.00);  -- Pedido 5 (Diana)

-- Inserir Itens_Pedido
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES
(1, 1, 1), (1, 2, 4),
(2, 3, 2),
(3, 4, 1), (3, 5, 1),
(4, 4, 1),
(5, 5, 4);

-- Pagamentos dos Clientes (Dica: Questão 3)
INSERT INTO pagamentos (id_pedido, valor_pago) VALUES
(1, 5825.50), 
(3, 250.00),  
(3, 250.00),  
(2, 2400.00), 
(5, 600.00);

-- Faça a Questão 1 abaixo --

SELECT 
    c.nome,
    p.valor_total
FROM clientes c
INNER JOIN pedidos p ON c.id_cliente = p.id_cliente;

-- Fim da Questão 1 --

-- Faça a Questão 2 abaixo --

SELECT 
    prod.nome_produto,
    SUM(ip.quantidade) AS quantidade_total_vendida,
    SUM(ip.quantidade * prod.preco) AS valor_total_obtido
FROM produtos prod
INNER JOIN itens_pedido ip ON prod.id_produto = ip.id_produto
GROUP BY prod.id_produto, prod.nome_produto;

-- Fim da Questão 2 --

-- Faça a Questão 3 abaixo --

SELECT 
    c.nome,
    COUNT(DISTINCT p.id_pedido) AS total_pedidos,
    SUM(pag.valor_pago) AS valor_total_pago
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
LEFT JOIN pagamentos pag ON p.id_pedido = pag.id_pedido
GROUP BY c.id_cliente, c.nome
ORDER BY valor_total_pago;

-- Fim da Questão 3 --

