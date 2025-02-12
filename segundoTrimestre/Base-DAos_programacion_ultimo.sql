-- Creamos la base de datos
drop database if exists streamWeb;
CREATE DATABASE streamWeb;
USE streamWeb;


-- Tabla Planes con precios actualizados
CREATE TABLE plan (
    id_plan INT AUTO_INCREMENT PRIMARY KEY,
    nombre_plan VARCHAR(50) NOT NULL,
    dispositivos INT NOT NULL,  -- Número de dispositivos permitidos
    precio DECIMAL(10, 2) NOT NULL,
    duracion_suscripcion ENUM("Mensual","Anual")NOT NULL
);

-- Insertar los datos en la tabla Plan
INSERT INTO plan (nombre_plan, dispositivos, precio, duracion_suscripcion) VALUES 
('Básico', 1, 9.99,'Mensual'),
('Básico', 1, 9.99 * 12,'Anual'),
('Estándar', 2, 13.99,'Mensual'),
('Estándar', 2, 13.99 * 12,'Anual'),
('Premium', 4, 17.99,'Mensual'),
('Premium', 4, 17.99 * 12,'Anual');

-- Tabla Paquetes con precios actualizados
CREATE TABLE paquetes (
    id_paquete INT AUTO_INCREMENT PRIMARY KEY,
    nombre_paquete VARCHAR(50) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL
);

-- Insertar los datos en la tabla Paquetes
INSERT INTO paquetes (nombre_paquete, precio) VALUES 
('Deporte', 6.99),
('Cine', 7.99),
('Infantil', 4.99);

-- Tabla Usuarios
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL UNIQUE,
    contraseña varchar(100) not null,
    edad INT NOT NULL CHECK (edad >= 0)
);

-- Tabla Resumen (Relación entre Usuarios, Paquetes y Planes)
CREATE TABLE resumen (
    id_resumen int auto_increment primary key,
    id_usuario INT,
    id_plan INT,
    id_paquete1 int,
    id_paquete2 int null,
    id_paquete3 int null,
    FOREIGN KEY (id_usuario) references usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_paquete1) REFERENCES paquetes(id_paquete) ON DELETE CASCADE,
	FOREIGN KEY (id_paquete2) REFERENCES paquetes(id_paquete) ON DELETE CASCADE,
	FOREIGN KEY (id_paquete3) REFERENCES paquetes(id_paquete) ON DELETE CASCADE,
    FOREIGN KEY (id_plan) REFERENCES plan(id_plan) ON DELETE CASCADE
);

create table administrador (
id_admin int primary key auto_increment,
nombre varchar(100) not null,
correo varchar(100) not null unique,
contraseña varchar(100) not null
);

insert into administrador (nombre, correo, contraseña) values
("Iker", "ikeracv@gmail.com", "$2a$12$L6yc3I5iwd3uEHjYlo2Wzu6hB1kKVCAhU8xOGdqOxfuIRmIRVKl8e");

insert into usuarios (nombre, apellido, correo_electronico, contraseña, edad) values
("Sergio", "Cabezon", "cabeza@gmail.com", "1234", 23),
("Rafa", "Agustin", "rafote@gmail.com", "1234", 23);

insert into resumen (id_usuario, id_plan, id_paquete1, id_paquete2, id_paquete3) values (2,3,2,null,null);
insert into resumen (id_usuario, id_plan, id_paquete1, id_paquete2, id_paquete3) values (1,6,1,2,3);
SELECT 
    u.*, 
    pl.nombre_plan AS Plan_Obtenido,
    CONCAT_WS(', ', p1.nombre_paquete, p2.nombre_paquete, p3.nombre_paquete) AS Paquetes_Obtenidos,
    pl.dispositivos,
    (pl.precio + IFNULL(p1.precio, 0) + IFNULL(p2.precio, 0) + IFNULL(p3.precio, 0)) AS Precio_Total
FROM Usuarios u
JOIN Resumen r ON u.id_usuario = r.id_usuario
JOIN Plan pl ON r.id_plan = pl.id_plan
LEFT JOIN Paquetes p1 ON r.id_paquete1 = p1.id_paquete
LEFT JOIN Paquetes p2 ON r.id_paquete2 = p2.id_paquete
LEFT JOIN Paquetes p3 ON r.id_paquete3 = p3.id_paquete;

select * from usuarios;
select * from administrador;
show tables;

SELECT * FROM usuarios u left join Resumen r ON u.id_usuario = r.id_usuario where r.id_usuario IS NULL;
select * from resumen;