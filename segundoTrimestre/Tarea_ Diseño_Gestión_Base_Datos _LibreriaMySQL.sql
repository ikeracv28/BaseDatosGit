-- creacion de la base de datos
drop database if exists libreria_online;
create database if not exists libreria_online;
use libreria_online;

-- creacion tabla clientes
create table clientes (
 id_cliente int primary key auto_increment,
 nombre varchar(50) not null,
 email varchar(50) unique not null,
 telefono char(9),
 direccion varchar(50)
 );
 
 
 -- creacion tabla autores
CREATE TABLE autores (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- creacion tabla categorias
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- creacion tabla libros
CREATE TABLE libros (
    id_libro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(80) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- creacion tabla libro_autor 
CREATE TABLE libro_autor (
    id_libro INT,
    id_autor INT,
    PRIMARY KEY (id_libro, id_autor),
    FOREIGN KEY (id_libro) REFERENCES libros(id_libro),
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor)
);

-- creacion tabla pedidos
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    fecha_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- creacion tabla detalles_pedidos
CREATE TABLE detalles_pedidos (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_libro INT,
    cantidad INT NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_libro) REFERENCES libros(id_libro)
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
('Cien Años de Soledad', 19.99, 20, 1),  -- 1 corresponde a "Ficción"
('Fundación', 15.99, 15, 4),  -- 4 corresponde a "Ciencia"
('Harry Potter y la Piedra Filosofal', 25.99, 10, 1),  -- 1 corresponde a "Ficción"
('El Cerebro de Broca', 18.50, 5, 4);  -- 4 corresponde a "Ciencia"

-- Relación libro-autor
INSERT INTO libro_autor (id_libro, id_autor)
VALUES
(1, 1), -- "Cien Años de Soledad" y "Gabriel García Márquez"
(2, 2), -- "Fundación" y "Isaac Asimov"
(3, 3), -- "Harry Potter y la Piedra Filosofal" y "J.K. Rowling"
(4, 4); -- "El Cerebro de Broca" y "Carl Sagan"

-- Parte 3: Consultas SQL 
-- 1. Listado de Libros con Autores y Categorías: Muestra el título del libro, el nombre del autor y la categoría. 
select l.titulo as titulo_libro, a.nombre as nombre_autor, c.nombre as categoria from libros l
left join libro_autor la on l.id_libro = la.id_libro 
left join autores a on la.id_autor = a.id_autor
left join categorias c on l.id_categoria = c.id_categoria;

-- 2. Clientes con Pedidos Realizados: Lista los nombres de los clientes y el total de sus pedidos. 
SELECT c.nombre AS cliente, SUM(p.total) AS total_pedidos FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente;

-- 3. Stock Crítico: Encuentra los libros cuyo stock sea menor o igual a 5. 
SELECT titulo, stock FROM libros
WHERE stock <= 5;
-- 4. Total de Pedidos por Cliente: Calcula el número de pedidos realizados por cada cliente. 
SELECT c.nombre AS cliente, COUNT(p.id_pedido) AS total_pedidos FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente;
 
 
 -- Parte 4: Ejercicios de Transacciones 
-- 1. Registrar un Pedido Nuevo (con Transacción):
 START TRANSACTION;

-- Crear un nuevo pedido para Juan Pérez
INSERT INTO pedidos (id_cliente, total)
VALUES (1, 0);
select * from pedidos;


-- Insertar detalles del pedido
INSERT INTO detalles_pedidos (id_pedido, id_libro, cantidad, subtotal)
VALUES 
(1, 1, 1, 19.99),
(1, 2, 2, 15.99 * 2);

select * from detalles_pedidos;

-- Actualizar el stock de los libros
UPDATE libros
SET stock = stock - 1
WHERE titulo = 'Cien Años de Soledad';

UPDATE libros
SET stock = stock - 2
WHERE titulo = 'Fundación';

select * from libros;

-- Calcular y actualizar el total del pedido
UPDATE pedidos
SET total = (SELECT SUM(subtotal) FROM detalles_pedidos WHERE id_pedido = @id_pedido)
WHERE id_pedido = @id_pedido;

select * from pedidos;
COMMIT;

-- 2. Simulación de Error con ROLLBACK:
 START TRANSACTION;

-- Intentar crear un pedido con stock insuficiente
INSERT INTO pedidos (id_cliente, total)
VALUES ((SELECT id_cliente FROM clientes WHERE nombre = 'Juan Pérez'), 0);
select * from pedidos;

-- Obtener el último ID de pedido
SET @id_pedido = LAST_INSERT_ID();

-- Insertar un detalle con stock insuficiente
INSERT INTO detalles_pedidos (id_pedido, id_libro, cantidad, subtotal)
VALUES 
(@id_pedido, (SELECT id_libro FROM libros WHERE titulo = 'El Cerebro de Broca'), 10, 18.50 * 10);
select * from detalles_pedidos;

-- Simulación de error al actualizar stock
UPDATE libros
SET stock = stock - 10
WHERE titulo = 'El Cerebro de Broca';
select * from libros;

-- Revertir transacción
ROLLBACK;

-- Parte 5: Ejercicios Avanzados (Opcionales) 
-- 1. Cálculo Automático del Total del Pedido:
 UPDATE pedidos
SET total = (SELECT SUM(subtotal) FROM detalles_pedidos WHERE detalles_pedidos.id_pedido = pedidos.id_pedido);
select * from pedidos;

-- manera de hacerlo con trigger
DELIMITER //

CREATE TRIGGER calcular_total_pedido
AFTER INSERT ON detalles_pedidos
FOR EACH ROW
BEGIN
    -- Sumar los subtotales de los detalles del pedido y actualizar el total
    UPDATE pedidos
    SET total = (
        SELECT SUM(subtotal)
        FROM detalles_pedidos
        WHERE id_pedido = NEW.id_pedido
    )
    WHERE id_pedido = NEW.id_pedido;
END;
//

DELIMITER ;

INSERT INTO detalles_pedidos (id_pedido, id_libro, cantidad, subtotal)
VALUES (1, 1, 2, 39.98); -- Pedido 1, 2 libros de "Cien Años de Soledad"
select * from detalles_pedidos;

-- 2. Libros sin Autores Asignados:
SELECT titulo FROM libros
WHERE id_libro NOT IN (SELECT DISTINCT id_libro FROM libro_autor);

-- manera de hacerlo con trigger
SELECT l.id_libro, l.titulo
FROM libros l
LEFT JOIN libro_autor la ON l.id_libro = la.id_libro
WHERE la.id_autor IS NULL;

-- 3. Pedidos con Desglose de Detalles: 
SELECT p.id_pedido, c.nombre AS cliente, l.titulo AS titulo_libro, dp.cantidad, dp.subtotal
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
JOIN detalles_pedidos dp ON p.id_pedido = dp.id_pedido
JOIN libros l ON dp.id_libro = l.id_libro;

