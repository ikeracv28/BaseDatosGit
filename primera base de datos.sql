-- Crear una base de datos.
CREATE database if not exists facturacion;
CREATE database if not exists clientes;

/* 
Con esto seleccionamos las base
de datos con la que queremos trabajar
*/

use facturacion;
use clientes;
CREATE table clientes(
	cif VARCHAR(9) PRIMARY KEY NOT NULL,
	nombre varchar(30) NOT NULL,
	direccion varchar(50) NOT NULL,
	poblacion varchar(50),
	web varchar(60),
	correo varchar(50)
),
