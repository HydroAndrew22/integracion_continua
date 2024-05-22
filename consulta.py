import psycopg2
from conexion import *

DB_HOST, DB_PORT, DB_NAME, DB_USER, DB_PASSWORD = consultar_db ()
# Conexión
try:
    conn = psycopg2.connect(
        dbname=DB_NAME, user=DB_USER,
        password=DB_PASSWORD, host=DB_HOST, port=DB_PORT
    )
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM holi")
    rows = cursor.fetchall()
    for row in rows:
        print(row)
    cursor.close()
    conn.close()
except psycopg2.Error as e:
    print("Error al conectar a la base de datos:", e)


