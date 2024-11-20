drop database if exists Escuela;
-- creamos la bsae de datos que nos piden
create database if not exists Escuela;

/* 
Con esto seleccionamos las base
de datos con la que queremos trabajar
*/
use Escuela;

-- Ahora creamos la tabla alumno
create table Alumno(
	NIF varchar(10) primary key not null,
	Nombre varchar(30) not null,
    Trabaja boolean,
    Estudios  set ('Eso', 'Bachillerato', 'FP Medio', 'FP Superior', 'Grado Universitario'),
    Ingresos decimal(18,2),
    Fecha_de_nacimiento date
);

-- Ahora hacemos insert into de 4 alumnos
insert into Alumno (NIF, Nombre, Trabaja, Estudios, Ingresos, Fecha_de_nacimiento)
values
('49997738Q', 'Iker', true, 'FP Superior', '4000', '2003-06-28'),
('47814475T', 'Giancarlo', false, 'Eso', '0', '1998-11-11'),
('48872455R', 'Carletto', false, 'Bachillerato', '1000', '1998-10-23'),
('49876543G', 'Pablo', true, 'Bachillerato', '6000', '2002-05-21');



select * from Alumno; -- selecciona de la tabla alumno
select Distinct Estudios from Alumno; -- seleccionamos los estudios de los alumnos pero el d Distinct hace que no se muestren 2 veces los repetidos
select concat(Nombre, ' - ' , Estudios) as info_Alumno from Alumno;
select substring(Estudios, 1, 3) As parte_Estudios From Alumno; -- me muestra solo la 2 y 3 letra del nombre
select * from Alumno order by Nombre asc; -- ordenar por orden ascendente los nombres
select nombre from Alumno where Ingresos = (select max(Ingresos) from Alumno); -- me muestra el que mas cobra de los alumnos
select nombre from Alumno where in 
select nombre from Alumno c where exists ( select 1 from nombre n where c.Alumno = ) -- para concatenar tablas que tengan un mismo valor




    
	

