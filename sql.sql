-- CREACION DE LA BASE DE DATOS
CREATE DATABASE bd_clinica with owner=postgres encoding='UTF8';

-- ELIMINAR LAS TABLAS SI EXISTEN
DROP TABLE IF EXISTS tab_agendar_cita, tab_empleados, tab_especialidades, tab_tipo_cita, tab_usuarios;


-- CREACION DE LAS TABLAS
CREATE TABLE tab_usuarios (
    id_usuario VARCHAR(50) NOT NULL, 
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    fecha_retiro TIMESTAMP NULL,
    esactivo BOOLEAN DEFAULT true NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_usuario)
) ;

CREATE TABLE tab_especialidades (
    id_especialidad SERIAL, 
    tipo VARCHAR(50) NOT NULL,
    esactivo BOOLEAN DEFAULT true NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP, --  ON UPDATE CURRENT_TIMESTAMP,  
    PRIMARY KEY (id_especialidad)
) ;


CREATE TABLE tab_empleados (
    id_profesional SERIAL, 
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    id_especialidad int NOT NULL,
    sede VARCHAR(50) NOT NULL,
    esactivo BOOLEAN DEFAULT true NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  
    FOREIGN KEY (id_especialidad) REFERENCES tab_especialidades(id_especialidad),
    PRIMARY KEY (id_profesional)
) ;


CREATE TABLE tab_tipo_cita (
    id_tipo_cita SERIAL, 
    tipo VARCHAR(50) NOT NULL,
    esactivo BOOLEAN DEFAULT true NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  
    PRIMARY KEY (id_tipo_cita)
) ;



CREATE TYPE estado_cita_enum AS ENUM ('PENDIENTE', 'REALIZADA', 'CANCELADA', 'CONFIRMADA');
CREATE TABLE tab_agendar_cita (
    id_ac SERIAL PRIMARY KEY,
    id_usuario VARCHAR(50) NOT NULL,
    id_tipo_cita INT NOT NULL,
    id_profesional INT NOT NULL,
    fecha_cita TIMESTAMP NOT NULL,
    estado_cita estado_cita_enum DEFAULT 'PENDIENTE',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES tab_usuarios(id_usuario),
    FOREIGN KEY (id_tipo_cita) REFERENCES tab_tipo_cita(id_tipo_cita),
    FOREIGN KEY (id_profesional) REFERENCES tab_empleados(id_profesional)
);


    

-- INSERT
INSERT INTO tab_especialidades (tipo) VALUES ('Cardiólogo'), ('Dermatólogo'), ('Ginecobstetra'), ('Ginecólogo'), ('Internista'), ('Médico General'), ('Nutricionista'), ('Oftalmólogo'), ('Ortopedista'), ('Otorrinolaringólogo'), ('Pediatra'), ('Urólogo');

INSERT INTO tab_tipo_cita (tipo) VALUES  ('Cardiología'), ('Dermatología'), ('Ginecobstetricia'), ('Ginecología'), ('Internista'), ('Medicina General'), ('Nutricionista'), ('Oftalmología'), ('Ortopédia'), ('Otorrinolaringología'), ('Pediatría'), ('Urología');

INSERT INTO tab_empleados (nombre, apellido, email, id_especialidad, sede) VALUES  ('Juan Camilo','Reyes','quam.curabitur@aol.net', 1,'Centro'),  ('Carlos','Santodomingo','non.justo.proin@hotmail.org', 2,'Manila'),  ('erick','Leon','auctor.vitae@aol.edu',10,'Argentina'),  ('Oscar','Betancourt','risus@hotmail.ca',5,'Poblado'),  ('Franco','Escamilla','dictum.cursus@icloud.couk',3,'Rio'), ('Cameron','Díaz','amet@protonmail.com',9,'Bello'), ('Rosalia','Mejía','nec.tellus@icloud.org',8,'La Frontera'), ('Eliana','Barrios','ut.nisi.a@icloud.ca',7,'Manrique'), ('Lorena','Cano','egestas.fusce@icloud.net',6,'Itagui'), ('María','giraldo','lorem.vitae.odio@yahoo.org',4,'Caldas'), ('Juana','Umaña','cursus.nunc@google.edu',11,'Sabaneta'), ('Leidy','Muñoz','convallis.est@aol.edu',12,'Enciso');



-- VISTAS

create view vw_consultar_empleados as SELECT CONCAT(em.nombre,' ', em.apellido) as nombre_profesional, em.email, es.tipo, em.sede, em.fecha_creacion::date as fecha_creacion
FROM tab_empleados em
LEFT join tab_especialidades es on em.id_profesional = es.id_especialidad 
where em.esactivo = true  


