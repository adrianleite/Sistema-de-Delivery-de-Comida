drop database if exists delivery_db;
CREATE DATABASE delivery_db;
USE delivery_db; 
CREATE TABLE if not exists CLIENTE (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    endereco VARCHAR(200) NOT NULL
);
CREATE TABLE if not exists RESTAURANTE (
    id_restaurante INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    telefone VARCHAR(20) NOT NULL
);
CREATE TABLE if not exists PRATO (
    id_prato INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    id_restaurante INT NOT NULL,
    FOREIGN KEY (id_restaurante) REFERENCES RESTAURANTE(id_restaurante)
);
CREATE TABLE if not exists ENTREGADOR (
    id_entregador INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Disponivel'
);
CREATE TABLE if not exists PEDIDO (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'Pendente',
    id_cliente INT NOT NULL,
    id_entregador INT,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente),
    FOREIGN KEY (id_entregador) REFERENCES ENTREGADOR(id_entregador)
);
CREATE TABLE if not exists ITEM_PEDIDO (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_prato INT NOT NULL,
    quantidade INT NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido),
    FOREIGN KEY (id_prato) REFERENCES PRATO(id_prato)
);