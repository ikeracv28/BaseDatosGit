show con_name;   // para saber en qué contenedor estas



show pdbs;   //  para que muestre las pdbs que hay creadas

alter session set container = xepdb1;  // para cambiar a la pdb que le estamos diciendo

// con este comando se crea la tablespace (la bd)
create tablespace pruebas
datafile 'C:\oracle\pruebas.dbf' size 100M
autoextend on next 10m maxsize unlimited;


// para comprobar si se ha creado bien la tablespace
select tablespace_name, status, contents, extent_management
from dba_tablespaces
where tablespace_name = 'PRUEBAS';



// Este comando sirve para ver la ruta y tamaño del archivo 
select tablespace_name, file_name, bytes/1024/1024 as size_mb, autoextensible
from dba_data_files 
where tablespace_name = 'PRUEBAS';


// crear un tablespace temporal llamado "temp_pruebas"
create temporary tablespace temp_pruebas 
tempfile 'C:\oracle\temp_pruebas.dfb' size 50M;


// crear un tablespace temporal llamado "temp_pruebas"
create undo tablespace undotbs
datafile 'C:\oracle\undotbs.dfb' size 100M;

// Consultar informacion sobre los tablespaces creados
select tablespace_name, status, contents
from dba_tablespaces;


// añadir un segundo archivo de datos al tablespace "pruebas"
alter tablespace pruebas
add datafile 'C:\oracle\pruebas2.dbf' size 50M;

// redimensionar el primer archivo de datos del tablespace "pruebas"
alter database datafile 'C:\oracle\pruebas.dbf' resize 150M;

// poner el tablespace "pruebas" en modo offline (inhabilitar temporalmente)
alter tablespace pruebas offline;

// volver a poner tablespace "pruebas" online
alter tablespace pruebas online;


// para eliminar la tablespace
drop tablespace pruebas including contents and datafiles;

-- Creacion de usuarios y asignacion de tablespace

// crear un usuario "usuario1" con tablespace predeterminado "pruebas"
create user usuario1 identified by "user"
default tablespace pruebas
quota unlimited on pruebas;

// Crear un segundo usuario "usuario2" con límite de espacio y cuenta bloqueada
create user usuario2 identified by "user2"
default tablespace pruebas 
quota 15M on pruebas 
account lock;

// crear un tercer usuario "usuario3" con tablespace temporal "temp_pruebas"
create user usuario3 identified by "user3"
default tablespace pruebas 
temporary tablespace temp_pruebas;

// otorgar permisos básicos a los usuarios
grant create session to usuario1, usuario2, usuario3;

//permiso de creaer tabla y vistas
grant create table, create view to usuario1;

//puede crear cualquier procedimiento y ejecutarlo
grant create procedure, execute any procedure to usuario2;

// puede crear tablas y insertar datos en cualquier tabla
grant create table, insert any table to usuario3;

// consultar los usuarios creados y sus detalles
select username, default_tablespace, account_status
from dba_users;

-- Creacion de roles y asignacion de privilegios

// crear un rol llamado "rolprofesor"
create role rolprofesor;


// asignar privilegios al rol "rolprofesor", ahora da error porque no tengo la tabla alumnos creada
grant create session to rolprofesor;
grant select, insert, update on alumnos to rolprofesor;


// asignar el rol "rolprofesor" a los usuarios "profe1" y "profe2" que creamos ahora
create user profe1 identified by "p1234";
create user profe2 identified by "p1234";
grant rolprofesor to profe1, profe2;


// asignar el rol DBA al usuario "administrador"
create user administrador identified by "admin1234";
grant DBA to administrador;


// crear una tabla de alumnos en el tablespace "pruebas"
create table usuario1.alumnos (
    alumno_id number primary key,
    nombre varchar2(100) not null,
    apellidos varchar2(150), 
    fecha_nacimiento date,
    genero char(1),
    curos varchar2(100)
) tablespace pruebas;


-- Consultas de tablespace, usuarios y datos

//consultar el estado de los tablespace
select tablespace_name, status, contents, extent_management, bytes
from dba_tablespaces;

//consultar el espacio libre en cada tablespace
select tablespace_name, sum(bytes)/1024/1024 as free_space_mb
from dba_free_space
group by tablespace_name;

// consultar los privilegios de sustema otrogados a usuarios
select * from dba_sys_privs
where grantee in ('USUARIO1', 'USUARIO2', 'USUARIO3');

//consultar los privilegios sobre tablas y objetos
select * from dba_tab_privs
where grantee in ('USUARIO1', 'USUARIO2', 'USUARIO3');

// consultar informacion sobre las sesiopnes activas en la base de datos
select sid, serial#, username, status 
from v$session
where username is not null;

// revocar el permios de crear tablas al usuario2
revoke create table from usuario2;

// otrogar permiso de actualizacion en todas las tablas al usuario
grant update any table to usuario2;

// revocar permisos de actualizacion solo en la tabla alumnos
revoke update on usuario1.alumnos from usuario2;

// consultar los privilegios de objetos aisgnados a un usuario
select * from dba_tab_privs 
where grantee = 'USUARIO2';


-- ELiminacion de tablas usuarios y tablespace

//eliminar la tabla "profesores creada por el usuario1"
drop table usuario1.alumnos;

-- Eliminar los usuarios "usuario1" y "usuario2"
drop user usuario1 cascade;
drop user usuario2 cascade;

// borrar el tablespace incluido su contenido y archivos
drop tablespace pruebas including contents and datafiles;


-- creacion de perfiles

// crear un perfil llamado perfil2 con restricciones especificas
create profile perfil2 limit
    sessions_per_user 3 
    connect_time 15
    password_life_time 45
    failed_login_attempts 5;
    
// asignar el perfil al usuario3
alter user usuario3 profile perfil2;

// consultar los limites del perfil perfil2
select resource_name, limit
from dba_profiles
where profile = 'PERFIL2';



    


