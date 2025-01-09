USE sakila;
SELECT column_name, column_type, column_key, extra 
FROM columns 
WHERE table_schema = 'sakila' AND table_name = 'actor';   -- permite ver los detalles de cada columna, con su tipo, si es clave primaria o tiene indices, y cualquier configuración adicional


SELECT Host, User
FROM mysql.user;   -- para ver host y users de la tabla user de mysql (la db)

SELECT * FROM sys.`x$memory_global_total`;  -- consultar la memoria total utilizada por el gestor

SELECT user, authentication_string, host FROM mysql.user;  -- Se determina qué usuarios tienen permiso para acceder al servidor.

SELECT user, host FROM mysql.user;  --  para consultar los usuarios creados en el sistema

DESC mysql.user;   -- para describir la tabla user 

SELECT user, select_priv, insert_priv, update_priv, delete_priv FROM mysql.user;  --  podemos comprobar que el usuario root y tienen permisos globales 

DESC mysql.db;

SELECT user, db, select_priv, insert_priv, update_priv, delete_priv FROM mysql.db;  -- podemos comprobar a modo de ejemplo que el usuario alumno tiene permisos de select y de insert en la base de datos sakila

SELECT * FROM mysql.tables_priv; -- Muestra los privilegios asignados a tablas específicas en las bases de datos


SELECT * FROM mysql.columns_priv;  -- Muestra los privilegios asignados a columnas específicas en las bases de datos

DESC mysql.procs_priv;

CREATE USER 'nombre_usuario'@'localhost' IDENTIFIED BY 'contraseña';  -- -- Crea un usuario con acceso local y una contraseña definida

-- ejemplos
CREATE USER 'user4'@'localhost'IDENTIFIED BY '12345678' PASSWORD EXPIRE;  -- Crea un usuario local con contraseña, pero obliga a cambiarla al primer inicio de sesión
CREATE USER 'user2'@'localhost' IDENTIFIED BY '12345678' PASSWORD EXPIRE INTERVAL 30 DAY;  -- Crea un usuario local con contraseña que debe cambiarse cada 30 días
CREATE USER 'user3'@'localhost' IDENTIFIED BY '12345678' ACCOUNT LOCK;  -- Crea un usuario local con contraseña, pero su cuenta está bloqueada al inicio

CREATE USER 'user1'@'localhost' IDENTIFIED BY '12345678' 
WITH MAX_QUERIES_PER_HOUR 100 MAX_USER_CONNECTIONS 10;  -- Crea un usuario local con contraseña, limitado a 100 consultas por hora y 10 conexiones simultáneas

-- Mysql -u user1 -p   -- este comando se usa solo si lo hacemos por consola

ALTER USER IF EXISTS 'user1'@'localhost' ACCOUNT LOCK;  -- Bloquea la cuenta del usuario 'user1' si existe

ALTER USER 'nombre_usuario'@'localhost' IDENTIFIED BY 'nueva_contraseña';  -- Para modificar la contraseña de un usuario

RENAME USER 'user1'@'localhost' TO 'usuario1'@'localhost';  -- Para modificar el nombre de un usuario debemos utilizar la instrucción RENAME USER indicando el nombre antiguo y el nombre nuevo.  -- Cambia el nombre del usuario 'user1' a 'usuario1' en 'localhost'

DROP USER 'nombre_usuario'@'localhost';  -- Para borrar a un determinado usuario se utiliza la orden DROP USER. Elimina el usuario 'nombre_usuario' en 'localhost' de la base de datos

GRANT permiso ON nombreBaseDatos . nombredetabla TO usuario;  -- Otorga el permiso especificado en 'nombredetabla' de 'nombreBaseDatos' al usuario. Aqui pone permiso prq es el ejemplo pero habria que poner lo que quieras (select, insert...)

-- Debemos tener en cuenta respecto al ON:
-- *.* Hace referencia a todas las bases de datos y tablas del sistema.
-- Basedatos.* Hace referencia a todas las tablas de la base de datos indicada.
-- Basedatos.tabla solo hace referencia a la tabla de la base de datos.


-- Los permisos son globales cuando indicamos en el parámetro ON *.* Por ejemplo en la primera instrucción damos todos los permisos al usuario USER1, en la segunda damos solo el permiso de SELECT sobre todas las bases de datos de MySQL al usuario user2.
GRANT ALL ON *.* TO 'user1'@'localhost'; -- Otorga todos los permisos sobre todas las bases de datos y tablas a 'user1' en 'localhost'
GRANT SELECT ON *.* TO 'user2'@'localhost'; -- Otorga solo el permiso de lectura (SELECT) sobre todas las bases de datos y tablas a 'user2' en 'localhost'


-- Para otorgar permisos a nivel de base de datos hemos de especificar el nombre de ésta en la cláusula ON del GRANT. Por ejemplo para que el usuario user3 pueda hacer un INSERT y un SELECT en todas las tablas de la base de datos Sakila utilizamos la siguiente instrucción.
GRANT SELECT, INSERT ON sakila.* TO 'user3'@'localhost'; -- Otorga los permisos de lectura (SELECT) y escritura (INSERT) sobre todas las tablas de la base de datos 'sakila' al usuario 'user3' en 'localhost'


-- Para otorgar permisos a nivel de tabla o de columna, debemos indicar en el parámetro ON el nombre de la base de datos y de la tabla sobre la que afecta el permiso. Si solo se aplica sobre una columna deberemos indicar el nombre de la columna.
GRANT SELECT ON sakila.film TO 'user1'@'localhost'; -- Otorga el permiso de lectura (SELECT) sobre la tabla 'film' de la base de datos 'sakila' al usuario 'user1' en 'localhost'
GRANT SELECT (title, description) ON sakila.film TO 'user2'@'localhost'; -- Otorga el permiso de lectura (SELECT) solo sobre las columnas 'title' y 'description' de la tabla 'film' en la base de datos 'sakila' al usuario 'user2' en 'localhost'

-- Para ver los privilegios que tiene un determinado usuario puede utilizar la instrucción SHOW GRANTS:
SHOW GRANTS;  -- en Mysql workbench se se hace solo poniendo show grants; , si fuera en consola seria con el mysql> delante.

-- La instrucción para quitar permisos a un determinado usuario es la instrucción REVOKE
REVOKE permiso ON nombreBaseDatos.nombredetabla FROM usuario; -- Revoca un permiso específico sobre una tabla de una base de datos para el usuario indicado


-- Debemos tener en cuenta respecto al ON:
-- *.* Hace referencia a todas las bases de datos y tablas del sistema.
-- Basedatos.* Hace referencia a todas las tablas de la base de datos indicada.
-- Basedatos.tabla solo hace referencia a la tabla de la base de datos.

-- Los permisos que se pueden quitar son los mismos que se utilizan con la orden GRANT. Pero para poder quitar un permiso debemos tener en cuenta:
-- -Debemos poseer ese permiso.
-- -Lo hemos obtenido con la opción “with grant option”.
-- -El usuario tiene el permiso CREATE USER.

REVOKE DELETE ON sakila.film FROM 'user1'@'localhost'; -- Revoca el permiso de eliminar (DELETE) sobre la tabla 'film' de la base de datos 'sakila' para el usuario 'user1' en 'localhost'

REVOKE SELECT (description) ON sakila.film FROM 'user2'@'localhost'; 
-- Revoca el permiso de lectura (SELECT) sobre la columna 'description' de la tabla 'film' en la base de datos 'sakila' para el usuario 'user2' en 'localhost'

REVOKE ALL ON *.* FROM 'user3'@'localhost'; -- Revoca todos los permisos sobre todas las bases de datos y tablas para el usuario 'user3' en 'localhost'  MIRAR MAÑANA

-- Esto es para revocar el permisos
REVOKE INSERT ON base_datos.* FROM 'nombre_usuario'@'localhost'; -- Revoca el permiso de insertar (INSERT) en todas las tablas de la base de datos 'base_datos' para el usuario 'nombre_usuario' en 'localhost'


-- Si otorgamos permisos a usuarios utilizando la opción WITH GRANT OPTION,
-- habilitamos a ese usuario para que pueda otorgar ese mismo permiso a otros usuarios
GRANT SELECT, INSERT ON sakila.* TO 'user1'@'localhost' WITH GRANT OPTION; -- Otorga permisos de lectura (SELECT) y escritura (INSERT) sobre todas las tablas de la base de datos 'sakila' a 'user1' en 'localhost', permitiéndole conceder estos permisos a otros usuarios


-- Visualizar Permisos:
SHOW GRANTS FOR 'nombre_usuario'@'localhost'; -- Muestra todos los permisos asignados al usuario 'nombre_usuario' en 'localhost'


-- Estas dos siguientes es para crear un rol, se puede hacer de las siguientes maneras:
CREATE ROLE IF NOT EXISTS 'nombre_rol'; -- Crea un rol con el nombre especificado, opcionalmente verificando si ya existe
CREATE ROLE 'nombre_rol'; -- Crea un rol con el nombre especificado

-- Para asignar y retirar privilegios a los roles utilizamos la misma orden GRANT vista anteriormente. A los roles se les asignan privilegios igual que a los usuarios. Para eliminar los privilegios de un rol utilizamos REVOKE.

GRANT SELECT ON sakila.* TO 'nombre_rol'; -- Otorga permiso de lectura (SELECT) sobre todas las tablas de la base de datos 'sakila' al rol 'nombre_rol'
GRANT INSERT ON sakila.film TO 'nombre_rol'; -- Otorga permiso de inserción (INSERT) en la tabla 'film' de la base de datos 'sakila' al rol 'nombre_rol'
GRANT UPDATE, DELETE ON sakila.actor TO 'nombre_rol'; -- Otorga permisos de actualización (UPDATE) y eliminación (DELETE) en la tabla 'actor' de la base de datos 'sakila' al rol 'nombre_rol'


-- El siguiente paso es asignar el rol a los usuarios con la instrucción GRANT, en el ejemplo anterior.
GRANT nombre_rol TO 'user1'@'localhost', 'user2'@'localhost'; -- Asigna el rol 'nombre_rol' a los usuarios 'user1' y 'user2' en 'localhost'


-- Un usuario puede tener diferentes roles asignados. En el último paso seleccionamos cual es el rol por defecto que va a utilitzar con la instrucción SET DEFAULT ROLE.
SET DEFAULT ROLE nombre_rol TO 'user1'@'localhost', 'user2'@'localhost'; -- Establece 'nombre_rol' como el rol predeterminado para los usuarios 'user1' y 'user2' en 'localhost'

SELECT user, authentication_string, host FROM mysql.user;