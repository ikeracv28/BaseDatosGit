CREATE DATABASE IF NOT EXISTS triangulos;
USE triangulos;
DELIMITER //

DELIMITER //

CREATE PROCEDURE CrearTablaYDatos()
BEGIN
  DECLARE i INT DEFAULT 0;
    -- Eliminar la tabla si existe
    DROP TABLE IF EXISTS triangulo;
    
    -- Crear la tabla
    CREATE TABLE triangulo (
        id INT AUTO_INCREMENT PRIMARY KEY,
        lado1 INT NOT NULL,
        lado2 INT NOT NULL,
        lado3 INT NOT NULL
    );

    -- Insertar 20 filas con valores aleatorios entre 1 y 5
  
    
    WHILE i < 20 DO
        INSERT INTO triangulo (lado1, lado2, lado3) 
        VALUES (FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 5));
        SET i = i + 1;
    END WHILE;
    
END //

DELIMITER ;


CALL CrearTablaYDatos();
DELIMITER //

CREATE FUNCTION TipoTriangulo(a INT, b INT, c INT) 
RETURNS VARCHAR(20) DETERMINISTIC
BEGIN
    DECLARE tipo VARCHAR(20);
    
    IF a = b AND b = c THEN
        SET tipo = 'Equilátero';
    ELSEIF a = b OR b = c OR a = c THEN
        SET tipo = 'Isósceles';
    ELSE
        SET tipo = 'Escaleno';
    END IF;
    
    RETURN tipo;
END //

DELIMITER ;
DELIMITER //

CREATE FUNCTION PerimetroTriangulo(a INT, b INT, c INT) 
RETURNS INT DETERMINISTIC
BEGIN
    RETURN a + b + c;
END //

DELIMITER ;
SELECT id, lado1, lado2, lado3, 
       TipoTriangulo(lado1, lado2, lado3) AS Tipo, 
       PerimetroTriangulo(lado1, lado2, lado3) AS Perimetro
FROM triangulo;
