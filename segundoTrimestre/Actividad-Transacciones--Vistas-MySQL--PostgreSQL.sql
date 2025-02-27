-- Creación de la base de datos
drop database banco_prueba;
CREATE DATABASE banco_prueba;
USE banco_prueba;  -- Para MySQL


-- Creación de la tabla cuentas
CREATE TABLE cuentas (
    id int auto_increment PRIMARY KEY,  -- AUTO_INCREMENT en MySQL, SERIAL en PostgreSQL
    nombre VARCHAR(100) NOT NULL,
    saldo DECIMAL(10,2) NOT NULL CHECK (saldo >= 0)
);

-- Inserción de datos iniciales en la tabla cuentas
INSERT INTO cuentas (nombre, saldo) VALUES ('Juan Pérez', 1500.00);
INSERT INTO cuentas (nombre, saldo) VALUES ('María López', 800.00);
INSERT INTO cuentas (nombre, saldo) VALUES ('Carlos Gómez', 2000.00);


-- Transacciones

-- 2.  Transaccion 1 
start transaction;

update cuentas set saldo = saldo - 300
where id = 1 and saldo >= 300;

update cuentas set saldo = saldo + 300
where id = 2;

commit;

select * from cuentas;


-- 3. Transaccion con rollback
start transaction;
update cuentas set saldo = saldo - 500
where id = 2 and saldo >= 500;

update cuentas set saldo = saldo + 500 
where id = 3;

-- Hacemos un select para comprobar que se han ejecutado los cambios
select * from cuentas;

-- Ahora hacemos rollback para que vuelva atras y no se guarden los camabios
rollback;
 
 -- Ahora hacemos otro select para ver como hemos vuelto a antes de los cambios
select * from cuentas;


-- 4. Transaccion con savepoint
-- Empezamos transaccion
start transaction;

-- Realizamos los cambios que queramos hacer
update cuentas set saldo = saldo - 500
where id = 3 and saldo >= 900;

select * from cuentas;
-- Ponemos el save point y le damos un nombre
savepoint prueba1;

update cuentas set saldo = saldo + 900 
where id = 2;

select * from cuentas;

-- Esto sirve para volver al punto de control que hemos creado
rollback to prueba1;

select * from cuentas;

-- Ya po ultimo ponemos el commit para guardar todos los cambios
commit;


-- 5. comprobar si hay autocommit
-- Esto es para ver si esta activo o no
SHOW VARIABLES LIKE 'autocommit';

-- Asi se desactiva 
SET autocommit = 0;

-- Y asi se activa
SET autocommit = 1;

-- BLOQUEOS

-- 6.  Crea un escenario donde dos sesiones intenten modificar la misma tabla. Utiliza bloqueos de tipo WRITE para evitar conflictos.

-- Para hacer estos ejercicios deberemos simular que simular que tenemos dos sesiones abiertas.
-- En la Session 1, bloquear la tabla y modificar un registro:
LOCK TABLES cuentas WRITE;

UPDATE cuentas SET saldo = saldo - 200 WHERE id = 1;

-- No se ejecuta COMMIT ni UNLOCK TABLES, la tabla sigue bloqueada
-- Ahora la tabla cuentas está bloqueada y nadie más puede escribir ni leer en ella.

-- En la Session 2, intentar modificar la misma tabla:
UPDATE cuentas SET saldo = saldo + 200 WHERE id = 1;

--  La consulta se quedará bloqueada hasta que Session 1 libere la tabla.
-- En Session 1, liberar la tabla:
UNLOCK TABLES;



