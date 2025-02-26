drop database if exists Hito_2;
create database Hito_2;
use Hito_2;



-- Tabla Usuarios
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    contraseña varchar(100) not null
);


-- Tabla tareas
CREATE TABLE tarea (
    id_tarea INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario int,
    descripcion TEXT NOT NULL,
    estado ENUM ("Pendiente", "Completado") DEFAULT "Pendiente",
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON UPDATE CASCADE ON DELETE CASCADE
);





