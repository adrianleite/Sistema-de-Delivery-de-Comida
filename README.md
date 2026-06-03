# 🍔 Sistema de Delivery

Sistema web de gerenciamento de pedidos de delivery desenvolvido com **Flask + MySQL**, contendo regras de negócio completas, procedures no banco e interface com Bootstrap.

---

## 🚀 Funcionalidades

* ✅ Criar pedidos
* ✅ Adicionar itens ao pedido
* ✅ Calcular total do pedido
* ✅ Fechar pedido
* ✅ Relatório de total gasto por cliente
* ✅ Filtro de pedidos por cliente e status
* ✅ Interface moderna com Bootstrap

---

## 🧠 Regras de Negócio

O sistema implementa validações diretamente no banco de dados:

* ✔️ Verifica se o cliente existe
* ✔️ Verifica se o entregador existe
* ✔️ Verifica se o entregador está disponível
* ❌ Impede criação de pedido com entregador ocupado
* ❌ Impede criação de pedido sem cliente válido
* ❌ Impede fechar pedido sem itens
* 🔄 Ao fechar pedido, o entregador volta a ficar disponível

---

## 📊 Status dos Pedidos

Os pedidos possuem os seguintes status:

* 🟡 **CRIADO** → Pedido em andamento
* 🟢 **FINALIZADO** → Pedido concluído

Na interface:

* "Aberto" → CRIADO
* "Fechado" → FINALIZADO

---

## 🧱 Tecnologias Utilizadas

* Python (Flask)
* MySQL
* HTML + Bootstrap 5

---

## 🗄️ Estrutura do Banco

Principais tabelas:

* `cliente`
* `entregador` 
* `pedido`
* `item_pedido`
* `prato`

---

## ⚙️ Procedures

### `sp_criar_pedido`

* Valida cliente
* Valida entregador
* Verifica disponibilidade
* Cria pedido
* Atualiza entregador para `OCUPADO`

### `sp_adicionar_item`

* Valida pedido
* Valida prato
* Verifica status do pedido

### `sp_fechar_pedido`

* Verifica se há itens
* Finaliza pedido
* Libera entregador (`DISPONIVEL`)

---

## 📈 Views

### `vw_detalhes_pedido`

Exibe:

* Pedido
* Cliente
* Prato
* Quantidade
* Status

### `vw_total_gasto_cliente`

Exibe:

* Cliente
* Total gasto

---

## 🖥️ Interface

O sistema possui:

* 📋 Listagem de pedidos
* 🎯 Filtro por cliente e status
* ➕ Criação de pedidos
* 🍽️ Adição de itens
* 💰 Tela de total por pedido
* 📊 Relatório por cliente

---

## ▶️ Como Executar

1. Clone o projeto
2. Configure o banco MySQL:

```sql
CREATE DATABASE delivery_db;
```

3. Execute os scripts SQL (tabelas, views e procedures)

4. Instale dependências:

```bash
pip install flask mysql-connector-python
```

5. Execute o projeto:

```bash
python app.py
```

6. Acesse:

```
http://localhost:5000
```

---

## 👨‍💻 Autor: Jose Adrian Santos Leite

Projeto desenvolvido para fins acadêmicos ( estudo de banco de dados + backend).

---
