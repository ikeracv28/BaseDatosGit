


-- Crear la tabla Clientes
CREATE TABLE Clientes (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    telefono VARCHAR(20),
    ciudad VARCHAR(100),
    cargo VARCHAR(50)
);

-- Crear la tabla Productos
CREATE TABLE Productos (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    precio NUMERIC(10, 2),
    medida VARCHAR(50),
    categoria_id INT
);

-- Crear la tabla Categorias
CREATE TABLE Categorias (
    id_categoria SERIAL PRIMARY KEY,
    nombre VARCHAR(100)
);

-- Crear la tabla Pedidos
CREATE TABLE Pedidos (
    id_pedido SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES Clientes(id_cliente),
    fecha_pedido DATE,
    fecha_entrega DATE
);

-- Crear la tabla productos_pedidos (relación entre productos y pedidos)
CREATE TABLE productos_pedidos (
    id SERIAL PRIMARY KEY,
    id_pedido INT REFERENCES Pedidos(id_pedido),
    id_producto INT REFERENCES Productos(id_producto),
    cantidad INT
);


-- Insertar datos en la tabla clientes
INSERT INTO Clientes (nombre, telefono, ciudad, cargo)
VALUES
('Juan Pérez', '123-456-7890', 'Madrid', 'Gerente'),
('María García', '234-567-8901', 'Barcelona', 'Secretaria'),
('Pedro Martínez', '345-678-9012', 'Valencia', 'Vendedor'),
('Ana López', '456-789-0123', 'Sevilla', 'Asistente'),
('Carlos Sánchez', '567-890-1234', 'Bilbao', 'Director');

-- Insertar datos en la tabla categorias
INSERT INTO Categorias (nombre)
VALUES
('Ropa'),
('Electrónica'),
('Muebles'),
('Deportes'),
('Juguetes');

-- Insertar datos en la tabla productos
INSERT INTO Productos (nombre, precio, medida, categoria_id)
VALUES
('Camiseta', 15.99, 'L', 1),
('Ordenador portátil', 799.99, 'Unidad', 2),
('Silla de oficina', 120.50, 'Unidad', 3),
('Bicicleta', 300.00, 'Unidad', 4),
('Muñeca de peluche', 25.00, 'Unidad', 5);

-- Insertar datos en la tabla pedidos
INSERT INTO Pedidos (id_cliente, fecha_pedido, fecha_entrega)
VALUES
(1, '2024-01-01', '2024-01-05'),
(2, '2024-02-10', '2024-02-12'),
(3, '2024-03-15', '2024-03-20'),
(4, '2024-04-20', '2024-04-22'),
(5, '2024-05-30', '2024-06-02');

-- Insertar datos en la tabla productos_pedidos
INSERT INTO productos_pedidos (id_pedido, id_producto, cantidad)
VALUES
(1, 1, 2),  -- Pedido 1, Producto 1 (Camiseta), 2 unidades
(2, 2, 1),  -- Pedido 2, Producto 2 (Ordenador portátil), 1 unidad
(3, 3, 1),  -- Pedido 3, Producto 3 (Silla de oficina), 1 unidad
(4, 4, 1),  -- Pedido 4, Producto 4 (Bicicleta), 1 unidad
(5, 5, 3);  -- Pedido 5, Producto 5 (Muñeca de peluche), 3 unidades


-- 1. Mostrar el número total de productos que hay en la base de datos.
SELECT COUNT(*) AS total_productos
FROM Productos;

-- 2. Obtener los productos cuyo precio sea mayor a 50.
SELECT nombre, precio
FROM Productos
WHERE precio > 50;

-- 3. Mostrar los clientes cuyo nombre contiene la letra 'e'.
SELECT nombre
FROM Clientes
WHERE nombre LIKE '%e%';


-- 4. Calcular el precio promedio de los productos.
SELECT AVG(precio) AS precio_promedio
FROM Productos;


-- 5. Obtener el cliente con el nombre más largo.
SELECT nombre
FROM Clientes
WHERE LENGTH(nombre) = (SELECT MAX(LENGTH(nombre)) FROM Clientes);


-- 6. Mostrar el producto más caro.
SELECT nombre, precio
FROM Productos
WHERE precio = (SELECT MAX(precio) FROM Productos);


-- 7. Contar el número de pedidos realizados por cada cliente.
SELECT id_cliente, COUNT(*) AS total_pedidos
FROM Pedidos
GROUP BY id_cliente;



-- 8. Mostrar los productos que no han sido vendidos (suponiendo que 'productos_pedidos' tiene registros).
SELECT nombre
FROM Productos
WHERE id_producto NOT IN (SELECT id_producto FROM productos_pedidos);

-- 9. Obtener el nombre de los clientes que realizaron pedidos en el mes de enero (suponiendo que la fecha está en formato 'YYYY-MM-DD').
SELECT DISTINCT c.nombre as nombre_cliente_pedido_enero
FROM Clientes c
JOIN Pedidos p ON c.id_cliente = p.id_cliente
WHERE EXTRACT(MONTH FROM p.fecha_pedido) = 1;


-- 10. Mostrar los 5 productos más baratos.
SELECT nombre, precio
FROM Productos
ORDER BY precio ASC
LIMIT 5;


-- 11. Obtener el nombre de los productos y su respectiva categoría.
SELECT p.nombre AS nombre_producto, c.nombre AS categoria_producto
FROM Productos p
JOIN Categorias c ON p.categoria_id = c.id_categoria;



-- 12. Calcular el total de ventas por producto (suponiendo que hay una tabla 'productos_pedidos' que tiene cantidades).
SELECT p.nombre, SUM(pp.cantidad * p.precio) AS total_ventas
FROM Productos p
JOIN productos_pedidos pp ON p.id_producto = pp.id_producto
GROUP BY p.nombre;


-- 13. Mostrar el nombre y teléfono de los clientes que viven en 'Madrid'.
SELECT nombre, telefono
FROM Clientes
WHERE ciudad = 'Madrid';


-- 14. Obtener el producto con la cantidad más vendida.
SELECT p.nombre, SUM(pp.cantidad) AS total_vendido
FROM Productos p
JOIN productos_pedidos pp ON p.id_producto = pp.id_producto
GROUP BY p.nombre
ORDER BY total_vendido DESC
LIMIT 1;



-- 15. Mostrar la fecha del primer pedido realizado por cada cliente.
SELECT id_cliente, MIN(fecha_pedido) AS primer_pedido
FROM Pedidos
GROUP BY id_cliente;


-- 16. Obtener el cliente con la mayor cantidad de pedidos.
SELECT id_cliente, COUNT(*) AS total_pedidos
FROM Pedidos
GROUP BY id_cliente
ORDER BY total_pedidos DESC
LIMIT 1;


-- 17. Mostrar las categorías que no tienen productos asociados.
SELECT c.nombre as categoria_sin_productos
FROM Categorias c
WHERE c.id_categoria NOT IN (SELECT DISTINCT id_categoria FROM Productos);



-- 18. Obtener el promedio de cantidad de productos por pedido.
SELECT AVG(pp.cantidad) AS promedio_cantidad
FROM productos_pedidos pp;



-- 19. Productos con el precio más alto de cada categoría
SELECT c.nombre AS categoria, p.nombre AS producto, MAX(p.precio) AS precio_maximo
FROM Productos p
JOIN Categorias c ON p.categoria_id = c.id_categoria
GROUP BY c.nombre, p.nombre
ORDER BY c.nombre;



-- 20. Clientes que realizaron pedidos en los últimos 8 meses
SELECT c.nombre, COUNT(p.id_pedido) AS total_pedidos
FROM Clientes c
JOIN Pedidos p ON c.id_cliente = p.id_cliente
WHERE p.fecha_pedido >= CURRENT_DATE - INTERVAL '8 month'
GROUP BY c.nombre
ORDER BY total_pedidos DESC;

