create database biblioteOnlineBD;
use biblioteOnlineBD;

create table clientes(
idCliente int primary key not null,
nombreCliente varchar(20) not null
);

create table libros(
idLibro int primary key not null,
nombreLibro varchar(30) not null,
stockLibro int not null,
precioLibro int not null
);

create table pedidos(
idPedido int primary key not null,
fechaPedido date not null,
idClienteFK int not null
);

create table Libros_pedidos(
idPedidoFK int not null,
idLibroFK int not null,
 cantidad INT NOT NULL
);

alter table pedidos
add constraint FKidCliente
foreign key (idClienteFK)
references clientes(idCliente);


alter table Libros_pedidos
add constraint FKPedido
foreign key (idPedidoFK)
references pedidos(idPedido);

alter table Libros_pedidos
add constraint FKLibro
foreign key (idLibroFK)
references libros(idLibro);

-- Procedimiento almacenado para registrar un nuevo pedido
DELIMITER $$
CREATE PROCEDURE registrarPedido(
    IN p_idCliente INT,
    IN p_idLibro INT,
    IN p_cantidad INT
)
BEGIN
    INSERT INTO pedidos (fechaPedido, idClienteFK) VALUES (CURDATE(), p_idCliente);
    
    INSERT INTO libros_pedidos (idPedidoFK, idLibroFK, cantidad) VALUES (LAST_INSERT_ID(), p_idLibro, p_cantidad);
    
    UPDATE libros SET stockLibro = stockLibro - p_cantidad WHERE idLibro = p_idLibro;
END$$
DELIMITER ;

-- Consultas solicitadas

-- 1. Listar los pedidos de un cliente específico con detalles de los libros comprados
SELECT p.idPedido, p.fechaPedido, l.nombreLibro, lp.cantidad 
FROM pedidos p
JOIN libros_pedidos lp ON p.idPedido = lp.idPedidoFK
JOIN libros l ON lp.idLibroFK = l.idLibro
WHERE p.idClienteFK = ?;

-- 2. Consultar el cliente con mayor número de pedidos
SELECT c.idCliente, c.nombreCliente, COUNT(p.idPedido) AS totalPedidos
FROM clientes c
JOIN pedidos p ON c.idCliente = p.idClienteFK
GROUP BY c.idCliente
ORDER BY totalPedidos DESC
LIMIT 1;

-- 3. Seleccionar los libros con precio mayor a $20.00
SELECT * FROM libros WHERE precioLibro > 20.00;

-- 4. Seleccionar los pedidos realizados después del 1 de octubre de 2024
SELECT * FROM pedidos WHERE fechaPedido > '2024-10-01';

-- 5. Ordenar los libros por precio de mayor a menor
SELECT * FROM libros ORDER BY precioLibro DESC;

-- 6. Obtener total de clientes y total de unidades vendidas
SELECT (SELECT COUNT(*) FROM clientes) AS totalClientes,
       (SELECT SUM(cantidad) FROM libros_pedidos) AS totalUnidadesVendidas;

-- 7. Mostrar el número de pedidos realizados por cada cliente
SELECT c.nombreCliente, COUNT(p.idPedido) AS totalPedidos
FROM clientes c
LEFT JOIN pedidos p ON c.idCliente = p.idClienteFK
GROUP BY c.idCliente;

-- 8. Mostrar el nombre del cliente, el título del libro y la cantidad de cada pedido
SELECT c.nombreCliente, l.nombreLibro, lp.cantidad
FROM clientes c
JOIN pedidos p ON c.idCliente = p.idClienteFK
JOIN libros_pedidos lp ON p.idPedido = lp.idPedidoFK
JOIN libros l ON lp.idLibroFK = l.idLibro;

-- 9. Mostrar los títulos de los libros y la cantidad total vendida de cada uno
SELECT l.nombreLibro, SUM(lp.cantidad) AS totalVendida
FROM libros l
JOIN libros_pedidos lp ON l.idLibro = lp.idLibroFK
GROUP BY l.idLibro;