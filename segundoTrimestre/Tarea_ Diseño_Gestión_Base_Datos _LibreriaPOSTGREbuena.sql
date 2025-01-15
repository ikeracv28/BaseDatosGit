-- Creación de la base de datos
DROP DATABASE IF EXISTS libreria_online;
CREATE DATABASE libreria_online;



-- Creación tabla clientes
CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    telefono CHAR(9),
    direccion VARCHAR(50)
);

-- Creación tabla autores
CREATE TABLE autores (
    id_autor SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Creación tabla categorías
CREATE TABLE categorias (
    id_categoria SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Creación tabla libros
CREATE TABLE libros (
    id_libro SERIAL PRIMARY KEY,
    titulo VARCHAR(80) NOT NULL,
    precio NUMERIC(10, 2) NOT NULL,
    stock INT NOT NULL,
    id_categoria INT REFERENCES categorias(id_categoria)
);

-- Creación tabla libro_autor
CREATE TABLE libro_autor (
    id_libro INT,
    id_autor INT,
    PRIMARY KEY (id_libro, id_autor),
    FOREIGN KEY (id_libro) REFERENCES libros(id_libro),
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor)
);

-- Creación tabla pedidos
CREATE TABLE pedidos (
    id_pedido SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES clientes(id_cliente),
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total NUMERIC(10, 2) NOT NULL
);

-- Creación tabla detalles_pedidos
CREATE TABLE detalles_pedidos (
    id_detalle SERIAL PRIMARY KEY,
    id_pedido INT REFERENCES pedidos(id_pedido),
    id_libro INT REFERENCES libros(id_libro),
    cantidad INT NOT NULL,
    subtotal NUMERIC(10, 2) NOT NULL
);
-- Insertar clientes
INSERT INTO clientes (nombre, email, telefono, direccion)
VALUES
('Juan Pérez', 'juan.perez@mail.com', '123456789', 'Calle Falsa 123'),
('María García', 'maria.garcia@mail.com', '987654321', 'Avenida Siempreviva 456');

-- Insertar categorías
INSERT INTO categorias (nombre)
VALUES
('Ficción'),
('No Ficción'),
('Educación'),
('Ciencia');

-- Insertar autores
INSERT INTO autores (nombre)
VALUES
('Gabriel García Márquez'),
('Isaac Asimov'),
('J.K. Rowling'),
('Carl Sagan');

-- Insertar libros
INSERT INTO libros (titulo, precio, stock, id_categoria)
VALUES
('Cien Años de Soledad', 19.99, 20, 1),
('Fundación', 15.99, 15, 4),
('Harry Potter y la Piedra Filosofal', 25.99, 10, 1),
('El Cerebro de Broca', 18.50, 5, 4);

-- Relación libro-autor
INSERT INTO libro_autor (id_libro, id_autor)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

-- Consultas SQL para probar los datos
-- 1. Listado de Libros con Autores y Categorías
SELECT l.titulo AS titulo_libro, a.nombre AS nombre_autor, c.nombre AS categoria
FROM libros l
LEFT JOIN libro_autor la ON l.id_libro = la.id_libro
LEFT JOIN autores a ON la.id_autor = a.id_autor
LEFT JOIN categorias c ON l.id_categoria = c.id_categoria;

-- 2. Clientes con Pedidos Realizados
SELECT c.nombre AS cliente, SUM(p.total) AS total_pedidos
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente;

-- 3. Stock Crítico
SELECT titulo, stock FROM libros
WHERE stock <= 5;

-- 4. Total de Pedidos por Cliente
SELECT c.nombre AS cliente, COUNT(p.id_pedido) AS total_pedidos
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente;

-- Operaciones con transacciones
-- Registrar un Pedido Nuevo
DO $$
DECLARE
    id_pedido INT;
BEGIN
    -- Crear un nuevo pedido para Juan Pérez
    INSERT INTO pedidos (id_cliente, total)
    VALUES ((SELECT id_cliente FROM clientes WHERE nombre = 'Juan Pérez'), 0)
    RETURNING id_pedido INTO id_pedido;

    -- Insertar detalles del pedido
    INSERT INTO detalles_pedidos (id_pedido, id_libro, cantidad, subtotal)
    VALUES 
    (id_pedido, (SELECT id_libro FROM libros WHERE titulo = 'Cien Años de Soledad'), 1, 19.99),
    (id_pedido, (SELECT id_libro FROM libros WHERE titulo = 'Fundación'), 2, 15.99 * 2);

    -- Actualizar el stock de los libros
    UPDATE libros
    SET stock = stock - 1
    WHERE titulo = 'Cien Años de Soledad';

    UPDATE libros
    SET stock = stock - 2
    WHERE titulo = 'Fundación';

    -- Calcular y actualizar el total del pedido
    UPDATE pedidos
    SET total = (SELECT SUM(subtotal) FROM detalles_pedidos WHERE id_pedido = pedidos.id_pedido)
    WHERE id_pedido = id_pedido;

END $$;

-- Resto de operaciones avanzadas
-- Libros sin Autores Asignados
SELECT titulo FROM libros
WHERE id_libro NOT IN (SELECT DISTINCT id_libro FROM libro_autor);

-- Pedidos con Desglose de Detalles
SELECT p.id_pedido, c.nombre AS cliente, l.titulo AS titulo_libro, dp.cantidad, dp.subtotal
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
JOIN detalles_pedidos dp ON p.id_pedido = dp.id_pedido
JOIN libros l ON dp.id_libro = l.id_libro;
