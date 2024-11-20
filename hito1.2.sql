-- Crear la base de datos que nos ha pedido la policia
create database if not exists Policia;

-- Seleccionar la base de datos que nos han pedido para trabajar con ella
USE policia;

-- crear las tablas que necesitemos para hacer la base de datos
CREATE table Bandas(
	idBanda  INT auto_increment primary KEY, -- este hay que poner int porque es tipo numérico, auto_increment para que cada banda que vayas metiendo se vaya incluyendo y primary key porque es la clave principal.
	Nombre varchar(30) NOT NULL,  -- en estos dos se pone varchar y el número que le haya puesto para que deje poner ese número
	Ciudad varchar(40) NOT NULL   -- de caracteres como mucho, y not null porque estos campos se tienen que rellenar si o si
);

-- creamos la tabla miembros y le metemos los atributos que le pusimos en el modelo entidad relacion
CREATE table Miembros(
	Dni varchar(9) primary KEY NOT NULL,
	Nombre varchar(30) NOT NULL,
    Apellido varchar(30) NOT NULL,
    Edad varchar(3) not null,
	idBanda varchar(40) NOT NULL
);

use ejercicios_crud;
select * from clientes;

-- obtener una relación de jefes y subordinados
select j.nombre as jefe, s.
