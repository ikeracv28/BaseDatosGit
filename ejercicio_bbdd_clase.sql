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
('Iris', 'Plaza del Sol 10', null, 18000.20, '2019-09-18', 4000.00),
('Amanda', 'Avenida Central 77', 'Bacelona', 27500.00, '2021-06-30', 4500.00),
('Richi', 'Calle Noclientesrte 55', 'Málaga', 10000.00, '2022-03-12', 1500.00),
('Ian', 'Avenida Sur 90', 'Malaga', 45000.90, '2020-07-25', 6000.00),
('Cristian', 'Calle Este 31', null, 32000.00, '2021-09-10', 3000.00),
('Sergio', 'Calle Oeste 99', 'Granada', 24000.25, '2023-04-14', 3800.00),
('Jesus', 'Calle del Río 12', 'Madrid', 18000.50, '2022-07-20', 2000.00),
('Fernando', 'Avenida de la Paz 33', 'Murcia', 5000.75, '2021-11-05', 1000.00);


select * from clientes;

-- creamos la tabla filial
create table if not exists filial(
	idFilial int primary key not null auto_increment,
    nombre varchar(30) not null,
    idCliente int not null,
    foreign key (idCliente) references clientes(idCliente) on delete cascade
);






