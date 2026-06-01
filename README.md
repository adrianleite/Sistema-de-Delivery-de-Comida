# 🍔 Sistema de Delivery - Banco de Dados

## 📌 Descrição

Este projeto implementa um sistema de delivery de comida utilizando banco de dados relacional (MySQL).
O foco principal é concentrar toda a **regra de negócio dentro do banco**, utilizando **Stored Procedures, Functions e Views**.

A aplicação apenas consome essas funcionalidades, sem implementar lógica diretamente no código.

---

## 🧱 Estrutura do Projeto

```
delivery-banco-dados/
│
├── modelos/
│   ├── conceitual.png
│   ├── logico.png
│
├── sql/
│   ├── ddl.sql
│   ├── dml.sql
│   ├── procedures.sql
│   ├── functions.sql
│   ├── views.sql
│
├── app/
│   └── (código da aplicação)
│
└── README.md
```

---

## 🗄️ Banco de Dados

O banco é composto pelas seguintes entidades:

* Cliente
* Restaurante
* Prato
* Entregador
* Pedido
* Item do Pedido

O modelo foi normalizado até a **3FN (Terceira Forma Normal)**.

---

## ⚙️ Regras de Negócio

As regras do sistema foram implementadas diretamente no banco através de procedures:

### ✅ Criar Pedido

* Verifica se o cliente existe
* Verifica se o entregador existe
* Verifica se o entregador está disponível
* Cria o pedido
* Define o entregador como ocupado

### ✅ Adicionar Item

* Verifica se o pedido existe
* Verifica se o prato existe
* Permite apenas pedidos com status "CRIADO"

### ✅ Fechar Pedido

* Impede fechar pedido sem itens
* Atualiza o status para "FINALIZADO"
* Libera o entregador

---

## 🧮 Functions

### `fn_total_pedido`

* Calcula o valor total de um pedido com base nos itens

---

## 👁️ Views

### `vw_detalhes_pedido`

* Mostra informações completas do pedido (cliente, prato, quantidade)

### `vw_total_gasto_cliente`

* Mostra quanto cada cliente já gastou

---

## 💻 Aplicação

A aplicação se conecta ao banco de dados e executa as procedures.

Exemplo (Python):

```python
cursor.callproc('sp_realizar_pedido', [1, 1])
```

A aplicação não contém regra de negócio, apenas chama o banco.

---

## ▶️ Como Executar

1. Criar o banco:

```
rodar ddl.sql
```

2. Inserir dados:

```
rodar dml.sql
```

3. Criar regras:

```
rodar procedures.sql
rodar functions.sql
rodar views.sql
```

4. Executar a aplicação:

```
rodar código em /app
```

---

## 🎯 Objetivo do Projeto

Demonstrar a utilização de banco de dados como camada principal de regra de negócio, garantindo:

* Integridade dos dados
* Centralização das regras
* Facilidade de manutenção
* Segurança das operações

---

## 👨‍💻 Autor(es)

* (Seu nome aqui)

---

## 🚀 Status

✔ Projeto funcional
✔ Banco normalizado (3FN)
✔ Regras implementadas no banco
✔ Aplicação integrada

```
```
