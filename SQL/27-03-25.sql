/*Sentencias de DDL*/

/*Creacion de base de datos*/

drop database tiendamascota;

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

insert into Mascota values (1 , 'Alma', 'F', 'criollo', 1), (2, 'Tom', 'M', 'criollo', 1);

insert into Mascota values (3 , 'kyara', 'F', 'criollo', 2);


insert into Cliente values (1014665735 , 'Daniel', 'Moreno', 'carrera 68', 320405, 1), (1234567 , 'Adriana', 'Bravo', 'carrera 70', 313357, 2);

insert into Producto values (1, 'Jabon', 'pedigri', 1000, 1014665735), (2, 'Comida', 'pedigri', 35000, 1234567);

insert into Vacuna values (11, 'Rabia', '2', 'Rabia'), (22, 'Fiebre', '4', 'Fiebre amarrila');

insert into Mascota_Vacuna values (11, 1, 'Rabia'), (22, 2, 'Fiebre');

select m.*, c.nombreCliente, p.nombreProducto
from Mascota m
join cliente c on m.idMascota = c.idMascotaFK
join producto p on p.cedulaClienteFK = c.cedulaCliente;

/* Delete*/

delete from Mascota where idMascota = 3;

select * from Mascota;

/*
PROCEDIMIENTOS ALMACENADOS

conjunto de instrucciones de SQL que se almacena en la BD
y se pueden ejecutar muchas veces

SINTAXIS:
	
    DELIMITER //
    CREATE PROCEDURE nombre(PARAMETROS: de entrada IN, salida OUT, )
    Begin
    
    -Instrucciones
    
    
    End
*/


select * from Mascota;

describe Mascota;

DELIMITER  // 
CREATE PROCEDURE InsertarMascota(in idMascota int, nombreMascota varchar(15), generoMascota varchar(15), 
razaMascota varchar(15), cantidad int (10))
BEGIN

insert into Mascota values (idMascota, nombreMascota, generoMascota, razaMascota, cantidad);

END //
DELIMITER ;

-- 	ejecutar procedimineto: Call nombreprocedimineto (VALORES) ---


call InsertarMascota('3', 'Drako', 'M', 'Criollo', '1');

describe Producto;

DELIMITER  // 
CREATE PROCEDURE ConsultarPrecio(out precio float)
BEGIN

select count(*) into precio from producto; 
END //
DELIMITER ;

call ConsultarPrecio(@resultado);
select @resultado;

-- CREAR PROCEDIMIENTO PARA INSTER REGISTROS EN TABLA DEBIL---
describe mascota_vacuna;
select * from mascota_vacuna;

DELIMITER  // 
CREATE PROCEDURE InsertarTablaDebil(in codigoVacunaFK int (11), idMascotaFK int (11), enfermedad varchar (15))
BEGIN
insert into mascota_vacuna values (codigoVacunaFK, idMascotaFK, enfermedad);

END //
DELIMITER ;

call InsertarTablaDebil('', '', '');


-- CONSULTAR VACUNAS QUE LE HAN APLICADO A UNA MASCOTA Y QUE ENFERMEDAD ESTA ATACANDO--

DELIMITER  // 
CREATE PROCEDURE ConsultarVacunasMascota(out mascota varchar (15), vacuna varchar(15), enfermedad varchar (15))
BEGIN

select m.nombreMascota, v.codigoVacuna, mv.enfermedad
from Mascota m
join Vacuna v on m.idMascota = v.idMascotaFK
join mascota_vacuna mv on v.codigoVacuna = mv.codigoVacunaFK;

END //
DELIMITER ;

-- 27/03/25

/* VISTAS
	
    consulta almacenada en la base de datos,
    genera una tabla virtual
    
    SINTAXIS:
    
    Create View nombreVista as
    select valoresconsultar from NombreTabla where condiciones
    
*/

describe cliente;
create view vistaCliente as
select * from cliente where cedulaCliente = 1014665735;

select * from vistaCliente;

create view vistaTelefono as
select * from cliente where telefono like '%4%' '%5%' '%6%';

/*cambiar una vista*/

alter view vistaTelefono as
select * from cliente where telefono like '%4%' 
or telefono like '%5%'
or telefono like '%6%';

-- drop view;  PARA ELIMINAR UNA VISTA

select * from vistaTelefono;

/* TRIGGERS
	Tipos:
	-Before:
		* Before insert
        * before update
        * before delete
        
        Se ejecutan antes de realizar el proceso.
        
	-Before:
		* after insert
        * after update
        * after delete
        
        Se ejecutan despues de realizar el proceso.
                
	SINTAXIS:
    
    DELIMITER //
    
    CREATE TRIGGER nombreTrigger
    AFTER INSERT (tipo tiempo y tipo de accion) on NOMBRETABLA
    for each row
    
    BEGIN
    
    instrucciones
    
    END
    
    
    //
    DELIMITER ;
	
*/

/* crear trigger para registrar en una tabla consolidado, cada vez 
que se registre una mascota*/

create table consolidado(
idMascota int primary key,
nombreMascota varchar (15),
generoMascota varchar (15),
razaMascota varchar (15),
cantidad int (10)
);

DELIMITER //

create trigger registrarConsolidado 
after insert on mascota
for each row

begin 

insert into consolidado values (new.idMascota, new.nombreMascota, new.generoMascota, new.razaMascota, new.cantidad);

end//
DELIMITER ;

select * from consolidado;

insert into Mascota values (4 , 'nebuña', 'F', 'criollo', 2);
insert into Mascota values (5 , 'jesus', 'm', 'criollo', 2);
insert into Mascota values (6 , 'juete', 'm', 'pincher', 2);


describe mascota;

select * from mascota;


select * from consolidado;


DELIMITER //

create table eliminados(
cedulaCliente int primary key,
nombreCliente varchar (15),
apellidoCliente varchar (15),
direccionCliente varchar (10),
telefono int (10),
idMascotaFK int
);

DELIMITER //

create trigger eliminarCliente 
before delete on cliente
for each row

begin 

insert into eliminados values(old.cedulaCliente, old.nombreCliente, old.apellidoCliente, old.direccionCliente, old.telefono, old.idMascotaFK);

end//
DELIMITER ;

drop trigger eliminarCliente;

select * from cliente;
describe cliente;

insert into cliente values(1014482973, 'Lina', 'peña', 'carrera 10', 1234, 2);

delete from cliente where cedulaCliente = 1014482973;

select * from eliminados;
