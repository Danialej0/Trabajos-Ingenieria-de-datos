
/* crear db*/ 

create database empleados_Departamentos;

use empleados_Departamentos;

create table empleados(
idEmpleado int AUTO_INCREMENT primary key not null,
nombre varchar (20) not null,
edad int not null,
salario bigint not null, /* EN DOLARES*/
departamento varchar (20) not null,
inicioContrato int not null
);

insert into empleados values (' ', 'Daniel', 18, 2000, 'Desarrollo', 2024), (' ', 'Cristian ', 38, 4100, 'Ventas', 2020), (' ', 'Adriana ', 42, 8000 , 'Gestion', 2018),
(' ', 'Mariana ', 17, 1000, 'Practicante', 2025), (' ', 'Juan', 37, 800, 'Aseo', 2024), (' ', 'Lina ', 41, 4000, 'Ventas', 2024), (' ', 'Armando ', 28, 4000, 'Desarrollo', 2018);

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