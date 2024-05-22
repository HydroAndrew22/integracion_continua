# Utiliza una imagen oficial de Python
FROM python:3.9

# Instala psycopg2 para conectarse a PostgreSQL
RUN pip install psycopg2-binary

# Copia el script de Python al contenedor
COPY consulta.py /consultar.py
COPY conexion.py /conexion.py

# Define el comando que se ejecutará cuando inicie el contenedor
CMD ["python", "/consultar.py"]