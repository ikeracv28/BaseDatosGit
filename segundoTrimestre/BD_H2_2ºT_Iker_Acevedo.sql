-- crear la base de datos triangulos
drop database if exists triangulos;
create database triangulos;
use triangulos;

-- crear el procedimiento almacenado
delimiter $$

create procedure crear_datos_triangulos()
begin
    -- borrar la tabla triangulo si ya existe y crearla de nuevo
    declare i int default 0;
    drop table if exists triangulo;
    create table triangulo (
        id int auto_increment primary key,
        lado1 int not null,
        lado2 int not null,
        lado3 int not null
    );

    -- insertar 20 filas con valores aleatorios entre 1 y 5
    
    set i = 0;
    while i < 20 do
        insert into triangulo (lado1, lado2, lado3)
        values (floor(1 + rand() * 5), floor(1 + rand() * 5), floor(1 + rand() * 5));
        set i = i + 1;
    end while;
end$$

delimiter ;

-- ejecutar el procedimiento para crear la tabla y los datos
call crear_datos_triangulos();

-- función para saber qué tipo de triángulo es
delimiter $$

create function tipo_triangulo(l1 int, l2 int, l3 int) 
returns varchar(20)
deterministic
begin
    declare tipo varchar(20);
    if l1 = l2 and l2 = l3 then
        set tipo = 'equilátero'; -- todos los lados iguales
    elseif l1 = l2 or l2 = l3 or l1 = l3 then
        set tipo = 'isósceles'; -- dos lados iguales
    else
        set tipo = 'escaleno'; -- todos los lados diferentes
    end if;
    return tipo;
end$$

delimiter ;

-- función para calcular el perímetro del triángulo
delimiter $$

create function calcular_perimetro(l1 int, l2 int, l3 int) 
returns int
deterministic
begin
    return l1 + l2 + l3; -- suma de los tres lados
end$$

delimiter ;

-- consulta para ver la tabla con el tipo y el perímetro de cada triángulo
select 
    id, lado1, lado2, lado3,
    tipo_triangulo(lado1, lado2, lado3) as tipo,
    calcular_perimetro(lado1, lado2, lado3) as perimetro
from triangulo;
