
drop database if exists supermercado;
-- Crear base de datos
CREATE DATABASE if not exists supermercado;
USE Supermercado;

-- Tabla de Productos
CREATE TABLE if not exists Productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    precio DECIMAL(10, 2),
    medida VARCHAR(50),
    id_categoria INT,
    CONSTRAINT fk_categoria FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria)
);

-- Tabla de Clientes
CREATE TABLE if not exists Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    direccion VARCHAR(150),
    ciudad VARCHAR(50),
    telefono VARCHAR(20),
    cargo VARCHAR(50)
);

-- Tabla de Categorias
CREATE TABLE if not exists Categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50)
);

-- Tabla de Pedidos
CREATE TABLE if not exists Pedidos (
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


-- 1. Seleccionar todos los productos disponibles
SELECT * FROM Productos;

-- 2. Listar los clientes con sus ciudades
SELECT nombre, ciudad FROM Clientes;

-- 3. Mostrar los pedidos realizados y sus fechas de entrega
SELECT * FROM Pedidos;

-- 4. Consultar los productos que tienen un precio mayor a 100
SELECT nombre, precio FROM Productos WHERE precio > 100;

-- 5. Obtener los pedidos realizados por "Juan Pérez"
SELECT * 
FROM Pedidos 
WHERE id_cliente = (SELECT id_cliente FROM Clientes WHERE nombre = 'Juan Pérez');

-- 6. Listar los productos y su categoría correspondiente
SELECT Productos.nombre AS producto, Categorias.nombre AS categoria
FROM Productos
JOIN Categorias ON Productos.id_categoria = Categorias.id_categoria;

-- 7. Consultar los clientes que viven en "Madrid"
SELECT * FROM Clientes WHERE ciudad = 'Madrid';

-- 8. Mostrar el total de pedidos realizados por cada cliente
SELECT Clientes.nombre, COUNT(Pedidos.id_pedido) AS total_pedidos
FROM Clientes
JOIN Pedidos ON Clientes.id_cliente = Pedidos.id_cliente
GROUP BY Clientes.nombre;

-- 9. Calcular el precio total de cada pedido
SELECT Pedidos.id_pedido, SUM(Productos.precio) AS precio_total
FROM Pedidos
JOIN Productos ON Pedidos.id_producto = Productos.id_producto
GROUP BY Pedidos.id_pedido;

-- 10. Listar los productos ordenados por precio descendente
SELECT * FROM Productos ORDER BY precio DESC;

-- 11. Consultar cuántos productos hay en cada categoría
SELECT Categorias.nombre, COUNT(Productos.id_producto) AS total_productos
FROM Categorias
LEFT JOIN Productos ON Categorias.id_categoria = Productos.id_categoria
GROUP BY Categorias.nombre;

-- 12. Obtener los pedidos realizados en diciembre de 2024
SELECT * FROM Pedidos WHERE MONTH(fecha_pedido) = 12 AND YEAR(fecha_pedido) = 2024;

-- 13. Mostrar los nombres de los clientes y los productos que han pedido
SELECT Clientes.nombre AS cliente, Productos.nombre AS producto
FROM Pedidos
JOIN Clientes ON Pedidos.id_cliente = Clientes.id_cliente
JOIN Productos ON Pedidos.id_producto = Productos.id_producto;

-- 14. Encontrar los productos que contienen "Micro" en su nombre
SELECT * FROM Productos WHERE nombre LIKE '%Micro%';

-- 15. Mostrar los productos cuyo precio esté entre 20 y 100
SELECT * FROM Productos WHERE precio BETWEEN 20 AND 100;

-- 16. Consultar los clientes que no tienen pedidos
SELECT * FROM Clientes
WHERE id_cliente NOT IN (SELECT DISTINCT id_cliente FROM Pedidos);

-- 17. Listar las categorías que no tienen productos
SELECT * FROM Categorias
WHERE id_categoria NOT IN (SELECT DISTINCT id_categoria FROM Productos);

-- 18. Eliminar un pedido (ejemplo con el pedido ID = 3)
DELETE FROM Pedidos WHERE id_pedido = 3;
select * from pedidos;

-- 19. Actualizar el precio de la "Camiseta" a 20.00
UPDATE Productos SET precio = 20.00 WHERE nombre = 'Camiseta';
select * from productos;

-- 20. Insertar un nuevo cliente
INSERT INTO Clientes (nombre, direccion, ciudad, telefono, cargo)
VALUES ('Luis Martínez', 'Calle 456', 'Valencia', '789 123 456', 'Cliente');
select * from clientes;

