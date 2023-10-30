-- PROCEDIMIENTO PARA REGISTRAR A UN ESTUDIANTE
DELIMITER //

CREATE PROCEDURE registrarEstudiante(
    IN p_carnet INT,
    IN p_nombres VARCHAR(255),
    IN p_apellidos VARCHAR(255),
    IN p_fecha_nacimiento DATE,
    IN p_correo VARCHAR(255),
    IN p_telefono INT,
    IN p_direccion VARCHAR(255),
    IN p_dpi BIGINT,
    IN p_carrera INT
)
BEGIN
    DECLARE id_carrera INT;

    -- Validar nombres y apellidos
    IF (SELECT f_validar_palabra(p_nombres)) = 0 OR (SELECT f_validar_palabra(p_apellidos)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL NOMBRE O EL APELLIDO NO SON VALIDOS';
    END IF;

    -- Validar correo
    IF (SELECT f_validar_correo(p_correo)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL CORREO NO ES VALIDO';
    END IF;

    -- Validar número de teléfono
    IF (SELECT f_validar_numero(p_telefono)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL NUMERO DE TELEFONO NO ES VALIDO';
    END IF;

    -- Obtener el ID de la carrera
    SET id_carrera = (SELECT f_get_carrera(p_carrera));

    -- Validar la existencia de la carrera
    IF id_carrera IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'LA CARRERA NO HA SIDO REGISTRADA';
    END IF;

    -- Validar si el estudiante ya ha sido registrado
    IF EXISTS (SELECT 1 FROM Estudiante WHERE estudiante_id = p_carnet) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL ESTUDIANTE YA HA SIDO AGREGADO ANTERIORMENTE';
    END IF;

    -- Validar si el DPI ya ha sido registrado
    IF EXISTS (SELECT 1 FROM Estudiante WHERE dpi = p_dpi) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL DPI YA HA SIDO REGISTRADO ANTERIORMENTE';
    END IF;

    -- Insertar estudiante
    INSERT INTO Estudiante(estudiante_id, carrera_id, nombres, apellidos, fecha_nac, correo, telefono, direccion, dpi)
    VALUES(p_carnet, id_carrera, p_nombres, p_apellidos, p_fecha_nacimiento, p_correo, p_telefono, p_direccion, p_dpi);

    SIGNAL SQLSTATE '00000' SET MESSAGE_TEXT = 'ESTUDIANTE REGISTRADO EXITOSAMENTE';
END //

DELIMITER ;

-- PROCEDIMIENTO PARA REGISTRAR A UN CURSO
DELIMITER //

CREATE PROCEDURE crearCarrera(IN p_nombre VARCHAR(50))
BEGIN
    DECLARE id INT;
    DECLARE sql_state CHAR(5) DEFAULT '00000';
    DECLARE errno INT;
    DECLARE message TEXT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            sql_state = RETURNED_SQLSTATE, 
            errno = MYSQL_ERRNO, 
            message = MESSAGE_TEXT; 
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = message;
    END;

    START TRANSACTION;
    INSERT INTO CARRERA(CARRERA) VALUES(p_nombre);
    SET id = LAST_INSERT_ID();
    
    IF id > 100 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error premeditado';
    END IF;

    COMMIT;
END //

DELIMITER ;

-- PROCEDIMIENTO PARA REGISTRAR DOCENTE
DELIMITER //

CREATE PROCEDURE registrarDocente(
    IN p_siif INT,
    IN p_nombres VARCHAR(255),
    IN p_apellidos VARCHAR(255),
    IN p_fecha_nacimiento DATE,
    IN p_correo VARCHAR(255),
    IN p_telefono INT,
    IN p_direccion VARCHAR(255),
    IN p_dpi BIGINT,
    IN fecha_inscripcion DATE
)
BEGIN

    -- Validar nombre y apellidos
    IF (SELECT f_validar_palabra(p_nombres)) = 0 OR (SELECT f_validar_palabra(p_apellidos)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL NOMBRE O EL APELLIDO NO SON VALIDOS';
    END IF;

    -- Validar correo
    IF (SELECT f_validar_correo(p_correo)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL CORREO NO ES VALIDO';
    END IF;

    -- Validar número de teléfono
    IF (SELECT f_validar_numero(p_telefono)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL NUMERO DE TELEFONO NO ES VALIDO';
    END IF;

    -- Validar si el docente ya ha sido registrado
    IF EXISTS (SELECT 1 FROM Docente WHERE siif = p_siif) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL DOCENTE YA HA SIDO AGREGADO ANTERIORMENTE';
    END IF;

    -- Validar si el DPI ya ha sido registrado
    IF EXISTS (SELECT 1 FROM Docente WHERE dpi = p_dpi) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL DPI YA HA SIDO REGISTRADO ANTERIORMENTE';
    END IF;

    -- Insertar docente
    INSERT INTO Docente(siif, nombres, apellidos, fecha_nac, correo, telefono, direccion, dpi, fecha_inscripcion)
    VALUES(p_siif, p_nombres, p_apellidos, p_fecha_nacimiento, p_correo, p_telefono, p_direccion, p_dpi, fecha_inscripcion);

    SIGNAL SQLSTATE '00000' SET MESSAGE_TEXT = 'DOCENTE REGISTRADO EXITOSAMENTE';

END //


DELIMITER ;

-- PROCEDIMIENTO PARA REGISTRAR UN CURSO
DELIMITER //

CREATE PROCEDURE registrarCurso(
    IN p_codigo INT,
    IN p_carrera INT,
    IN p_nombre VARCHAR(255),
    IN p_creditos_necesarios INT,
    IN p_creditos_otorga INT,
    IN p_obligatorio INT
)
BEGIN

    DECLARE id_carrera INT;

    -- Validar si el curso ya existe
    IF EXISTS (SELECT 1 FROM Curso WHERE curso_id = p_codigo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL CURSO YA HA SIDO AGREGADO ANTERIORMENTE';
    END IF;

    -- Obtener id de la carrera
    SET id_carrera = (SELECT f_get_carrera(p_carrera));

    -- Validar la existencia de la carrera
    IF id_carrera IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'LA CARRERA NO HA SIDO REGISTRADA';
    END IF;

    -- Validar el formato del numero de creditos necesarios
    IF (SELECT f_validar_numero(p_creditos_necesarios)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL NUMERO DE CREDITOS NECESARIOS NO ES VALIDO';
    END IF;
    
    -- Validar el formato del numero de creditos que otorga
    IF (SELECT f_validar_numero(p_creditos_otorga)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL NUMERO DE CREDITOS QUE OTORGA NO ES VALIDO';
    END IF;

    -- Validar el estado (si es obligatorio o no)
    IF (SELECT f_validar_estado(p_obligatorio)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL VALOR DE ESTADO (OBLIGATORIO/NO OBLIGATORIO) DEL CURSO ES INVALIDO';
    END IF;

    -- Insertar curso
    INSERT INTO Curso(curso_id, carrera_id, curso, creditos_necesarios, creditos_otorga, obligatorio)
    VALUES(p_codigo, id_carrera, p_nombre, p_creditos_necesarios, p_creditos_otorga, p_obligatorio);

    SIGNAL SQLSTATE '00000' SET MESSAGE_TEXT = 'CURSO REGISTRADO EXITOSAMENTE';

END //

DELIMITER ;

-- PROCEDIMIENTO PARA REGISTRAR UN CURSO HABILITADO
DELIMITER //
CREATE PROCEDURE habilitarCurso(
    IN p_ciclo VARCHAR(255),
    IN p_curso INT,
    IN p_docente INT,
    IN p_seccion CHAR(2),
    IN p_cupo INT,
    IN p_anio INT,
    IN p_numero_asignados INT
)
BEGIN

    DECLARE id_curso INT;
    DECLARE id_docente INT;

    -- Validar si el curso no ha sido registrado
    IF NOT EXISTS (SELECT 1 FROM Curso WHERE curso_id = p_curso) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL CURSO NO HA SIDO REGISTRADO';
    END IF;

    -- Obtener id del curso
    SET id_curso = (SELECT f_get_curso(p_curso));

    -- Validar la existencia del curso
    IF id_curso IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL CURSO NO HA SIDO REGISTRADO';
    END IF;

    -- Obtener id del docente
    SET id_docente = (SELECT f_get_docente(p_docente));

    -- Validar la existencia del docente
    IF id_docente IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL DOCENTE NO HA SIDO REGISTRADO';
    END IF;

    -- Validar el formato de la seccion
    IF (SELECT f_validar_caracter(p_seccion)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'LA SECCION NO ES VALIDA';
    END IF;

    -- Validar si la seccion ya ha sido registrada
    IF EXISTS (SELECT 1 FROM CursoHabilitado WHERE curso_id = p_curso AND seccion = p_seccion) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'LA SECCION YA HA SIDO REGISTRADA';
    END IF;

    -- Validar el formato del numero de cupo
    IF (SELECT f_validar_numero(p_cupo)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL NUMERO DE CUPO NO ES VALIDO';
    END IF;

    -- Validar el formato del ciclo
    IF (SELECT f_validar_ciclo(p_ciclo)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL CICLO NO ES VALIDO';
    END IF;

    -- Validar el formato del numero de asignados
    IF (SELECT f_validar_numero(p_numero_asignados)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL NUMERO DE ASIGNADOS NO ES VALIDO';
    END IF;

    -- Insertar curso habilitado
    INSERT INTO CursoHabilitado(ciclo, curso_id, docente_id, seccion, cupo, anio, numero_asignados)
    VALUES(p_ciclo, id_curso, id_docente, p_seccion, p_cupo, p_anio, p_numero_asignados);

    SIGNAL SQLSTATE '00000' SET MESSAGE_TEXT = 'CURSO HABILITADO REGISTRADO EXITOSAMENTE';

END //

DELIMITER ;


-- PROCEDIMIENTO PARA REGISTRAR UN HORARIO
DELIMITER //
CREATE PROCEDURE agregarHorario(
    IN p_curso_habilitado INT,
    IN p_fecha INT,
    IN p_horario VARCHAR(255)
)
BEGIN

    DECLARE id_curso_habilitado INT;

    -- Obtener id del curso habilitado
    SET id_curso_habilitado = (SELECT f_get_curso_habilitado(p_curso_habilitado));

    -- Validar si el curso ingresado no ha sido habilitado
    IF id_curso_habilitado IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL CURSO NO HA SIDO HABILITADO';
    END IF;

    -- Validar si el curso habilitado ya ha sido registrado
    IF EXISTS (SELECT 1 FROM Horario WHERE curso_habilitado_id = p_curso_habilitado AND fecha = p_fecha AND horario = p_horario) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL HORARIO YA HA SIDO REGISTRADO';
    END IF;

    -- Validar el formato de numero del curso habilitado
    IF (SELECT f_validar_numero(p_curso_habilitado)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL NUMERO DEL CURSO HABILITADO NO ES VALIDO';
    END IF;

    -- Validar el formato de la fecha (dia)
    IF (SELECT f_validar_dia(p_fecha)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL DIA NO ES VALIDO';
    END IF;

    -- Validar el formato del horario
    IF (SELECT f_validar_horario(p_horario)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL HORARIO NO ES VALIDO';
    END IF;

    -- Insertar horario
    INSERT INTO Horario(curso_habilitado_id, fecha, horario)
    VALUES(p_curso_habilitado, p_fecha, p_horario);

    SIGNAL SQLSTATE '00000' SET MESSAGE_TEXT = 'HORARIO REGISTRADO EXITOSAMENTE';

END //

DELIMITER ;

-- PROCEDIMIENTO PARA ASIGNAR UN CURSO A UN ESTUDIANTE
DELIMITER //

CREATE PROCEDURE asignarCurso(
    IN p_codigo INT,
    IN p_ciclo VARCHAR(255),
    IN p_seccion VARCHAR(255),
    IN p_carnet INT
)
BEGIN
    DECLARE carr_cur INT;
    DECLARE carr_est INT;
    DECLARE cr_nec INT;
    DECLARE cr_est INT;
    DECLARE curh INT;
    DECLARE carnet_val INT;
    DECLARE asignados INT;
    DECLARE cup INT;

    -- Obtener la carrera del curso
    SET carr_cur = (SELECT CARRERA_ID FROM CURSO WHERE CURSO_ID = p_codigo);

    -- Validar si la carrera del curso no se pudo determinar
    IF carr_cur IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR AL DETERMINAR LA CARRERA DEL CURSO';
    END IF;

    -- Obtener la carrera del estudiante
    SET carr_est = (SELECT CARRERA_ID FROM ESTUDIANTE WHERE ESTUDIANTE_ID = p_carnet);

    -- Validar si la carrera del estudiante no se pudo determinar
    IF carr_est IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR AL DETERMINAR LA CARRERA DEL ESTUDIANTE';
    END IF;

    -- Comprobar si el curso es de la misma carrera o si es de carrera libre
    IF carr_cur != carr_est AND carr_cur != 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR AL ASIGNAR EL CURSO PORQUE NO ES DE LA CARRERA';
    END IF;

    -- Obtener el número de créditos necesarios del curso
    SET cr_nec = (SELECT CREDITOS_NECESARIOS FROM CURSO WHERE CURSO_ID = p_codigo);

    -- Validar si el número de créditos necesarios no se pudo determinar
    IF cr_nec IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR AL DETERMINAR EL NUMERO DE CREDITOS NECESARIOS DEL CURSO';
    END IF;

    -- Obtener el número de créditos del estudiante
    SET cr_est = (SELECT CREDITOS FROM ESTUDIANTE WHERE ESTUDIANTE_ID = p_carnet);

    -- Validar si el número de créditos del estudiante no se pudo determinar
    IF cr_est IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR AL DETERMINAR EL NUMERO DE CREDITOS QUE TIENE EL ESTUDIANTE';
    END IF;

    -- Comprobar si el estudiante tiene suficientes créditos
    IF cr_est < cr_nec THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR EN LA ASIGNACION, EL ESTUDIANTE NO POSEE LOS CREDITOS NECESARIOS PARA ASIGNARSE EL CURSO';
    END IF;

    -- Validar el ciclo
    IF (SELECT f_validar_ciclo(p_ciclo)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL CICLO NO ES VALIDO';
    END IF;

    -- Validar la sección
    IF (SELECT f_validar_caracter(p_seccion)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'LA SECCION NO ES VALIDA';
    END IF;

    -- Obtener el ID del curso habilitado
    SET curh = (SELECT CURSO_HABILITADO_ID FROM CURSOHABILITADO WHERE CURSO_ID = p_codigo AND CICLO = p_ciclo AND SECCION = p_seccion);

    -- Validar si el curso ingresado no ha sido habilitado
    IF curh IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL CURSO INGRESADO NO HA SIDO HABILITADO';
    END IF;

    -- Validar el carnet del estudiante
    SET carnet_val = (SELECT ESTUDIANTE_ID FROM ESTUDIANTE WHERE ESTUDIANTE_ID = p_carnet);

    -- Validar si el estudiante no ha sido agregado
    IF carnet_val IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL ESTUDIANTE NO HA SIDO AGREGADO';
    END IF;

    -- Contar el número de estudiantes asignados al curso habilitado
    SET asignados = (SELECT COUNT(*) FROM ASIGNACION WHERE CURSO_HABILITADO_CURSO_HABILITADO_ID = curh);

    -- Obtener el cupo del curso habilitado
    SET cup = (SELECT CUPO FROM CURSOHABILITADO WHERE CURSO_HABILITADO_ID = curh);

    -- Validar si se produjo un error al determinar el número de estudiantes asignados
    IF asignados IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR AL DETERMINAR EL NUMERO DE ESTUDIANTES ASIGNADOS';
    END IF;

    -- Validar si se produjo un error al determinar el cupo del curso habilitado
    IF cup IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR AL DETERMINAR EL CUPO DE ESTUDIANTES PARA EL CURSO HABILITADO';
    END IF;

    -- Comprobar si el cupo está lleno
    IF asignados >= cup THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR AL ASIGNAR EL CURSO, EL CUPO DEL CURSO HA LLEGADO A SU MAXIMO';
    END IF;

    -- Comprobar si el curso ya ha sido asignado al estudiante
    IF (SELECT ESTADO FROM ASIGNACION WHERE CURSO_HABILITADO_CURSO_HABILITADO_ID = curh AND ESTUDIANTE_ESTUDIANTE_ID = p_carnet) = 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR AL ASIGNAR EL CURSO, EL CURSO YA FUE ASIGNADO ANTERIORMENTE';
    END IF;

    -- Comprobar si el estudiante ya tiene el mismo curso asignado
    IF (SELECT CURSO_CURSO_ID FROM ASIGNACION
        INNER JOIN CURSOHABILITADO ON ASIGNACION.CURSO_HABILITADO_CURSO_HABILITADO_ID = CURSOHABILITADO.CURSO_HABILITADO_ID
        INNER JOIN ESTUDIANTE ON ASIGNACION.ESTUDIANTE_ESTUDIANTE_ID = ESTUDIANTE.ESTUDIANTE_ID
        WHERE CURSOHABILITADO.CURSO_CURSO_ID = p_codigo AND ESTUDIANTE.ESTUDIANTE_ID = p_carnet) = p_codigo
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR AL ASIGNAR EL CURSO, EL CURSO YA FUE ASIGNADO ANTERIORMENTE';
    END IF;

    -- Insertar asignación
    INSERT INTO ASIGNACION(CURSO_HABILITADO_CURSO_HABILITADO_ID, ESTUDIANTE_ESTUDIANTE_ID) VALUES(curh, p_carnet);

    -- Actualizar el número de asignados
    UPDATE CURSOHABILITADO SET NUMERO_ASIGNADOS = asignados + 1 WHERE CURSO_HABILITADO_ID = curh;

    -- Mensaje de éxito
    SIGNAL SQLSTATE '00000' SET MESSAGE_TEXT = 'ASIGNACION GENERADA EXITOSAMENTE';

END //

DELIMITER ;

-- PROCEDIMIENTO PARA DESASIGNAR UN CURSO

DELIMITER //

CREATE PROCEDURE desasignarCurso(
    IN p_codigo INT,
    IN p_ciclo VARCHAR(255),
    IN p_seccion VARCHAR(255),
    IN p_carnet INT
)
BEGIN
    DECLARE curh INT;
    DECLARE carnet_val INT;
    DECLARE est INT;
    DECLARE nota INT;
    DECLARE asignados INT;

    -- Validar el ciclo
    IF (SELECT f_validar_ciclo(p_ciclo)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL CICLO NO ES VALIDO';
    END IF;

    -- Validar la sección
    IF (SELECT f_validar_caracter(p_seccion)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'LA SECCION NO ES VALIDA';
    END IF;

    -- Obtener el ID del curso habilitado
    SET curh = (SELECT CURSO_HABILITADO_ID FROM CURSOHABILITADO WHERE CURSO_CURSO_ID = p_codigo AND CICLO = p_ciclo AND SECCION = p_seccion);

    -- Validar si el curso ingresado no ha sido habilitado
    IF curh IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL CURSO INGRESADO NO HA SIDO HABILITADO';
    END IF;

    -- Validar el carnet del estudiante
    SET carnet_val = (SELECT ESTUDIANTE_ID FROM ESTUDIANTE WHERE ESTUDIANTE_ID = p_carnet);

    -- Validar si el estudiante no ha sido agregado
    IF carnet_val IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL ESTUDIANTE NO HA SIDO AGREGADO';
    END IF;

    -- Obtener el estado del curso asignado
    SET est = (SELECT ESTADO FROM ASIGNACION WHERE CURSO_HABILITADO_CURSO_HABILITADO_ID = curh AND ESTUDIANTE_ESTUDIANTE_ID = p_carnet);

    -- Validar si se produjo un error al determinar el estado del curso
    IF est IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR AL DETERMINAR EL ESTADO DEL CURSO';
    END IF;

    -- Comprobar si el curso ya está desasignado
    IF est = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL CURSO SE ENCUENTRA EN ESTADO DESASIGNADO ACTUALMENTE';
    END IF;

    -- Obtener la nota del curso asignado
    SET nota = (SELECT NOTA FROM ASIGNACION WHERE CURSO_HABILITADO_CURSO_HABILITADO_ID = curh AND ESTUDIANTE_ESTUDIANTE_ID = p_carnet);

    -- Validar si la nota ya ha sido ingresada
    IF nota IS NOT NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR AL DESASIGNAR EL CURSO, LA NOTA FINAL YA HA SIDO INGRESADA';
    END IF;

    -- Contar el número de estudiantes asignados al curso habilitado
    SET asignados = (SELECT COUNT(*) FROM ASIGNACION WHERE CURSO_HABILITADO_CURSO_HABILITADO_ID = curh);

    -- Validar si se produjo un error al determinar el número de estudiantes asignados
    IF asignados IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR AL DETERMINAR EL NUMERO DE ESTUDIANTES ASIGNADOS';
    END IF;

    -- Actualizar el estado del curso a desasignado
    UPDATE ASIGNACION SET ESTADO = 0 WHERE CURSO_HABILITADO_CURSO_HABILITADO_ID = curh AND ESTUDIANTE_ESTUDIANTE_ID = p_carnet;

    -- Actualizar el número de asignados
    UPDATE CURSOHABILITADO SET NUMERO_ASIGNADOS = asignados - 1 WHERE CURSO_HABILITADO_ID = curh;

    SIGNAL SQLSTATE '00000' SET MESSAGE_TEXT = 'CURSO DESASIGNADO EXITOSAMENTE';
END //

DELIMITER ;

-- PROCEDIMIENTO PARA INGRESAR NOTA DE UN CURSO
DELIMITER //

CREATE PROCEDURE IngresarNota(
    IN p_codigo INT,
    IN p_ciclo VARCHAR(255),
    IN p_seccion VARCHAR(255),
    IN p_carnet INT,
    IN p_nota INT
)
BEGIN
    DECLARE curh INT;
    DECLARE carnet_val INT;
    DECLARE est INT;
    DECLARE notas INT;
    DECLARE cr_otorga INT;
    DECLARE cr_est INT;

    -- Validar el ciclo
    IF (SELECT f_validar_ciclo(p_ciclo)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL CICLO NO ES VALIDO';
    END IF;

    -- Validar la sección
    IF (SELECT f_validar_caracter(p_seccion)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'LA SECCION NO ES VALIDA';
    END IF;

    -- Obtener el ID del curso habilitado
    SET curh = (SELECT CURSO_HABILITADO_ID FROM CURSOHABILITADO WHERE CURSO_CURSO_ID = p_codigo AND CICLO = p_ciclo AND SECCION = p_seccion);

    -- Validar si el curso ingresado no ha sido habilitado
    IF curh IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL CURSO INGRESADO NO HA SIDO HABILITADO';
    END IF;

    -- Validar el carnet del estudiante
    SET carnet_val = (SELECT ESTUDIANTE_ID FROM ESTUDIANTE WHERE ESTUDIANTE_ID = p_carnet);

    -- Validar si el estudiante no ha sido agregado
    IF carnet_val IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL ESTUDIANTE NO HA SIDO AGREGADO';
    END IF;

    -- Obtener el estado del curso asignado
    SET est = (SELECT ESTADO FROM ASIGNACION WHERE CURSO_HABILITADO_CURSO_HABILITADO_ID = curh AND ESTUDIANTE_ESTUDIANTE_ID = p_carnet);

    -- Validar si se produjo un error al determinar el estado del curso
    IF est IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR AL DETERMINAR EL ESTADO DEL CURSO';
    END IF;

    -- Comprobar si el curso está desasignado
    IF est = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL CURSO SE ENCUENTRA EN ESTADO DESASIGNADO ACTUALMENTE';
    END IF;

    -- Validar el formato de la nota
    IF (SELECT f_validar_numero(p_nota)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'LA NOTA INGRESADA NO ES VALIDA';
    END IF;

    -- Obtener la nota del curso asignado
    SET notas = (SELECT NOTA FROM ASIGNACION WHERE CURSO_HABILITADO_CURSO_HABILITADO_ID = curh AND ESTUDIANTE_ESTUDIANTE_ID = p_carnet);

    -- Validar si la nota ya ha sido ingresada
    IF notas IS NOT NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR AL INGRESAR LA NOTA FINAL, YA HA SIDO INGRESADA ANTERIORMENTE';
    END IF;

    -- Obtener el número de créditos que otorga el curso
    SET cr_otorga = (SELECT CREDITOS_OTORGA FROM CURSO WHERE CURSO_ID = p_codigo);

    -- Validar si se produjo un error al determinar el número de créditos que otorga el curso
    IF cr_otorga IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR AL DETERMINAR EL NUMERO DE CREDITOS QUE OTORGA EL CURSO';
    END IF;

    -- Obtener el número de créditos del estudiante
    SET cr_est = (SELECT CREDITOS FROM ESTUDIANTE WHERE ESTUDIANTE_ID = p_carnet);

    -- Validar si se produjo un error al determinar el número de créditos del estudiante
    IF cr_est IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR AL DETERMINAR EL NUMERO DE CREDITOS QUE TIENE EL ESTUDIANTE';
    END IF;

    -- Validar si el estudiante aprobó el curso
    IF ROUND(p_nota, 0) >= 61 THEN
        BEGIN
            -- Actualizar los créditos del estudiante
            UPDATE ESTUDIANTE SET CREDITOS = cr_est + cr_otorga WHERE ESTUDIANTE_ID = p_carnet;
            SIGNAL SQLSTATE '00000' SET MESSAGE_TEXT = 'CURSO APROBADO, LOS CREDITOS DEL ESTUDIANTE SE HAN ACTUALIZADO';
        END;
    END IF;

    -- Ingresar la nota final
    UPDATE ASIGNACION SET NOTA = ROUND(p_nota, 0) WHERE CURSO_HABILITADO_CURSO_HABILITADO_ID = curh AND ESTUDIANTE_ESTUDIANTE_ID = p_carnet AND ESTADO = 1;
    SIGNAL SQLSTATE '00000' SET MESSAGE_TEXT = 'NOTA DEL CURSO AGREGADA EXITOSAMENTE';
END //

DELIMITER ;

-- PROCEDIMIENTO PARA GENERAR LA ACTA

DELIMITER //
CREATE PROCEDURE GenerarActa(
    IN p_codigo NUMERIC,
    IN p_ciclo VARCHAR(255),
    IN p_seccion VARCHAR(255)
)
BEGIN
    DECLARE curh_id NUMERIC;
    DECLARE calificados NUMERIC;
    DECLARE asignados NUMERIC;
    DECLARE ultimo NUMERIC;
    
    -- Validar el ciclo
    IF (SELECT f_validar_ciclo(p_ciclo)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL CICLO NO ES VALIDO';
        RETURN;
    END IF;

    -- Validar la sección
    IF (SELECT f_validar_caracter(p_seccion)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'LA SECCION NO ES VALIDA';
        RETURN;
    END IF;

    -- Obtener el ID del curso habilitado
    SET curh_id = (SELECT CURH_ID FROM CURSO_HABILITADO WHERE CURSO_CUR_ID = p_codigo AND CICLO = p_ciclo AND SECCION = p_seccion);

    -- Validar si el curso ingresado no ha sido habilitado
    IF (SELECT IFNULL(curh_id, -1)) = -1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL CURSO INGRESADO NO HA SIDO HABILITADO';
        RETURN;
    END IF;

    -- Determinar la cantidad de alumnos calificados
    SET calificados = (SELECT COUNT(*) FROM ASIGNACION 
                       INNER JOIN CURSO_HABILITADO ON ASIGNACION.CURSO_HABILITADO_CURH_ID = CURSO_HABILITADO.CURH_ID 
                       WHERE CURSO_HABILITADO_CURH_ID = curh_id AND ESTADO = 1 AND YEAR(CURSO_HABILITADO.AÑO) = YEAR(NOW()) AND CURSO_HABILITADO.SECCION = p_seccion AND NOTA IS NULL);

    -- Validar si hubo un error al determinar la cantidad de alumnos calificados
    IF (SELECT IFNULL(calificados, -1)) = -1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR AL DETERMINAR LA CANTIDAD DE ALUMNOS CALIFICADOS';
        RETURN;
    END IF;

    -- Obtener el número de alumnos asignados
    SET asignados = (SELECT NUM_ASIGNADOS FROM CURSO_HABILITADO WHERE CURH_ID = curh_id);

    -- Validar si hubo un error al determinar el número de alumnos asignados
    IF (SELECT IFNULL(asignados, -1)) = -1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR AL DETERMINAR EL NUMERO DE ALUMNOS ASIGNADOS';
        RETURN;
    END IF;

    -- Validar si no se pueden generar las actas hasta que se ingresen notas a todos los estudiantes
    IF calificados > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'NO SE PUEDEN GENERAR LAS ACTAS HASTA HABER INGRESADO NOTAS A TODOS LOS ESTUDIANTES';
        RETURN;
    END IF;

    -- Validar si no hay estudiantes asignados al curso
    IF asignados = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR AL GENERAR EL ACTA, NO HAY ESTUDIANTES ASIGNADOS AL CURSO';
        RETURN;
    END IF;

    -- Insertar el registro del acta
    INSERT INTO ACTA(ACT_DATE) VALUES(NOW());

    -- Obtener el ID del acta generada
    SET ultimo = (SELECT LAST_INSERT_ID());

    -- Validar si hubo un error al determinar el ID del acta generada
    IF (SELECT IFNULL(ultimo, -1)) = -1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR AL DETERMINAR EL ID DEL ACTA GENERADA';
        RETURN;
    END IF;

    -- Actualizar el campo ACTA_ACT_ID en la tabla ASIGNACION
    UPDATE ASIGNACION SET ACTA_ACT_ID = ultimo WHERE CURSO_HABILITADO_CURH_ID = curh_id AND ESTADO = 1;

    -- Mensaje de éxito
    SIGNAL SQLSTATE '00000' SET MESSAGE_TEXT = 'ACTAS GENERADAS EXITOSAMENTE';
END //
DELIMITER ;
