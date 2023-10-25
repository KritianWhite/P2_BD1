CREATE DATABASE UNIVERSIDAD;
USE UNIVERSIDAD;

CREATE TABLE Carrera (
    carrera_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(4000) NOT NULL
);

CREATE TABLE Docente (
    docente_id INT NOT NULL PRIMARY KEY,
    nombres VARCHAR(4000) NOT NULL,
    apellidos VARCHAR(4000) NOT NULL,
    fecha_nac DATE NOT NULL,
    correo VARCHAR(4000) NOT NULL,
    telefono INT NOT NULL,
    direccion VARCHAR(4000) NOT NULL,
    dpi INT NOT NULL,
    fecha_ins DATE NOT NULL DEFAULT CURRENT_DATE()
);

CREATE TABLE Estudiante (
    estudiante_id INT NOT NULL PRIMARY KEY,
    carrera_id INT NOT NULL,
    nombres VARCHAR(4000) NOT NULL,
    apellidos VARCHAR(4000) NOT NULL,
    fecha_nac DATE NOT NULL,
    correo VARCHAR(4000) NOT NULL,
    telefono INT NOT NULL,
    direccion VARCHAR(4000) NOT NULL,
    dpi INT NOT NULL,
    fecha_ins DATE NOT NULL DEFAULT CURRENT_DATE(),
    creditos INT NOT NULL DEFAULT 0,
    FOREIGN KEY (carrera_id) REFERENCES Carrera(carrera_id)
);

CREATE TABLE Curso (
    curso_id INT NOT NULL PRIMARY KEY,
    carrera_id INT NOT NULL,
    nombre VARCHAR(4000) NOT NULL,
    creditos_necesarios INT NOT NULL,
    creditos_otorga INT NOT NULL,
    obligatorio INT NOT NULL,
    FOREIGN KEY (carrera_id) REFERENCES Carrera(carrera_id)
);

CREATE TABLE CursoHabilitado (
    curso_hab_id INT AUTO_INCREMENT PRIMARY KEY,
    ciclo VARCHAR(4000) NOT NULL,
    curso_id INT NOT NULL,
    docente_id INT NOT NULL,
    seccion VARCHAR(4000) NOT NULL,
    cupo INT NOT NULL,
    anio INT NOT NULL DEFAULT YEAR(CURDATE()),
    num_asignados INT NOT NULL DEFAULT 0,
    FOREIGN KEY (curso_id) REFERENCES Curso(curso_id),
    FOREIGN KEY (docente_id) REFERENCES Docente(docente_id)
);

CREATE TABLE Horario (
    curso_hab_id INT NOT NULL,
    dia INT NOT NULL,
    horario VARCHAR(4000) NOT NULL,
    FOREIGN KEY (curso_hab_id) REFERENCES CursoHabilitado(curso_hab_id)
);

CREATE TABLE Acta (
    acta_id INT AUTO_INCREMENT PRIMARY KEY,
    acta_date DATE NOT NULL
);

CREATE TABLE Asignacion (
    curso_hab_id INT NOT NULL,
    estado INT NOT NULL DEFAULT 1,
    estudiante_id INT NOT NULL,
    acta_id INT,
    nota INT,
    FOREIGN KEY (acta_id) REFERENCES Acta(acta_id),
    FOREIGN KEY (curso_hab_id) REFERENCES CursoHabilitado(curso_hab_id),
    FOREIGN KEY (estudiante_id) REFERENCES Estudiante(estudiante_id)
);

CREATE TABLE HistorialTransaccion (
    fecha DATE NOT NULL DEFAULT CURRENT_DATE(),
    descripcion VARCHAR(4000) NOT NULL,
    tipo VARCHAR(4000) NOT NULL
);
