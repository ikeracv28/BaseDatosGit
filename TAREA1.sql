-- Cambiar el contexto al contenedor raíz de la base de datos (CDB)
ALTER SESSION SET CONTAINER = CDB$ROOT;

-- Verificar si la base de datos está configurada como multitenant
SELECT name, cdb FROM v$database;

-- Consultar la lista de bases de datos pluggables (PDBs) disponibles en el sistema
SELECT PDB_ID, PDB_NAME, STATUS FROM DBA_PDBS;

-- Crear una nueva base de datos pluggable llamada pdb_estudiantes con un usuario administrador
CREATE PLUGGABLE DATABASE pdb_estudiantes 
ADMIN USER admin_alumnos IDENTIFIED BY admin123
STORAGE UNLIMITED
FILE_NAME_CONVERT = ('/opt/oracle/oradata/XE/pdbseed/', '/opt/oracle/oradata/XE/pdb_estudiantes/');

-- Mostrar las PDBs después de la creación
SHOW PDBS;

-- Abrir la nueva base de datos pluggable para que pueda ser utilizada
ALTER PLUGGABLE DATABASE pdb_estudiantes OPEN;

-- Verificar el estado de la PDB recién creada
SELECT PDB_ID, PDB_NAME, STATUS FROM DBA_PDBS WHERE PDB_NAME = 'PDB_ESTUDIANTES';

-- Cambiar la sesión para trabajar dentro de la nueva PDB
ALTER SESSION SET CONTAINER = pdb_estudiantes;

-- Crear una tabla llamada "alumnos" dentro de la PDB
CREATE TABLE alumnos (
    id NUMBER PRIMARY KEY,
    nombre VARCHAR2(50),
    edad NUMBER
);

-- Insertar registros en la tabla "alumnos"
INSERT INTO alumnos VALUES (1,'sergio',24);
INSERT INTO alumnos VALUES (2,'manolo',23);
INSERT INTO alumnos VALUES (3,'pepito',13);

-- Guardar los cambios realizados en la tabla
COMMIT;

-- Consultar los datos ingresados en la tabla alumnos
SELECT * FROM alumnos;

-- Regresar al contenedor raíz (CDB)
ALTER SESSION SET CONTAINER = CDB$ROOT;

-- Cerrar la PDB antes de proceder con su clonación
ALTER PLUGGABLE DATABASE pdb_estudiantes CLOSE IMMEDIATE;

-- Clonar la PDB para crear una nueva con el nombre pdb_estudiantes_copia
CREATE PLUGGABLE DATABASE pdb_estudiantes_copia FROM pdb_estudiantes
FILE_NAME_CONVERT = ('/opt/oracle/oradata/FREE/pdbseed/', '/opt/oracle/oradata/FREE/pdb_estudiantes/');

-- Mostrar la lista de PDBs para verificar que la clonación se realizó correctamente
SHOW PDBS;

-- Abrir tanto la PDB original como su clon
ALTER PLUGGABLE DATABASE pdb_estudiantes OPEN;
ALTER PLUGGABLE DATABASE pdb_estudiantes_copia OPEN;

-- Confirmar que la clonación fue exitosa consultando las PDBs
SELECT PDB_ID, PDB_NAME, STATUS FROM DBA_PDBS;

-- Cambiar la sesión para trabajar dentro de la PDB clonada
ALTER SESSION SET CONTAINER = pdb_estudiantes_copia;

-- Verificar que los datos de la tabla "alumnos" están en la PDB clonada
SELECT * FROM ALUMNOS;

-- Regresar al contenedor raíz y listar nuevamente las PDBs
ALTER SESSION SET CONTAINER = CDB$ROOT;
SELECT PDB_ID, PDB_NAME, STATUS FROM DBA_PDBS;

-- Cerrar todas las sesiones activas en la PDB antes de eliminarla
BEGIN
    FOR ses IN (SELECT sid, serial# FROM v$session 
    WHERE con_id = (SELECT con_id FROM v$pdbs WHERE name = 'PDB_ESTUDIANTES'))
    LOOP
        EXECUTE IMMEDIATE 'ALTER SYSTEM KILL SESSION ''' || ses.sid || ',' || ses.serial# || ''' IMMEDIATE';
    END LOOP;
END;

-- Cerrar las PDBs antes de proceder a eliminarlas
ALTER PLUGGABLE DATABASE pdb_estudiantes CLOSE IMMEDIATE;
ALTER PLUGGABLE DATABASE pdb_estudiantes_copia CLOSE IMMEDIATE;

-- Confirmar que ambas PDBs están en estado MOUNTED antes de eliminarlas
SELECT PDB_NAME, STATUS FROM DBA_PDBS WHERE PDB_NAME IN ('PDB_ESTUDIANTES', 'PDB_ESTUDIANTES_COPIA');

-- Eliminar ambas PDBs incluyendo sus archivos de datos
DROP PLUGGABLE DATABASE pdb_estudiantes INCLUDING DATAFILES;
DROP PLUGGABLE DATABASE pdb_estudiantes_copia INCLUDING DATAFILES;

-- Verificar que las PDBs han sido eliminadas correctamente
SHOW PDBS;
