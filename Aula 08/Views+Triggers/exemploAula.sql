-- Remove o banco anterior, se existir
DROP DATABASE IF EXISTS ExemploAula;

-- Cria e usa o novo banco
CREATE DATABASE ExemploAula;
USE ExemploAula;

-- Tabelas

CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    saldo DECIMAL(10,2) DEFAULT 0.00
);

CREATE TABLE compras (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    valor DECIMAL(10,2),
    data_compra TIME DEFAULT (CURRENT_TIME),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Trigger

DELIMITER $$

CREATE TRIGGER trg_saldo_inicial
BEFORE INSERT ON clientes
FOR EACH ROW
BEGIN
    SET NEW.saldo = 100.00;
END$$

DELIMITER ;

-- ==============================
-- Procedure - registrar compra
-- ==============================
DELIMITER $$

CREATE PROCEDURE registrar_compra(
    IN p_cliente_id INT,
    IN p_valor DECIMAL(10,2)
)
BEGIN
    UPDATE clientes
    SET saldo = saldo - p_valor
    WHERE id = p_cliente_id;

    INSERT INTO compras (cliente_id, valor)
    VALUES (p_cliente_id, p_valor);
END$$

DELIMITER ;

-- ==============================
-- Function - total gasto
-- ==============================
DELIMITER $$

CREATE FUNCTION total_gasto(p_cliente_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10,2);

    SELECT COALESCE(SUM(valor), 0)
    INTO v_total
    FROM compras
    WHERE cliente_id = p_cliente_id;

    RETURN v_total;
END$$

DELIMITER ;

-- ==============================
-- View - compras com nome do cliente
-- ==============================
CREATE VIEW view_compras AS
SELECT 
    c.nome AS cliente,
    cp.valor,
    cp.data_compra
FROM compras cp
JOIN clientes c ON cp.cliente_id = c.id;

-- ==============================
-- Inserindo dados e testando
-- ==============================

-- Inserir clientes (trigger vai dar saldo inicial)
INSERT INTO clientes (nome) VALUES ('Maria');
INSERT INTO clientes (nome) VALUES ('João');

-- Ver saldo inicial
SELECT * FROM clientes;

-- Fazer uma compra (Maria compra 30,00)
CALL registrar_compra(1, 30.00);

-- Ver todas as compras
SELECT * FROM view_compras;

-- Ver total gasto por cliente
SELECT nome, total_gasto(id) AS total_gasto FROM clientes;
