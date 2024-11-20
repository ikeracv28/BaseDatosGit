/* ***Fichero creación BD empresa
	David Valbuena
	Octubre 2024
***/
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
 foreign key (departamento) REFERENCES departamento(numdep));

INSERT INTO trabajadores VALUES ("11112222A","Rojo Iglesias, Marta", "Barcelona",12, 60000, 2);
INSERT INTO trabajadores VALUES ("11112233A","Perez Carrillo, Iván","Bilbao",5, 48000, 2);
INSERT INTO trabajadores VALUES ("11112244B","Torres Marqués, Fernando","Madrid",11, 55000, 2);
INSERT INTO trabajadores VALUES ("11112255B","Rubio Sánchez, María","Sevilla",4, 36000, 3);
INSERT INTO trabajadores VALUES ("11112266C","Llamas Rocasolano, Isabel","Barcelona",13, 28000, 3);
INSERT INTO trabajadores VALUES ("11112222C","Gomez Corachán, Manuel","Madrid",15, 22000, 1);
INSERT INTO trabajadores VALUES ("22112222A","Roca Benítez, Elena","Sevilla",6, 35000, 4);
INSERT INTO trabajadores (dni, nombre, antiguedad, salario, departamento) VALUES ("33112222C","Muñoz Casas, Montse",7,40000, 5);

select * from departamento;
select * from trabajadores;



-- Ejemplo 1
INSERT INTO trabajadores VALUES ("33112222A","Nualart Vives, Carlos", "Barcelona",10, 30000, 4);

-- Ejemplo 2 insercción en tablas con campos autonuméricos.

INSERT INTO departamento VALUES (0,'Marketing');
select * from departamento;

INSERT INTO departamento (nombredep) VALUES ('Ventas');
select * from departamento;

-- Ejemplo 3 insercción en tablas con opción set
desc trabajadores;
INSERT INTO trabajadores SET dni="22334455C", nombre="Perez Cano, Isabel", 
ciudad="Madrid",
antiguedad=2, salario=36000, departamento=3;

select * from trabajadores;

-- Ejemplo 4 insercción con instrucción select

CREATE TABLE trabajadoresbarcelona LIKE trabajadores;
DESC trabajadoresbarcelona;

SELECT * FROM trabajadoresbarcelona;

INSERT into trabajadoresbarcelona
SELECT * from trabajadores WHERE ciudad="barcelona";

select * from trabajadoresbarcelona;

   
-- Ejemplo  creamos una nueva tabla metodo 2 con el select directamente.
-- Sirve para hacer backup, no copia las claves solo los datos
-- Creamos trabajadoresRH con los datos que nos interesan de Recursos Humanos
-- Podemos añadir campos adicionales.

DROP TABLE if exists trabajadoresRH;
CREATE TABLE trabajadoresRH AS 
select t.dni, t.nombre, t.ciudad, t.salario, d.nombredep, "Planta2" as situacion
from trabajadores t, departamento d
where t.departamento=d.numdep and nombredep="Recursos Humanos";

desc trabajadoresRH;

Select * from trabajadoresRH;
show tables;

-- Ejemplo copiar en otra base de datos.
-- El mismo ejemplo anterior.
-- Creamos una base de datos nueva llamada empresabar
-- Una tabla trabajadores con los datos de los trabajadores de Barcelona.
-- Para indicar la tabla de otra base de datos seguimos el formato: basededatos.tabla

CREATE DATABASE backupempresa;
use backupempresa;
show tables;
DROP TABLE if exists trabajadores;

CREATE TABLE trabajadores AS SELECT t.dni, t.nombre, t.ciudad, 
t.salario, d.nombredep
from empresa.trabajadores t 
inner join empresa.departamento d
on t.departamento=d.numdep 
where t.ciudad="Barcelona";

select * from backupempresa.trabajadores;
SELECT * FROM empresa.trabajadores;

create table departamento like empresa.departamento;
select * from departamento;

insert into	departamento select * from empresa.departamento;
select * from empresa.departamento;
select * from departamento;





-- ejemplo REPLACE
use empresa;
select * from trabajadores;

replace into trabajadores values 
("11112222A","Rojo Iglesias, Marta", "Sevilla",8,40000,1);

UPDATE trabajadores set ciudad="Barcelona", antiguedad=10, 
salario=60000, departamento=3 where dni="11112222A";

UPDATE trabajadores set ciudad="Malaga" where dni="11112222A";

SELECT * FROM trabajadores;

select * from departamento;
replace into departamento values (9,"ASIR");
UPDATE departamento SET numdep=15 where numdep=7;

-- Ejemplo1 update

select * from departamento order by numdep;
update departamento set nombredep="Personal" where numdep=2;

-- Subimos un 10% el salario de los trabajadores del departamento 2 

SELECT * from trabajadores where departamento=2;
desc trabajadores;
-- UPDATE trabajadores SET salario=salario+(salario*0.10) where departamento=2;
-- las dos formas darian el mismo resultado, pero en esta se escribe un poco menos de codigo.
UPDATE trabajadores SET salario=salario*1.1 where departamento=2;

-- Ejemplo2 update
-- Añadimos un campo llamado dietas a la tabla trabajadores
-- Ponemos un 2% de su salario
-- A los trabajadores de madrid con una antiguedad superior a 6 años.

select * from trabajadores 
where ciudad="Madrid" and antiguedad>6;

desc trabajadores;

alter table trabajadores
add dietas decimal (8,2);

desc trabajadores;

UPDATE trabajadores SET dietas=salario*0.02 where ciudad="Madrid" and antiguedad>6;


-- Ejemplo update
-- Actualizamos el departamento de Perez Cano, Isabel
-- a recursos humanos
-- Lo seleccionamos con otra consulta
select * from trabajadores where nombre="Perez Cano, Isabel";


UPDATE trabajadores  SET departamento= (select numdep from departamento where nombredep="Personal" )
where nombre="Perez Cano, Isabel";

UPDATE empresa.trabajadores SET departamento = '3' WHERE dni='22334455C';


-- Ejemplo update
-- Actualizamos el salario del departamento de contabilidad un 5%
-- Lo seleccionamos con otra subconsulta

SELECT * from trabajadores where departamento=1;
UPDATE trabajadores SET salario=salario+(salario*0.05) 
where departamento In (Select numdep from departamento where nombredep="Contabilidad");