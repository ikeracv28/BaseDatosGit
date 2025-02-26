drop database if exists StreamWeb;
CREATE DATABASE IF NOT EXISTS StreamWeb;
USE StreamWeb;

-- Tabla de usuarios
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    correo VARCHAR(255) NOT NULL UNIQUE,
    edad INT NOT NULL,
    nombre_plan ENUM('Basico', 'Estandar', 'Premium') NOT NULL,
    duracion ENUM('Mensual', 'Anual') NOT NULL
);

create table administrador ( 
id_administrador int auto_increment primary key,
nombre varchar(100) not null,
correo_electronico varchar(100) not null unique,
contraseña varchar(100)
);

-- Tabla de paquetes (solo para definir los paquetes)
CREATE TABLE  paquetes (
    id_paquete INT AUTO_INCREMENT PRIMARY KEY,
    nombre_paquete ENUM('Deporte', 'Cine', 'Infantil') NOT NULL
);

-- Tabla intermedia para la relación muchos a muchos entre usuarios y paquetes
CREATE TABLE  usuarios_paquetes (
    id_usuario INT,
    id_paquete INT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_paquete) REFERENCES paquetes(id_paquete) ON DELETE CASCADE
);



INSERT INTO usuarios (nombre, apellidos, correo, edad, nombre_plan, duracion) 
VALUES 
('Juan', 'Pérez', 'juan.perez@email.com', 30, 'Basico', 'Mensual'),
('Ana', 'Gómez', 'ana.gomez@email.com', 25, 'Estandar', 'Anual'),
('Carlos', 'Ramírez', 'carlos.ramirez@email.com', 40, 'Premium', 'Mensual'),
('María', 'Fernández', 'maria.fernandez@email.com', 35, 'Estandar', 'Mensual'),
('Luis', 'Martínez', 'luis.martinez@email.com', 28, 'Basico', 'Anual');

insert into administrador (nombre, correo_electronico, contraseña) values
('Iker', 'ikeracv@gmail.com', 1234);

-- Insertar paquetes predefinidos
INSERT INTO paquetes (nombre_paquete) VALUES 
('Deporte'),
('Cine'),
('Infantil');

-- Insertar
INSERT INTO usuarios_paquetes (id_usuario, id_paquete) VALUES 
(1, 1), 
(2, 2),
(3, 3), 
(4, 2), 
(5, 1); 


SELECT 
    u.id_usuario,
    u.nombre,
    u.apellidos,
    u.correo,
    u.edad,
    u.nombre_plan,
    u.duracion,
    p.nombre_paquete
FROM 
    usuarios u
JOIN 
    usuarios_paquetes up ON u.id_usuario = up.id_usuario
JOIN 
    paquetes p ON up.id_paquete = p.id_paquete;
    
    SELECT u.id_usuario, u.nombre, u.apellidos, u.correo, u.edad, u.nombre_plan, u.duracion, p.nombre_paquete, CASE u.nombre_plan WHEN 'Basico' THEN 9.99 WHEN 'Estandar' THEN 13.99 WHEN 'Premium' THEN 17.99 END AS precio_plan, CASE p.nombre_paquete WHEN 'Deporte' THEN 6.99 WHEN 'Cine' THEN 7.99 WHEN 'Infantil' THEN 4.99 END AS precio_paquete, (CASE u.nombre_plan WHEN 'Basico' THEN 9.99 WHEN 'Estandar' THEN 13.99 WHEN 'Premium' THEN 17.99 END + CASE p.nombre_paquete WHEN 'Deporte' THEN 6.99 WHEN 'Cine' THEN 7.99 WHEN 'Infantil' THEN 4.99 END) AS total_pago FROM usuarios u JOIN usuarios_paquetes up ON u.id_usuario = up.id_usuario JOIN paquetes p ON up.id_paquete = p.id_paquete;