create database Escuela; -- Para crear mi BD (conjunto de tablas)
use Escuela;             -- Para indicarle a la PC que vamos a trabajar sobre esta BD Escuela.

/*Tablas Fuertes*/

-- Tabla Carrera:
-- Con paréntesis (no corchetes) y usamos comas :
create table Carrera ( -- Asi creamos una Tabla (que tienen atributos/campos).
	clave_c int,
    nom_c varchar(50), -- 50 caracteres como máximo.
    durac_c float, -- durac_c es de tipo float porque una carrera puede durar 3 años y medio.
    -- Pongo mi campo que va a ser PK:
    constraint pk_cc primary key (clave_c) -- Le decimos que clave_c es una PK (en el diagrama son los pintados en negro).
										   -- Y con constraint fk_cc foreign key (clave_c) le diriamos que clave_c es una FK (circulos pintados a la mitad).
    -- Saber: pk_cc es el ALIAS, no pueden haber alias iguales (abajo por ej. en la tabla Materia le pusimos pk_cm).
); -- No olvidarse del ;

-- Tabla Materia:
create table Materia (
	clave_m int,
    nom_m varchar(50),
    cred_m float,
    constraint pk_cm primary key (clave_m)
);

-- Tabla profesor:
create table Profesor(
	clave_p int,
    nom_p varchar (150),
    dir_p varchar (200),
    tel_p bigint,        -- El int NO nos permite almacenar todos los números necesarios para un teléfono, el bigint SI.
    hor_p datetime,
    constraint pk_cp primary key (clave_p)
);

/*Tablas Debiles (dependen de otras tablas)*/

-- Tabla alumno (con una FK):
create table Alumno(
	mat_alu int,
    nom_alu varchar(150),
    edad_alu int, 
    sem_alu int,
    gen_alu varchar(10),
    clave_c1 int, 	-- Esta hace referencia a la clave_c de la tabla Carrera. 
					-- Y como ahí es int, acá tambien es int. Tambien le pongo distinto nombre (clave_c1 enves de clave_c) porque no se pueden repetir los nombres de los atributos.
    constraint pk_calu primary key (mat_alu),
    constraint fk_fc1 foreign key (clave_c1) references Carrera (clave_c)
	-- Arriba defino a clave_c1 como FK, y la referencio con la clave_c que sacamos de la 
    -- tabla Carrera. Entonces acá indico que “ANTES era el campo clave_c de la tabla Carrera”: 
);

-- Tablas Intermedias (Alumno-Profesor, Materia-Alumno y Materia-Profesor):
create table Alu_pro(
	mat_alu1 int,
    clave_p1 int,
    constraint fk_falu1 foreign key (mat_alu1) references Alumno (mat_alu),
	constraint fk_fp1 foreign key (clave_p1) references Profesor (clave_p)
);

create table Mat_alu(
	clave_m1 int,
    mat_alu2 int,
    constraint fk_falu2 foreign key (mat_alu2) references Alumno (mat_alu),
    constraint fk_fm1 foreign key (clave_m1) references Materia (clave_m)
);

create table Mat_pro(
	clave_m2 int,
    clave_p2 int,
    constraint fk_fp2 foreign key (clave_p2) references Profesor (clave_p),
	constraint fk_fm2 foreign key (clave_m2) references Materia (clave_m)
);