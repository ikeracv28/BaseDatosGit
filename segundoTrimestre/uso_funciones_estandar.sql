-- Crear base de datos
CREATE DATABASE Supermercado;
USE Supermercado;

-- Tabla de Productos
CREATE TABLE Productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    precio DECIMAL(10, 2),
    medida VARCHAR(50),
    id_categoria INT,
    CONSTRAINT fk_categoria FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria)
);

-- Tabla de Clientes
CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    direccion VARCHAR(150),
    ciudad VARCHAR(50),
    telefono VARCHAR(20),
    cargo VARCHAR(50)
);

-- Tabla de Categorias
CREATE TABLE Categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50)
);

-- Tabla de Pedidos
CREATE TABLE Pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_producto INT,
    fecha_pedido DATE,
    fecha_entrega DATE,
    CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    CONSTRAINT fk_producto FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

-- Insertar datos en Categorias
INSERT INTO Categorias (nombre)
VALUES ('Electrónica'), ('Hogar'), ('Ropa'), ('Deportes');

-- Insertar datos en Productos
INSERT INTO Productos (nombre, precio, medida, id_categoria)
VALUES 
('Televisor', 500.50, '32 pulgadas', 1),
('Lavadora', 300.25, '6 kg', 2),
('Camiseta', 15.90, 'M', 3),
('Pelota', 20.00, 'Tamaño 5', 4),
('Microondas', 85.90, '60 centimetros', 2)
;

-- Insertar datos en Clientes
INSERT INTO Clientes (nombre, direccion, ciudad, telefono, cargo)
VALUES 
('Juan Pérez', 'Calle 123', 'Madrid', '123 456 789', 'Gerente'),
('Ana López', 'Avenida 456', 'Barcelona', '987 654 321', 'Vendedor'),
('Carlos Gómez', 'Plaza 789', 'Sevilla', '456 789 123', 'Cliente');

-- Insertar datos en Pedidos
INSERT INTO Pedidos (id_cliente, id_producto, fecha_pedido, fecha_entrega)
VALUES 
(1, 1, '2024-12-01', '2024-12-05'),
(2, 2, '2024-12-02', '2024-12-07'),
(3, 3, '2024-12-03', '2024-12-04');


-- 1. Mostrar los nombres de los productos convertidos a mayúsculas.
select upper(nombre) as nombre_en_mayusculas from Productos;

-- 2. Obtener el nombre de los clientes sustituyendo la letra a por un asterisco (*).
select replace(nombre, 'a','*') as nombre_modificado from clientes;

-- 3. Mostrar los primeros 5 caracteres de cada nombre de producto.
select left(nombre,5) as primeros_5_caracteres from productos;

-- 4. Listar las categorías de producto en orden inverso alfabético, pero solo mostrando el nombre al revés.
select reverse(nombre) as nombre_reverso from categorias order by nombre desc;

-- 5. Calcular el precio de cada producto redondeado al entero más cercano.
select nombre, round(precio) as precio_redondeado from productos;

-- 6. Mostrar la longitud del nombre de cada cliente.
select nombre, char_length(nombre) as longitud_nombre from clientes;

-- 7.  Extraer el año de la fecha de pedido para todos los pedidos.
select fecha_pedido, year(fecha_pedido) as año_pedido from pedidos;

-- 8.  Calcular la diferencia en días entre la fecha de pedido y la fecha de entrega de cada pedido.
select fecha_pedido, fecha_entrega, datediff(fecha_entrega, fecha_pedido) as diferencia_dias 
from pedidos;

-- 9. Mostrar el nombre de los clientes con la primera letra en mayúscula y las demás en minúscula.
select concat(upper(left(nombre,1)), lower(substring(nombre,2))) as nombre_formateado 
from clientes;

-- 10.  Concatenar el nombre del producto con su medida, separados por un guion (-).
select concat(nombre, '-', medida) as producto_con_medida from productos;

-- 11.  Mostrar solo el nombre en mayúsculas de los clientes que viven en ciudades cuyo nombre termina con una vocal.
select upper(nombre) as nombre_mayusculas from clientes
where ciudad like '%a' or ciudad like '%e' or ciudad like '%i' or ciudad like '%o' or ciudad like '%u';

-- 12.  Reemplazar las letras "a" en los nombres de producto por el símbolo @.
select replace(nombre, 'a', '@') as nombre_modificado from clientes;

-- 13.  Convertir la fecha de pedido al formato "DD/MM/YYYY".
select id_producto, date_format(fecha_pedido, '%d/%m/%y') as fecha_formateada from pedidos;

-- 14.  Calcular el precio de cada producto multiplicado por 1.21 (añadiendo IVA).
select nombre, precio, precio * 1.21 as precio_con_iva from productos;

-- 15.  Mostrar las 3 primeras letras de las categorías.
select left(nombre, 3) as primeras_3_letras from categorias;

-- 16.  Listar los nombres de productos que contengan exactamente 10 caracteres.
select nombre from productos where length(nombre) = 10;

-- 17.  Extraer el nombre del cliente junto al cargo entre paréntesis en la misma columna.
select concat(nombre, '(', cargo,')') as nombre_y_cargo from clientes;

-- 18.  Mostrar el número de teléfono de los clientes con guiones en lugar de espacios en blanco.
select replace(telefono,' ', '-') as telefono_guiones from clientes;

-- 19.  Obtener la parte del nombre del cliente antes del primer espacio en blanco.
select substring_index(nombre, ' ', 1) as primer_nombre from clientes;

-- 20.  Calcular el día de la semana en que se realizó cada pedido.
select fecha_pedido, dayname(fecha_pedido) as dia_semana from pedidos;