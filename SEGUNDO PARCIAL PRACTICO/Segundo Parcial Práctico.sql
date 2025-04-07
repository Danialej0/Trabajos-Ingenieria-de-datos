create database Dataverse;
use Dataverse;


/* creacion de tablas*/

create table sensores(
id_Sensor int primary key not null,
tipo varchar (20) not null,
ubicacion varchar (20) not null,
fecha_Instalacion date not null

);

create table analisis(
id_analisis int primary key not null,
id_usuarioFK int,
id_eventoFK int,
id_registroConsumoFK int
);

create table registros_Sensores(
	id_registro  int primary key not null,
    id_sensorFK int,
    id_analisisFK int
);

create table Transporte(
	id_transporte int primary key not null,
    tipo varchar (20) not null,
    capacidad int not null
    
);

create table Usuarios(
	id_usuario int primary key not null,
    nombre varchar (20) not null,
    email varchar (30) not null,
    id_transporteFK int 
);

create table Consumo_Energetico(
	id_registroConsumo int primary key not null,
    zona varchar (20) not null,
    consumo_Kw varchar(20) not null,
    fecha date not null
);

create table Seguridad(
	id_evento int primary key not null,
    tipo_evento varchar (40) not null,
    descripcion varchar (100),
    fecha_hora time not null,
    ubicacion varchar (20) not null
    
);

/* relaciones */ 
alter table registros_Sensores
add constraint FKidSennsor
foreign key (id_sensorFK)
references sensores(id_sensor);

alter table registros_Sensores
add constraint FKidAnalisis
foreign key (id_analisisFK)
references analisis(id_analisis);

alter table usuarios
add constraint FKIdtransporte
foreign key (id_transporteFK)
references transporte(id_transporte);

alter table analisis
add constraint FKidusuario
foreign key (id_usuarioFK)
references usuarios(id_usuario);

alter table analisis
add constraint FKIdEvento
foreign key (id_eventoFK)
references seguridad(id_evento);

alter table analisis
add constraint FKConsumo
foreign key (id_registroConsumoFK)
references Consumo_Energetico(id_registroConsumo);

-- modificar tabla usuario

alter table usuarios add telefono int;


-- inserciones 

insert into sensores values(1, 'temperatura', 'centro', '2025-03-03'), (2, 'accidentes', 'sur', '2024-10-11'), (3, 'huecos', 'este', '2023-08-24'), 
(4, 'trafico', 'oeste', '2024-01-01'), (5, 'clima', 'nor-occdiente', '2024-06-06');

insert into registros_Sensores values();

    
insert into Transporte values(1, 'bus', 200), (2, 'metro', 200), (3, 'transmi', 200), (4, 'bicicleta', 200), (5, 'automovil', 200);


insert into seguridad values (1, 'robo', '', '13:00:00', 'centro');
insert into seguridad values (2, 'asesinato', '', '13:00:00', 'centro'), (3, 'riña', '', '13:00:00', 'centro'), (4, 'pelea', '', '13:00:00', 'centro'),
(5, 'ruido', '', '13:00:00', 'centro');

insert into Usuarios values();
insert into Consumo_Energetico values(1, 'sur', 5000, '2024-10-11'), (2, 'norte', 1234, '2025-03-03'), (3, 'este', 4324, '2024-06-06'), (4, 'oeste', 3213, '2024-01-01'), (5, 'sur-occidente', 4324, '2023-08-24');


-- Vistas


-- procedimientos


-- triggers


-- multitablas