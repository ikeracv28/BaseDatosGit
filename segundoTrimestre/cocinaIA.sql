drop database if exists cocina;
create database cocina;
use cocina;

create table recetas(
    id_receta int auto_increment primary KEY,
    nombre varchar(255),
    ingredientes text,
    preparacion text
);

select * from recetas;