create database empleados_Departamentos_Cargos;

use empleados_Departamentos_Cargos;

create table empleados(
idEmpleado int AUTO_INCREMENT primary key not null,
nombre varchar (20) not null,
edad int not null,
salario bigint not null, /* EN DOLARES*/
idDepartamentoFk int not null,
foreign key(idDepartamentoFk) references departamentos (idDepartamento) on delete cascade on update cascade,
idCargoFk varchar(40) not null,
foreign key(idCargoFk) references cargo (idCargo) on delete cascade on update cascade,
inicioContrato int not null
);

Create table departamentos(
idDepartamento int auto_increment primary key not null,
nombreDepartamento varchar (20) not null
);

create table cargo(
idCargo varchar(40) primary key not null,
nombreCargo varchar (20) not null,
rangoCargo varchar (20) not null,
descripcionCargo varchar(40) not null
);

insert into departamentos values (' ', 'Desarrollo'), (' ', 'Ventas'), (' ', 'Humanos'), (' ', 'Marketing'), (' ', 'Atencion') ;

insert into cargo values ('1234', 'Analista Datos nivel 2', '2', ' Encargado de tomar desiciones según las estadisticas'),
 ('2345', 'Vendedor nivel 5', '5', 'Encargado de relizar las ventas'), ('3456', 'Desarrollador software nivel 1', '1', 'Encargado de relizar y mantener el software'),
 ('4567', 'Desarrollador software nivel 2', '2', 'Encargado de relizar y mantener el software'),
 ('5678 ', 'Vendedor nivel 3', '3', 'Encargado de relizar las ventas');

select * from cargo;

insert into empleados values (' ', 'Daniel', 18, 2000, '1', '3456', 2023 ),
(' ', 'Cristian ', 38 , 4100, '2', '2345', 2020),
(' ', 'Adriana ', 42, 8000 , '1', '4567', 2018),
(' ', 'Mariana ', 17, 1000, '1', '3456', 2025),
(' ', 'Juan', 37, 2500, '4', '1234', 2024);

select * from empleados;


/* nombres, edades y salrios */

select nombre, edad, salario from empleados;

/* empleados con mas de 4000 dolar de salario */

select * from empleados where salario >= 4000;

/* empleados departamentos de ventas */

select* from empleados where departamento= 'Ventas';

/* empleados entre 30 y 40 años */

select* from empleados where edad >= 30 and edad <= 40;

/* empleados contratos despues de 2020 */

select* from empleados where inicioContrato > 2020;

/* empleados nombres que empiezen con a o c*/

select* from empleados where nombre like 'A%' or nombre like 'C%';

/* empleados nombres que empiezen con a o c*/

select* from empleados where nombre like 'A%' or nombre like 'C%';

/*Promeido salarial*/

select Avg(salario) as promedioSalario FROM empleados;

/* maximo salario*/

select nombre, salario as 'Mejor Salario' from empleados where salario= (select max(salario) from empleados);

/* consultar rangos BETWEEN ... AND*/

select * from empleados where idEmpleado between 1 and 2;

/* consultar un valor dentro de una lista de valores IN*/

select * from empleados where departamento in ('ventas', 'practicante');

select * from empleados order by salario desc;

select *, (2025 - inicioContrato) as 'años trabajados' from empleados;

select nombre, inicioContrato, timestampdiff(year, inicioContrato, Curdate()) as 'dias trabajados' from empleados;

select * from empleados order by salario desc limit 3;

select count(*) as 'empleados que ganan más del salario promedio' from empleados
where salario > (select avg(salario) from empleados);

/* CANTIDAD DE TRABAJADORES POR DEPARTAMENTOS (group all)*/

/* ultimo reto*/

select *, (2025 - inicioContrato) as 'años trabajados' from empleados 
where ((2025 - inicioContrato)>=(select max((2025 - inicioContrato)) from empleados) and salario>=(select max(salario) from empleados));

/*FUNCIONES AGREGADAS*/

/* funcion SELEC MAX,

- SELECT MIN,
- SELECT COUNT,
- HAVING: select * from empleados group by departamento having...

*/

/* MODIFICACIONES:

update NOMBRE-TABLA set CAMPO1 = 'VALOR-REEMPLAZO', CAMPO2..., where LLAVEPRIMARIA = 'Valor';

delete from NOMBRE-TABLA where...
*/

/* tipos de join

inner join; filas comunes de ambas tablas
left join; devuelve las filas de la tabla izquierda y todas las filas que coinciden en ambas
right join; devuelve las filas de la tabla derecha y todas las filas que coinciden en ambas
full join; deveulve todas las filas 
*/

/* CONSULTA DE TODOS LOS CARGOS QUE TENGAN UN RANGO ESPECIFICO*/

select * from cargo 
where rangoCargo = '2';


/*MOSTRAR EN PATALLA LOS EMPLEADOS QUE TENGAN UN CARGO ESPECIFICO*/

select nombre, nombreCargo from empleados
left join cargo
on cargo.idCargo = empleados.idCargoFk
where idCargo = '3456';



/* MOSTRAR TODOS LOS EMPLEADOS QUE TENGAN MAS DE 3 AÑOS DE ANTIGUEDAD, SU DEPARTAMNETO, SU CARGO Y SALARIO*/


/* MOSTRAR TODA LA INFO DE UN EMPLEADO, CON DEPARTAMENTO Y CARGO Y SU RANGO*/

select * from empleados
join cargo
on cargo.idCargo = empleados.idCargoFk
join departamentos
on departamentos.idDepartamento = empleados.idDepartamentoFk;


/* MOSTRAR TODOS LOS DEPARTAMENTOS QUE NO TENGAN EMPLEADOS ASIGNADOS*/

/* MOSTRAR TODOS LOS CARGOS QUE NO TENGAN EMPLEADOS ASIGNADOS*/

select idCargo, nombreCargo from cargos
left join empleados
on cargo.idCargo = empleados.idCargoFk
where idEmpleado is null;








