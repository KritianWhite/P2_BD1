-- VALIDAR CARACTERES SI SON MAYUSCULAS
DELIMITER //

CREATE FUNCTION f_validar_caracter(caracter VARCHAR(255))
RETURNS INT
BEGIN
    DECLARE esCaracterValido INT;

    -- Verificar si el caracter es una letra mayúscula
    IF caracter REGEXP '^[A-Z]$' THEN
        SET esCaracterValido = 1; -- El caracter es una letra mayúscula
    ELSE
        SET esCaracterValido = 0; -- El caracter no es una letra mayúscula
    END IF;

    RETURN esCaracterValido;
END //

DELIMITER ;

-- VALIDACION DEL CURSO
DELIMITER //

CREATE FUNCTION f_get_carrera(carrera INT)
RETURNS INT
BEGIN
    DECLARE carrera_id INT;

    -- Obtener el ID de la carrera desde la tabla Carrera
    SET carrera_id = (SELECT carrera_id FROM Carrera WHERE carrera_id = carrera);

    RETURN carrera_id;
END //

DELIMITER ;
-- Path: f_get_carrera.sql

-- VALIDAR CICLO DE ESTUDIO

DELIMITER //

CREATE FUNCTION f_validar_ciclo(ciclo VARCHAR(255))
RETURNS INT
BEGIN
    DECLARE esCicloValido INT;

    -- Verificar si el ciclo es válido
    IF ciclo IN ('1S', '2S', 'VJ', 'VD') THEN
        SET esCicloValido = 1; -- El ciclo es válido
    ELSE
        SET esCicloValido = 0; -- El ciclo no es válido
    END IF;

    RETURN esCicloValido;
END //

DELIMITER ;

-- VALIDACION DEL DIA
DELIMITER //

CREATE FUNCTION f_validar_dia(dia NUMERIC)
RETURNS INT
BEGIN
    DECLARE esDiaValido INT;

    -- Verificar si el día está en el rango de 1 a 7
    IF dia BETWEEN 1 AND 7 THEN
        SET esDiaValido = 1; -- El día está en el rango válido
    ELSE
        SET esDiaValido = 0; -- El día no está en el rango válido
    END IF;

    RETURN esDiaValido;
END //

DELIMITER ;

-- VALIDACION DE EMAIL
DELIMITER //

CREATE FUNCTION f_validar_correo(correo VARCHAR(255))
RETURNS INT
BEGIN
    DECLARE arrobaPos INT;
    DECLARE puntoPos INT;

    -- Encontrar la posición de la arroba (@) y el punto (.) en el correo
    SET arrobaPos = LOCATE('@', correo);
    SET puntoPos = LOCATE('.', correo, arrobaPos);

    -- Verificar si la arroba y el punto existen y están en las posiciones correctas
    IF arrobaPos > 1 AND puntoPos > arrobaPos + 1 AND LENGTH(correo) - puntoPos > 1 THEN
        RETURN 1; -- El correo es válido
    ELSE
        RETURN 0; -- El correo no es válido
    END IF;
END //

DELIMITER ;

-- VALIDACION DE NUMEROS
DELIMITER //

CREATE FUNCTION f_validar_numero(numero NUMERIC)
RETURNS INT
BEGIN
    DECLARE esNumeroPositivo INT;

    -- Verificar si el número es mayor o igual a 0
    IF numero >= 0 THEN
        SET esNumeroPositivo = 1; -- El número es positivo
    ELSE
        SET esNumeroPositivo = 0; -- El número no es positivo
    END IF;

    RETURN esNumeroPositivo;
END //

DELIMITER ;

-- VALIDACION DE CALENDARIO
DELIMITER //

CREATE FUNCTION f_validar_horario(hora VARCHAR(255))
RETURNS INT
BEGIN
    DECLARE esHorarioValido INT;

    -- Verificar si el horario tiene el formato HH:MM-HH:MM
    IF hora REGEXP '^[0-9]{2}:[0-9]{2}-[0-9]{2}:[0-9]{2}$' THEN
        SET esHorarioValido = 1; -- El horario tiene el formato válido
    ELSE
        SET esHorarioValido = 0; -- El horario no tiene el formato válido
    END IF;

    RETURN esHorarioValido;
END //

DELIMITER ;
-- Path: f_Validate_schedule.sql

-- VALIDACION DEL ESTADO 
DELIMITER //

CREATE FUNCTION f_validar_estado(estado NUMERIC)
RETURNS INT
BEGIN
    DECLARE esEstadoValido INT;

    -- Verificar si el estado es 0 o 1
    IF estado IN (0, 1) THEN
        SET esEstadoValido = 1; -- El estado es válido
    ELSE
        SET esEstadoValido = 0; -- El estado no es válido
    END IF;

    RETURN esEstadoValido;
END //

DELIMITER ;

-- VALIDACION DE PALABRAS

DELIMITER //

CREATE FUNCTION f_validar_palabra(palabra VARCHAR(255))
RETURNS INT
BEGIN
    DECLARE contieneSoloLetras INT;

    -- Verificar si la palabra contiene solo letras y espacios
    SET contieneSoloLetras = palabra REGEXP '^[a-zA-Z ]+$';

    IF contieneSoloLetras = 1 THEN
        RETURN 1; -- La palabra contiene solo letras y espacios
    ELSE
        RETURN 0; -- La palabra contiene otros caracteres además de letras y espacios
    END IF;
END //

DELIMITER ;