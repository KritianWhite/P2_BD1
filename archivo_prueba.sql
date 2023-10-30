-- REGISTRO DE CARRERAS
CALL crearCarrera('Ingenieria Civil');       -- 1  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Industrial');  -- 2  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Sistemas');    -- 3  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Electronica'); -- 4  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Mecanica');    -- 5  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Mecatronica'); -- 6  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Quimica');     -- 7  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Ambiental');   -- 8  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Materiales');  -- 9  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Textil');      -- 10 VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Area Comun');             -- 0 VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE

-- REGISTRO DE DOCENTES
CALL registrarDocente('Docente de','Apellido Uno','1999-10-30','aadf@ingenieria.usac.edu.gt',12345678,'direccion',12345678910,1);
CALL registrarDocente('Docente de','Apellido Dos','1999-11-20','docente2@ingenieria.usac.edu.gt',12345678,'direcciondocente2',12345678911,2);
CALL registrarDocente('Docente de','Apellido Tres','1980-12-20','docente3@ingenieria.usac.edu.gt',12345678,'direcciondocente3',12345678912,3);
CALL registrarDocente('Docente de','Apellido Cuatro','1981-11-20','docente4@ingenieria.usac.edu.gt',12345678,'direcciondocente4',12345678913,4);
CALL registrarDocente('Docente de','Apellido Cinco','1982-09-20','docente5@ingenieria.usac.edu.gt',12345678,'direcciondocente5',12345678914,5);

-- REGISTRO DE ESTUDIANTES
-- SISTEMAS
CALL registrarEstudiante(202000001,'Estudiante de','Sistemas Uno','1999-10-30','sistemasuno@gmail.com',12345678,'direccion estudiantes sistemas 1',337859510101,3);
CALL registrarEstudiante(202000002,'Estudiante de','Sistemas Dos','2000-5-3','sistemasdos@gmail.com',12345678,'direccion estudiantes sistemas 2',32781580101,3);
CALL registrarEstudiante(202000003,'Estudiante de','Sistemas Tres','2002-5-3','sistemastres@gmail.com',12345678,'direccion estudiantes sistemas 3',32791580101,3);
-- CIVIL
CALL registrarEstudiante(202100001,'Estudiante de','Civil Uno','1990-5-3','civiluno@gmail.com',12345678,'direccion de estudiante civil 1',3182781580101,1);
CALL registrarEstudiante(202100002,'Estudiante de','Civil Dos','1998-08-03','civildos@gmail.com',12345678,'direccion de estudiante civil 2',3181781580101,1);
-- INDUSTRIAL
CALL registrarEstudiante(202200001,'Estudiante de','Industrial Uno','1999-10-30','industrialuno@gmail.com',12345678,'direccion de estudiante industrial 1',3878168901,2);
CALL registrarEstudiante(202200002,'Estudiante de','Industrial Dos','1994-10-20','industrialdos@gmail.com',89765432,'direccion de estudiante industrial 2',29781580101,2);
-- ELECTRONICA
CALL registrarEstudiante(202300001, 'Estudiante de','Electronica Uno','2005-10-20','electronicauno@gmail.com',89765432,'direccion de estudiante electronica 1',29761580101,4);
CALL registrarEstudiante(202300002, 'Estudiante de','Electronica Dos', '2008-01-01','electronicados@gmail.com',12345678,'direccion de estudiante electronica 2',387916890101,4);
-- ESTUDIANTES RANDOM
CALL registrarEstudiante(201710160, 'ESTUDIANTE','SISTEMAS RANDOM','1994-08-20','estudiasist@gmail.com',89765432,'direccionestudisist random',29791580101,3);
CALL registrarEstudiante(201710161, 'ESTUDIANTE','CIVIL RANDOM','1995-08-20','estudiacivl@gmail.com',89765432,'direccionestudicivl random',30791580101,1);


CALL crearCurso(0006,'Idioma Tecnico 1',0,7,0,0); 
CALL crearCurso(0007,'Idioma Tecnico 2',0,7,0,0);
CALL crearCurso(101,'MB 1',0,7,0,1); 
CALL crearCurso(103,'MB 2',0,7,0,1); 
CALL crearCurso(017,'SOCIAL HUMANISTICA 1',0,4,0,1); 
CALL crearCurso(019,'SOCIAL HUMANISTICA 2',0,4,0,1); 
CALL crearCurso(348,'QUIMICA GENERAL',0,3,0,1); 
CALL crearCurso(349,'QUIMICA GENERAL LABORATORIO',0,1,0,1);

-- INGENIERIA EN SISTEMAS
CALL crearCurso(777,'Compiladores 1',80,4,3,1); 
CALL crearCurso(770,'INTR. A la Programacion y computacion 1',0,4,3,1); 
CALL crearCurso(960,'MATE COMPUTO 1',33,5,3,1); 
CALL crearCurso(795,'lOGICA DE SISTEMAS',33,2,3,1);
CALL crearCurso(796,'LENGUAJES FORMALES Y DE PROGRAMACIÓN',0,3,3,1);
-- INGENIERIA INDUSTRIAL
CALL crearCurso(123,'Curso Industrial 1',0,4,2,1); 
CALL crearCurso(124,'Curso Industrial 2',0,4,2,1);
CALL crearCurso(125,'Curso Industrial enseñar a pensar',10,2,2,0);
CALL crearCurso(126,'Curso Industrial ENSEÑAR A DIBUJAR',2,4,2,1);
CALL crearCurso(127,'Curso Industrial 3',8,4,2,1);
-- INGENIERIA CIVIL
CALL crearCurso(321,'Curso Civil 1',0,4,1,1);
CALL crearCurso(322,'Curso Civil 2',4,4,1,1);
CALL crearCurso(323,'Curso Civil 3',8,4,1,1);
CALL crearCurso(324,'Curso Civil 4',12,4,1,1);
CALL crearCurso(325,'Curso Civil 5',16,4,1,0);
CALL crearCurso(0250,'Mecanica de Fluidos',0,5,1,1);
-- INGENIERIA ELECTRONICA
CALL crearCurso(421,'Curso Electronica 1',0,4,4,1);
CALL crearCurso(422,'Curso Electronica 2',4,4,4,1);
CALL crearCurso(423,'Curso Electronica 3',8,4,4,0);
CALL crearCurso(424,'Curso Electronica 4',12,4,4,1);
CALL crearCurso(425,'Curso Electronica 5',16,4,4,1);


-- CAMBIOS MIOS
-- Habilitar area comun:
CALL habilitarCurso(0006, '1S', 1, 5, 'A'); -- 1
CALL habilitarCurso(0007, '1S', 1, 3, 'B'); -- 2
CALL habilitarCurso(101, '2S', 2, 2, 'C'); -- 3
CALL habilitarCurso(103, '1S', 4, 2, 'D'); -- 4
CALL habilitarCurso(017, '1S', 3, 5, 'E'); -- 5
CALL habilitarCurso(019, 'VJ', 1, 5, 'F'); -- 6
CALL habilitarCurso(348, 'VD', 2, 5, 'G'); -- 7
CALL habilitarCurso(349, 'VD', 5, 5, 'H'); -- 8

-- Agregar Horarios:
call agregarHorario(1, 1, '09:00-09:50');
call agregarHorario(1, 3, '07:00-08:50');
call agregarHorario(2, 1, '07:00-08:50');
call agregarHorario(3, 2, '09:00-10:40');
call agregarHorario(4, 2, '09:00-09:50');
call agregarHorario(5, 3, '10:40-12:20');
call agregarHorario(6, 3, '10:40-12:20');
call agregarHorario(7, 3, '10:40-12:20');
call agregarHorario(8, 3, '10:40-12:20');

call asignarCurso(0101, '2S', 'C', 202000001);
call asignarCurso(0101, '2S', 'C', 202000002);
call asignarCurso(0101, '2S', 'C', 202000003);
call asignarCurso(0101, '2S', 'C', 201710161);

call asignarCurso(0007, '1S', 'B', 202000002);

call desasignarCurso(0101, '2S', 'C', 202000003);
call desasignarCurso(0101, '2S', 'C', 202000002);
call asignarCurso(0101, '2S', 'C', 202000003); -- error

call ingresarNota(0101, '2S', 'C', 202000001, 96);
call ingresarNota(0101, '2S', 'C', 201710161, 60);

call generarActa(0101,'2S', 'C');
call generarActa(0007,'1S', 'B'); -- Error

call consultarPensum(1);
call consultarPensum(11);

call consultarEstudiante(202000003);

call consultarDocente(1);

call consultarAsignados(0101, '2S',2023, 'C');

call consultarAprobacion(0101, '2S', 2023, 'C');

call consultarActas(0101);

call consultarDesasignacion(0101, '2S',  2023, 'C'); 

-- SELECT * FROM HISTORIAL; -- ver historial

