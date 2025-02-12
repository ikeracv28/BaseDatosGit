drop database if exists BiliotecaPLSQL;
create database BiliotecaPLSQL;
use BiliotecaPLSQL;

-- Creamos la tabla LIBRO
CREATE TABLE LIBRO (
    ID INT AUTO_INCREMENT PRIMARY KEY, 
    TITULO VARCHAR(100), 
    AUTOR VARCHAR(50), 
    PRECIO DECIMAL(10,2), 
    DISPONIBLES INT
);

-- Insertamos los datos en la tabla LIBRO
INSERT INTO LIBRO (TITULO, AUTOR, PRECIO, DISPONIBLES)
VALUES 
    ('El Quijote', 'Miguel de Cervantes', 20.00, 5),
    ('Cien Años de Soledad', 'Gabriel García Márquez', 15.50, 3),
    ('1984', 'George Orwell', 18.00, 4);

-- Creamos la tabla CLIENTE
CREATE TABLE CLIENTE (
    ID INT AUTO_INCREMENT PRIMARY KEY, 
    NOMBRE VARCHAR(50), 
    TELEFONO VARCHAR(15)
);

-- Insertamos los datos en la tabla CLIENTE
INSERT INTO CLIENTE (NOMBRE, TELEFONO)
VALUES 
    ('Juan Pérez', '123456789'),
    ('Ana López', '987654321');

-- Creamos la tabla PRESTAMO
CREATE TABLE PRESTAMO (
    ID INT AUTO_INCREMENT PRIMARY KEY, 
    CLIENTE_ID INT, 
    LIBRO_ID INT, 
    FECHA_PRESTAMO DATE, 
    FECHA_DEVOLUCION DATE,
    FOREIGN KEY (CLIENTE_ID) REFERENCES CLIENTE(ID),
    FOREIGN KEY (LIBRO_ID) REFERENCES LIBRO(ID)
);

-- Insertamos los datos en la tabla PRESTAMO
-- Asegúrate de que los IDs de los libros y clientes estén correctos
INSERT INTO PRESTAMO (CLIENTE_ID, LIBRO_ID, FECHA_PRESTAMO, FECHA_DEVOLUCION)
VALUES 
    ((SELECT ID FROM CLIENTE WHERE NOMBRE = 'Juan Pérez'), (SELECT ID FROM LIBRO WHERE TITULO = 'El Quijote'), '2025-01-01', NULL),
    ((SELECT ID FROM CLIENTE WHERE NOMBRE = 'Ana López'), (SELECT ID FROM LIBRO WHERE TITULO = 'Cien Años de Soledad'), '2025-01-15', NULL);
    
    -- Ejercicios Propuestos
/* Parte 1: Declaración de Variables y Operaciones Básicas
Declara una variable para almacenar el precio de un libro y calcula el IVA (21%) del precio.
Usa una estructura de control para verificar si un libro tiene más de 5 ejemplares disponibles y muestra un mensaje según el caso.
*/

-- eliminamos el procedimiento si ya existe, para evitar errores
drop procedure if exists calcular_iva_y_verificar;

delimiter $$

-- creamos el procedimiento calcular_iva_y_verificar
create procedure calcular_iva_y_verificar()
begin
    -- declaramos la variable para el precio del libro
    declare precio_libro decimal(10,2);
    -- declaramos la variable para los ejemplares disponibles
    declare ejemplares_disponibles int;
    
    -- asignamos valores a las variables
    set precio_libro = 20.00;  -- el precio del libro
    set ejemplares_disponibles = 6;  -- número de ejemplares disponibles
    
    -- calculamos el IVA (21%)
    select 
        precio_libro as 'precio libro',  -- mostramos el precio del libro
        precio_libro * 0.21 as 'iva',  -- calculamos el IVA (21%)
        (precio_libro + (precio_libro * 0.21)) as 'precio con iva';  -- sumamos el IVA al precio
    
    -- verificamos si hay más de 5 ejemplares disponibles
    if ejemplares_disponibles > 5 then
        -- si hay más de 5 ejemplares, mostramos este mensaje
        select 'hay más de 5 ejemplares disponibles.' as mensaje;
    else
        -- si no hay suficientes ejemplares, mostramos este mensaje
        select 'no hay suficientes ejemplares disponibles.' as mensaje;
    end if;
end $$

delimiter ;

-- ejecutamos el procedimiento
call calcular_iva_y_verificar();

/*
Parte 2: Procedimientos Almacenados con Variables Locales
Crea un procedimiento llamado CalculaIVA que:

Reciba como parámetro el ID de un libro.
Calcule el precio con IVA (21%) y lo muestre como resultado.

Crea un procedimiento llamado VerificaDisponibilidad que:

Reciba como parámetro el ID de un libro.
Muestre si el libro está disponible (si hay ejemplares en stock).

*/

-- eliminamos el procedimiento si ya existe, para evitar errores
drop procedure if exists calculaiva;

delimiter $$

-- creamos el procedimiento calculaiva
create procedure calculaiva(in id_libro int)
begin
    -- declaramos la variable para almacenar el precio del libro
    declare precio_libro decimal(10,2);
    
    -- obtenemos el precio del libro con el ID proporcionado
    select precio into precio_libro
    from libro
    where id = id_libro;
    
    -- calculamos el IVA (21%) y el precio con IVA
    select 
        precio_libro as 'precio libro', 
        precio_libro * 0.21 as 'iva', 
        (precio_libro + (precio_libro * 0.21)) as 'precio con iva';
end $$

delimiter ;

-- ejecutamos el procedimiento pasando el ID del libro
call calculaiva(1);  -- ejemplo de ejecución con el libro con id 1

-- eliminamos el procedimiento si ya existe, para evitar errores
drop procedure if exists verificadisponibilidad;

delimiter $$

-- creamos el procedimiento verificadisponibilidad
create procedure verificadisponibilidad(id_libro int)
begin
    -- declaramos la variable para almacenar los ejemplares disponibles
    declare ejemplares_disponibles int;
    
    -- obtenemos la cantidad de ejemplares disponibles para el libro con el ID proporcionado
    select disponibles into ejemplares_disponibles
    from libro
    where id = id_libro;
    
    -- verificamos si hay ejemplares disponibles
    if ejemplares_disponibles > 0 then
        -- si hay ejemplares, mostramos este mensaje
        select 'el libro está disponible.' as mensaje;
    else
        -- si no hay ejemplares disponibles, mostramos este mensaje
        select 'el libro no está disponible.' as mensaje;
    end if;
end $$

delimiter ;

-- ejecutamos el procedimiento pasando el ID del libro
call verificadisponibilidad(2);  -- ejemplo de ejecución con el libro con id 2

/*
Parte 3: Estructuras de Control y Lógica Compleja
Diseña un procedimiento llamado ClasificaCliente que:

1. Reciba el ID de un cliente.
Clasifique al cliente según el número de préstamos realizados:
"Cliente nuevo" si no tiene préstamos.
"Cliente regular" si tiene entre 1 y 3 préstamos.
"Cliente frecuente" si tiene más de 3 préstamos.
*/





-- eliminamos el procedimiento si ya existe, para evitar errores
drop procedure if exists clasificacliente;

delimiter $$

-- creamos el procedimiento clasificacliente
create procedure clasificacliente(id_cliente int)
begin
    -- declaramos una variable para contar los préstamos del cliente
    declare numero_prestamos int;
    
    -- obtenemos el número de préstamos que ha realizado el cliente
    select count(*) into numero_prestamos
    from prestamo
    where cliente_id = id_cliente;
    
    -- clasificar al cliente según el número de préstamos
    if numero_prestamos = 0 then
        select 'Cliente nuevo' as clasificacion;
    elseif numero_prestamos between 1 and 3 then
        select 'Cliente regular' as clasificacion;
    else
        select 'Cliente frecuente' as clasificacion;
    end if;
end $$

delimiter ;

-- ejemplo de ejecución del procedimiento para el cliente con ID 1
call clasificacliente(1);

/*
2. Implementa un procedimiento llamado GeneraResumen que:

Recorra todos los libros de la tabla LIBRO.
Calcule y muestre el valor total del inventario para cada libro (PRECIO × DISPONIBLES).
*/

-- eliminamos el procedimiento si ya existe, para evitar errores
drop procedure if exists generaresumen;

delimiter $$

-- creamos el procedimiento generaresumen
create procedure generaresumen()
begin
    -- declaramos las variables para almacenar los datos del libro
    declare fin_bucle int default false;
    declare id_libro int;
    declare precio_libro decimal(10,2);
    declare disponibles_l int;
    declare total_inventario decimal(10,2);
    
    -- abrimos el cursor para recorrer todos los libros
    declare libros_cursor cursor for
    select id, precio, disponibles from libro;
    
    -- defino un manejador para finalizar el cursor cuando no haya mas filas
    declare continue handler for not found set fin_bucle = true;
    
    -- abrimos el cursor
    open libros_cursor;
    
    -- leemos cada libro
    read_loop: loop
        fetch libros_cursor into id_libro, precio_libro, disponibles_l;
        
        -- si no hay más libros, salimos del loop
        if fin_bucle then
            leave read_loop;
        end if;
        
        -- calculamos el valor total del inventario para el libro
        set total_inventario = precio_libro * disponibles_l;
        
        -- mostramos el resumen del libro
        select id_libro as 'ID Libro', precio_libro as 'Precio', disponibles_l as 'Disponibles', total_inventario as 'Valor Inventario';
    end loop;
    
    -- cerramos el cursor
    close libros_cursor;
end $$

delimiter ;

-- ejecutamos el procedimiento para generar el resumen de inventario
call generaresumen();

/*
3. Diseña un procedimiento llamado Promocion que:

Reciba el ID de un libro.
Reduzca su precio en un 10%. Si el precio resulta ser menor a 5, debe establecerse en 5.
*/

-- eliminamos el procedimiento si ya existe, para evitar errores
drop procedure if exists promocion;

delimiter $$

-- creamos el procedimiento promocion
create procedure promocion(in id_libro int)
begin
    -- declaramos una variable para almacenar el precio del libro
    declare precio_libro decimal(10,2);
    
    -- obtenemos el precio del libro
    select precio into precio_libro
    from libro
    where id = id_libro;
    
    -- reducimos el precio en un 10%
    set precio_libro = precio_libro * 0.9;
    
    -- si el precio es menor a 5, lo establecemos en 5
    if precio_libro < 5 then
        set precio_libro = 5;
    end if;
    
    -- actualizamos el precio del libro en la base de datos
    update libro
    set precio = precio_libro
    where id = id_libro;
    
    -- mostramos el nuevo precio
    select 'Nuevo precio para el libro con ID' as mensaje, precio_libro as 'Precio actualizado';
end $$

delimiter ;

-- ejecutamos el procedimiento para aplicar la promoción al libro con ID 1
call promocion(1);

/*
Parte 4: Uso de Bucles
Diseña un procedimiento llamado ActualizarPrecios que recorra todos los libros y aumente sus precios en un 5%.
*/

-- eliminamos el procedimiento si ya existe, para evitar errores
drop procedure if exists actualizarprecios;

delimiter $$

-- creamos el procedimiento actualizarprecios
create procedure actualizarprecios()
begin
    -- declaramos las variables para almacenar el precio del libro
    declare id_libro int;
    declare precio_libro decimal(10,2);
    
    -- declaramos una variable para verificar si el cursor ha terminado
    declare fin_bucle boolean default false;
    
    
    -- declaramos un cursor para recorrer todos los libros
    declare libros_cursor cursor for
    select id, precio from libro;
    
    -- manejamos el fin del cursor
    declare continue handler for not found set fin_bucle = true;
    
    -- abrimos el cursor
    open libros_cursor;
    
    -- leemos los libros uno por uno
    read_loop: loop
        -- obtenemos los datos del libro
        fetch libros_cursor into id_libro, precio_libro;
        
        -- si no hay más libros, salimos del loop
        if fin_bucle then
            leave read_loop;
        end if;
        
        -- aumentamos el precio del libro en un 5%
        set precio_libro = precio_libro * 1.05;
        
        -- actualizamos el precio en la base de datos
        update libro
        set precio = precio_libro
        where id = id_libro;
    end loop;
    
    -- cerramos el cursor
    close libros_cursor;
    
    -- mensaje indicando que los precios se han actualizado
    select 'Precios de todos los libros han sido aumentados en un 5%' as mensaje;
end $$

delimiter ;

-- ejecutamos el procedimiento para actualizar los precios de todos los libros
call actualizarprecios();

select precio from libro;




