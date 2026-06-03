-- ----------------------------------------------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_criar_pedido;

DELIMITER $$

CREATE PROCEDURE sp_criar_pedido(
    IN p_id_cliente INT,
    IN p_id_entregador INT
)
BEGIN
    DECLARE v_cliente INT;
    DECLARE v_entregador INT;
    DECLARE v_status VARCHAR(20);

    SELECT COUNT(*) INTO v_cliente FROM cliente WHERE id_cliente = p_id_cliente;
    IF v_cliente = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cliente não existe';
    END IF;

    SELECT COUNT(*) INTO v_entregador FROM entregador WHERE id_entregador = p_id_entregador;
    IF v_entregador = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Entregador não existe';
    END IF;

    SELECT status INTO v_status FROM entregador WHERE id_entregador = p_id_entregador;
    IF v_status <> 'Disponivel' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Entregador indisponível';
    END IF;

    INSERT INTO pedido (data_pedido, status, id_cliente, id_entregador)
    VALUES (NOW(), 'CRIADO', p_id_cliente, p_id_entregador);

    UPDATE entregador
    SET status = 'Ocupado'
    WHERE id_entregador = p_id_entregador;
END $$

DELIMITER ;

-- ------------------------------------------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_adicionar_item;

DELIMITER $$

CREATE PROCEDURE sp_adicionar_item(
    IN p_id_pedido INT,
    IN p_id_prato INT,
    IN p_quantidade INT
)
BEGIN
    DECLARE v_pedido INT;
    DECLARE v_prato INT;
    DECLARE v_status VARCHAR(20);

    SELECT COUNT(*) INTO v_pedido FROM pedido WHERE id_pedido = p_id_pedido;
    IF v_pedido = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Pedido não existe';
    END IF;

    SELECT COUNT(*) INTO v_prato FROM prato WHERE id_prato = p_id_prato;
    IF v_prato = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Prato não existe';
    END IF;

    SELECT status INTO v_status FROM pedido WHERE id_pedido = p_id_pedido;
    IF v_status <> 'CRIADO' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Pedido não pode ser alterado';
    END IF;

    INSERT INTO item_pedido (id_pedido, id_prato, quantidade)
    VALUES (p_id_pedido, p_id_prato, p_quantidade);
END $$

DELIMITER ;

-- ---------------------------------------------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_fechar_pedido;

DELIMITER $$

CREATE PROCEDURE sp_fechar_pedido(
    IN p_id_pedido INT
)
BEGIN
    DECLARE v_itens INT;
    DECLARE v_entregador INT;

    SELECT COUNT(*) INTO v_itens FROM item_pedido WHERE id_pedido = p_id_pedido;
    IF v_itens = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Pedido sem itens';
    END IF;

    UPDATE pedido
    SET status = 'FINALIZADO'
    WHERE id_pedido = p_id_pedido;

    SELECT id_entregador INTO v_entregador
    FROM pedido
    WHERE id_pedido = p_id_pedido;

    UPDATE entregador
    SET status = 'Disponivel'
    WHERE id_entregador = v_entregador;
END $$

DELIMITER ;