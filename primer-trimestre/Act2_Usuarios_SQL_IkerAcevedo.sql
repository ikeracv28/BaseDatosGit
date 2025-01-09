
USE escuela; -- Entramos a la base de datos llamada 'escuela'.

-- 1.1 Creamos un usuario llamado 'estudiante' con la contraseña 'estudiante123'.
-- Este usuario tiene un límite de 100 consultas por hora y puede hacer hasta 50 conexiones al mismo tiempo.
CREATE USER 'estudiante' IDENTIFIED BY 'estudiante123'
WITH MAX_QUERIES_PER_HOUR 100 MAX_USER_CONNECTIONS 50;

-- 1.2 Le damos permisos a 'estudiante' para consultar datos (SELECT) y añadir nuevos datos (INSERT) en cualquier base de datos y tabla.
GRANT SELECT, INSERT ON *.* TO 'estudiante';

-- 1.3 Creamos otro usuario, 'alumno', con contraseña 'alumno123'.
-- A este usuario le permitimos consultar datos (SELECT) y modificar datos (UPDATE) solo en la base de datos 'escuela'.
CREATE USER 'alumno' IDENTIFIED BY 'alumno123';
GRANT SELECT, UPDATE ON escuela.* TO 'alumno';

-- 1.4 Cambiamos el nombre del usuario 'estudiante' a 'usuario_estudiante'.
-- Después, eliminamos al usuario 'alumno' porque ya no lo necesitamos.
RENAME USER 'estudiante' TO 'usuario_estudiante';
DROP USER 'alumno';

-- 2.1 Creamos otro usuario llamado 'profesor' con contraseña 'profesor123'.
-- Le damos permisos para consultar, añadir y actualizar datos, pero solo en la tabla 'alumno' de la base de datos 'escuela'.
CREATE USER 'profesor' IDENTIFIED BY 'profesor123';
GRANT SELECT, INSERT, UPDATE ON escuela.alumno TO 'profesor';

-- 2.2 También le damos permisos específicos al usuario 'profesor' para actualizar la columna 'nombre' en la tabla 'alumno'.
GRANT UPDATE (nombre) ON escuela.alumno TO 'profesor';

-- 2.3 Quitamos el permiso de actualizar la columna 'nombre' al usuario 'profesor'.
REVOKE UPDATE (nombre) ON escuela.alumno FROM 'profesor';

-- Aquí mostramos los permisos que tiene actualmente el usuario 'profesor'.
SHOW GRANTS FOR 'profesor';

-- 3.1 Creamos dos roles (grupos de permisos):
-- El rol 'consulta_total' da permisos para consultar cualquier tabla de la base de datos 'escuela'.
CREATE ROLE 'consulta_total';
GRANT SELECT ON escuela.* TO 'consulta_total';

-- El rol 'gestor_datos' da permisos para añadir, actualizar y borrar datos en la tabla 'alumno'.
CREATE ROLE 'gestor_datos';
GRANT INSERT, UPDATE, DELETE ON escuela.alumno TO 'gestor_datos';

-- 3.2 Asignamos roles:
-- Le damos el rol 'consulta_total' al usuario 'usuario_estudiante'.
-- Le damos el rol 'gestor_datos' al usuario 'profesor'.
GRANT consulta_total TO 'usuario_estudiante';
GRANT gestor_datos TO 'profesor';

-- 3.3 Hacemos que el rol 'consulta_total' sea el rol principal o predeterminado para el usuario 'usuario_estudiante'.
SET DEFAULT ROLE consulta_total TO 'usuario_estudiante';

-- 4.1 Creamos un usuario llamado 'invitado' sin contraseña.
-- Le damos permisos para consultar y añadir datos en cualquier tabla de la base de datos 'escuela'.
CREATE USER 'invitado';
GRANT SELECT ON escuela.* TO 'invitado';
GRANT INSERT ON escuela.* TO 'invitado';

-- Mostramos los permisos que tiene actualmente el usuario 'invitado'.
SHOW GRANTS FOR 'invitado';

-- 4.2 Creamos un usuario llamado 'supervisor' con contraseña '12345678'.
-- Le ponemos un límite de 200 consultas por hora y un máximo de 10 conexiones a la vez.
-- Además, configuramos que su contraseña caduque para que la tenga que cambiar.
CREATE USER 'supervisor' IDENTIFIED BY '12345678' 
WITH MAX_QUERIES_PER_HOUR 200 MAX_USER_CONNECTIONS 10 PASSWORD EXPIRE;

-- 5.1 Mostramos los permisos asignados al usuario 'root' (administrador principal) en el host 'localhost'.
SHOW GRANTS FOR 'root'@'localhost';

-- 5.2 Revisamos información de los permisos que tienen los usuarios en las tablas internas de MySQL:
-- Tabla 'mysql.user': muestra los permisos generales que tiene cada usuario.
SELECT user, select_priv, insert_priv, update_priv, delete_priv, drop_priv, create_priv FROM mysql.user;

-- Tabla 'mysql.db': muestra los permisos asignados por cada base de datos.
SELECT user, select_priv, insert_priv, update_priv, delete_priv, drop_priv, create_priv FROM mysql.db;

-- Tabla 'mysql.tables_priv': muestra los permisos específicos por tabla.
SELECT User, Host, Db, Table_name, Table_priv, Column_priv FROM mysql.tables_priv;

-- Tabla 'mysql.columns_priv': muestra los permisos específicos por columna.
SELECT User, Host, Db, Table_name, column_name, Column_priv FROM mysql.columns_priv;
