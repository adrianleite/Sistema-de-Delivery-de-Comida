-- --------------------------------------------------------------------------------------

drop view IF EXISTS vw_detalhes_pedido ;
CREATE OR REPLACE VIEW vw_detalhes_pedido AS
SELECT 
    pe.id_pedido,
    c.nome AS cliente,
    e.nome AS entregador,
    pe.status,
    p.nome AS prato,
    ip.quantidade,
    p.preco,
    (p.preco * ip.quantidade) AS subtotal
FROM pedido pe
JOIN cliente c ON pe.id_cliente = c.id_cliente
LEFT JOIN entregador e ON pe.id_entregador = e.id_entregador
JOIN item_pedido ip ON pe.id_pedido = ip.id_pedido
JOIN prato p ON ip.id_prato = p.id_prato;

-- --------------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW vw_total_gasto_cliente AS
SELECT 
    c.id_cliente,
    c.nome,
    SUM(p.preco * ip.quantidade) AS total_gasto
FROM cliente c
JOIN pedido pe ON pe.id_cliente = c.id_cliente
JOIN item_pedido ip ON ip.id_pedido = pe.id_pedido
JOIN prato p ON p.id_prato = ip.id_prato
GROUP BY c.id_cliente, c.nome;