-- eliminamos la base de datos si ya existe
-- esto evita errores si queremos crearla de nuevo
drop database if exists plsql_ejercicios;

-- creamos la base de datos
create database plsql_ejercicios;

-- usamos la base de datos creada
use plsql_ejercicios;

-- creamos la tabla producto con sus campos
create table producto (
    id_producto int auto_increment primary key, 
    descripcion varchar(100), 
    stock int not null, 
    precio decimal(10,2) not null 
);

-- creamos la tabla cliente con sus campos
create table cliente (
    id_cliente int auto_increment primary key, 
    nombre varchar(50), 
    telefono varchar(15) 
);

-- creamos la tabla factura con sus campos
create table factura (
    id_factura int auto_increment primary key, 
    total decimal(10,2) not null, 
    fecha date not null, 
    id_cliente int, 
    foreign key (id_cliente) references cliente (id_cliente) 
);

-- insertamos datos en la tabla producto
insert into producto (descripcion, stock, precio) 
values 
    ('martillo', 100, 10.50),
    ('taladro', 50, 45.99);
  
-- insertamos datos en la tabla cliente
insert into cliente (nombre, telefono) 
values 
    ('iker acevedo', '123456789');

-- insertamos datos en la tabla factura
-- antes de insertar verificamos los id disponibles con: select * from cliente;
insert into factura (total, fecha, id_cliente)
values
    (899.99, '2025-02-01', 1);
    
-- eliminamos el procedimiento si ya existe para evitar errores
drop procedure if exists calculoiva; 

delimiter $$

-- creamos el procedimiento que calcula el iva de un producto
create procedure calculoiva()
begin
    declare nombre_producto varchar(50);
    declare iva decimal(10,2);
    declare precio_base decimal(10,2);
    declare texto text;

    -- asignamos un producto específico
    set nombre_producto = "martillo";
    
    -- obtenemos el precio del producto seleccionado
    select precio into precio_base from producto where descripcion = nombre_producto;
    
    -- calculamos el iva (21% del precio base)
    set iva = precio_base * 0.21;
    
    -- generamos el texto con el precio final incluyendo iva
    set texto = concat("el precio total del " , nombre_producto, " es de " , precio_base + iva , "€");

    -- mostramos el resultado
    select texto as resultado;
end $$
delimiter ;

-- ejecutamos el procedimiento
call calculoiva();    

-- eliminamos el procedimiento si ya existe
drop procedure if exists validaedad;

delimiter $$

-- creamos el procedimiento que clasifica a una persona según su edad
create procedure validaedad(edad int)
begin 
    declare texto text;
    
    if edad < 18 then
        set texto = "es menor de edad";
    elseif edad < 65 then
        set texto = "es adulto";
    else 
        set texto = "es jubilado";
    end if;
    
    -- mostramos el resultado
    select texto as rango;
end $$
delimiter ;

-- ejecutamos el procedimiento con un ejemplo
call validaedad(40);

-- eliminamos el procedimiento si ya existe
drop procedure if exists clasificacliente;

delimiter $$

-- creamos un procedimiento que clasifica a un cliente según el total gastado
create procedure clasificacliente(total decimal(10,2))
begin
    declare texto text;
    
    if total < 500 then 
        set texto = "cliente regular";
    elseif total >= 500 then
        set texto = "cliente preferente";
    end if;
    
    -- mostramos el resultado
    select texto as tipo_cliente;
end $$
delimiter ;

-- ejecutamos el procedimiento con un ejemplo
call clasificacliente(600);

-- eliminamos el procedimiento si ya existe
drop procedure if exists generaresumen;

delimiter $$

-- creamos un procedimiento que muestra un resumen de los productos
create procedure generaresumen()
begin
    select id_producto, descripcion, stock, precio, (stock * precio) as valor_total from producto;
end $$
delimiter ;

-- ejecutamos el procedimiento
call generaresumen();

-- eliminamos el procedimiento si ya existe
drop procedure if exists promocion;

delimiter $$

-- creamos un procedimiento que aplica una promoción a un producto
create procedure promocion(in p_id_producto int)
begin
    declare precio_actual decimal(10,2);
    declare nuevo_precio decimal(10,2);
    
    -- obtenemos el precio actual del producto
    select precio into precio_actual from producto where id_producto = p_id_producto;
    
    -- reducimos el precio en un 10%
    set nuevo_precio = precio_actual * 0.90;
    
    -- si el nuevo precio es menor a 5, lo dejamos en 5
    if nuevo_precio < 5 then
        set nuevo_precio = 5;
    end if;
    
    -- actualizamos el precio en la base de datos
    update producto 
    set precio = nuevo_precio 
    where id_producto = p_id_producto;
    
    -- mostramos el nuevo precio
    select 
        id_producto,
        descripcion,
        precio as nuevo_precio
    from producto
    where id_producto = p_id_producto;
end $$
delimiter ;

-- ejecutamos el procedimiento con un id de producto
call promocion(1);







