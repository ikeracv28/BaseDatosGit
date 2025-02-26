drop database if exists empresa;
create database empresa;

create table empleados (
id_empleado serial primary key,
nombre varchar(100),
apellido varchar(100),
fecha_nacimiento date,
puesto varchar(100),
antiguedad int,
salario decimal(10,2)
);

create table departamentos (
id_departamento serial primary key,
nombre_departamento varchar(100)
);

create table proyectos (
id_proyecto serial primary key,
nombre_proyecto varchar(100),
fecha_inicio date,
id_departamento int,
foreign key (id_departamento) references departamentos(id_departamento)
on delete cascade 
on update cascade);

INSERT INTO departamentos (nombre_departamento) VALUES 
('Finanzas'),
('Atención al Cliente'),
('Ingeniería');

INSERT INTO proyectos (nombre_proyecto, fecha_inicio, id_departamento) VALUES 
('Optimización de Presupuesto', '2024-02-15', 1), -- Finanzas
('Sistema de Tickets', '2024-04-01', 2),         -- Atención al Cliente
('Diseño de Nuevo Producto', '2024-05-10', 3);   -- Ingeniería


INSERT INTO empleados (nombre, apellido, fecha_nacimiento, puesto, salario) VALUES
('Iker', 'Acevedo', '1992-06-14', 'Analista Financiero', 4200.00), -- Finanzas
('Rafael', 'Medina', '1989-09-25', 'Contador', 4000.00),          -- Finanzas
('Alejandro', 'Tovar', '1993-11-12', 'Gestor de Inversiones', 4500.00), -- Finanzas
('Marcos', 'Perez', '1995-04-08', 'Soporte Técnico', 3200.00),   -- Atención al Cliente
('Richi', 'Rich', '1997-07-30', 'Representante de Atención', 2900.00), -- Atención al Cliente
('Iris', 'Perez', '1994-01-22', 'Supervisor de Servicio', 3600.00), -- Atención al Cliente
('Amanda', 'Mandona', '1988-10-18', 'Ingeniera de Producto', 5000.00), -- Ingeniería
('Ian', 'Fernandez', '1996-03-05', 'Ingeniero de Software', 4800.00), -- Ingeniería
('Sergio', 'Gomez', '1991-12-09', 'Diseñador de Hardware', 4700.00), -- Ingeniería
('Sergio', 'Arroyo', '1990-08-28', 'Gerente de Ingeniería', 5500.00); -- Ingeniería


create procedure 
