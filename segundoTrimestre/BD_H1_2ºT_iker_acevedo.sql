-- creación de la base de datos
drop database if exists cine_arte_atrezo;
create database cine_arte_atrezo;
use cine_arte_atrezo;

-- tabla categorías
create table categorias (
    id_categoria int auto_increment primary key,
    nombre varchar(80) not null,
    descripcion text
);

-- tabla detalles_de_pedido
create table detalles_pedido (
    id_detalle int auto_increment primary key,
    cantidad int not null,
    precio decimal(10, 2) not null
);

-- tabla productos
create table productos (
    id_producto int auto_increment primary key,
    nombre varchar(50) not null,
    precio decimal(10, 2) not null,
	descripcion text,
    cantidad int not null,
    id_detalle int,
    foreign key (id_detalle) references detalles_pedido(id_detalle) 
    on delete cascade
    on update cascade
);

-- tabla cliente
create table cliente (
    id_cliente int auto_increment primary key,
    nombre varchar(80) not null,
    correo varchar(80) unique not null,
    telefono varchar(20) unique,
    direccion varchar(80)
);

-- tabla envíos
create table envios (
    id_envio int primary key auto_increment,
    direccion varchar(80) not null,
    estado varchar(50) not null,
    fecha_envio datetime not null
);

-- tabla pedidos
create table pedidos (
    id_pedido int auto_increment primary key,
    fecha date not null,
    total decimal(10, 2) not null,
    metodo_pago varchar(50),
    estado_alquiler varchar(80),
    id_cliente int not null,
    id_envio int not null,
    id_detalle int not null,
    foreign key (id_cliente) references cliente(id_cliente) 
    on delete cascade
    on update cascade,
    foreign key (id_envio) references envios(id_envio) 
    on delete cascade
    on update cascade,
	foreign key (id_detalle) references detalles_pedido(id_detalle) 
    on delete cascade
    on update cascade
);

-- tabla relacion categorias_productos
create table categorias_productos (
	id_categoria int,
    id_producto int,
	foreign key (id_categoria) references categorias(id_categoria) 
    on delete cascade
    on update cascade,
    foreign key (id_producto) references productos(id_producto) 
    on delete cascade
    on update cascade
);

-- Tabla categorias (10 registros)
INSERT INTO categorias (nombre, descripcion) VALUES
('Decorados', 'Material para decorar escenarios de cine'),
('Vestuario', 'Ropa y accesorios para actores'),
('Atrezzo', 'Elementos menores utilizados en escenas'),
('Iluminación', 'Equipos para iluminar sets de rodaje'),
('Sonido', 'Equipos y accesorios para grabación de audio'),
('Utilería', 'Objetos utilizados como parte del set'),
('Maquillaje', 'Productos de maquillaje profesional'),
('Efectos Especiales', 'Herramientas y materiales para efectos visuales'),
('Mobiliario', 'Muebles utilizados en sets'),
('Transporte', 'Medios de transporte para rodajes');

-- Tabla cliente (15 registros)
INSERT INTO cliente (nombre, correo, telefono, direccion) VALUES
('Carlos Martínez', 'carlos.martinez@mail.com', '600123456', 'Calle Falsa 123'),
('Ana Gómez', 'ana.gomez@mail.com', '600654321', 'Avenida Real 45'),
('Juan Pérez', 'juan.perez@mail.com', NULL, 'Plaza Central 9'),
('Lucía Hernández', 'lucia.hernandez@mail.com', '700112233', NULL),
('Pedro Sánchez', 'pedro.sanchez@mail.com', '601789456', 'Calle Luna 56'),
('María López', 'maria.lopez@mail.com', NULL, 'Avenida Sol 78'),
('Laura Torres', 'laura.torres@mail.com', '602345678', 'Calle Estrella 12'),
('Sergio Ramírez', 'sergio.ramirez@mail.com', '600987654', NULL),
('Isabel González', 'isabel.gonzalez@mail.com', '604123123', 'Avenida Principal 34'),
('Fernando Ortega', 'fernando.ortega@mail.com', NULL, 'Calle Jardín 10'),
('Marta Ruiz', 'marta.ruiz@mail.com', '605555666', 'Avenida Esperanza 22'),
('José Vidal', 'jose.vidal@mail.com', '600333444', NULL),
('Elena Castro', 'elena.castro@mail.com', '607777888', 'Calle Paz 45'),
('David Gómez', 'david.gomez@mail.com', NULL, 'Calle Sueño 78'),
('Claudia Núñez', 'claudia.nunez@mail.com', '600111222', 'Avenida Arcoíris 21');

-- Tabla envios (10 registros)
INSERT INTO envios (direccion, estado, fecha_envio) VALUES
('Calle Falsa 123', 'En tránsito', '2025-01-15 10:00:00'),
('Avenida Real 45', 'Entregado', '2025-01-16 15:00:00'),
('Plaza Central 9', 'Pendiente', '2025-01-18 08:30:00'),
('Calle Nueva 12', 'Cancelado', '2025-01-17 14:45:00'),
('Calle Luna 56', 'En tránsito', '2025-01-18 10:00:00'),
('Avenida Sol 78', 'Pendiente', '2025-01-19 12:00:00'),
('Calle Estrella 12', 'Entregado', '2025-01-20 14:00:00'),
('Avenida Principal 34', 'Pendiente', '2025-01-21 16:30:00'),
('Calle Jardín 10', 'En tránsito', '2025-01-22 11:15:00'),
('Avenida Esperanza 22', 'Entregado', '2025-01-23 09:45:00');

-- Tabla detalles_pedido (12 registros)
INSERT INTO detalles_pedido (cantidad, precio) VALUES
(3, 120.50),
(5, 300.00),
(2, 45.00),
(4, 200.75),
(10, 500.00),
(8, 350.00),
(6, 90.00),
(7, 150.00),
(4, 75.50),
(9, 420.25),
(3, 210.00),
(5, 180.00);

-- Tabla productos (15 registros)
INSERT INTO productos (nombre, precio, descripcion, cantidad, id_detalle) VALUES
('Silla de madera', 40.50, 'Silla de madera para decorados', 10, 1),
('Vestido rojo', 75.00, 'Vestido de época para actriz', 5, 2),
('Lámpara vintage', 60.00, 'Lámpara decorativa', 8, 3),
('Candelabro dorado', 100.00, 'Candelabro elegante para mesas', 3, 4),
('Camisa blanca', 30.00, 'Camisa de algodón para vestuario', 15, 5),
('Foco LED', 200.00, 'Foco de alta potencia', 6, 6),
('Micrófono inalámbrico', 150.00, 'Micrófono para grabación de sonido', 4, 7),
('Sofá de cuero', 400.00, 'Sofá para sets de grabación', 2, NULL),
('Caja de herramientas', 80.00, 'Herramientas para efectos especiales', 9, 8),
('Piano eléctrico', 1500.00, 'Piano para escenarios musicales', 1, 9),
('Maquillaje artístico', 25.00, 'Kit de maquillaje para cine', 20, 10),
('Espejo con luces', 350.00, 'Espejo profesional con iluminación', 3, 11),
('Mesa de madera', 100.00, 'Mesa de estilo rústico', 5, 12),
('Ventilador de escena', 120.00, 'Ventilador para efectos climáticos', 4, NULL),
('Escalera plegable', 60.00, 'Escalera portátil para escenarios', 6, NULL);

-- Tabla pedidos (20 registros)
INSERT INTO pedidos (fecha, total, metodo_pago, estado_alquiler, id_cliente, id_envio, id_detalle) VALUES
('2025-01-15', 121.50, 'Tarjeta', 'Pendiente', 1, 1, 1),
('2025-01-16', 375.00, 'Efectivo', 'Completado', 2, 2, 2),
('2025-01-18', 105.00, 'Transferencia', 'Pendiente', 3, 3, 3),
('2025-01-17', 400.75, 'Tarjeta', 'Cancelado', 4, 4, 4),
('2025-01-19', 500.00, 'Efectivo', 'Completado', 5, 5, 5),
('2025-01-20', 200.00, 'Transferencia', 'Pendiente', 6, 6, 6),
('2025-01-21', 90.00, 'Tarjeta', 'En tránsito', 7, 7, 7),
('2025-01-22', 420.25, 'Tarjeta', 'Entregado', 8, 8, 8),
('2025-01-23', 350.00, 'Efectivo', 'Pendiente', 9, 9, 9),
('2025-01-24', 150.00, 'Transferencia', 'En tránsito', 10, 10, 10),
('2025-01-25', 300.00, 'Tarjeta', 'Pendiente', 11, 1, 2),
('2025-01-26', 125.00, 'Efectivo', 'Completado', 12, 2, 3),
('2025-01-27', 800.00, 'Tarjeta', 'Cancelado', 13, 3, 4),
('2025-01-28', 600.00, 'Transferencia', 'En tránsito', 14, 4, 5),
('2025-01-29', 100.00, 'Efectivo', 'Entregado', 15, 5, 6),
('2025-01-30', 75.00, 'Tarjeta', 'Pendiente', 1, 6, 7),
('2025-01-31', 180.00, 'Transferencia', 'Pendiente', 2, 7, 8),
('2025-02-01', 350.00, 'Tarjeta', 'Entregado', 3, 8, 9),
('2025-02-02', 200.75, 'Efectivo', 'Cancelado', 4, 9, 10),
('2025-02-03', 125.50, 'Tarjeta', 'En tránsito', 5, 10, 11);

-- Relación entre categorías y productos
INSERT INTO categorias_productos (id_categoria, id_producto) VALUES
(1, 1), -- Decorados -> Silla de madera
(2, 2), -- Vestuario -> Vestido rojo
(4, 3), -- Iluminación -> Lámpara vintage
(1, 4), -- Decorados -> Candelabro dorado
(2, 5), -- Vestuario -> Camisa blanca
(4, 6), -- Iluminación -> Foco LED
(5, 7), -- Sonido -> Micrófono inalámbrico
(9, 8), -- Mobiliario -> Sofá de cuero
(8, 9), -- Efectos Especiales -> Caja de herramientas
(3, 10), -- Atrezzo -> Piano eléctrico
(7, 11), -- Maquillaje -> Maquillaje artístico
(4, 12), -- Iluminación -> Espejo con luces
(9, 13), -- Mobiliario -> Mesa de madera
(8, 14), -- Efectos Especiales -> Ventilador de escena
(6, 15); -- Utilería -> Escalera plegable



-- Primeras 5 consultas para comprobar las relaciones entre las tablas

-- Consulta de todos los productos
select * from productos;

-- Consulta de todos los clientes
select * from cliente;

-- Consulta para comprobar que los pedidos incluyen detalles de pedidos
select p.id_pedido, p.fecha, dp.id_detalle, dp.cantidad, dp.precio from pedidos p join detalles_pedido dp on p.id_detalle = dp.id_detalle;
  
-- Consulta para comprobar la relación entre pedidos y envíos
select p.id_pedido, p.fecha, p.total, e.direccion as direccion_envio, e.estado as estado_envio, e.fecha_envio from pedidos p join envios e on p.id_envio = e.id_envio;
 
-- Consulta para comprobar la relación entre productos y categorías
select cp.id_categoria, cat.nombre as categoria, cp.id_producto, prod.nombre as producto, prod.precio from categorias_productos cp join categorias cat on cp.id_categoria = cat.id_categoria join productos prod on cp.id_producto = prod.id_producto;
 

-- Realiza consultas en múltiples tablas. Debes plantear las consultas que vayan a ser útiles para la futura aplicación web. Mínimo 20 consultas SQL.


-- Consulta para obtener los productos y sus respectivas categorías
select p.nombre, c.nombre from productos p
inner join categorias_productos cp on p.id_producto = cp.id_producto
inner join categorias c on cp.id_categoria = c.id_categoria;

-- Consulta para obtener el nombre y precio de los productos, con la cantidad comprada
select p.nombre, p.precio, d.cantidad
from productos p
inner join detalles_pedido d on p.id_producto = d.id_producto;

-- Consulta para obtener todos los productos y la cantidad total de cada uno en todos los pedidos
select p.nombre, sum(d.cantidad) as total_vendido
from productos p
inner join detalles_pedido d on p.id_producto = d.id_producto
group by p.nombre;

-- Consulta para obtener el total de ventas por cliente
select c.nombre, sum(d.precio * d.cantidad) as total
from clientes c
inner join pedidos p on c.id_cliente = p.id_cliente
inner join detalles_pedido d on p.id_pedido = d.id_pedido
group by c.nombre;

SELECT p.id_pedido, p.fecha, c.nombre AS Cliente, p.estado_alquiler
FROM pedidos p
LEFT JOIN cliente c ON p.id_cliente = c.id_cliente
WHERE p.estado_alquiler = 'Pendiente';


SELECT e.id_envio, e.direccion, e.estado, e.fecha_envio, c.nombre AS Cliente
FROM envios e
RIGHT JOIN pedidos p ON e.id_envio = p.id_envio
RIGHT JOIN cliente c ON p.id_cliente = c.id_cliente;

SELECT c.nombre AS Categoria, COUNT(p.id_producto) AS Total_Productos
FROM categorias c
LEFT JOIN categorias_productos cp ON c.id_categoria = cp.id_categoria
LEFT JOIN productos p ON cp.id_producto = p.id_producto
GROUP BY c.id_categoria;

-- 1. obtener todos los pedidos con su respectivo cliente y detalle utilizando join
select p.id_pedido, p.fecha, p.total, c.nombre as cliente, d.cantidad, d.precio
from pedidos p
join cliente c on p.id_cliente = c.id_cliente
join detalles_pedido d on p.id_detalle = d.id_detalle;

-- 2. obtener todos los productos con su categoría utilizando inner join
select pr.nombre as producto, ca.nombre as categoria
from productos pr
inner join categorias_productos cp on pr.id_producto = cp.id_producto
inner join categorias ca on cp.id_categoria = ca.id_categoria;

-- 3. obtener todos los productos y su detalle utilizando right join
select pr.nombre as producto, d.cantidad, d.precio
from productos pr
right join detalles_pedido d on pr.id_detalle = d.id_detalle;

-- 4. obtener clientes con pedidos pendientes utilizando subconsulta
select nombre, correo 
from cliente 
where id_cliente in (select id_cliente from pedidos where estado_alquiler = 'Pendiente');

-- 5. obtener los productos con su categoría y cantidad en inventario utilizando group by
select pr.nombre as producto, ca.nombre as categoria, sum(pr.cantidad) as total_en_inventario
from productos pr
join categorias_productos cp on pr.id_producto = cp.id_producto
join categorias ca on cp.id_categoria = ca.id_categoria
group by pr.nombre, ca.nombre;

-- 6. obtener pedidos por estado de envío utilizando inner join
select p.id_pedido, p.fecha, e.estado as estado_envio
from pedidos p
inner join envios e on p.id_envio = e.id_envio;

-- 7. obtener clientes con más de un pedido utilizando group by y having
select c.nombre, count(p.id_pedido) as numero_pedidos
from cliente c
join pedidos p on c.id_cliente = p.id_cliente
group by c.id_cliente
having count(p.id_pedido) > 1;

-- 8. obtener productos con sus detalles y precios utilizando join
select pr.nombre as producto, d.cantidad, d.precio 
from productos pr
join detalles_pedido d on pr.id_detalle = d.id_detalle;

-- 9. obtener los productos con su categoría y precio utilizando subconsulta
select nombre, precio 
from productos 
where id_producto in (select id_producto from categorias_productos where id_categoria = 1);

-- 10. obtener pedidos con estado 'Completado' y su método de pago utilizando inner join
select p.id_pedido, p.metodo_pago, p.total
from pedidos p
inner join cliente c on p.id_cliente = c.id_cliente
where p.estado_alquiler = 'Completado';

-- 11. obtener los clientes y los productos que han pedido utilizando inner join
select c.nombre as cliente, pr.nombre as producto
from cliente c
join pedidos p on c.id_cliente = p.id_cliente
join productos pr on pr.id_detalle = p.id_detalle;

-- 12. obtener los detalles de los pedidos con su producto y cantidad utilizando right join
select d.id_detalle, pr.nombre as producto, d.cantidad
from detalles_pedido d
right join productos pr on pr.id_detalle = d.id_detalle;

-- 13. obtener el total de ventas por cliente utilizando group by
select c.nombre, sum(p.total) as total_ventas
from cliente c
join pedidos p on c.id_cliente = p.id_cliente
group by c.id_cliente;

-- 14. obtener los productos más vendidos utilizando group by y order by
select pr.nombre as producto, sum(d.cantidad) as cantidad_vendida
from productos pr
join detalles_pedido d on pr.id_detalle = d.id_detalle
group by pr.id_producto
order by cantidad_vendida desc;

-- 15. obtener los envíos con su estado y fecha utilizando join
select e.direccion, e.estado, e.fecha_envio
from envios e
join pedidos p on e.id_envio = p.id_envio;

-- 16. obtener los productos en inventario con su precio total utilizando group by
select pr.nombre as producto, sum(pr.cantidad * pr.precio) as precio_total
from productos pr
group by pr.id_producto;

-- 17. obtener los clientes que tienen pedidos 'En tránsito' utilizando subconsulta
select nombre, correo
from cliente
where id_cliente in (select id_cliente from pedidos where estado_alquiler = 'En tránsito');

-- 18. obtener los productos sin categoría utilizando left join
select pr.nombre as producto, ca.nombre as categoria
from productos pr
left join categorias_productos cp on pr.id_producto = cp.id_producto
left join categorias ca on cp.id_categoria = ca.id_categoria
where ca.id_categoria is null;

-- 19. obtener productos cuyo precio es mayor a 100 utilizando subconsulta
select nombre, precio 
from productos 
where precio > (select avg(precio) from productos);

-- 20. obtener el total de productos pedidos por categoría utilizando group by
select ca.nombre as categoria, sum(d.cantidad) as total_pedidos
from categorias ca
join categorias_productos cp on ca.id_categoria = cp.id_categoria
join productos pr on cp.id_producto = pr.id_producto
join detalles_pedido d on pr.id_detalle = d.id_detalle
group by ca.nombre;


-- 5. obtener los clientes con el número total de productos que han comprado
select c.nombre as cliente, sum(d.cantidad) as total_comprado
from cliente c
join pedidos p on c.id_cliente = p.id_cliente
join detalles_pedido d on p.id_detalle = d.id_detalle
group by c.id_cliente;

-- 6. obtener el pedido con el mayor total
select id_pedido, total
from pedidos
order by total desc
limit 1;

-- 7. obtener los productos con un precio superior al promedio de todos los productos
select nombre, precio
from productos
where precio > (select avg(precio) from productos);

-- 8. obtener el total de ventas de cada producto
select pr.nombre as producto, sum(d.cantidad * d.precio) as total_venta
from productos pr
join detalles_pedido d on pr.id_detalle = d.id_detalle
group by pr.id_producto;

-- 3. obtener los pedidos realizados en el mes de enero
select id_pedido, fecha, total
from pedidos
where month(fecha) = 1;

-- 1. obtener todos los productos cuyo precio esté entre 50 y 150
select nombre, precio
from productos
where precio between 50 and 150;
