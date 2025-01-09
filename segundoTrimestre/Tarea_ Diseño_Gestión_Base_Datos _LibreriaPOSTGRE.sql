-- Crear la base de datos
CREATE DATABASE libreria_online;
\c libreria_online

-- Tabla clientes
CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(15),
    direccion VARCHAR(150)
);

-- Tabla autores
CREATE TABLE autores (
    id_autor SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Tabla categorias
CREATE TABLE categorias (
    id_categoria SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Tabla libros
CREATE TABLE libros (
    id_libro SERIAL PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL CHECK(precio > 0),
    stock INT NOT NULL CHECK(stock >= 0),
    id_categoria INT REFERENCES categorias(id_categoria) ON DELETE SET NULL
);

-- Tabla libro_autor (relación muchos a muchos entre libros y autores)
CREATE TABLE libro_autor (
    id_libro INT REFERENCES libros(id_libro) ON DELETE CASCADE,
    id_autor INT REFERENCES autores(id_autor) ON DELETE CASCADE,
    PRIMARY KEY (id_libro, id_autor)
);

-- Tabla pedidos
CREATE TABLE pedidos (
    id_pedido SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES clientes(id_cliente) ON DELETE CASCADE,
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10, 2) NOT NULL CHECK(total > 0)
);

-- Tabla detalles_pedidos
CREATE TABLE detalles_pedidos (
    id_detalle SERIAL PRIMARY KEY,
    id_pedido INT REFERENCES pedidos(id_pedido) ON DELETE CASCADE,
    id_libro INT REFERENCES libros(id_libro) ON DELETE CASCADE,
    cantidad INT NOT NULL CHECK(cantidad > 0),
    subtotal DECIMAL(10, 2) NOT NULL CHECK(subtotal > 0)
);
