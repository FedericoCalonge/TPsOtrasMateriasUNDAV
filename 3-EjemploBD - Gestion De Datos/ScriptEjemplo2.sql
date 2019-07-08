use Escuela;
-- Recordamos que en Carrera tenia a clave_c int, nom_c varchar(50) y durac_c float.
insert into Carrera values (1,'Derecho',3.5);
insert into Carrera values (2,'Ingeniería en Informatica',5);

-- Recordamos que en Materia tenia clave_m int, nom_m varchar(50) y cred_m float.
insert into Materia values (1, 'Matematica', 25);
insert Materia values(2, 'Ingles', 10);

-- Profesor tenía clave, nombre, dirección y telefono y el horario de entrada (en datetime -->YYYY-MM-DD HH:MM:SS ).
insert into Profesor values (1,'Claudio','Calle falsa 123', 42910830, '2017-04-20 7:00:00');
insert into Profesor values (2,'Agustina','Calle falsa 435', 42191562, '2016-06-13 8:30:00');

-- Alumno tiene su PK, nombre, edad, semestre, sexo y
-- por último la FK clave_c1 que referenciaba a la tabla Carrera. 
-- Entonces si quiero decir que Anita estudia Derecho, le pongo 1 a este valor (PK de la Carrera Derecho).
-- Y  a Sergio le ponemos 2, ya que estudia Ing. Inf.
insert into alumno values (1,'Anita',18,6,'Femenino', 1);
insert into alumno values (2,'Sergio',19,8,'Masculino', 2);

-- Alu_Pro tenia los alumnos a los cuales el profesor daba clases.
insert into alu_pro values (1,2); 
-- Con lo de arriba indico que 1 es mat_alu1 (que referencia a la tabla Alumno la cual es Anita).
-- Y que 2 es clave_p1 (que referencia al profesor, y le pongo 2, osea que es la profesora Agustina).
-- Esto quiere decir que Agustina le da clases a Anita. 
-- Aca abajo decimos que Agustina le da clases a Sergio:
insert into alu_pro values (2,2); 

-- Mat_alu:
insert into mat_alu values (2,1);
-- Arriba esta la clave de la materia --> 1 matematica, 2 Ingles.
-- Y la clave del alumno --> 1 para Anita.
-- Puesto (2, 1) quiere decir que el alumno 1 (Anita) tiene como materia 2 (Ingles). 
-- Aca abajo decimos que Sergio da matematica:
insert into mat_alu values (1,2);

-- Mat_pro:
insert into mat_pro values (2,2);
-- Arriba es (clave de la materia, clave profesor).
-- Así, Ingles la da Agustina.
-- Con lo de abajo decimos que matematica la da Claudio:
insert into mat_pro values (1,1);


-- Ahora vamos a mostrar los datos de nuestras tablas:
select * from carrera; -- Todo lo que ingresamos en carrera.
select clave_m, nom_m from materia; -- Solo los campos clave y nombre de la materia.
select * from materia; -- Todo lo que ingresamos en materia

-- Si queremos saber que Carrera cursa Ana, usamos inner join.
-- NO podemos hacer simplemente así:
-- select nom_alu, edad_alu, sem_alu, nom_c from alumno
-- Ya que nom_m (el nombre de la Carrera) está en la tabla Carrera y NO en Alumno, entonces hacemos:
select nom_alu, edad_alu, sem_alu, nom_c 
from alumno inner join carrera on alumno.clave_c1=carrera.clave_c;
-- Arriba entonces decimos que los datos nom_alu, edad_alu, sem_alu y nom_c 
-- los sacamos de la tabla alumno UNIÓN la tabla carrera (osea
-- que pueden estar en cualquiera de estas 2 tablas).
-- Y esta igualación (alumno.clave_c1=carrera.clave_c) representa
-- las relaciones entre las tablas, mediante las FK; nos permite
-- hacer el "puente" entre el alumno y la carrera. Clave_c1 pertenece a la tabla alumno y 
-- clave_c es la FK que pertenece a la tabla carrera. 

-- Ahora quiero saber el nombre de los profesores que les da clases a los alumnos: 
-- Tengo que "ir" por un camino de carrera a alumno y luego a alu_pro y luego a profesor donde esta el nom_p que necesito.
-- Este camino lo veo viendo el esquema.  Entonces hacemos:
select nom_alu, edad_alu, sem_alu, nom_c, nom_p
from alumno inner join carrera on alumno.clave_c1=carrera.clave_c
			-- Agregamos estas dos lineas:
            inner join alu_pro on alu_pro.mat_alu1=alumno.mat_alu
            inner join profesor on profesor.clave_p=alu_pro.clave_p1;

-- Ahora tambien quiero saber el nombre de las materias que da cada profesor:
select nom_alu, edad_alu, sem_alu, nom_c, nom_p, nom_m
from alumno inner join carrera on alumno.clave_c1=carrera.clave_c
			inner join alu_pro on alu_pro.mat_alu1=alumno.mat_alu
            inner join profesor on profesor.clave_p=alu_pro.clave_p1
			-- Agregamos estas dos lineas:
            inner join mat_alu on mat_alu.mat_alu2=alumno.mat_alu
            inner join materia on materia.clave_m=mat_alu.clave_m1;
            
-- Aplicamos una condicion:
-- Quiero el nombre de la carrera de los alumnos que tengan edad de 18 (osea solo va a mostrarme Anita y NO Sergio que tiene 19).
select nom_alu, edad_alu, sem_alu, nom_c 
from alumno inner join carrera on alumno.clave_c1=carrera.clave_c
where edad_alu=18; -- Tambien puedo poner <,>, etc. Puedo tambien poner nom_alu=’sergio’.

            
