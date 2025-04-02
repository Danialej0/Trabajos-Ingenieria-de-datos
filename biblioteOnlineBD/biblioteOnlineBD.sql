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
idLibroFK int not null
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