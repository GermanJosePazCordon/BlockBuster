from flask import Flask, jsonify
import psycopg2

app = Flask(__name__)
 
@app.route("/")
def home():
    tmp = "<h1>"
    tmp += "PRACTICA LABORATORIO DE MANEJO E IMPLEMENTACION DE ARCHIVOS"
    tmp += "<br>"
    tmp += "SECCION B"
    tmp += "<br>"
    tmp += "GERMAN JOSE PAZ CORDON"
    tmp += "<br>"
    tmp += "201902934"
    tmp += "</h1>"
    return tmp

@app.route("/cargarTemporal")
def cargarTemporal():
    con = psycopg2.connect(
        host = "localhost",
        database = "mia",
        user = "postgres",
        password = "postgres"
    )
    cur = con.cursor()
    cur.execute(open("./endpoints/cargarTemporal.sql", "r").read())
    cur.close()
    con.close()
    tmp = "<h1>"
    tmp += "DATOS CARGADOS CORECTAMENTE"
    tmp += "<br>"
    tmp += "</h1>"
    return tmp

@app.route("/eliminarTemporal")
def eliminarTemporal():
    con = psycopg2.connect(
        host = "localhost",
        database = "mia",
        user = "postgres",
        password = "postgres"
    )
    cur = con.cursor()
    cur.execute(open("./endpoints/eliminarTemporal.sql", "r").read())
    cur.close()
    con.close()
    tmp = "<h1>"
    tmp += "DATOS ELIMINADOS CORRECTAMENTE"
    tmp += "<br>"
    tmp += "</h1>"
    return tmp

@app.route("/cargarModelo")
def cargarModelo():
    con = psycopg2.connect(
        host = "localhost",
        database = "mia",
        user = "postgres",
        password = "postgres"
    )
    cur = con.cursor()
    cur.execute(open("./Tablas.sql", "r").read())
    cur.close()
    con.close()

    con = psycopg2.connect(
        host = "localhost",
        database = "mia",
        user = "postgres",
        password = "postgres"
    )
    cur = con.cursor()
    cur.execute(open("./LlenarTablas.sql", "r").read())
    cur.close()
    con.close()
    tmp = "<h1>"
    tmp += "TABLAS CREADAS CORRECTAMENTE"
    tmp += "<br>"
    tmp += "</h1>"
    return tmp

@app.route("/eliminarModelo")
def eliminarModelo():
    con = psycopg2.connect(
        host = "localhost",
        database = "mia",
        user = "postgres",
        password = "postgres"
    )
    cur = con.cursor()
    cur.execute(open("./endpoints/eliminarModelo.sql", "r").read())
    cur.close()
    con.close()
    tmp = "<h1>"
    tmp += "TABLAS ELIMINADAS CORRECTAMETE"
    tmp += "<br>"
    tmp += "</h1>"
    return tmp

@app.route("/consulta1")
def consulta1():
    con = psycopg2.connect(
        host = "localhost",
        database = "mia",
        user = "postgres",
        password = "postgres"
    )
    cur = con.cursor()
    cur.execute(open("./endpoints/consulta1.sql", "r").read())
    rows = cur.fetchall()
    tmp = "<h2>"
    tmp += "CONSULTA #1"
    tmp += "<br>"
    tmp += "</h2>"
    tmp += '<table class="default">'
    tmp +=  '<tr>'
    tmp += '<th>Numero de copias</th>'
    tmp += '</tr>'
    tmp += '<tr>'
    tmp += '<th>-----------------------</th>'
    tmp +=  '</tr>'
    for i in rows:
        tmp +=  '<tr>'
        tmp +=  '<td>' + str(i[0]) + '</td>'
        tmp += '</tr>'
    tmp += '</table>'
    cur.close()
    con.close()
    return tmp

@app.route("/consulta2")
def consulta2():
    con = psycopg2.connect(
        host = "localhost",
        database = "mia",
        user = "postgres",
        password = "postgres"
    )
    cur = con.cursor()
    cur.execute(open("./endpoints/consulta2.sql", "r").read())
    rows = cur.fetchall()
    tmp = "<h2>"
    tmp += "CONSULTA #2"
    tmp += "<br>"
    tmp += "</h2>"
    tmp += '<table class="default">'
    tmp +=  '<tr>'
    tmp += '<th>Nombre</th><th>Apellido</th><th>Monto</th>'
    tmp += '</tr>'
    tmp +=  '<tr>'
    tmp += '<th>-----------</th><th>----------</th><th>---------</th>'
    tmp +=  '</tr>'
    for i in rows:
        tmp +=  '<tr>'
        tmp +=  '<td>' + str(i[0]) + '</td><td>' +  str(i[1]) + '</td><td>' + str(i[2]) + '</td>'
        tmp += '</tr>'
    tmp += '</table>'
    cur.close()
    con.close()
    return tmp

@app.route("/consulta3")
def consulta3():
    con = psycopg2.connect(
        host = "localhost",
        database = "mia",
        user = "postgres",
        password = "postgres"
    )
    cur = con.cursor()
    cur.execute(open("./endpoints/consulta3.sql", "r").read())
    rows = cur.fetchall()
    tmp = "<h2>"
    tmp += "CONSULTA #3"
    tmp += "<br>"
    tmp += "</h2>"
    tmp += '<table class="default">'
    tmp +=  '<tr>'
    tmp += '<th>Nombre completo</th>'
    tmp += '</tr>'
    tmp += '<tr>'
    tmp += '<th>-----------------------</th>'
    tmp +=  '</tr>'
    for i in rows:
        tmp +=  '<tr>'
        tmp +=  '<td>' + str(i[0]) + '</td>'
        tmp += '</tr>'
    tmp += '</table>'
    cur.close()
    con.close()
    return tmp

@app.route("/consulta4")
def consulta4():
    con = psycopg2.connect(
        host = "localhost",
        database = "mia",
        user = "postgres",
        password = "postgres"
    )
    cur = con.cursor()
    cur.execute(open("./endpoints/consulta4.sql", "r").read())
    rows = cur.fetchall()
    tmp = "<h2>"
    tmp += "CONSULTA #4"
    tmp += "<br>"
    tmp += "</h2>"
    tmp += '<table class="default">'
    tmp +=  '<tr>'
    tmp += '<th>Nombre</th><th>Apellido</th><th>Lanzamiento</th>'
    tmp += '</tr>'
    tmp +=  '<tr>'
    tmp += '<th>-----------------</th><th>-------------------</th><th>-------------------</th>'
    tmp +=  '</tr>'
    for i in rows:
        tmp +=  '<tr>'
        tmp +=  '<td>' + str(i[0]) + '</td><td>' +  str(i[1]) + '</td><td>' + str(i[2]) + '</td>'
        tmp += '</tr>'
    tmp += '</table>'
    cur.close()
    con.close()
    return tmp

@app.route("/consulta5")
def consulta5():
    con = psycopg2.connect(
        host = "localhost",
        database = "mia",
        user = "postgres",
        password = "postgres"
    )
    cur = con.cursor()
    cur.execute(open("./endpoints/consulta5.sql", "r").read())
    rows = cur.fetchall()
    tmp = "<h2>"
    tmp += "CONSULTA #5"
    tmp += "<br>"
    tmp += "</h2>"
    tmp += '<table class="default">'
    tmp +=  '<tr>'
    tmp += '<th>Nombre</th><th>Apellido</th><th>Pais</th><th>Porcentaje</th>'
    tmp += '</tr>'
    tmp +=  '<tr>'
    tmp += '<th>-----------</th><th>----------</th><th>------------</th><th>---------------</th>'
    tmp +=  '</tr>'
    for i in rows:
        tmp +=  '<tr>'
        tmp +=  '<td>' + str(i[0]) + '</td><td>' +  str(i[1]) + '</td><td>' + str(i[2]) + '</td><td>' + str(i[3]) + '</td>'
        tmp += '</tr>'
    tmp += '</table>'
    cur.close()
    con.close()
    return tmp

@app.route("/consulta6")
def consulta6():
    con = psycopg2.connect(
        host = "localhost",
        database = "mia",
        user = "postgres",
        password = "postgres"
    )
    cur = con.cursor()
    cur.execute(open("./endpoints/consulta6.sql", "r").read())
    rows = cur.fetchall()
    tmp = "<h2>"
    tmp += "CONSULTA #6"
    tmp += "<br>"
    tmp += "</h2>"
    tmp += '<table class="default">'
    tmp +=  '<tr>'
    tmp += '<th>Pais</th><th>Clientes por pais</th><th>Ciudad</th><th>Clientes por ciudad</th><th>Porcentaje</th>'
    tmp += '</tr>'
    tmp +=  '<tr>'
    tmp += '<th>-----------------------------------------------</th><th>-------------------------</th><th>-------------------------------------</th><th>--------------------------</th><th>-----------------</th>'
    tmp +=  '</tr>'
    for i in rows:
        tmp +=  '<tr>'
        tmp +=  '<td>' + str(i[0]) + '</td><td>' +  str(i[1]) + '</td><td>' + str(i[2]) + '</td><td>' + str(i[3]) + '</td><td>' + str(i[4]) + '</td>'
        tmp += '</tr>'
    tmp += '</table>'
    cur.close()
    con.close()
    return tmp

@app.route("/consulta7")
def consulta7():
    con = psycopg2.connect(
        host = "localhost",
        database = "mia",
        user = "postgres",
        password = "postgres"
    )
    cur = con.cursor()
    cur.execute(open("./endpoints/consulta7.sql", "r").read())
    rows = cur.fetchall()
    tmp = "<h2>"
    tmp += "CONSULTA #7"
    tmp += "<br>"
    tmp += "</h2>"
    tmp += '<table class="default">'
    tmp +=  '<tr>'
    tmp += '<th>Pais</th><th>Ciudad</th><th>Promedio</th>'
    tmp += '</tr>'
    tmp +=  '<tr>'
    tmp += '<th>-----------------------------------------------</th><th>-------------------------------------</th><th>-----------------</th>'
    tmp +=  '</tr>'
    for i in rows:
        tmp +=  '<tr>'
        tmp +=  '<td>' + str(i[0]) + '</td><td>' +  str(i[1]) + '</td><td>' + str(i[2]) + '</td>'
        tmp += '</tr>'
    tmp += '</table>'
    cur.close()
    con.close()
    return tmp

@app.route("/consulta8")
def consulta8():
    con = psycopg2.connect(
        host = "localhost",
        database = "mia",
        user = "postgres",
        password = "postgres"
    )
    cur = con.cursor()
    cur.execute(open("./endpoints/consulta8.sql", "r").read())
    rows = cur.fetchall()
    tmp = "<h2>"
    tmp += "CONSULTA #8"
    tmp += "<br>"
    tmp += "</h2>"
    tmp += '<table class="default">'
    tmp +=  '<tr>'
    tmp += '<th>Pais</th><th>Porcentaje</th>'
    tmp += '</tr>'
    tmp +=  '<tr>'
    tmp += '<th>----------------------------------------------------</th><th>-----------------</th>'
    tmp +=  '</tr>'
    for i in rows:
        tmp +=  '<tr>'
        tmp +=  '<td>' + str(i[0]) + '</td><td>' +  str(i[1]) + '</td>'
        tmp += '</tr>'
    tmp += '</table>'
    cur.close()
    con.close()
    return tmp

@app.route("/consulta9")
def consulta9():
    con = psycopg2.connect(
        host = "localhost",
        database = "mia",
        user = "postgres",
        password = "postgres"
    )
    cur = con.cursor()
    cur.execute(open("./endpoints/consulta9.sql", "r").read())
    rows = cur.fetchall()
    tmp = "<h2>"
    tmp += "CONSULTA #9"
    tmp += "<br>"
    tmp += "</h2>"
    tmp += '<table class="default">'
    tmp +=  '<tr>'
    tmp += '<th>Ciudad</th><th>Numero de rentas</th>'
    tmp += '</tr>'
    tmp +=  '<tr>'
    tmp += '<th>--------------------------------------</th><th>-------------------------</th>'
    tmp +=  '</tr>'
    for i in rows:
        tmp +=  '<tr>'
        tmp +=  '<td>' + str(i[0]) + '</td><td>' +  str(i[1]) + '</td>'
        tmp += '</tr>'
    tmp += '</table>'
    cur.close()
    con.close()
    return tmp

@app.route("/consulta10")
def consulta10():
    con = psycopg2.connect(
        host = "localhost",
        database = "mia",
        user = "postgres",
        password = "postgres"
    )
    cur = con.cursor()
    cur.execute(open("./endpoints/consulta10.sql", "r").read())
    rows = cur.fetchall()
    tmp = "<h2>"
    tmp += "CONSULTA #10"
    tmp += "<br>"
    tmp += "</h2>"
    tmp += '<table class="default">'
    tmp +=  '<tr>'
    tmp += '<th>Pais</th><th>Ciudad</th>'
    tmp += '</tr>'
    tmp +=  '<tr>'
    tmp += '<th>---------------------------------------------</th><th>-------------------------</th>'
    tmp +=  '</tr>'
    for i in rows:
        tmp +=  '<tr>'
        tmp +=  '<td>' + str(i[0]) + '</td><td>' +  str(i[1]) + '</td>'
        tmp += '</tr>'
    tmp += '</table>'
    cur.close()
    con.close()
    return tmp

if __name__ == '__main__':
    app.run(debug=True)


