-- CARRERA
DELIMITER //

CREATE TRIGGER tr_carrera_insert
AFTER INSERT ON CARRERA
FOR EACH ROW
BEGIN
    -- Se realizó una operación de inserción
    INSERT INTO HISTORIAL (descripcion, tipo)
    VALUES ('SE REALIZO UNA ACCION EN LA TABLA CARRERA', 'INSERT');
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER tr_carrera_update
AFTER UPDATE ON CARRERA
FOR EACH ROW
BEGIN
    -- Se realizó una operación de actualización
    INSERT INTO HISTORIAL (descripcion, tipo)
    VALUES ('SE REALIZO UNA ACCION EN LA TABLA CARRERA', 'UPDATE');
END;
//

DELIMITER ;


DELIMITER //

CREATE TRIGGER tr_carrera_delete
AFTER DELETE ON CARRERA
FOR EACH ROW
BEGIN
    -- Se realizó una operación de eliminación
    INSERT INTO HISTORIAL (descripcion, tipo)
    VALUES ('SE REALIZO UNA ACCION EN LA TABLA CARRERA', 'DELETE');
END;
//

DELIMITER ;

-- DOCENTE
DELIMITER //

CREATE TRIGGER tr_docente_insert
AFTER INSERT ON DOCENTE
FOR EACH ROW
BEGIN
    -- Se realizó una operación de inserción
    INSERT INTO HISTORIAL (descripcion, tipo)
    VALUES ('SE REALIZO UNA ACCION EN LA TABLA DOCENTE', 'INSERT');
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER tr_docente_update
AFTER UPDATE ON DOCENTE
FOR EACH ROW
BEGIN
    -- Se realizó una operación de actualización
    INSERT INTO HISTORIAL (descripcion, tipo)
    VALUES ('SE REALIZO UNA ACCION EN LA TABLA DOCENTE', 'UPDATE');
END;
//

DELIMITER ;


DELIMITER //

CREATE TRIGGER tr_docente_delete
AFTER DELETE ON DOCENTE
FOR EACH ROW
BEGIN
    -- Se realizó una operación de eliminación
    INSERT INTO HISTORIAL (descripcion, tipo)
    VALUES ('SE REALIZO UNA ACCION EN LA TABLA DOCENTE', 'DELETE');
END;
//

DELIMITER ;

-- ESTUDIANTE
DELIMITER //

CREATE TRIGGER tr_estudiante_insert
AFTER INSERT ON ESTUDIANTE
FOR EACH ROW
BEGIN
    -- Se realizó una operación de inserción
    INSERT INTO HISTORIAL (descripcion, tipo)
    VALUES ('SE REALIZO UNA ACCION EN LA TABLA ESTUDIANTE', 'INSERT');
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER tr_estudiante_update
AFTER UPDATE ON ESTUDIANTE
FOR EACH ROW
BEGIN
    -- Se realizó una operación de actualización
    INSERT INTO HISTORIAL (descripcion, tipo)
    VALUES ('SE REALIZO UNA ACCION EN LA TABLA ESTUDIANTE', 'UPDATE');
END;
//

DELIMITER ;


DELIMITER //

CREATE TRIGGER tr_estudiante_delete
AFTER DELETE ON ESTUDIANTE
FOR EACH ROW
BEGIN
    -- Se realizó una operación de eliminación
    INSERT INTO HISTORIAL (descripcion, tipo)
    VALUES ('SE REALIZO UNA ACCION EN LA TABLA ESTUDIANTE', 'DELETE');
END;
//

DELIMITER ;

-- CURSO
DELIMITER //

CREATE TRIGGER tr_curso_insert
AFTER INSERT ON CURSO
FOR EACH ROW
BEGIN
    -- Se realizó una operación de inserción
    INSERT INTO HISTORIAL (descripcion, tipo)
    VALUES ('SE REALIZO UNA ACCION EN LA TABLA CURSO', 'INSERT');
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER tr_curso_update
AFTER UPDATE ON CURSO
FOR EACH ROW
BEGIN
    -- Se realizó una operación de actualización
    INSERT INTO HISTORIAL (descripcion, tipo)
    VALUES ('SE REALIZO UNA ACCION EN LA TABLA CURSO', 'UPDATE');
END;
//

DELIMITER ;


DELIMITER //

CREATE TRIGGER tr_curso_delete
AFTER DELETE ON CURSO
FOR EACH ROW
BEGIN
    -- Se realizó una operación de eliminación
    INSERT INTO HISTORIAL (descripcion, tipo)
    VALUES ('SE REALIZO UNA ACCION EN LA TABLA CURSO', 'DELETE');
END;
//

DELIMITER ;

-- CURSOHABILITADO
DELIMITER //

CREATE TRIGGER tr_cursoHabilitado_insert
AFTER INSERT ON CURSOHABILITADO
FOR EACH ROW
BEGIN
    -- Se realizó una operación de inserción
    INSERT INTO HISTORIAL (descripcion, tipo)
    VALUES ('SE REALIZO UNA ACCION EN LA TABLA CURSOHABILITADO', 'INSERT');
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER tr_cursoHabilitado_update
AFTER UPDATE ON CURSOHABILITADO
FOR EACH ROW
BEGIN
    -- Se realizó una operación de actualización
    INSERT INTO HISTORIAL (descripcion, tipo)
    VALUES ('SE REALIZO UNA ACCION EN LA TABLA CURSOHABILITADO', 'UPDATE');
END;
//

DELIMITER ;


DELIMITER //

CREATE TRIGGER tr_cursoHabilitado_delete
AFTER DELETE ON CURSOHABILITADO
FOR EACH ROW
BEGIN
    -- Se realizó una operación de eliminación
    INSERT INTO HISTORIAL (descripcion, tipo)
    VALUES ('SE REALIZO UNA ACCION EN LA TABLA CURSOHABILITADO', 'DELETE');
END;
//

DELIMITER ;

-- HORARIO
DELIMITER //

CREATE TRIGGER tr_horario_insert
AFTER INSERT ON HORARIO
FOR EACH ROW
BEGIN
    -- Se realizó una operación de inserción
    INSERT INTO HISTORIAL (descripcion, tipo)
    VALUES ('SE REALIZO UNA ACCION EN LA TABLA HORARIO', 'INSERT');
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER tr_horario_update
AFTER UPDATE ON HORARIO
FOR EACH ROW
BEGIN
    -- Se realizó una operación de actualización
    INSERT INTO HISTORIAL (descripcion, tipo)
    VALUES ('SE REALIZO UNA ACCION EN LA TABLA HORARIO', 'UPDATE');
END;
//

DELIMITER ;


DELIMITER //

CREATE TRIGGER tr_horario_delete
AFTER DELETE ON HORARIO
FOR EACH ROW
BEGIN
    -- Se realizó una operación de eliminación
    INSERT INTO HISTORIAL (descripcion, tipo)
    VALUES ('SE REALIZO UNA ACCION EN LA TABLA HORARIO', 'DELETE');
END;
//

DELIMITER ;

-- ACTA
DELIMITER //

CREATE TRIGGER tr_acta_insert
AFTER INSERT ON ACTA
FOR EACH ROW
BEGIN
    -- Se realizó una operación de inserción
    INSERT INTO HISTORIAL (descripcion, tipo)
    VALUES ('SE REALIZO UNA ACCION EN LA TABLA ACTA', 'INSERT');
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER tr_acta_update
AFTER UPDATE ON ACTA
FOR EACH ROW
BEGIN
    -- Se realizó una operación de actualización
    INSERT INTO HISTORIAL (descripcion, tipo)
    VALUES ('SE REALIZO UNA ACCION EN LA TABLA ACTA', 'UPDATE');
END;
//

DELIMITER ;


DELIMITER //

CREATE TRIGGER tr_acta_delete
AFTER DELETE ON ACTA
FOR EACH ROW
BEGIN
    -- Se realizó una operación de eliminación
    INSERT INTO HISTORIAL (descripcion, tipo)
    VALUES ('SE REALIZO UNA ACCION EN LA TABLA ACTA', 'DELETE');
END;
//

DELIMITER ;

-- ASIGNACION
DELIMITER //

CREATE TRIGGER tr_asignacion_insert
AFTER INSERT ON ASIGNACION
FOR EACH ROW
BEGIN
    -- Se realizó una operación de inserción
    INSERT INTO HISTORIAL (descripcion, tipo)
    VALUES ('SE REALIZO UNA ACCION EN LA TABLA ASIGNACION', 'INSERT');
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER tr_asignacion_update
AFTER UPDATE ON ASIGNACION
FOR EACH ROW
BEGIN
    -- Se realizó una operación de actualización
    INSERT INTO HISTORIAL (descripcion, tipo)
    VALUES ('SE REALIZO UNA ACCION EN LA TABLA ASIGNACION', 'UPDATE');
END;
//

DELIMITER ;


DELIMITER //

CREATE TRIGGER tr_asignacion_delete
AFTER DELETE ON ASIGNACION
FOR EACH ROW
BEGIN
    -- Se realizó una operación de eliminación
    INSERT INTO HISTORIAL (descripcion, tipo)
    VALUES ('SE REALIZO UNA ACCION EN LA TABLA ASIGNACION', 'DELETE');
END;
//

DELIMITER ;
