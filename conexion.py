def consultar_db():
    # Configuración de la base de datos PostgreSQL
    DB_HOST = "my_postgres"  # Nombre del contenedor de PostgreSQL
    DB_PORT = 5432
    DB_NAME = "bd_clinica"
    DB_USER = "postgres"
    DB_PASSWORD = "root"

    return DB_HOST, DB_PORT, DB_NAME, DB_USER, DB_PASSWORD


# 
#     DB_HOST = "localhost"
#     DB_PORT = 5432
#     DB_NAME = "bd_clinica"
#     DB_USER = "usuario_consulta"
#     DB_PASSWORD = "consulta"
#

