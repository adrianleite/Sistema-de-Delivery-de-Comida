from flask import Flask, render_template, request, redirect
import mysql.connector

app = Flask(__name__)

def conectar():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="root",
        database="delivery_db"
    )

# HOME
@app.route("/")
def index():
    cliente = request.args.get("cliente")
    status = request.args.get("status")

    con = conectar()
    cursor = con.cursor(dictionary=True)

    query = """
        SELECT * FROM vw_detalhes_pedido
        WHERE 1=1
    """
    params = []

    if cliente:
        query += " AND cliente LIKE %s"
        params.append(f"%{cliente}%")

    if status:
        query += " AND status = %s"
        params.append(status)

    cursor.execute(query, params)
    pedidos = cursor.fetchall()

    cursor.close()
    con.close()

    return render_template("index.html", pedidos=pedidos)

# CRIAR PEDIDO
@app.route("/criar", methods=["GET", "POST"])
def criar():
    if request.method == "POST":
        id_cliente = request.form["cliente"]
        id_entregador = request.form["entregador"]

        con = conectar()
        cursor = con.cursor()
        try:
            cursor.callproc('sp_criar_pedido', [id_cliente, id_entregador])
            con.commit()
        except Exception as e:
            print(e)

        cursor.close()
        con.close()

        return redirect("/")

    return render_template("criar_pedido.html")

# ADICIONAR ITEM
@app.route("/item", methods=["GET", "POST"])
def item():
    con = conectar()
    cursor = con.cursor(dictionary=True)

    if request.method == "POST":
        id_pedido = request.form["pedido"]
        id_prato = request.form["prato"]
        quantidade = request.form["quantidade"]

        try:
            cursor.callproc('sp_adicionar_item', [id_pedido, id_prato, quantidade])
            con.commit()
        except Exception as e:
            print(e)

        cursor.close()
        con.close()
        return redirect("/")

    # 🔽 buscar pedidos e pratos
    cursor.execute("SELECT id_pedido FROM pedido WHERE status = 'CRIADO'")
    pedidos = cursor.fetchall()

    cursor.execute("SELECT id_prato, nome FROM prato")
    pratos = cursor.fetchall()

    cursor.close()
    con.close()

    return render_template("adicionar_item.html", pedidos=pedidos, pratos=pratos)

# TOTAL
@app.route("/total/<int:id>")
def total(id):
    con = conectar()
    cursor = con.cursor()
    cursor.execute(f"SELECT fn_total_pedido({id})")
    total = cursor.fetchone()[0]

    cursor.close()
    con.close()

    return f"Total do pedido {id}: R$ {total}"

# FECHAR
@app.route("/fechar/<int:id>")
def fechar(id):
    con = conectar()
    cursor = con.cursor()

    try:
        cursor.callproc('sp_fechar_pedido', [id])
        con.commit()
    except Exception as e:
        print(e)

    cursor.close()
    con.close()

    return redirect("/")

if __name__ == "__main__":
    app.run(debug=True)

