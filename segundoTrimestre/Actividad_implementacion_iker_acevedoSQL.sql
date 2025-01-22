drop database if exists Banco;
-- Crear la base de datos
CREATE DATABASE Banco;
USE Banco;

-- Crear la tabla cuentas
CREATE TABLE cuentas (
    id_cuenta INT PRIMARY KEY,
    nombre_cliente VARCHAR(50) NOT NULL,
    saldo DECIMAL(10, 2) NOT NULL
);

-- Crear la tabla auditoria
CREATE TABLE auditoria (
    id_auditoria INT PRIMARY KEY AUTO_INCREMENT,
    cuenta_id INT NOT NULL,
    saldo_anterior DECIMAL(10, 2) NOT NULL,
    saldo_actual DECIMAL(10, 2) NOT NULL,
    fecha DATETIME NOT NULL,
    FOREIGN KEY (cuenta_id) REFERENCES cuentas(id_cuenta)
);

-- Insertar datos de ejemplo en la tabla cuentas
INSERT INTO cuentas (id_cuenta, nombre_cliente, saldo)
VALUES
    (1, 'Iker Acevedo', 1500.00),
    (2, 'Rafa Medina', 2400.50),
    (3, 'Alejandro Tovar', 3200.75),
    (4, 'Marcos Perez', 4100.00),
    (5, 'Richi Skater', 1800.25);


-- Insertar datos de ejemplo en la tabla auditoria
INSERT INTO auditoria (cuenta_id, saldo_anterior, saldo_actual, fecha)
VALUES
	(1, 1400.00, 1300.00, '2025-01-05 14:00:00'),
    (4, 4100.00, 4000.00, '2025-01-06 12:30:00'),
    (5, 1800.25, 1700.25, '2025-01-07 15:45:00'),
    (2, 2300.50, 2200.50, '2025-01-08 10:15:00'),
    (3, 3100.75, 3000.75, '2025-01-09 09:00:00');

-- Consultar las tablas para verificar los datos
SELECT * FROM cuentas;
SELECT * FROM auditoria;

-- Ejercicio 2: Creación de la función ObtenerSaldo


DELIMITER $$
create function ObtenerSaldo(id_cuenta int)
returns decimal(10,2) -- Decimos que devolverá un número decimal.
deterministic -- Significa que siempre dará el mismo resultado para los mismos datos
begin
	-- Declaramos una variable para almacenar el saldo
	declare saldo_actual DECIMAL(10, 2);
    
    -- Obtenemos el saldo de la cuenta especificada
    select saldo into saldo_actual from cuentas where cuentas.id_cuenta = id_cuenta;
    
    -- Devolvemos el saldo
    return saldo_actual;
end $$ -- Termina la función.

-- Volvemos al modo normal
DELIMITER ;

-- Hacemos este select para comprobar el funcionamiento de la funcion que acabamos de hacer
select ObtenerSaldo(1) as saldoCuenta1;


-- Ejercicio 3: Creación del disparador RegistrarAuditoria

delimiter $$

create trigger RegistrarAuditoria
after update on cuentas -- esto lo que dice es que este disparador se ejecute despues de que haya una actualizacion en la tabla cuentas
for each row -- Se ejecutará para cada fila que se actualice en la tabla "cuentas".
begin -- El bloque BEGIN ... END agrupa los comandos que se ejecutarán cuando el trigger sea activado.

/*Si el saldo ha cambiado, insertamos un nuevo registro en la tabla auditoria. Los valores a insertar son:
NEW.id_cuenta: El ID de la cuenta que ha sido modificada.
OLD.saldo: El saldo de la cuenta antes de la actualización.
NEW.saldo: El saldo de la cuenta después de la actualización.
NOW(): La fecha y hora actuales del cambio.
*/
	insert auditoria (cuenta_id, saldo_anterior, saldo_actual, fecha)
    values (new.id_cuenta, old.saldo, new.saldo, now());
    
end$$ -- Fin del bloque del trigger.

delimiter ;

-- hacemos un update para comprobar que el trigger va, en este caso le actualizamos le saldo de 1400 a 5000
update cuentas set saldo = 5000.00 where id_cuenta = 1;

-- Ahora hacemos el select para comprobar que funciona correctamente
select * from auditoria;
    
    
-- Ejercicio 4: Creación del procedimiento TransferenciaSegura

delimiter $$
create procedure TransferenciaSegura(
in cuenta_origen int,   -- ID de la cuenta de origen
in cuenta_destino int,  -- ID de la cuenta de destino
in monto decimal(10, 2) -- Monto a transferir
)
begin 
declare saldo_origen decimal(10,2); -- Variable para almacenar el saldo de la cuenta de origen
declare saldo_destino decimal(10,2); -- Variable para almacenar el saldo de la cuenta de destino

-- Iniciar una transacción
    START TRANSACTION;

    -- Validar que la cuenta de origen tiene suficiente saldo
    SELECT saldo INTO saldo_origen FROM cuentas WHERE id_cuenta = cuenta_origen FOR UPDATE;
    IF saldo_origen < monto THEN
        -- Si no hay suficiente saldo, revertir la transacción y mostrar error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Saldo insuficiente en la cuenta de origen.';
    END IF;

    -- Verificar que la cuenta de destino existe
    SELECT saldo INTO saldo_destino FROM cuentas WHERE id_cuenta = cuenta_destino;
    IF saldo_destino IS NULL THEN
        -- Si la cuenta de destino no existe, revertir la transacción y mostrar error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La cuenta de destino no existe.';
    END IF;

    -- Realizar la transferencia: restar el monto de la cuenta de origen y sumarlo a la cuenta de destino
    UPDATE cuentas SET saldo = saldo - monto WHERE id_cuenta = cuenta_origen;
    UPDATE cuentas SET saldo = saldo + monto WHERE id_cuenta = cuenta_destino;

    -- Confirmar la transacción
    COMMIT;

END $$

DELIMITER ;

-- Transferencia válida entre dos cuentas:
-- Transfiere 500.00 de la cuenta 1 a la cuenta 2.
CALL TransferenciaSegura(1, 2, 500.00);


-- Transferencia con saldo insuficiente en la cuenta de origen:
-- Intenta transferir 7000.00 de la cuenta 1 a la cuenta 2, pero la cuenta 1 no tiene suficiente saldo.
CALL TransferenciaSegura(1, 2, 7000.00);


-- Transferencia a una cuenta inexistente
-- Intenta transferir 100.00 de la cuenta 1 a una cuenta inexistente con id_cuenta = 999.
CALL TransferenciaSegura(1, 999, 100.00);


-- Ejercicio 5: Prueba completa del sistema
-- Paso 1: Consultar saldo inicial
SELECT id_cuenta, nombre_cliente, saldo FROM cuentas;

-- Paso 2: Ejecutar transferencia válida
CALL TransferenciaSegura(1, 2, 500.00);

-- Verificación 1: Nuevos saldos
SELECT id_cuenta, nombre_cliente, saldo FROM cuentas;

-- Verificación 2: Registro en auditoria
SELECT * FROM auditoria ORDER BY fecha DESC;

-- Paso 3: Intentar transferencia inválida
CALL TransferenciaSegura(1, 3, 10000.00);

-- Verificación 3: Saldos tras intento de transferencia inválida
SELECT id_cuenta, nombre_cliente, saldo FROM cuentas;





    
    