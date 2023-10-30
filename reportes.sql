-- CONSULTAR PENSUM
DELIMITER //
CREATE PROCEDURE consultarPensum(
    IN p_codigo NUMERIC
)
BEGIN
    SELECT CURSO_ID, CURSO, CREDITOS_NECESARIOS, CREDITOS_OTORGA, OBLIGATORIO 
    FROM CURSO 
    WHERE CARRERA_ID = p_codigo;
END //
DELIMITER ;

-- CONSULTAR AL ESTUDIANTE
DELIMITER //
CREATE PROCEDURE consultarEstudiante(
    IN p_carnet BIGINT
)
BEGIN
    DECLARE car BIGINT;
    
    -- Obtener el ID del estudiante
    SET car = (SELECT ESTUDIANTE_ID FROM ESTUDIANTE WHERE ESTUDIANTE_ID = p_carnet);
    
    -- Validar si el estudiante no ha sido registrado
    IF car IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL ESTUDIANTE NO HA SIDO REGISTRADO';
    END IF;
    
    SELECT ESTUDIANTE_ID AS CARNET, CONCAT(NOMBRES, ' ', APELLIDOS) AS NOMBRE_COMPLETO, FECHA_NACIMIENTO, CORREO, TELEFONO, DIRECCION, DPI AS NUMERO_DPI, CARRERA.CARRERA AS CARRERA, FECHA_INSCRIPCION, CREDITOS 
    FROM ESTUDIANTE
    INNER JOIN CARRERA ON ESTUDIANTE.CARRERA_ID = CARRERA.CARRERA_ID
    WHERE ESTUDIANTE_ID = p_carnet;
END //
DELIMITER ;

-- CONSULTAR AL DOCENTE
DELIMITER //
CREATE PROCEDURE consultarDocente(
    IN p_carnet BIGINT
)
BEGIN
    DECLARE car BIGINT;
    
    -- Obtener el ID del docente
    SET car = (SELECT DOCENTE_ID FROM DOCENTE WHERE DOCENTE_ID = p_carnet);
    
    -- Validar si el docente no ha sido registrado
    IF car IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL DOCENTE NO HA SIDO REGISTRADO';
    END IF;
    
    SELECT DOCENTE_ID AS REGISTRO_SIIF, CONCAT(NOMBRES, ' ', APELLIDOS) AS NOMBRE_COMPLETO, FECHA_NACIMIENTO, CORREO, TELEFONO, DIRECCION, DPI AS NUMERO_DPI, FECHA_INSCRIPCION 
    FROM DOCENTE
    WHERE DOCENTE_ID = p_carnet;
END //
DELIMITER ;

-- CONSULTAR ASIGNADOS
DELIMITER //
CREATE PROCEDURE consultarAsignados(
    IN p_codigo NUMERIC,
    IN p_ciclo VARCHAR(255),
    IN p_anio NUMERIC,
    IN p_seccion VARCHAR(255)
)
BEGIN
    DECLARE cod VARCHAR(255);
    DECLARE curh NUMERIC;
    DECLARE asignados NUMERIC;
    
    -- Obtener el código del curso
    SET cod = (SELECT CURSO_ID FROM CURSO WHERE CURSO_ID = p_codigo);
    
    -- Validar si el curso no ha sido registrado anteriormente
    IF cod IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL CURSO NO HA SIDO REGISTRADO ANTERIORMENTE';
    END IF;
    
    -- Obtener el ID del curso habilitado
    SET curh = (SELECT CURSO_HABILITADO_ID FROM CURSOHABILITADO WHERE CURSO_ID = p_codigo AND CICLO = p_ciclo AND SECCION = p_seccion AND ANIO = p_anio);
    
    -- Validar si el curso ingresado no ha sido habilitado
    IF curh IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL CURSO INGRESADO NO HA SIDO HABILITADO';
    END IF;
    
    -- Contar la cantidad de estudiantes asignados al curso habilitado
    SET asignados = (SELECT COUNT(*) FROM ASIGNACION WHERE CURSO_HABILITADO_ID = curh);
    
    -- Validar si no hay estudiantes asignados al curso
    IF asignados <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'NO HAY ALUMNOS ASIGNADOS AL CURSO';
    END IF;
    
    -- Consultar los estudiantes asignados
    SELECT ASIGNACION.ESTUDIANTE_ID AS CARNET, CONCAT(ESTUDIANTE.NOMBRES, ' ', ESTUDIANTE.APELLIDOS) AS NOMBRE_COMPLETO, ESTUDIANTE.CREDITOS AS CREDITOS
    FROM ASIGNACION
    INNER JOIN ESTUDIANTE ON ASIGNACION.ESTUDIANTE_ID = ESTUDIANTE.ESTUDIANTE_ID 
    WHERE ASIGNACION.CURSO_HABILITADO_ID = curh AND ESTADO = 1;
END //
DELIMITER ;

-- CONSULTAR APROBACIONES
DELIMITER //
CREATE PROCEDURE consultarAprobacion(
    IN p_codigo NUMERIC,
    IN p_ciclo VARCHAR(255),
    IN p_anio NUMERIC,
    IN p_seccion VARCHAR(255)
)
BEGIN
    DECLARE cod VARCHAR(255);
    DECLARE curh NUMERIC;
    DECLARE asignados NUMERIC;
    
    -- Obtener el código del curso
    SET cod = (SELECT CURSO_ID FROM CURSO WHERE CURSO_ID = p_codigo);
    
    -- Validar si el curso no ha sido registrado anteriormente
    IF cod IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL CURSO NO HA SIDO REGISTRADO ANTERIORMENTE';
    END IF;
    
    -- Obtener el ID del curso habilitado
    SET curh = (SELECT CURSO_HABILITADO_ID FROM CURSOHABILITADO WHERE CURSO_ID = p_codigo AND CICLO = p_ciclo AND SECCION = p_seccion AND ANIO = p_anio);
    
    -- Validar si el curso ingresado no ha sido habilitado
    IF curh IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL CURSO INGRESADO NO HA SIDO HABILITADO';
    END IF;
    
    -- Contar la cantidad de estudiantes asignados al curso habilitado
    SET asignados = (SELECT COUNT(*) FROM ASIGNACION WHERE CURSO_HABILITADO_ID = curh);
    
    -- Validar si no hay estudiantes asignados al curso
    IF asignados <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'NO HAY ALUMNOS ASIGNADOS AL CURSO';
    END IF;
    
    -- Consultar las aprobaciones de los estudiantes
    SELECT ASIGNACION.ESTUDIANTE_ID AS CARNET, CONCAT(ESTUDIANTE.NOMBRES, ' ', ESTUDIANTE.APELLIDOS) AS NOMBRE_COMPLETO,
    CASE WHEN NOTA >= 61 THEN 'APROBADO' ELSE 'REPROBADO' END AS ESTADO_CURSO
    FROM ASIGNACION
    INNER JOIN ESTUDIANTE ON ASIGNACION.ESTUDIANTE_ID = ESTUDIANTE.ESTUDIANTE_ID
    WHERE CURSO_HABILITADO_ID = curh AND ESTADO = 1;
END //
DELIMITER ;

-- PROCEDIMIENTO PARA CONSULTAR ACTAS
DELIMITER //
CREATE PROCEDURE consultarActas(
    IN p_codigo NUMERIC
)
BEGIN
    DECLARE cod VARCHAR(255);
    
    -- Obtener el código del curso
    SET cod = (SELECT CURSO_ID FROM CURSO WHERE CURSO_ID = p_codigo);
    
    -- Validar si el curso no ha sido registrado anteriormente
    IF cod IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL CURSO NO HA SIDO REGISTRADO ANTERIORMENTE';
    END IF;
    
    SELECT CURSO_ID AS CODIGO_CURSO, SECCION,
    CASE 
        WHEN CICLO = '1S' THEN 'PRIMER SEMESTRE'
        WHEN CICLO = '2S' THEN 'SEGUNDO SEMESTRE'
        WHEN CICLO = 'VJ' THEN 'VACACIONES DE JUNIO'
        WHEN CICLO = 'VD' THEN 'VACACIONES DE DICIEMBRE'
    END AS CICLO, ANIO, COUNT(NUMERO_ASIGNADOS) AS CANTIDAD_ASIGNADOS, ACTA.ACTA_FECHA AS FECHA_GENERACION
    FROM CURSOHABILITADO
    INNER JOIN ASIGNACION ON CURSOHABILITADO.CURSO_HABILITADO_ID = ASIGNACION.CURSO_HABILITADO_ID
    INNER JOIN ACTA ON ASIGNACION.ACTA_ID = ACTA.ACTA_ID
    WHERE CURSO_ID = p_codigo
    GROUP BY CURSO_ID, SECCION, CICLO, ANIO, ACTA.ACTA_FECHA
    ORDER BY ACTA.ACTA_FECHA;
END //
DELIMITER ;

-- PROCEDIMIENTO PARA CONSULTAR DESASIGNACIONES
DELIMITER //
CREATE PROCEDURE consultarDesasignacion(
    IN p_codigo NUMERIC,
    IN p_ciclo VARCHAR(255),
    IN p_anio NUMERIC,
    IN p_seccion VARCHAR(255)
)
BEGIN
    DECLARE cod VARCHAR(255);
    DECLARE curh NUMERIC;
    DECLARE asignados NUMERIC;
    DECLARE desasignados NUMERIC;
    DECLARE porcentaje NUMERIC;
    
    -- Obtener el código del curso
    SET cod = (SELECT CURSO_ID FROM CURSO WHERE CURSO_ID = p_codigo);
    
    -- Validar si el curso no ha sido registrado anteriormente
    IF cod IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL CURSO NO HA SIDO REGISTRADO ANTERIORMENTE';
    END IF;
    
    -- Obtener el ID del curso habilitado
    SET curh = (SELECT CURSO_HABILITADO_ID FROM CURSOHABILITADO WHERE CURSO_ID = p_codigo AND CICLO = p_ciclo AND SECCION = p_seccion AND ANIO = p_anio);
    
    -- Validar si el curso ingresado no ha sido habilitado
    IF curh IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL CURSO INGRESADO NO HA SIDO HABILITADO';
    END IF;
    
    -- Contar la cantidad de estudiantes asignados al curso habilitado
    SET asignados = (SELECT COUNT(*) FROM ASIGNACION WHERE CURSO_HABILITADO_ID = curh);
    
    -- Contar la cantidad de estudiantes desasignados del curso habilitado
    SET desasignados = (SELECT COUNT(*) FROM ASIGNACION WHERE ESTADO = 0 AND CURSO_HABILITADO_ID = curh);
    
    -- Calcular el porcentaje de desasignación
    SET porcentaje = CASE WHEN desasignados > 0 THEN (desasignados*100)/asignados ELSE 0 END;
    
    -- Validar si no hay estudiantes asignados al curso
    IF asignados <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'NO HAY ALUMNOS ASIGNADOS AL CURSO';
    END IF;
    
    SELECT CURSO_ID AS CODIGO_CURSO, SECCION,
    CASE 
        WHEN CICLO = '1S' THEN 'PRIMER SEMESTRE'
        WHEN CICLO = '2S' THEN 'SEGUNDO SEMESTRE'
        WHEN CICLO = 'VJ' THEN 'VACACIONES DE JUNIO'
        WHEN CICLO = 'VD' THEN 'VACACIONES DE DICIEMBRE'
    END AS CICLO, ANIO, asignados AS LLEVARON_EL_CURSO, desasignados AS DESASIGNARON_EL_CURSO, porcentaje AS PORCENTAJE_DESASIGNACION
    FROM CURSOHABILITADO
    WHERE CURSO_ID = p_codigo AND CICLO = p_ciclo AND SECCION = p_seccion AND ANIO = p_anio;
END //
DELIMITER ;
