drop database if exists tema_5;
create database tema_5;

use tema_5;

create table tabla_1(
DNI varchar(9) primary key,
nombre varchar(50) not null
) engine = InnoDB;    #Para seleccionar el motor es despues del parantesis y antes del ; se pone engine = y el motor que queramos

/*
#Hay que ponerle comillas al nombre para que no de error
show table status like 'tabla_1'; 

#Esto es para cambiar el motor a la tabla, despues volvemos a hacer show table para comprobarlo
alter table tabla_1 
engine = InnoDB;

#Esto es para cambiar el motor otra vez a MyISAM
alter table tabla_1 
engine = MyISAM;
*/

create table tabla_2(
ID_tabla int primary key auto_increment,
FK_tabla2 varchar(9)) engine = InnoDB;

#AQUI LE METEMOS FOREING KEY A LA TABLA 2 Y NO DARA ERROR PRQ ESTAMOS CON EL MOTOR InnoDB, al hacerlo con MyISAM dara error y no creara la FK
alter table tabla_2
add constraint FK_tabla1y2 foreign key (fk_tabla2) references tabla_1 (DNI);

#Hay que ponerle comillas al nombre para que no de error y el show table es para que muestre la tabla
show table status like 'tabla_2';

#Desc es para que te describa la tabla y pones el nombre de la tabla que quieras
desc tabla_2;

#Resumen: si usamos el motor MyISAM al añadir la FK deberia dar error y con el motor InnoDB si que nos deberia de crear la FK


