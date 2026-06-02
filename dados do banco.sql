-- RESTAURANTES
INSERT INTO restaurante (id_restaurante, nome, categoria, telefone) VALUES
(1, 'Pizzaria Top', 'Pizza', '9999-1111'),
(2, 'Lanches BR', 'Hamburguer', '9999-2222');

-- CLIENTES
INSERT INTO cliente (id_cliente, nome, telefone, endereco) VALUES
(1, 'João Silva', '8888-1111', 'Rua A'),
(2, 'Maria Souza', '8888-2222', 'Rua B'),
(3, 'Pedro Santos', '8888-3333', 'Rua C');

-- ENTREGADORES
INSERT INTO entregador (id_entregador, nome, telefone, status) VALUES
(1, 'Carlos Moto', '7777-1111', 'Disponivel'),
(2, 'Ana Bike', '7777-2222', 'Disponivel');

-- PRATOS
INSERT INTO prato (id_prato, nome, descricao, preco, id_restaurante) VALUES
(1, 'Pizza Calabresa', 'Pizza com calabresa', 30.00, 1),
(2, 'Hambúrguer', 'Hambúrguer artesanal', 20.00, 2),
(3, 'Lasanha', 'Lasanha de carne', 25.00, 2),
(4, 'Refrigerante', 'Coca-cola lata', 5.00, 1);

-- PEDIDOS
INSERT INTO pedido (id_pedido, data_pedido, status, id_cliente, id_entregador) VALUES
(1, NOW(), 'CRIADO', 1, 1),
(2, NOW(), 'CRIADO', 2, 2);

-- ITENS
INSERT INTO item_pedido (id_pedido, id_prato, quantidade) VALUES
(1, 1, 2),
(1, 4, 2),
(2, 2, 1),
(2, 3, 1);


