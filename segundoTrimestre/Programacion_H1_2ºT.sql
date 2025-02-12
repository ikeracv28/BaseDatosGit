drop database if exists stream1web;
-- Creamos la base de datos
CREATE DATABASE stream1web;
USE stream1web;


-- Tabla Planes con precios actualizados
CREATE TABLE plan (
    id_plan INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    dispositivos INT NOT NULL,  -- Número de dispositivos permitidos
    precio DECIMAL(10, 2) NOT NULL,
    duracion_suscripcion ENUM("Mensual","Anual")NOT NULL
);

-- Insertar los datos en la tabla Plan
INSERT INTO plan (nombre, dispositivos, precio, duracion_suscripcion) VALUES 
('Básico', 1, 9.99,'Mensual'),
('Básico', 1, 9.99 * 12,'Anual'),
('Estándar', 2, 13.99,'Mensual'),
('Estándar', 2, 13.99 * 12,'Anual'),
('Premium', 4, 17.99,'Mensual'),
('Premium', 4, 17.99 * 12,'Anual');

-- Tabla Paquetes con precios actualizados
CREATE TABLE paquetes (
    id_paquete INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL
);


-- Insertar los datos en la tabla Paquetes
INSERT INTO paquetes (nombre, precio) VALUES 
('Deporte', 6.99),
('Cine', 7.99),
('Infantil', 4.99);
-- Tabla administrador
CREATE TABLE administrador(
id_admin INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR (50) NOT NULL,
correo VARCHAR(100) NOT NULL,
contraseña VARCHAR(100) NOT NULL);
INSERT INTO administrador (nombre, correo, contraseña) VALUES
("Iker","ikeracv@gmail.com","1234");
 
-- Tabla Usuarios
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL UNIQUE,
    edad INT NOT NULL CHECK (edad >= 0)
);
INSERT INTO usuarios(nombre, apellidos, correo_electronico, edad) VALUES
("manolo","gomez", "manolo@mail.com","21");
-- Tabla Resumen (Relación entre Usuarios, Paquetes y Planes)
CREATE TABLE resumen(
    id_resumen INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    id_plan INT,
    id_paquete1 INT,
    id_paquete2 INT null,
    id_paquete3 INT null,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_paquete1) REFERENCES paquetes(id_paquete) ON DELETE CASCADE,
    FOREIGN KEY (id_paquete2) REFERENCES paquetes(id_paquete) ON DELETE CASCADE,
    FOREIGN KEY (id_paquete3) REFERENCES paquetes(id_paquete) ON DELETE CASCADE,
    FOREIGN KEY (id_plan) REFERENCES plan(id_plan) ON DELETE CASCADE
);
select * from usuarios;
select * from detalles;
select * from paquetes;
INSERT INTO detalles (id_usuario, id_plan, id_paquete1,id_paquete2) VALUES (1,2,3,2);
INSERT INTO detalles (id_usuario, id_plan, id_paquete1,id_paquete2) VALUES (2,2,3);
SELECT 
    u.*, 
    pl.nombre AS Plan_Obtenido,
    CONCAT_WS(', ', p1.nombre, p2.nombre, p3.nombre) AS Paquetes_Obtenidos,
    pl.dispositivos,
    (pl.precio + IFNULL(p1.precio, 0) + IFNULL(p2.precio, 0) + IFNULL(p3.precio, 0)) AS Precio_Total
FROM usuarios u
JOIN detalles r ON u.id_usuario = r.id_usuario
JOIN plan pl ON r.id_plan = pl.id_plan
LEFT JOIN paquetes p1 ON r.id_paquete1 = p1.id_paquete
LEFT JOIN paquetes p2 ON r.id_paquete2 = p2.id_paquete
LEFT JOIN paquetes p3 ON r.id_paquete3 = p3.id_paquete;

