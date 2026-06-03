DROP FUNCTION IF EXISTS fn_total_pedido;

DELIMITER $$

CREATE FUNCTION fn_total_pedido(p_id_pedido INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10,2);

    SELECT SUM(p.preco * ip.quantidade)
    INTO v_total
    FROM item_pedido ip
    JOIN prato p ON p.id_prato = ip.id_prato
    WHERE ip.id_pedido = p_id_pedido;

    RETURN IF(v_total IS NULL, 0, v_total);
END $$

DELIMITER ;