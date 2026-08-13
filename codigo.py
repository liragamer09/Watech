
from flask import Flask, render_template, request
import mysql.connector
from werkzeug.security import generate_password_hash


app = Flask(__name__)


def conectar_banco():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="root",
        database="user_watech"
    )


@app.route("/signup", methods=["GET", "POST"])
def signup():

    if request.method == "POST":
       
        nome = request.form.get("nome_user")
        email = request.form.get("email")
        senha_digitada = request.form.get("senha")
        nascimento = request.form.get("data_nascimento")
        
        senha_segura = generate_password_hash(senha_digitada)
        
        try:
           
            conexao = conectar_banco()
            cursor = conexao.cursor()
            
            
            comando_sql = """
            INSERT INTO users (nome_user, email, senha, data_nascimento) 
            VALUES (%s, %s, %s, %s)
            """
            
         
            valores = (nome, email, senha_segura, nascimento)
            
           
            cursor.execute(comando_sql, valores)
            conexao.commit()
            
            
            cursor.close()
            conexao.close()
            
            return "<h1>Sucesso! Usuário cadastrado na Watech!</h1>"
            
        except mysql.connector.Error as erro:

            return f"<h1>Ocorreu um erro no banco de dados: {erro}</h1>"


    return render_template("cadastro.html")


if __name__ == "__main__":
    app.run(debug=True)