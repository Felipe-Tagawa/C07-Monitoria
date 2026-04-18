-- COMMIT
START TRANSACTION;
UPDATE conta SET saldo = saldo - 100 WHERE id_conta = 1;
UPDATE conta SET saldo = saldo + 100 WHERE id_conta = 2;
COMMIT;

-- ROLLBACK
START TRANSACTION;
DELETE FROM pedidos WHERE id = 10;
ROLLBACK; -- nada foi apagado

-- SAVEPOINT
START TRANSACTION;
INSERT INTO log VALUES ('inicio');
SAVEPOINT ponto1;
INSERT INTO log VALUES ('etapa 2');
ROLLBACK TO ponto1; -- só desfaz após savepoint
COMMIT;

-- RELEASE SAVEPOINT
RELEASE SAVEPOINT ponto1;

-- SET TRANSACTION
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SET TRANSACTION READ ONLY;

-- AUTOCOMMIT
SET autocommit = 0;

-- Exemplo Completo
START TRANSACTION;

SAVEPOINT before_insert;

INSERT INTO pedido (cliente_id, total) VALUES (5, 299.90);

-- Considerando que algo deu errado
ROLLBACK TO before_insert;

-- Tentativa nova

INSERT INTO pedido (cliente_id, total) VALUES (5, 199.90);

COMMIT;

-- Exercícios

-- ================================================
-- BANCO: financeiro
-- ================================================

CREATE DATABASE financeiro;
USE financeiro;

CREATE TABLE contas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titular VARCHAR(100),
    saldo NUMERIC(10,2)
);

INSERT INTO contas (titular, saldo) VALUES
    ('Alice', 1500.00),
    ('Bruno', 200.00),
    ('Carla', 800.00);

-- Exercício 1 — COMMIT e ROLLBACK
-- Alice vai transferir R$ 300,00 para Bruno. Escreva a transação, confirme com COMMIT e consulte os saldos. Depois, refaça o exercício mas use ROLLBACK no final — o que muda?

-- Exercício 2 — SAVEPOINT
-- Carla vai transferir R$ 100,00 para Alice e R$ 100,00 para Bruno. Crie um SAVEPOINT entre as duas operações. Desfaça apenas a segunda transferência com ROLLBACK TO e confirme o restante.

-- Exercício 3 — Dissertativa rápida
-- Olhe o código abaixo e responda: quais operações chegam ao banco após o COMMIT?
START TRANSACTION;
    UPDATE contas SET saldo = saldo - 200 WHERE id = 1;
    SAVEPOINT sp1;
    UPDATE contas SET saldo = saldo + 200 WHERE id = 2;
    ROLLBACK TO sp1;
COMMIT;