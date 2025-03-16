/*Lenguaje de manipulación*/


create database TiendaMascota;
/*Habilitar la base de datos*/
use TiendaMascota;
/*Creacion de tablas*/
create table Mascota(
idMascota int primary key,
nombreMascota varchar (15),
generoMascota varchar (15),
razaMascota varchar (15),
cantidad int (10)
);
create table Cliente(
cedulaCliente int primary key,
nombreCliente varchar (15),
apellidoCliente varchar (15),
direccionCliente varchar (10),
telefono int (10),
idMascotaFK int
);
create table Producto(
codigoProducto int primary key,
nombreProducto varchar (15),
marca varchar (15),
precio float,
cedulaClienteFK int
);
create table Vacuna(
codigoVacuna int primary key,
nombreVacuna varchar (15),
dosisVacuna int (10),
enfermedad varchar (15)
);
create table Mascota_Vacuna(
codigoVacunaFK int,
idMascotaFK int,
enfermedad varchar (15)
);

/*crear las relaciones*/

alter table Cliente
add constraint FClienteMascota
foreign key (idMascotaFK)
references Mascota(idMascota);

alter table Producto
add constraint FKProductoCliente
foreign key (cedulaClienteFK)
references Cliente(cedulaCliente);

alter table Mascota_Vacuna
add constraint FKMV
foreign key (idMascotaFK)
references Mascota(idMascota );

alter table Mascota_Vacuna
add constraint FKVM
foreign key (codigoVacunaFK)
references Vacuna(codigoVacuna);

/*Inserción: creacion de registros - crear filas en tablas*/
describe mascota;
insert into mascota (idMascota,nombreMascota, generoMascota, razaMascota, cantidad)
values (1, 'Rush', 'Macho', 'criollo', 1);

insert into mascota values (2, 'alma', 'hembra', 'criolla', 1);

/*CONSULTAR; unicamente permite ver
Select * from "tabla"
*/

select * from mascota;

/*insercion multiple*/

insert into mascota values (3, 'tom', 'M', 'criollo', 1), (4, 'kyara', 'H', 'criollo', 1);

insert into mascota values (5, 'tobias', 'H', 'criollo', 1),
(6, 'drako', 'H', 'Criollo', 1);

select * from mascota;

describe vacuna;

insert into vacuna values (1, 'rabia', 1, 'rabia'), (2, 'malaria', 10, 'malaria');

insert into vacuna values (3, 'dengue', 2, 'dengue'), (4, 'covid', 3, 'covid'), (5, 'fiebre', 1 , 'fiebre');

select * from vacuna;
 /*------------ */
describe producto;

insert into producto values(1, 'collar', 'dogshow', '10.3223', 12345);

insert into producto values(2, 'purina', 'dogshow', '9999', 14234), (3, 'juguete', 'rakatakata', '12.321', 656543), 
(4, 'croquetas', 'almashow', '12.31213', 033423), (5, 'juguete', 'perrinator', '0.321', 12345);

select * from producto;

describe cliente;

/* CUANDO HAY LLAVE FORANEA, SE TIENE QUE COLOCAR EL NUMERO QUE CORRESPONDE EN SU TABLA ORIGINAL*/

insert into cliente values (4332, 'daniel', 'moreno', 'avenida 68', '3204', 2);

insert into cliente values(12345, 'raul', 'jimenez', 'centro', '3213', 3), (14234, 'luisa', 'porras', 'hayuelos', '42433', 4),
(656543, 'cristian', 'porras', 'hayuelos', '543543', 5), (033423, 'adriana', 'bravo', 'kennedy', '54353', 6);

select * from cliente;

/*-------------------------*/

describe Mascota_vacuna;

insert into Mascota_vacuna values (1, 2, 'rabia');
insert into Mascota_vacuna values (2, 3, 'dengue'), (3, 4, 'malaria');

select * from Mascota_vacuna;