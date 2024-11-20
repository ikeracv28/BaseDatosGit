-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS ejercicios_crud;
USE ejercicios_crud;

-- Crear la tabla 'clientes'
CREATE TABLE IF NOT EXISTS clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(15),
    puntos INT DEFAULT 0,
    fecha_registro DATE,
    fecha_modificacion DATETIME
);

-- Insertar registros en la tabla 'clientes'
INSERT INTO clientes (nombre, email, telefono, puntos, fecha_registro)
VALUES 
    ('Juan Perez', 'juan@mail.com', '123456789', 100, '2020-01-15'),
    ('Ana Lopez', 'ana@mail.com', NULL, 80, '2019-03-20'),
    ('Laura Gomez', 'laura@mail.com', '111222333', 50, '2018-05-12'),
    ('Pedro Ramirez', 'pedro@mail.com', '555444333', 120, '2017-07-19'),
    ('Marta Diaz', 'marta@mail.com', '666777888', 200, '2021-09-01'),
    ('Luis Lopez', 'luis@mail.com', '333444555', 150, '2016-11-22'),
    ('Carlos Sanchez', 'carlos@mail.com', '999888777', 90, '2023-04-10'),
    ('Carlos Ruiz', 'carlos.ruiz@mail.com', '222333444', 110, '2023-02-28'),
    ('Sofia Ortiz', 'sofia@mail.com', '123456789', 30, '2023-08-15');

-- Verificar la creación y los datos
SELECT * FROM clientes;


-- Insert: ¿Cómo se inserta un nuevo cliente en una tabla llamada clientes con los campos nombre, email y telefono?
insert into clientes (nombre, email, telefono)
values
	('Iker Acevedo', 'ikeracv@gmail.com', '622315742');
    

-- Update: ¿Cómo se actualiza el campo telefono de un cliente cuyo ID es 1?
UPDATE clientes set telefono= '622334455' where id= '1';

-- Delete: ¿Cómo se elimina un registro de la tabla clientes donde el nombre es 'Juan Perez'?
delete from clientes where nombre='Juan Perez';

-- Insert: ¿Cómo se inserta un nuevo cliente sin un número de teléfono en la tabla clientes?
insert into clientes (nombre, email, puntos, fecha_registro)
values ('Alejandro Torero', 'jandrole@gmail.com', '200', '2021-07-11');

-- Update: ¿Cómo se actualiza el email de todos los clientes cuyo nombre es 'Juan Perez'?
replace into clientes (id, nombre, email, telefono, puntos, fecha_registro)
 values ('1','Juan Perez', 'juanitomaravilla@mail.com', '123456789', 100, '2020-01-15');

-- Insert: ¿Cómo se inserta un cliente con valores por defecto para los campos puntos y fecha_registro?
insert into clientes (nombre, email, telefono, puntos, fecha_registro)
values ('rafiki', 'rafikihijo', '633445565', default, default);

-- Update: ¿Cómo se actualizan los puntos de todos los clientes que tienen el mismo email que 'correo@mail.com'?
update clientes set puntos=1000 where email='correo@gmail.com';

-- Delete: ¿Cómo se eliminan todos los clientes cuyo número de teléfono es nulo?
delete from clientes where telefono is null;

-- Insert: ¿Cómo se inserta un nuevo cliente en la tabla clientes, pero solo si no existe otro cliente con el mismo email?
-- se hace en clase el siguiente dia

-- Update: ¿Cómo se cambia el nombre de un cliente con email específico a 'Cliente Actualizado'?
update clientes set nombre= 'Cliente Actualizado' where email='carlos@mail.com';

-- Delete: ¿Cómo se eliminan todos los clientes que tienen menos de 50 puntos?
delete from clientes where puntos < '50';

-- Update: ¿Cómo se actualiza el telefono de todos los clientes para agregar un prefijo '34-' al inicio de cada número de teléfono?
update clientes set telefono= concat('34-', telefono)  where telefono is not null; 

-- Insert: ¿Cómo se insertan varios clientes en una sola consulta?
insert into clientes(nombre, email, telefono, puntos, fecha_registro)
values  
('Richi edit', 'laura@mail.com', '111222333', 50, '2018-05-12'),
('Pedro Ramirez', 'pedro@mail.com', '555444333', 120, '2017-07-19');

-- Update: ¿Cómo se reinicia a cero el campo puntos para todos los clientes cuyo nombre empiece con 'A'?
update clientes set puntos= '0' where nombre like 'J%' ;

-- Insert: ¿Cómo se inserta un cliente utilizando un subquery para calcular su puntos inicial basado en el promedio de todos los puntos?
insert into clientes(nombre, email, telefono, fecha_registro)
values ('Marcos Escolar', 'marquitos24@gmail.com', '666555444' , (SELECT AVG(puntos) FROM clientes), '2024-05-19');
 

-- Delete: ¿Cómo se eliminan todos los clientes registrados hace más de 5 años usando un campo fecha_registro?
delete from clientes where fecha_registro > 5 year ;

-- Update: ¿Cómo se incrementan los puntos de todos los clientes con más de 100 puntos y se actualiza la fecha de modificación a la fecha actual?


-- Insert: ¿Cómo se inserta un cliente y se devuelve el ID generado utilizando la función LAST_INSERT_ID()?


-- Update: ¿Cómo se actualizan los puntos de todos los clientes a la mitad de su valor actual?


-- Delete: ¿Cómo se eliminan todos los clientes cuyo telefono comienza con el prefijo '123-'?
