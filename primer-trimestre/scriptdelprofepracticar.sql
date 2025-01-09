/* ***Fichero creación BD empresa
	David Valbuena
	Octubre 2024
** */
/*Si la BD existe la elimina*/
DROP DATABASE IF EXISTS empresa;
/*Crea la BD empresa */
CREATE DATABASE empresa;
/* CREATE DATABASE IF NOT EXISTS empresa; */

USE empresa;

DROP TABLE IF EXISTS departamento; 

CREATE TABLE IF NOT EXISTS departamento ( 
numdep int not null auto_increment, 
nombredep varchar(20) not null unique, 
primary key (numdep)); 

INSERT INTO departamento VALUES ('1','Contabilidad'); 
INSERT INTO departamento VALUES ('2','Recursos Humanos'); 
INSERT INTO departamento VALUES ('3','Informática'); 
INSERT INTO departamento VALUES ('4','Comercial');
INSERT INTO departamento VALUES ('5','Facturación');

/*Tabla trabajadores */

DROP TABLE IF EXISTS trabajadores; 

CREATE TABLE IF NOT EXISTS trabajadores (
 dni  VARCHAR(9) PRIMARY KEY ,
 nombre  VARCHAR(50),
 ciudad VARCHAR(40),
 antiguedad   INT(2), 
 salario decimal (8,2),
 departamento int not null,
 constraint fk_departamento foreign key (departamento) REFERENCES departamento(numdep));

INSERT INTO trabajadores VALUES ("11112222A","Rojo Iglesias, Marta", "Barcelona",12, 60000, 2);
INSERT INTO trabajadores VALUES ("11112233A","Perez Carrillo, Iván","Bilbao",5, 48000, 2);
INSERT INTO trabajadores VALUES ("11112244B","Torres Marqués, Fernando","Madrid",11, 55000, 2);
INSERT INTO trabajadores VALUES ("11112255B","Rubio Sánchez, María","Sevilla",4, 36000, 3);
INSERT INTO trabajadores VALUES ("11112266C","Llamas Rocasolano, Isabel","Barcelona",13, 28000, 3);
INSERT INTO trabajadores VALUES ("11112222C","Gomez Corachán, Manuel","Madrid",15, 22000, 1);
INSERT INTO trabajadores VALUES ("22112222A","Roca Benítez, Elena","Sevilla",6, 35000, 4);
INSERT INTO trabajadores VALUES ("33112222A","Nualart Vives, Carlos", "Barcelona",10, 30000, 4);
INSERT INTO trabajadores VALUES ("22334455C","Perez Cano, Isabel", "Madrid",2, 36000, 3);
INSERT INTO trabajadores (dni, nombre, antiguedad, salario, departamento) VALUES 
("33112222C","Muñoz Casas, Montse",7,40000, 5);

/* Ejemplo 1 */
-- Borramos el trabajador con dni '22334455C'

SELECT * from trabajadores;
DELETE FROM trabajadores where dni='22334455C';

/* Ejemplo 2 */
-- Borramos todos los trabajadores del departamento de contabilidad.

DELETE FROM trabajadores 
where departamento in (
	SELECT numdep FROM departamento
    WHERE nombredep='Contabilidad') ;
    
/* Ejemplo 3 */
-- Borramos todos los trabajadores del departamento de recursos Humanos,
-- con menos de 10 años de antiguedad.

DELETE FROM trabajadores 
where departamento in (
	SELECT numdep FROM departamento
    WHERE nombredep='Recursos Humanos') and antiguedad<10;

desc trabajadores; 
desc departamento;

/*Integridad Referencial*/
-- Borramos la clave foranea.alter
ALTER TABLE trabajadores
DROP FOREIGN KEY fk_departamento;

-- Añadimos la nueva clave foránea con las restricciones.
ALTER TABLE trabajadores
ADD CONSTRAINT fk_departamento FOREIGN KEY (departamento)  
REFERENCES departamento(numdep) 
ON DELETE NO ACTION
ON UPDATE CASCADE;

-- Probamos el DELETE (da error)
-- Probamos el UPDATE (si funciona)

DELETE from departamento where nombredep='Recursos Humanos';
UPDATE departamento SET numdep='20' WHERE nombredep='Recursos Humanos';
SELECT * from trabajadores;
select * from departamento;

-- Ejemplo 2: Uso de SET NULL.
-- Añadimos la nueva clave foránea con las restricciones.
DESC trabajadores;
ALTER TABLE trabajadores
DROP FOREIGN KEY fk_departamento;
-- modificamos el campo departamento para que acepte valores nulos
-- sino nos dará error al poner la restricción
ALTER TABLE trabajadores
modify departamento int(11) null;

ALTER TABLE trabajadores
ADD CONSTRAINT fk_departamento FOREIGN KEY (departamento)  
REFERENCES departamento(numdep) 
ON DELETE SET NULL;
-- Al no poner update el valor es NO ACTION o RESTRICT
-- Probamos el DELETE (Si funciona)
-- Probamos el UPDATE (No funciona) al no tener definida la integridad referencial.
-- para que funcione tenemos que poner el ON update CASCADE;

UPDATE departamento SET numdep='2' WHERE nombredep='Recursos Humanos';
DELETE from departamento where nombredep='Recursos Humanos';
SELECT * from trabajadores;
