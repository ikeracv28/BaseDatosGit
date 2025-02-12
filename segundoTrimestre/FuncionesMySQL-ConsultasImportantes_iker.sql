drop database if exists FuncionesMySQL;
create database  FuncionesMySQL;
use FuncionesMySQL;

-- creamos la tabla producto. aqui almacenaremos información sobre los productos que vendemos.
-- id será el identificador único de cada producto y se autoincrementará solo.
-- descripcion nos dirá de qué se trata el producto y precio cuánto cuesta.
create table producto (
    id int primary key auto_increment,
    descripcion varchar(100),
    precio decimal(10,2)
);

-- ahora insertamos algunos productos de ejemplo. estos son cosas que podríamos vender en una tienda de herramientas.
insert into producto (descripcion, precio) values 
('martillo', 10.50),
('destornillador', 5.75),
('sierra', 25.30),
('taladro', 45.99),
('alicates', 15.00);

-- creamos la tabla cliente. aquí almacenaremos información sobre las personas que compran nuestros productos.
-- id será el identificador único de cada cliente.
-- nombre nos dirá quién es el cliente y tlf su número de teléfono.
create table cliente (
    id int primary key auto_increment,
    nombre varchar(50),
    tlf varchar(15)
);

-- insertamos algunos clientes de ejemplo. estos son nombres comunes con teléfonos ficticios.
insert into cliente (nombre, tlf) values 
('juan perez', '123456789'),
('maria lopez', '987654321'),
('carlos sanchez', '567890123'),
('laura martinez', '111222333'),
('pedro garcia', '444555666');

-- creamos la tabla factura. aquí almacenaremos información sobre las ventas realizadas.
-- numero será el identificador único de cada factura.
-- fecha nos dirá cuándo se hizo la venta y total cuánto se gastó.
create table factura (
    numero int primary key auto_increment,
    fecha date,
    total decimal(10,2)
);

-- insertamos algunas facturas de ejemplo. estas son ventas realizadas en diferentes fechas.
insert into factura (fecha, total) values 
('2025-01-01', 100.50),
('2025-01-02', 75.99),
('2025-01-03', 50.30);

-- parte 1: funciones de cadena

-- 1. convertimos todos los nombres de los clientes a mayúsculas. upper() hace eso.
select upper(nombre) as nombre_mayusculas from cliente;

-- 2. convertimos las descripciones de los productos a minúsculas. lower() hace eso.
select lower(descripcion) as descripcion_minusculas from producto;

-- 3. calculamos el número de caracteres en cada descripción de producto. length() cuenta los caracteres.
select descripcion, length(descripcion) as longitud from producto;

-- 4. concatenamos el nombre y el teléfono de cada cliente. concat() une texto.
select concat(nombre, ' (', tlf, ')') as nombre_con_tlf from cliente;

-- 5. extraemos los primeros 3 caracteres de cada descripción. substring() corta texto.
select descripcion, substring(descripcion, 1, 3) as primeros_3_caracteres from producto;

-- 6. rellenamos las descripciones de los productos con el carácter '-' hasta completar 30 caracteres. lpad() añade caracteres al inicio.
select lpad(descripcion, 30, '-') as descripcion_rellena from producto;

-- parte 2: funciones aritméticas

-- 1. calculamos el valor absoluto de -25. abs() da el valor absoluto.
select abs(-25) as valor_absoluto;

-- 2. redondeamos el precio de los productos a 1 decimal. round() redondea números.
select descripcion, round(precio, 1) as precio_redondeado from producto;

-- 3. calculamos el total con un iva del 21% para cada producto. multiplicamos el precio por 1.21.
select descripcion, precio * 1.21 as total_con_iva from producto;

-- 4. encontramos el cuadrado de 5. pow() eleva un número a una potencia.
select pow(5, 2) as cuadrado_de_5;

-- 5. calculamos la raíz cuadrada de 100. sqrt() encuentra la raíz cuadrada.
select sqrt(100) as raiz_cuadrada_de_100;

-- parte 3: funciones de fecha y hora

-- 1. obtenemos la fecha actual usando now() y curdate(). ambas funciones nos dan la fecha actual.
select now() as fecha_hora_actual, curdate() as fecha_actual;

-- 2. formateamos la fecha de las facturas como "miércoles 1-ene-2025". date_format() cambia el formato de la fecha.
select date_format(fecha, '%W %e-%b-%Y') as fecha_formateada from factura;

-- 3. extraemos el mes de la fecha actual. month() nos da el número del mes.
select month(curdate()) as mes_actual;

-- 4. calculamos la diferencia en días entre hoy y el 1 de enero de 2025. datediff() calcula la diferencia entre dos fechas.
select datediff('2025-01-01', curdate()) as diferencia_en_dias;
