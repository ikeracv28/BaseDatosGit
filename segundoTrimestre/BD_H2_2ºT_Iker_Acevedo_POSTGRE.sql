-- crear la base de datos triangulos y conectarse a ella
drop database if exists triangulos; 
create database triangulos;



-- procedimiento para crear la tabla y generar datos aleatorios
create or replace procedure crear_datos_triangulos()
language plpgsql
as $$
declare 
    i int := 0; -- variable para controlar el bucle
begin
    -- eliminar la tabla si ya existe
    drop table if exists triangulo;

    -- crear la tabla triangulo con un único campo de tipo array
    create table triangulo (
        id serial primary key, -- id autoincremental como clave primaria
        lados int[] not null -- array que almacena los tres lados del triángulo
    );

    -- insertar 20 filas con valores aleatorios entre 1 y 5 para los tres lados
    while i < 20 loop
        insert into triangulo (lados)
        values (
            array[
                floor(random() * 5 + 1)::int, -- genera un número aleatorio entre 1 y 5 para el primer lado
                floor(random() * 5 + 1)::int, -- genera un número aleatorio entre 1 y 5 para el segundo lado
                floor(random() * 5 + 1)::int  -- genera un número aleatorio entre 1 y 5 para el tercer lado
            ]
        );
        i := i + 1; -- incrementa el contador del bucle
    end loop;
end;
$$;

-- función para determinar el tipo de triángulo
create or replace function tipo_triangulo(lados int[]) returns varchar
language plpgsql
as $$
declare
    tipo varchar(20); -- almacena el tipo de triángulo
begin
    if lados[1] = lados[2] and lados[2] = lados[3] then
        tipo := 'equilátero'; -- todos los lados iguales
    elsif lados[1] = lados[2] or lados[2] = lados[3] or lados[1] = lados[3] then
        tipo := 'isósceles'; -- dos lados iguales
    else
        tipo := 'escaleno'; -- todos los lados diferentes
    end if;
    return tipo;
end;
$$;

-- función para calcular el perímetro del triángulo
create or replace function calcular_perimetro(lados int[]) 
returns int 
language plpgsql
as $$
begin
    return lados[1] + lados[2] + lados[3]; -- suma de los tres lados
end;
$$;

-- llamar al procedimiento para generar los datos
call crear_datos_triangulos();

-- consulta para ver los triángulos con cada lado separado, su tipo y su perímetro
select 
    lados[1] as lado1, lados[2] as lado2, lados[3] as lado3, -- extraigo cada lado del array
    tipo_triangulo(lados) as tipo, -- llamo a la función que identifica el tipo de triángulo
    calcular_perimetro(lados) as perimetro -- llamo a la función que calcula el perímetro
from triangulo;

