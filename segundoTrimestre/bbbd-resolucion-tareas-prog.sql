-- Crear la base de datos

CREATE DATABASE gestor_tareas;

USE gestor_tareas;


-- Crear la tabla usuarios

CREATE TABLE usuarios (

    id INT PRIMARY KEY AUTO_INCREMENT,

    nombre_usuario VARCHAR(100) NOT NULL,

    correo VARCHAR(100) NOT NULL UNIQUE,

    contrasena VARCHAR(255) NOT NULL

);


-- Crear la tabla tareas

CREATE TABLE tareas (

    id_tarea INT PRIMARY KEY AUTO_INCREMENT,

    id_usuario INT NOT NULL,

    titulo VARCHAR(255) NOT NULL,

    descripcion TEXT NOT NULL,

    estado ENUM('pendiente', 'completada') NOT NULL DEFAULT 'pendiente',

    FOREIGN KEY (id_usuario) REFERENCES usuarios(id) ON DELETE CASCADE

);


-- Inserciones en la tabla usuarios

INSERT INTO usuarios (nombre_usuario, correo, contrasena) VALUES

('Juan Pérez', 'juan.perez@example.com', 'contrasena123'),

('Ana Gómez', 'ana.gomez@example.com', 'contrasena456');


-- Inserciones en la tabla tareas

INSERT INTO tareas (id_usuario, titulo, descripcion, estado) VALUES

(1, 'Tarea 1', 'Descripción de la tarea 1', 'pendiente'),

(1, 'Tarea 2', 'Descripción de la tarea 2', 'completada'),

(2, 'Tarea 3', 'Descripción de la tarea 3', 'pendiente');


select * from usuarios;