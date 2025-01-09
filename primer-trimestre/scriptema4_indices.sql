drop database if exists actividad_iad;
create database actividad_iad;

use actividad_iad;

create table empleado_iad(
DNI varchar(9) primary key, 
nombre varchar(50) not null,
apellido varchar(50) not null,
antigÜedad int
);


#aqui creemos los indices de los campos de la tabla ya creada
create index idx_nombre_empleado_iad on empleado_iad (nombre);
create index idx_apellido_empleado_iad on empleado_iad (apellido);
 
insert into empleado_iad (DNI, nombre, apellido, antigÜedad) 
values
('49997738Q', 'iker', 'acevedo', 4),
('11223344S', 'rafa', 'medina', 2),
('12345678A', 'alejandro', 'gomez', 5),
('87654321B', 'marcos', 'lopez', 3),
('23456789C', 'iris', 'martinez', 7),
('98765432D', 'sergio', 'fernandez', 1),
('34567890E', 'jesus', 'ruiz', 4),
('45678901F', 'amanda', 'torres', 6),
('56789012G', 'ian', 'vazquez', 2),
('67890123H', 'richi', 'perez', 8);

select * from empleado_iad;

#para verificar cómo MySQL utilizará los índices creados
EXPLAIN SELECT * FROM empleado_iad WHERE nombre = 'alejandro';
EXPLAIN SELECT * FROM empleado_iad WHERE apellido = 'lopez';

select * from empleado_iad where DNI = '49997738Q';

#esta consulta sirve para ver los indices que tenemos de la tabla empleado_iad en este caso
show index from empleado_iad;

#con drop index on eliminaremos el indice que elijamos de la tabla que pongamos
drop index idx_nombre_empleado_iad on empleado_iad;
drop index idx_apellido_empleado_iad on empleado_iad;

#Ahora hacemos la misma consulta que antes paero ahora sin que sean indices
EXPLAIN SELECT * FROM empleado_iad WHERE nombre = 'alejandro';
EXPLAIN SELECT * FROM empleado_iad WHERE apellido = 'lopez';

#El ANALYZE TABLE recopila estadisticas sobre la distibucion de datos en los índices
ANALYZE TABLE empleado_iad;

#El OPTIMIZE TABLE reorganiza la tabla y sus índices
OPTIMIZE TABLE empleado_iad;

#Con esto lo habilitamos en toda la base de datos y mide el tiempo de ejecución de las consultas
SET PROFILING = 1;

EXPLAIN SELECT * FROM empleado_iad WHERE nombre = 'iker' and apellido = 'acevedo';

#con este comando ves el tiempo de ejecucuion de las consultas
SHOW PROFILES;

#se utiliza para verificar la integridad de una tabla y asegurarse de que no haya problemas con sus índices o datos.
#Este comando revisará la tabla empleado_iad y mostrará cualquier error
CHECK TABLE empleado_iad;





