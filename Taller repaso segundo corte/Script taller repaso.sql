create database votaciones2503816;

use votaciones2503816;

create table Curso(
idCurso int primary key not null,
nomCurso varchar (20) not null,
estadoCU bool not null
);

create table Concejo(
idConcejo int  primary key not null,
nomConcejo varchar (20) not null,
estadoCO bool not null
);

create table Cargo(
idCargo int primary key not null,
nomCargo varchar (20) not null,
estadoC bool not null,
idConsejoFK int
);

create table Eleccion(
idEleccion int  primary key not null,
fechaEleccion date not null,
anioEleccion year not null,
estadoEL bool not null
);

create table Genero(
idGenero int primary key not null,
nomGenero varchar (20) not null,
estadoG bool not null
);

create table Jornada(
idJornada int primary key not null,
nomJornada varchar (20) not null,
estadoJ bool not null
);

create table TipoDocumento(
idTipoDoc int primary key not null,
nomTipoDoc varchar (20) not null,
estadoTD bool not null
);

create table TipoMiembro(
idTipoMiembro int primary key not null,
nomTipoMiembro varchar (20) not null,
estadoTM bool not null
);

create table Usuario(
idUsuario int primary key not null,
noDocUsuario int not null,
idTipoDocFK int not null, 
nombreUsuario varchar(20) not null,
apellidoUsuario varchar(20) not null,
idGeneroFK int not null,
fechaNacUsuario date not null,
emailUsuario varchar(30) not null, 
passWordUsuario varchar(20) not null,
idJornadaFK int not null,
idTipoMiembroFK int not null,
idCursoFK int not null,
estadoU bool not null
);

create table Postulacion_Candidato(
idPostCandidato int primary key not null,
idUsuarioFK int not null,
idEleccionFK int not null,
idCargoFK int not null,
propuestas varchar(50) not null,
totalVotos int not null,
estadoCan bool not null
);

create table Votacion(
idVotacion int primary key not null,
horaVotacion time not null,
idUsuarioFK int not null,
idPostCandidatoFK int not null,
estadoV bool not null
);

-- CREAR RELACIONES

alter table Cargo
add constraint FKidConsejo
foreign key (idConsejoFK)
references Concejo(idConcejo);

alter table Usuario
add constraint FKidTipoDocFK
foreign key (idTipoDocFK)
references TipoDocumento(idTipoDoc);

alter table Usuario
add constraint FKidGenero
foreign key (idGeneroFK)
references Genero(idGenero);

alter table Usuario
add constraint FKidJornada
foreign key (idJornadaFK)
references Jornada(idJornada);

alter table Usuario
add constraint FKidTipoMiembro
foreign key (idTipoMiembroFK)
references TipoMiembro(idTipoMiembro);

alter table Usuario
add constraint FKidCursoFK
foreign key (idCursoFK)
references Curso(idCurso);

alter table Postulacion_Candidato
add constraint FKidUsuario
foreign key (idUsuarioFK)
references Usuario(idUsuario);

alter table Postulacion_Candidato
add constraint FKidEleccion
foreign key (idEleccionFK)
references Eleccion(idEleccion);

alter table Postulacion_Candidato
add constraint FKidCargo
foreign key (idCargoFK)
references Cargo(idCargo);

alter table Votacion
add constraint FKidUsuarioVotacion
foreign key (idUsuarioFK)
references Usuario(idUsuario);

alter table Votacion
add constraint FKidPostCandidato
foreign key (idPostCandidatoFK)
references Postulacion_Candidato(idPostCandidato);

-- INSERCIONES

insert into genero values(1,'Femenino', true), (2,'Masculino', true);


insert into jornada values(1,'Mañana',true), (2,'Tarde', true), (3,'Noche', true);


insert into TipoDocumento values(1,'Tarjeta de Identidad',true), (2,'Cédula Ciudadanía', true), (3,'Cédula Extranjeria', true), (4,'Pasaporte', true), (5,'NUIP', false);

insert into Curso values(1,'901',true), (2,'902', true), (3,'1001', true), (4,'1002', true), (5,'1003', false),
(6,'1101',true), (7,'1102', true), (8,'1103', false);

insert into Concejo values(1,'Concejo Académico',true), (2,'Concejo Directivo', true), (3,'Concejo Convivencia', true);

insert into Cargo values(1,'Personero', 1, true), (2,'Contralor',1, true), (3,'Cabildante',1, true);

insert into Eleccion values(1, '2020-04-20', '2020',true), (2, '2019-04-15', '2019',true), (3, '2019-04-12', '2019',false), (4, '2018-04-14', '2018',true), (5, '2017-04-12', '2017',true);

DELETE FROM Eleccion WHERE idEleccion IN (1, 2, 3, 4, 5);
select * from eleccion;

insert into TipoMiembro values(1,'Estudiante',true), (2,'Profesor', true), (3,'Acudiente', true);

describe usuario;

insert into Usuario values(1, 1, 1, 'Voto', 'Blanco', 2, '0000-00-00', '','', 1, 1, 3, true), (2, 1010123456, 1, 'DAVID SANTIAGO', 'LÓPEZ MORA', 2, '2004-10-11', 'davidLopez456@hotmail.com','David2004', 1, 1, 1, true),
(3, 1010123789, 1, 'LAURA MILENA', 'GOMEZ BONILLA', 1, '2004-03-17', 'lauragomez@gmail.com','Gomez2004', 1, 1, 1, true), (4, 1010123741, 1, 'DIEGO FERNANDO', 'CAÑON VARGAS', 2, '2003-05-20', 'diegocanon@hotmail.com','Diego2003', 1, 1, 1, true), 
(5, 1010123852, 1, 'TATIANA', 'VARGAS CABRERA', 1, '2003-11-28', 'tatacabrera@gmail.com','Cabrera2003', 1, 1, 3, true), (6, 1010123963, 1, 'LEYDY KATHERINE', 'FERNANDEZ RODRIGUEZ', 1, '2004-06-28', 'leydy2004@gmail.com','Leydy2004', 1, 1, 4, true), 
(7, 1010123654, 2, 'MAURICIO', 'BERMUDEZ AMAYA', 2, '2002-01-26', 'maobermudez@gmail.com','Amaya2002', 1, 1, 4, true), (8, 1010741258, 1, 'ANDRES FELIPE', 'RODRIGUEZ PEREZ', 2, '2004-03-23', 'andyrodriguez@gmail.com','Arodriguez2004', 1, 1, 3, true),
(9, 1010236859, 1, 'MARIA ANGÉLICA', 'TRIVIÑO LATORRE', 1, '2002-02-04', 'angelicatri@gmail.com','Trivino2002', 1, 1, 3, true), (10, 1010236963, 1, 'GENARO', 'VASQUEZ RODRIGUEZ', 2, '2002-11-14', 'gevasquez@gmail.com','Vasquez123', 1, 1, 3, false); 

select * from usuario;

insert into Postulacion_Candidato values (1,1,1,1,'Mejorar entrega refrigerios, Alargar descansos', 0, true), (2,5,1,1,'Mejorar entrega refrigerios, Alargar descansos', 0, true),
(3,7,1,1,'Mejorar sala de informática, Construir piscina', 0, true);

insert into votacion values(1,'12:08:15', 1, 1, true), (2, '12:12:35', 2, 3, true),
(3,'12:14:18', 3, 2, true), (4,'12:15:58', 4, 2, true), 
(5,'12:18:025', 5, 3, true), (6,'12:24:22', 6, 3, true), 
(7, '12:28:02', 7, 3, true), (8, '12:30:14', 8, 1, true),
(9,'12:40:20', 9, 2, true), (10, '12:45:20', 10, 2, true); 

-- CONSULTAS

-- mostrar nombre concejo que tenga asignado un cargo, con su nombre y estado
select co.nomConcejo, ca.nomCargo, ca.estadoC
from concejo co
join cargo ca on co.idConcejo = ca.idConsejoFK;


-- mostrar nombre concejo que tenga asignado un cargo, con su nombre y estado, tenga o no tenga cargo asignado

select co.nomConcejo, ca.nomCargo, ca.estadoC
from concejo co
left join cargo ca on co.idConcejo = ca.idConsejoFK;

-- Realice una consulta que muestre cada usuario con su jornada, tipo de miembro y curso

SELECT Usuario.nombreUsuario, Usuario.apellidoUsuario, Jornada.nomJornada, TipoMiembro.nomTipoMiembro, Curso.nomCurso
FROM Usuario
JOIN Jornada ON Usuario.idJornadaFK = Jornada.idJornada
JOIN TipoMiembro ON Usuario.idTipoMiembroFK = TipoMiembro.idTipoMiembro
JOIN Curso ON Usuario.idCursoFK = Curso.idCurso;

-- Agregue el campo a la tabla estudiante llamada profesión.

alter table usuario add profesion varchar(20);

-- Realice una consulta que muestre la cantidad de votos obtenidos por cada candidato en las votaciones registradas. 

SELECT Usuario.nombreUsuario, Usuario.apellidoUsuario, Postulacion_Candidato.totalVotos
FROM Postulacion_Candidato
JOIN Usuario ON Postulacion_Candidato.idUsuarioFK = Usuario.idUsuario
ORDER BY Postulacion_Candidato.totalVotos DESC;


