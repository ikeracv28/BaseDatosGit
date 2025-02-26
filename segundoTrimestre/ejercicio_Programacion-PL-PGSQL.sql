/*
1. Creación de la Base de Datos y Tablas

Instrucciones:
• Crea una base de datos llamada empresa.
• En esta base de datos, debes crear las siguientes tablas:
*/
drop database if exists empresa;
create database empresa;

create table departamentos (
id_departamento serial primary key,
nombre_departamento varchar(100)
);

create table empleados (
id_empleado serial primary key,
nombre varchar(100),
apellido varchar(100),
fecha_nacimiento date,
puesto varchar(100),
antiguedad int,
salario decimal(10,2),
id_departamento int,
foreign key (id_departamento) references departamentos(id_departamento)
on delete cascade 
on update cascade);
);



create table proyectos (
id_proyecto serial primary key,
nombre_proyecto varchar(100),
fecha_inicio date,
id_departamento int,
foreign key (id_departamento) references departamentos(id_departamento)
on delete cascade 
on update cascade);

/*
2. Inserción de Datos de Ejemplo

Instrucciones:
• Inserta al menos 10 empleados con datos fi cticios, asignándolos a diferentes departamentos
y proyectos.
• Incluye al menos 3 departamentos y 3 proyectos distintos.
*/

INSERT INTO departamentos (nombre_departamento) VALUES 
('Finanzas'),
('Atención al Cliente'),
('Ingeniería');

INSERT INTO proyectos (nombre_proyecto, fecha_inicio, id_departamento) VALUES 
('Optimización de Presupuesto', '2024-02-15', 1), -- Finanzas
('Sistema de Tickets', '2024-04-01', 2),         -- Atención al Cliente
('Diseño de Nuevo Producto', '2024-05-10', 3);   -- Ingeniería


INSERT INTO empleados (nombre, apellido, fecha_nacimiento, puesto, antiguedad, salario, id_departamento) VALUES
('Iker', 'Acevedo', '1992-06-14', 'Analista Financiero', 7, 4200.00, 1), -- Finanzas
('Rafael', 'Medina', '1989-09-25', 'Contador', 10, 4000.00, 1),          -- Finanzas
('Alejandro', 'Tovar', '1993-11-12', 'Gestor de Inversiones', 6, 4500.00, 1), -- Finanzas
('Marcos', 'Perez', '1995-04-08', 'Soporte Técnico', 4, 3200.00, 2),   -- Atención al Cliente
('Richi', 'Rich', '1997-07-30', 'Representante de Atención', 2, 2900.00, 2), -- Atención al Cliente
('Iris', 'Perez', '1994-01-22', 'Supervisor de Servicio', 5, 3600.00, 2), -- Atención al Cliente
('Amanda', 'Mandona', '1988-10-18', 'Ingeniera de Producto', 12, 5000.00, 3), -- Ingeniería
('Ian', 'Fernandez', '1996-03-05', 'Ingeniero de Software', 3, 4800.00, 3), -- Ingeniería
('Sergio', 'Gomez', '1991-12-09', 'Diseñador de Hardware', 8, 4700.00, 3), -- Ingeniería
('Sergio', 'Arroyo', '1990-08-28', 'Gerente de Ingeniería', 11, 5500.00, 3); -- Ingeniería



/*
3. Procedimientos y Funciones

Instrucciones:
• Crea un procedimiento almacenado que reciba como parámetro el id_empleado y actualice
su salario un 10% si lleva más de 3 años trabajando en la empresa.
• Crea una función que reciba el id_departamento y devuelva el salario promedio de los empleados
que trabajan en ese departamento. 
*/


create procedure actualizar_salario (i_id_empleado int)
language plpgsql
AS $$
declare años_trabajados int;
begin

 -- Obtener la antigüedad del empleado
	select antiguedad into años_trabajados 
	from empleados where id_empleado = i_id_empleado;
	
	-- Si lleva más de 3 años, aumentar el salario en un 10%
	 if años_trabajados > 3 then
	        update empleados
	        set salario = salario * 1.10
	        where id_empleado = i_id_empleado;
	 end if;
end;
	$$;
	
select * from empleados;

call actualizar_salario(4);



create function salario_promedio (i_id_departamento int)
returns decimal(10,2)
language plpgsql
as $$
declare promedio decimal(10,2);
begin 

	-- Calcular el salario promedio de los empleados en el departamento dado
	select avg(salario) into promedio from empleados
	where id_departamento = i_id_departamento;
	-- Si no hay empleados en ese departamento, devolver 0 para evitar errores
	return coalesce(promedio,0);
end;
$$;

select * from empleados;

select salario_promedio(1);

/*
4. Variables Locales y Globales

Instrucciones:
• Crea una variable global llamada fecha_actual para almacenar la fecha actual del sistema.
• Crea un bloque PL/pgSQL donde defi nas variables locales para realizar un cálculo de
antigüedad y, en función de eso, aplicar una bonifi cación a los empleados que tienen más de
5 años en la empresa.
*/


-- En lugar de definir fecha_actual, puedes usar CURRENT_DATE directamente dentro del bloque PL/pgSQL:
DO $$
DECLARE
    v_fecha_actual DATE := CURRENT_DATE; -- Variable local con la fecha actual
BEGIN
    RAISE NOTICE 'La fecha actual es %', v_fecha_actual;
END $$;

--  Aplicar la Bonificación con Variables Locales
DO $$
DECLARE
    v_id_empleado INT;
    v_antiguedad INT;
    v_salario_actual DECIMAL(10,2);
    v_fecha_actual DATE := CURRENT_DATE; -- Variable local con la fecha actual
BEGIN
    -- Recorrer cada empleado y calcular su bonificación si aplica
    FOR v_id_empleado IN (SELECT id_empleado FROM empleados) LOOP

        -- Obtener la antigüedad del empleado
        SELECT antiguedad, salario INTO v_antiguedad, v_salario_actual
        FROM empleados
        WHERE id_empleado = v_id_empleado;

        -- Si lleva más de 5 años, aumentar el salario en un 5%
        IF v_antiguedad > 5 THEN
            UPDATE empleados
            SET salario = salario * 1.05
            WHERE id_empleado = v_id_empleado;

            RAISE NOTICE 'Bonificación aplicada al empleado ID %: Nuevo Salario = %', 
                          v_id_empleado, v_salario_actual * 1.05;
        ELSE
            RAISE NOTICE 'El empleado ID % no cumple con los 5 años de antigüedad', 
                          v_id_empleado;
        END IF;

    END LOOP;
END $$;

/*
5. Sentencias Condicionales y Flujos de Control

Instrucciones:
• Crea un procedimiento almacenado que reciba como parámetro el id_empleado y un valor
de salario. Si el salario es mayor al valor actual, actualizarlo, de lo contrario, devolver un
mensaje indicando que el salario no ha cambiado.
*/


CREATE PROCEDURE actualizar_salario_si_mayor(p_id_empleado INT, p_nuevo_salario DECIMAL(10,2))
LANGUAGE plpgsql
AS $$
DECLARE
    v_salario_actual DECIMAL(10,2);
BEGIN
    -- Verificar si el empleado existe antes de continuar
    IF NOT EXISTS (SELECT 1 FROM empleados WHERE id_empleado = p_id_empleado) THEN
        RAISE EXCEPTION 'El empleado con ID % no existe', p_id_empleado;
    END IF;

    -- Obtener el salario actual del empleado
    SELECT salario INTO v_salario_actual
    FROM empleados WHERE id_empleado = p_id_empleado;

    -- Comprobar si el nuevo salario es mayor al actual
    IF p_nuevo_salario > v_salario_actual THEN
        -- Actualizar el salario
        UPDATE empleados
        SET salario = p_nuevo_salario
        WHERE id_empleado = p_id_empleado;

        RAISE NOTICE 'El salario del empleado con ID % ha sido actualizado a %', 
                      p_id_empleado, p_nuevo_salario;
    ELSE
        -- Mensaje indicando que el salario no cambia
        RAISE NOTICE 'El nuevo salario (%.2f) no es mayor que el salario actual (%.2f). No se realizaron cambios.', 
                      p_nuevo_salario, v_salario_actual;
    END IF;
END;
$$;

select * from empleados;

CALL actualizar_salario_si_mayor(5, 4000.00);

/*
6. Triggers

Instrucciones:
• Crea un trigger que, al insertar un nuevo empleado, verifi que si su salario es mayor al salario
promedio de la empresa. Si lo es, inserte un mensaje en una tabla de auditoría llamada
auditoria_salarios, con la información del empleado y un mensaje de alerta.
*/

-- Primero tenemos que crear la tabla auditoria para poder realizar este ejercicio.
CREATE TABLE auditoria_salarios (
    id_auditoria SERIAL PRIMARY KEY,
    id_empleado INT,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    salario DECIMAL(10,2),
    mensaje TEXT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- Primero, definimos una función que realizará la lógica de comparación del salario del empleado con el salario promedio de la empresa
CREATE OR REPLACE FUNCTION verificar_salario_alto()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    salario_promedio DECIMAL(10,2);
BEGIN
    -- Calcular el salario promedio de todos los empleados
    SELECT AVG(salario) INTO salario_promedio FROM empleados;

    -- Si el salario del nuevo empleado es mayor al promedio, insertar en auditoría
    IF NEW.salario > salario_promedio THEN
        INSERT INTO auditoria_salarios (id_empleado, nombre, apellido, salario, mensaje)
        VALUES (NEW.id_empleado, NEW.nombre, NEW.apellido, NEW.salario, 
                'ALERTA: Salario mayor al promedio de la empresa');
    END IF;

    RETURN NEW;
END;
$$;

--Después de definir la función, creamos el trigger en la tabla empleados
CREATE TRIGGER trigger_auditoria_salarios
AFTER INSERT ON empleados
FOR EACH ROW
EXECUTE FUNCTION verificar_salario_alto();

-- Para probar el trigger
SELECT AVG(salario) FROM empleados;

INSERT INTO empleados (nombre, apellido, fecha_nacimiento, puesto, antiguedad, salario, id_departamento)
VALUES ('Juan', 'Ramírez', '1990-05-15', 'Director', 15, 7000.00, 1);

SELECT * FROM auditoria_salarios;

/*
7. Cursores

Instrucciones:
• Crea un cursor que recorra todos los empleados de un departamento específi co y, por cada
uno, imprima su nombre y salario en la consola.
*/

DO $$
DECLARE
	-- Se seleccionan los empleados de un departamento específico.
    cur_empleados CURSOR FOR 
        SELECT nombre, salario FROM empleados WHERE id_departamento = 1; 
    v_nombre VARCHAR(100);
    v_salario DECIMAL(10,2);
BEGIN
    -- Abrir el cursor
    OPEN cur_empleados;

	--Usamos un LOOP con FETCH para obtener los datos fila por fila
    LOOP
        -- Extrae una fila a la vez y asigna los valores a v_nombre y v_salario
        FETCH cur_empleados INTO v_nombre, v_salario;
        
        -- Si no hay más filas, salir del bucle
        EXIT WHEN NOT FOUND;

        -- Imprimir los datos del empleado
        RAISE NOTICE 'Empleado: %, Salario: %', v_nombre, v_salario;
    END LOOP;
    
    -- Cerrar el cursor
    CLOSE cur_empleados;
END $$;



