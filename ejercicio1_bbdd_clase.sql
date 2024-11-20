-- borramos la base de datos
drop database if exists actividad;


-- creamos la base de datos
create database if not exists actividad;

-- usamos la actividad
use actividad;

-- creamos la tabla clientes
create table if not exists clientes(
	idCliente int primary key not null auto_increment,
    nombre varchar(30) not null,
    direccion varchar(50),
    poblacion varchar(50),
    facturacion decimal(18,2),
    fechaalta date,
    credito decimal(18,2)
);

-- ahora insertamos los datos de la tabla
insert into clientes (nombre, direccion, poblacion, facturacion, fechaalta, credito)
values 
('Alejandro', 'Calle Mayor 123', 'Madrid', 15000.50, '2021-05-15', 2000.00),
('Iker', 'Avenida de la Luz 45', 'Barcelona', 30000.00, '2022-01-10', 5000.00),
('Rafa', 'Calle Sol 23', 'Valencia', 22000.75, '2020-11-22', 3500.00),
('Marcos', 'Calle Luna 89', 'Sevilla', 5000.00, '2023-02-05', 1200.00),
('Iris', null, null, 18000.20, '2019-09-18', 4000.00),
('Amanda', 'Avenida Central 77', 'Barcelona', 27500.00, '2021-06-30', 4500.00),
('Richi', 'Calle Noclientesrte 55', 'Málaga', 10000.00, '2022-03-12', 1500.00),
('Ian', 'Avenida Sur 90', 'Malaga', 45000.90, '2020-07-25', 6000.00),
('Cristian', null, null, 32000.00, '2021-09-10', 3000.00),
('Sergio', 'Calle Oeste 99', 'Granada', 24000.25, '2023-04-14', 3800.00),
('Jesus', 'Calle del Río 12', 'Madrid', 18000.50, '2022-07-20', 2000.00),
('Fernando', 'Avenida de la Paz 33', 'Murcia', 5000.75, '2024-11-05', 1000.00);


select * from clientes;

-- creamos la tabla filial
create table if not exists filial(
	idFilial int primary key not null auto_increment,
    nombre varchar(30) not null,
    idCliente int,
    foreign key (idCliente) references clientes(idCliente) on delete cascade
);

-- ahora insertamos los datos de la tabla filial
insert into filial (nombre, idCliente) values
('Filial Madrid', 1),
('Filial Barcelona', 2),
('Filial Valencia', 3),
('Filial Alicante', 4),
('Filial Sevilla', 5),
('Filial Jaen', 6),
('Filial Bilbao', 7),
('Filial Galicia', 8),
('Filial Malaga', null),
('Filial Toledo', 10);

-- Aqui sacamos los registros de la tabla clientes
select * from clientes;

-- Ahora sacamos el nombre y la direccion de la tabla clientes
select  nombre, direccion from clientes;

-- Ahora mostramos todsa las ciudades de donde son los clientes, eliminando duplicados
select distinct poblacion FROM clientes;

--  Recupera todos los registros de la tabla «clientes» ordenados por «fechaalta» de manera ascendente.
select * from clientes order by fechaalta asc;

-- Muestra todos los datos de los clientes cuyo «credito» sea mayor a 2000.
select * from clientes where credito > 2000;

-- Escribe una consulta que muestre el nombre, la facturación original y la facturación reducida en 1000 unidades para cada cliente.
select nombre, facturacion, (facturacion - 1000) as facturacion_reducida 
from clientes;

-- Calcula el 10% de la facturación de cada cliente y muéstralo junto con el nombre del cliente.
select nombre, facturacion, (facturacion * 0.10) as porcentaje_facturacion 
from clientes;

-- Selecciona todos los clientes cuya «facturacion» sea mayor o igual a 15,000.
select * from clientes where facturacion >= 15000;

-- Selecciona todos los clientes cuya «facturacion» sea mayor o igual a 15,000.
select * from clientes where facturacion < 20000;

-- Selecciona todos los clientes cuya «poblacion» sea 'Madrid' o 'Barcelona'.
select * from clientes where poblacion = 'Madrid' or poblacion = 'Barcelona';

-- Selecciona todos los clientes cuyo «nombre» empiece con 'Cliente'.
select * from clientes where nombre like 'Cliente';

-- Selecciona todos los clientes cuya «facturacion» esté entre 15000 y 25000.
select * from clientes where facturacion between 15000 AND 25000;

--  Selecciona todos los clientes cuya «poblacion» esté en las ciudades 'Madrid', 'Barcelona' o 'Valencia'.
select * from clientes where poblacion in ('Madrid', 'Barcelona', 'Valencia');

select * from clientes where direccion is null;

select c.nombre as nombre_cliente, f.nombre as nombre_filial
from clientes c
inner join filial f on c.idCliente = f.idCliente;

select c.nombre as nombre_cliente, c.direccion, f.nombre as nombre_filial
from clientes c
left join filial f on c.idCliente = f.idCliente;

select poblacion, SUM(facturacion) as facturacion_total
from clientes
group by poblacion;

select poblacion, SUM(facturacion) as facturacion_total
from clientes
group by poblacion
having SUM(facturacion) > 40000;

select * from clientes order by credito desc;

select * from clientes  where facturacion > (select avg(facturacion) from clientes);

-- no va porque tengo que actualizarlo
update clientes 
set credito = 5000 
where poblacion = 'Madrid';

-- no va porque tengo que actualizarlo
-- Elimina todos los clientes cuya «facturacion» sea menor a 10000.
delete from clientes
where facturacion < 10000;

-- Cuenta el número total de clientes.
select COUNT(*) as total_clientes
from clientes;

-- Calcula la facturación media de todos los clientes.
select avg(facturacion) as facturacion_media from clientes;

-- Muestra la facturación máxima de todos los clientes.
select max(facturacion) as facturacion_maxima from clientes;

-- Muestra la facturación mínima de todos los clientes.
select min(facturacion) as facturacion_minima from clientes;

--  Calcula la suma total de crédito de todos los clientes.
select sum(credito) as credito_total from clientes;

-- Cuenta el número de poblaciones diferentes en las que residen los clientes.
select count(distinct poblacion) as numero_poblaciones from clientes;

-- Selecciona todos los clientes dados de alta después del '2023-06-01'.
select * from clientes where fechaalta > '2023-06-01';

-- Selecciona todos los clientes que no estén en las ciudades 'Madrid' o 'Barcelona'.
select * from clientes where poblacion not in ('Madrid', 'Barcelona')

-- voy por el 35















