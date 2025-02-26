CREATE DATABASE club_deportivo;

 USE club_deportivo;


-- Tabla socios
CREATE TABLE socios (
  id_socio INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  telefono VARCHAR(15),
  fecha_nacimiento DATE
);

-- Tabla eventos
CREATE TABLE eventos (
  id_evento INT AUTO_INCREMENT PRIMARY KEY,
  nombre_evento VARCHAR(100) NOT NULL,
  fecha DATE NOT NULL,
  lugar VARCHAR(100) NOT NULL
);

-- Tabla inscripciones
CREATE TABLE inscripciones (
  id_inscripcion INT AUTO_INCREMENT PRIMARY KEY,
  id_socio INT,
  id_evento INT,
  fecha_inscripcion DATE,
  FOREIGN KEY (id_socio) REFERENCES socios(id_socio),
  FOREIGN KEY (id_evento) REFERENCES eventos(id_evento)
);

-- 2.2 Inserción de Datos Iniciales
-- A continuación, insertaremos 20 socios de ejemplo en la tabla socios:
INSERT INTO socios (nombre, apellido, email, telefono, fecha_nacimiento) VALUES
('Juan', 'Pérez', 'juan.perez@example.com', '600000001', '1990-01-15'),
('Ana', 'Gómez', 'ana.gomez@example.com', '600000002', '1985-05-20'),
('Carlos', 'López', 'carlos.lopez@example.com', '600000003', '1992-03-10'),
('Laura', 'Martínez', 'laura.martinez@example.com', '600000004', '1998-07-25'),
('Miguel', 'Sánchez', 'miguel.sanchez@example.com', '600000005', '1980-11-30'),
('Lucía', 'Ramírez', 'lucia.ramirez@example.com', '600000006', '1994-09-05'),
('Sergio', 'Fernández', 'sergio.fernandez@example.com', '600000007', '1989-04-15'),
('María', 'Hernández', 'maria.hernandez@example.com', '600000008', '1996-08-20'),
('José', 'Díaz', 'jose.diaz@example.com', '600000009', '1987-12-01'),
('Raquel', 'Núñez', 'raquel.nunez@example.com', '600000010', '1991-06-17'),
('David', 'Castro', 'david.castro@example.com', '600000011', '1983-10-13'),
('Andrea', 'Moreno', 'andrea.moreno@example.com', '600000012', '1995-03-08'),
('Javier', 'Ruiz', 'javier.ruiz@example.com', '600000013', '1982-01-21'),
('Clara', 'Ortiz', 'clara.ortiz@example.com', '600000014', '1993-09-09'),
('Fernando', 'Vega', 'fernando.vega@example.com', '600000015', '1990-02-18'),
('Nerea', 'Gil', 'nerea.gil@example.com', '600000016', '1997-11-25'),
('Luis', 'Méndez', 'luis.mendez@example.com', '600000017', '1986-12-12'),
('Sofía', 'Domínguez', 'sofia.dominguez@example.com', '600000018', '1994-05-27'),
('Pedro', 'Fuentes', 'pedro.fuentes@example.com', '600000019', '1988-07-04'),
('Isabel', 'Cruz', 'isabel.cruz@example.com', '600000020', '1999-03-15');


