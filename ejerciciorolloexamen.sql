drop database if exists torneo;

create database if not exists torneo;

use torneo;

create table torneos(
nombre_t varchar(50) primary key,
fecha_inicio date not null,
premio decimal(8,2) not null);


create table equipos(
nombre_e varchar(50) primary key,
puntos decimal(8,2) not null,
fecha_creacion date not null,
descripcion text);

create table t_e(
nombre_t varchar(50) not null,
nombre_e varchar(50) not null,
foreign key (nombre_t) references torneos(nombre_t),
foreign key (nombre_e) references equipos(nombre_e));



create table jugadores(
apodo varchar(50) primary key,
nombre_j varchar(50),
apellido varchar(50),
pais varchar(30) not null,
edad int,
nombre_e varchar(50) not null,
foreign key (nombre_e) references equipos(nombre_e));

INSERT INTO torneos (nombre_t, fecha_inicio, premio) VALUES
('Torneo Apertura', '2024-01-10', 10000.00),
('Torneo Clausura', '2024-06-15', 15000.00),
('Copa Nacional', '2024-09-20', 20000.00),
('Superliga', '2023-03-05', 25000.00),
('Liga de Campeones', '2024-10-10', 30000.00);


INSERT INTO equipos (nombre_e, puntos, fecha_creacion, descripcion) VALUES
('Equipo Águilas', 45.5, '2020-03-01', 'Equipo con gran trayectoria.'),
('Equipo Toros', 37.0, '2018-07-15', 'Equipo revelación del torneo.'),
('Equipo Leones', 50.0, '2015-09-10', 'Máximos campeones en los últimos años.'),
('Equipo Tigres', 42.0, '2019-05-12', 'Consolidándose como favoritos.'),
('Equipo Halcones', 38.5, '2021-02-20', 'Rápido ascenso en el ranking.'),
('Equipo Delfines', 25.0, '2022-01-18', 'Debut en torneos mayores.'),
('Equipo Cóndores', 32.0, '2020-11-23', 'Equipo competitivo en defensa.'),
('Equipo Lobos', 40.0, '2023-03-03', 'Jugadores destacados en ataque.'),
('Equipo Zorros', 28.0, '2017-09-15', 'Equipo con tácticas sorpresivas.'),
('Equipo Serpientes', 35.0, '2016-12-10', 'Respetados por su juego físico.');


INSERT INTO t_e (nombre_t, nombre_e) VALUES
('Torneo Apertura', 'Equipo Águilas'),
('Torneo Apertura', 'Equipo Toros'),
('Torneo Apertura', 'Equipo Leones'),
('Torneo Clausura', 'Equipo Tigres'),
('Torneo Clausura', 'Equipo Halcones'),
('Copa Nacional', 'Equipo Delfines'),
('Copa Nacional', 'Equipo Lobos'),
('Superliga', 'Equipo Zorros'),
('Superliga', 'Equipo Serpientes'),
('Liga de Campeones', 'Equipo Águilas'),
('Liga de Campeones', 'Equipo Cóndores');


INSERT INTO jugadores (apodo, nombre_j, apellido, pais, edad, nombre_e) VALUES
-- Equipo Águilas
('El Capitán', 'Carlos', 'Gómez', 'Argentina', 29, 'Equipo Águilas'),
('La Bala', 'Luis', 'Martínez', 'México', 25, 'Equipo Águilas'),
('El Águila', 'Fernando', null, 'Colombia', 23, 'Equipo Águilas'),
('Cañón', 'Sergio', 'Ríos', 'Chile', null, 'Equipo Águilas'),

-- Equipo Toros
('Destructor', 'Juan', 'Pérez', 'España', null, 'Equipo Toros'),
('Fuerza', 'Héctor', 'Vega', 'Ecuador', 29, 'Equipo Toros'),
('Coloso', 'Ricardo', 'Silva', 'Uruguay', 24, 'Equipo Toros'),

-- Equipo Leones
('Mago', 'Andrés', null, 'Brasil', 27, 'Equipo Leones'),
('Muralla', 'Pedro', 'Sánchez', 'Chile', 28, 'Equipo Leones'),
('Rayo', 'Jorge', 'Mendoza', 'Argentina', 26, 'Equipo Leones'),

-- Equipo Tigres
('Tigre', 'Martín', null, 'Uruguay', 24, 'Equipo Tigres'),
('Veloz', 'Diego', 'Ramírez', 'Perú', 26, 'Equipo Tigres'),
('Centinela', 'Manuel', 'Ortiz', 'México', 25, 'Equipo Tigres'),

-- Equipo Halcones
('Águila', 'Felipe', 'García', 'Colombia', 23, 'Equipo Halcones'),
('Portero', 'Rodrigo', 'Martínez', 'España', 32, 'Equipo Halcones'),
('Defensa', 'Mario', 'Pérez', 'Chile', null, 'Equipo Halcones'),

-- Equipo Delfines
('Goleador', 'David', 'Ramírez', 'Perú', 26, 'Equipo Delfines'),
('Velocista', 'Luis', null, 'Venezuela', 22, 'Equipo Delfines'),
('Arquero', 'Alberto', 'Reyes', 'Argentina', 30, 'Equipo Delfines'),

-- Equipo Cóndores
('Cóndor', 'Javier', 'Muñoz', 'Paraguay', 31, 'Equipo Cóndores'),
('Puntero', 'Oscar', 'Hernández', 'México', 28, 'Equipo Cóndores'),
('Tanque', null, 'López', 'Chile', 27, 'Equipo Cóndores'),

-- Equipo Lobos
('Lobo', 'Hernán', 'Salazar', 'Argentina', 24, 'Equipo Lobos'),
('Garra', 'Eduardo', 'Morales', 'Ecuador', null, 'Equipo Lobos'),
('Defensor', 'Tomás', 'Campos', 'Colombia', 26, 'Equipo Lobos'),

-- Equipo Zorros
('Estratega', 'Gabriel', 'Fernández', 'Paraguay', 31, 'Equipo Zorros'),
('Zorro', 'Pablo', 'Suárez', 'México', 27, 'Equipo Zorros'),
('Táctico', null, 'Romero', 'Uruguay', 28, 'Equipo Zorros'),

-- Equipo Serpientes
('Serpiente', 'Diego', 'Castro', 'Brasil', 24, 'Equipo Serpientes'),
('Rápido', 'Adrián', 'Cáceres', 'Ecuador', null, 'Equipo Serpientes'),
('Agil', 'Carlos', 'Mejía', 'Venezuela', 25, 'Equipo Serpientes');


-- Suma 3 puntos a uno de los equipos que participa en un torneo.
update equipos set puntos = puntos + 3 where nombre_e = 'Equipo Leones';
select nombre_e, puntos from equipos;

-- Obtén listado de jugadores incluyendo el equipo al que está unido cada uno.
select nombre_j, apodo, apellido, pais, edad, equipos.nombre_e from jugadores
inner join equipos on jugadores.nombre_e = equipos.nombre_e;  

-- Obtén listado de equipos con más de 3 jugadores.
select equipos.nombre_e, count(jugadores.apodo) as total_jugadores
from equipos inner join jugadores on equipos.nombre_e = jugadores.nombre_e
group by equipos.nombre_e having count(jugadores.apodo) > 3;

-- Obtén los torneos en los que participó un equipo específico.
select nombre_t, nombre_e from t_e where nombre_e = 'Equipo Delfines';

-- Obtén los 3 equipos con más puntos acumulados en los torneos.
select nombre_e, puntos as equiposconmaspuntos from equipos order by puntos desc limit 3;









