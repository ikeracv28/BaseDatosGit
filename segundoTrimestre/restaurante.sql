drop database restaurante;

-- tabla de platos
create table plato (
    id_plato serial primary key,
    nombre varchar(100) not null,
    categoria varchar(50) not null,
    precio decimal(10,2) not null
);

-- tabla de ingredientes
create table ingrediente (
    id_ingrediente serial primary key,
    nombre_ingrediente varchar(100) not null
);

-- tabla intermedia para la relación muchos a muchos entre platos e ingredientes
create table plato_ingrediente (
    id_plato int not null,
    id_ingrediente int not null,
    constraint fk_plato foreign key (id_plato) references plato(id_plato),
    constraint fk_ingrediente foreign key (id_ingrediente) references ingrediente(id_ingrediente),
    primary key (id_plato, id_ingrediente)
);

-- insertar platos
insert into plato (nombre, categoria, precio) values
('sopa de risas y lágrimas', 'entrante', 5.99),
('tortilla de la abuela marciana', 'principal', 9.99),
('pastel intergaláctico de chocolate', 'postre', 3.99),
('cóctel del unicornio resfriado', 'bebida', 4.99);

-- insertar ingredientes
insert into ingrediente (nombre_ingrediente) values
('harina'), ('huevos'), ('leche galáctica'),
('azúcar estelar'), ('chocolate oscuro'),
('fresas mágicas'), ('queso espacial'),
('hierbas finas'), ('polvo de asteroides'),
('lágrimas de cebolla'), ('hielo polar');

-- insertar la relación entre platos e ingredientes
insert into plato_ingrediente (id_plato, id_ingrediente) values
(1, 1), (1, 8), (1, 10), -- sopa de risas y lágrimas
(2, 2), (2, 7), (2, 9), -- tortilla de la abuela marciana
(3, 5), (3, 3), (3, 4), -- pastel intergaláctico de chocolate
(4, 6), (4, 3), (4, 11); -- cóctel del unicornio resfriado

--1. Ver el menú completo con precios.
select nombre, categoria, precio from plato;


--2. Listar los ingredientes de un plato específico.
select i.nombre_ingrediente from Ingrediente i
join Plato_Ingrediente pi on i.id_ingrediente =
pi.id_ingrediente
join Plato p on pi.id_plato = p.id_plato
where p.nombre = 'tortilla de la abuela marciana';


--3. Encentrar el plato más caro usando una subconsulta.
select nombre, precio from plato 
where precio = (select max(precio) from plato);

select * from plato;

--4. Encontrar el plato más barato usando la cláusula LIMIT.


--5. Encontrar el plato con más ingredientes.


--6. Calcular el costo promedio de los platos en cada categoría.


--7. Buscar platos que contengan leche, chocolate o fresas.


--8. Encontrar los platos que tienen más de dos ingredientes y con un coste superior a 5 euros.


--9. Encontrar los platos principales con más de dos ingredientes.


--10. Insertar un nuevo plato llamado Ensalada de Estrellas Fugaces en la categoría Entrante, con un precio de $7.50.


--11. Inserta en la tabla ingrediente tres ingredientes de tu invención para la nueva “Ensalada de Estrellas Fugaces”.


--12. Asigna los tres nuevos ingredientes a tu nueva ensalada.


--13. Insertar tres platos nuevos de la categoría Postre con nombres curiosos.Recuerda asignarles ingredientes.


--14. Aumentar el precio del plato Pastel Intergaláctico de Chocolate en un 10%.


--15. Actualiza la categoría del plato Cóctel del Unicornio Resfriado de Bebida a Postre Líquido.


--16. Cambia el nombre del ingrediente Esencia de Sol a Extracto de Sal.


--17. Incrementa en $1.00 el precio de todos los platos de la categoría Principal.


--18. Asigna el ingrediente Toques de Fantasía a todos los platos de la categoría, Postre.

