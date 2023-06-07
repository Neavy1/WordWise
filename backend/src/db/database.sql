CREATE DATABASE IF NOT EXISTS institucion_educativa;

USE institucion_educativa;

CREATE TABLE `institucion_educativa` (
  `id_institucion_educativa` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_institucion_educativa` varchar(100) NOT NULL,
  `fecha_fundacion` date NOT NULL,
  `fk_id_rector` int NOT NULL,
  `anio_vigente` int NOT NULL,
  `periodo_academico_vigente` int NOT NULL
);

CREATE TABLE `facultad` (
  `id_facultad` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_facultad` varchar(100) NOT NULL,
  `ubicacion` varchar(100),
  `fk_id_institucion_educativa` int NOT NULL,
  `fk_id_director_facultad` int NOT NULL
);

CREATE TABLE `departamento` (
  `id_departamento` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_departamento` varchar(100) NOT NULL,
  `fk_id_facultad` int NOT NULL,
  `fk_id_institucion_educativa` int NOT NULL,
  `fk_id_jefe_departamento` int NOT NULL
);

CREATE TABLE `rol` (
  `id_rol` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_rol` varchar(50) NOT NULL
);

CREATE TABLE `permiso` (
  `id_permiso` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_permiso` varchar(50) NOT NULL,
  `descripcion` varchar(100)
);

CREATE TABLE `sexo` (
  `id_sexo` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_sexo` varchar(50) NOT NULL
);

CREATE TABLE `estado_academico` (
  `id_estado_academico` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_estado_academico` varchar(50) NOT NULL
);

CREATE TABLE `direccion` (
  `id_direccion` int PRIMARY KEY,
  `direccion` varchar(100) NOT NULL,
  `barrio` varchar(100) NOT NULL,
  `ciudad` varchar(100) NOT NULL,
  `departamento` varchar(100) NOT NULL
);

CREATE TABLE `usuario` (
  `id_usuario` int PRIMARY KEY,
  `sexo` int NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `correo_electronico` varchar(100) UNIQUE NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `url_foto` varchar(100),
  `contrasena_salt` varchar(100) NOT NULL,
  `contrasena_hash` varchar(100) NOT NULL
);

CREATE TABLE `detalle_estudiante` (
  `id_estudiante` int PRIMARY KEY,
  `fk_id_estado_academico` int NOT NULL
);

CREATE TABLE `detalle_docente` (
  `id_docente` int PRIMARY KEY,
  `fk_id_departamento` int NOT NULL,
  `url_hoja_de_vida` varchar(100),
  `salario` int NOT NULL,
  `fk_id_tipo_contrato` int NOT NULL
);

CREATE TABLE `tipo_contrato` (
  `id_tipo_contrato` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_contrato` varchar(100) NOT NULL
);

CREATE TABLE `detalle_administrativo` (
  `id_administrativo` int PRIMARY KEY
);

CREATE TABLE `cargo_administrativo` (
  `id_cargo_administrativo` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_cargo_administrativo` varchar(100) NOT NULL,
  `descripcion_cargo_administrativo` varchar(100)
);

CREATE TABLE `periodo_academico` (
  `id_periodo_academico` int PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(50)
);

CREATE TABLE `anio_periodo_academico` (
  `id_anio_periodo_academico` int PRIMARY KEY AUTO_INCREMENT,
  `anio` int,
  `fk_id_periodo_academico` int NOT NULL,
  `fk_id_institucion_educativa` int NOT NULL,
  `fecha_matricula` date NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_final` date NOT NULL
);

CREATE TABLE `programa_academico` (
  `id_programa_academico` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_facultad` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `total_creditos` int NOT NULL,
  `fk_id_director` int NOT NULL
);

CREATE TABLE `asignatura` (
  `id_asignatura` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_departamento` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `num_creditos` int,
  `max_estudiantes` int NOT NULL,
  `curso_extension` boolean,
  `descripcion` varchar(255),
  `intensidad_horaria` int,
  `costo` int
);

CREATE TABLE `dia_semana` (
  `id_dia_semana` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_dia_semana` varchar(20) NOT NULL
);

CREATE TABLE `clase` (
  `id_clase` int PRIMARY KEY,
  `hora_inicio` int NOT NULL,
  `hora_final` int NOT NULL
);

CREATE TABLE `clase_dia` (
  `id_clase_dia` int PRIMARY KEY,
  `fk_id_dia_semana` int NOT NULL,
  `fk_id_clase` int NOT NULL
);

CREATE TABLE `ubicacion_clase` (
  `id_ubicacion_clase` int PRIMARY KEY,
  `id_edificio` int,
  `id_salon` int,
  `nombre` varchar(100),
  `descripcion` varchar(150)
);

CREATE TABLE `oferta_academica` (
  `id_oferta_academica` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_anio_periodo_academico` int NOT NULL,
  `fk_id_programa_academico` int NOT NULL
);

CREATE TABLE `matricula_academica` (
  `id_matricula_academica` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_oferta_academica` int NOT NULL,
  `fk_id_estudiante` int NOT NULL
);

CREATE TABLE `curso` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_oferta_academica` int NOT NULL,
  `fk_id_asignatura` int NOT NULL
);

CREATE TABLE `grupo` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_curso` int NOT NULL,
  `numero_grupo` int NOT NULL,
  `fk_id_docente_asignado` int NOT NULL
);

CREATE TABLE `horario_clase` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_grupo` int NOT NULL,
  `fk_id_clase_dia` int NOT NULL,
  `fk_id_ubicacion_clase` int NOT NULL
);

CREATE TABLE `historial_academico` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_grupo` int NOT NULL,
  `fk_id_estudiante` int NOT NULL,
  `nota_estudiante_curso` float
);

CREATE TABLE `nota_estudiante_asignatura_matriculada` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_matricula_academica` int NOT NULL,
  `fk_id_asignatura` int NOT NULL,
  `nota_final_estudiante_asignatura` int
);

CREATE TABLE `creditos_aprobados_estudiante_programa_academico` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_estudiante` int,
  `fk_id_programa_academico` int NOT NULL,
  `total_creditos_aprobados` int
);

CREATE TABLE `prerequisitos_asignatura` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_asignatura` int NOT NULL,
  `fk_id_asignatura_prerequisito` int NOT NULL
);

CREATE TABLE `rol_permiso` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_rol` int NOT NULL,
  `fk_id_permiso` int NOT NULL
);

CREATE TABLE `asignacion_roles` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_usuario` int NOT NULL,
  `fk_id_rol` int NOT NULL
);

CREATE TABLE `docente_asignatura` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_docente` int NOT NULL,
  `fk_id_asignatura` int NOT NULL
);

CREATE TABLE `pensum_programa_academico` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_programa_academico` int NOT NULL,
  `fk_id_asignatura` int NOT NULL
);

CREATE TABLE `detalle_administrativo_cargo_administrativo` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_administrativo` int NOT NULL,
  `fk_id_cargo_administrativo` int NOT NULL
);

-------------------------------------------------------- ÍNDICES --------------------------------------------------------
CREATE UNIQUE INDEX `anio_periodo_academico_index_0` ON `anio_periodo_academico` (`anio`, `fk_id_periodo_academico`);

CREATE UNIQUE INDEX `clase_index_1` ON `clase` (`hora_inicio`, `hora_final`);

CREATE UNIQUE INDEX `clase_dia_index_2` ON `clase_dia` (`fk_id_dia_semana`, `fk_id_clase`);

CREATE UNIQUE INDEX `oferta_academica_index_3` ON `oferta_academica` (`fk_id_anio_periodo_academico`, `fk_id_programa_academico`);

CREATE UNIQUE INDEX `matricula_academica_index_4` ON `matricula_academica` (`fk_id_oferta_academica`, `fk_id_estudiante`);

CREATE UNIQUE INDEX `curso_index_5` ON `curso` (`fk_id_oferta_academica`, `fk_id_asignatura`);

CREATE UNIQUE INDEX `grupo_index_6` ON `grupo` (`fk_id_curso`, `numero_grupo`);

CREATE UNIQUE INDEX `horario_clase_index_7` ON `horario_clase` (`fk_id_grupo`, `fk_id_clase_dia`);

CREATE UNIQUE INDEX `horario_clase_index_8` ON `horario_clase` (`fk_id_clase_dia`, `fk_id_ubicacion_clase`);

CREATE UNIQUE INDEX `historial_academico_index_9` ON `historial_academico` (`fk_id_grupo`, `fk_id_estudiante`);

CREATE UNIQUE INDEX `nota_estudiante_asignatura_matriculada_index_10` ON `nota_estudiante_asignatura_matriculada` (`fk_id_matricula_academica`, `fk_id_asignatura`);

CREATE UNIQUE INDEX `creditos_aprobados_estudiante_programa_academico_index_11` ON `creditos_aprobados_estudiante_programa_academico` (`fk_id_estudiante`, `fk_id_programa_academico`);

CREATE UNIQUE INDEX `prerequisitos_asignatura_index_12` ON `prerequisitos_asignatura` (`fk_id_asignatura`, `fk_id_asignatura_prerequisito`);

CREATE UNIQUE INDEX `rol_permiso_index_13` ON `rol_permiso` (`fk_id_rol`, `fk_id_permiso`);

CREATE UNIQUE INDEX `asignacion_roles_index_14` ON `asignacion_roles` (`fk_id_usuario`, `fk_id_rol`);

CREATE UNIQUE INDEX `docente_asignatura_index_15` ON `docente_asignatura` (`fk_id_docente`, `fk_id_asignatura`);

CREATE UNIQUE INDEX `pensum_programa_academico_index_16` ON `pensum_programa_academico` (`fk_id_programa_academico`, `fk_id_asignatura`);

CREATE UNIQUE INDEX `detalle_administrativo_cargo_administrativo_index_17` ON `detalle_administrativo_cargo_administrativo` (`fk_id_administrativo`, `fk_id_cargo_administrativo`);

-------------------------------------------------------- LLAVES FORÁNEAS --------------------------------------------------------

ALTER TABLE `institucion_educativa` ADD FOREIGN KEY (`fk_id_rector`) REFERENCES `detalle_administrativo` (`id_administrativo`);

ALTER TABLE `facultad` ADD FOREIGN KEY (`fk_id_institucion_educativa`) REFERENCES `institucion_educativa` (`id_institucion_educativa`);

ALTER TABLE `facultad` ADD FOREIGN KEY (`fk_id_director_facultad`) REFERENCES `detalle_administrativo` (`id_administrativo`);

ALTER TABLE `departamento` ADD FOREIGN KEY (`fk_id_facultad`) REFERENCES `facultad` (`id_facultad`);

ALTER TABLE `departamento` ADD FOREIGN KEY (`fk_id_institucion_educativa`) REFERENCES `institucion_educativa` (`id_institucion_educativa`);

ALTER TABLE `departamento` ADD FOREIGN KEY (`fk_id_jefe_departamento`) REFERENCES `detalle_administrativo` (`id_administrativo`);

ALTER TABLE `direccion` ADD FOREIGN KEY (`id_direccion`) REFERENCES `usuario` (`id_usuario`);

ALTER TABLE `usuario` ADD FOREIGN KEY (`sexo`) REFERENCES `sexo` (`id_sexo`);

ALTER TABLE `detalle_estudiante` ADD FOREIGN KEY (`id_estudiante`) REFERENCES `usuario` (`id_usuario`);

ALTER TABLE `detalle_estudiante` ADD FOREIGN KEY (`fk_id_estado_academico`) REFERENCES `estado_academico` (`id_estado_academico`);

ALTER TABLE `detalle_docente` ADD FOREIGN KEY (`id_docente`) REFERENCES `usuario` (`id_usuario`);

ALTER TABLE `detalle_docente` ADD FOREIGN KEY (`fk_id_departamento`) REFERENCES `departamento` (`id_departamento`);

ALTER TABLE `detalle_docente` ADD FOREIGN KEY (`fk_id_tipo_contrato`) REFERENCES `tipo_contrato` (`id_tipo_contrato`);

ALTER TABLE `detalle_administrativo` ADD FOREIGN KEY (`id_administrativo`) REFERENCES `usuario` (`id_usuario`);

ALTER TABLE `anio_periodo_academico` ADD FOREIGN KEY (`fk_id_periodo_academico`) REFERENCES `periodo_academico` (`id_periodo_academico`);

ALTER TABLE `anio_periodo_academico` ADD FOREIGN KEY (`fk_id_institucion_educativa`) REFERENCES `institucion_educativa` (`id_institucion_educativa`);

ALTER TABLE `programa_academico` ADD FOREIGN KEY (`fk_id_facultad`) REFERENCES `facultad` (`id_facultad`);

ALTER TABLE `programa_academico` ADD FOREIGN KEY (`fk_id_director`) REFERENCES `detalle_administrativo` (`id_administrativo`);

ALTER TABLE `asignatura` ADD FOREIGN KEY (`fk_id_departamento`) REFERENCES `departamento` (`id_departamento`);

ALTER TABLE `clase_dia` ADD FOREIGN KEY (`fk_id_dia_semana`) REFERENCES `dia_semana` (`id_dia_semana`);

ALTER TABLE `clase_dia` ADD FOREIGN KEY (`fk_id_clase`) REFERENCES `dia_semana` (`id_dia_semana`);

ALTER TABLE `oferta_academica` ADD FOREIGN KEY (`fk_id_anio_periodo_academico`) REFERENCES `anio_periodo_academico` (`id_anio_periodo_academico`);

ALTER TABLE `oferta_academica` ADD FOREIGN KEY (`fk_id_programa_academico`) REFERENCES `programa_academico` (`id_programa_academico`);

ALTER TABLE `matricula_academica` ADD FOREIGN KEY (`fk_id_oferta_academica`) REFERENCES `oferta_academica` (`id_oferta_academica`);

ALTER TABLE `matricula_academica` ADD FOREIGN KEY (`fk_id_estudiante`) REFERENCES `detalle_estudiante` (`id_estudiante`);

ALTER TABLE `curso` ADD FOREIGN KEY (`fk_id_oferta_academica`) REFERENCES `oferta_academica` (`id_oferta_academica`);

ALTER TABLE `curso` ADD FOREIGN KEY (`fk_id_asignatura`) REFERENCES `asignatura` (`id_asignatura`);

ALTER TABLE `grupo` ADD FOREIGN KEY (`fk_id_curso`) REFERENCES `curso` (`id`);

ALTER TABLE `grupo` ADD FOREIGN KEY (`fk_id_docente_asignado`) REFERENCES `detalle_docente` (`id_docente`);

ALTER TABLE `horario_clase` ADD FOREIGN KEY (`fk_id_grupo`) REFERENCES `grupo` (`id`);

ALTER TABLE `horario_clase` ADD FOREIGN KEY (`fk_id_clase_dia`) REFERENCES `clase_dia` (`id_clase_dia`);

ALTER TABLE `horario_clase` ADD FOREIGN KEY (`fk_id_ubicacion_clase`) REFERENCES `ubicacion_clase` (`id_ubicacion_clase`);

ALTER TABLE `historial_academico` ADD FOREIGN KEY (`fk_id_grupo`) REFERENCES `grupo` (`id`);

ALTER TABLE `historial_academico` ADD FOREIGN KEY (`fk_id_estudiante`) REFERENCES `detalle_estudiante` (`id_estudiante`);

ALTER TABLE `nota_estudiante_asignatura_matriculada` ADD FOREIGN KEY (`fk_id_matricula_academica`) REFERENCES `matricula_academica` (`id_matricula_academica`);

ALTER TABLE `nota_estudiante_asignatura_matriculada` ADD FOREIGN KEY (`fk_id_asignatura`) REFERENCES `asignatura` (`id_asignatura`);

ALTER TABLE `creditos_aprobados_estudiante_programa_academico` ADD FOREIGN KEY (`fk_id_estudiante`) REFERENCES `detalle_estudiante` (`id_estudiante`);

ALTER TABLE `creditos_aprobados_estudiante_programa_academico` ADD FOREIGN KEY (`fk_id_programa_academico`) REFERENCES `programa_academico` (`id_programa_academico`);

ALTER TABLE `prerequisitos_asignatura` ADD FOREIGN KEY (`fk_id_asignatura`) REFERENCES `asignatura` (`id_asignatura`);

ALTER TABLE `prerequisitos_asignatura` ADD FOREIGN KEY (`fk_id_asignatura_prerequisito`) REFERENCES `asignatura` (`id_asignatura`);

ALTER TABLE `rol_permiso` ADD FOREIGN KEY (`fk_id_rol`) REFERENCES `rol` (`id_rol`);

ALTER TABLE `rol_permiso` ADD FOREIGN KEY (`fk_id_permiso`) REFERENCES `permiso` (`id_permiso`);

ALTER TABLE `asignacion_roles` ADD FOREIGN KEY (`fk_id_usuario`) REFERENCES `usuario` (`id_usuario`);

ALTER TABLE `asignacion_roles` ADD FOREIGN KEY (`fk_id_rol`) REFERENCES `rol` (`id_rol`);

ALTER TABLE `docente_asignatura` ADD FOREIGN KEY (`fk_id_docente`) REFERENCES `detalle_docente` (`id_docente`);

ALTER TABLE `docente_asignatura` ADD FOREIGN KEY (`fk_id_asignatura`) REFERENCES `asignatura` (`id_asignatura`);

ALTER TABLE `pensum_programa_academico` ADD FOREIGN KEY (`fk_id_programa_academico`) REFERENCES `programa_academico` (`id_programa_academico`);

ALTER TABLE `pensum_programa_academico` ADD FOREIGN KEY (`fk_id_asignatura`) REFERENCES `asignatura` (`id_asignatura`);

ALTER TABLE `detalle_administrativo_cargo_administrativo` ADD FOREIGN KEY (`fk_id_administrativo`) REFERENCES `detalle_administrativo` (`id_administrativo`);

ALTER TABLE `detalle_administrativo_cargo_administrativo` ADD FOREIGN KEY (`fk_id_cargo_administrativo`) REFERENCES `cargo_administrativo` (`id_cargo_administrativo`);

-------------------------------------------------------- TRIGGERS --------------------------------------------------------

-- 1. validar que un estudiante no pueda matricular una asignatura que ya aprobó en la tabla nota_estudiante_asignatura_matriculada
DELIMITER $$
CREATE TRIGGER validar_asignatura_abrobada
BEFORE INSERT ON nota_estudiante_asignatura_matriculada
FOR EACH ROW
BEGIN
  DECLARE nota_existente FLOAT;
  -- Obtener la nota final de la asignatura para el estudiante actual
  SELECT nota_final_estudiante_asignatura INTO nota_existente
  FROM nota_estudiante_asignatura_matriculada
  WHERE fk_id_matricula_academica = NEW.fk_id_matricula_academica
    AND fk_id_asignatura = NEW.fk_id_asignatura
    AND nota_final_estudiante_asignatura >= 3.0
  LIMIT 1;
  -- Verificar si el estudiante ya ha aprobado la asignatura
  IF nota_existente IS NOT NULL THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'El estudiante ya ha aprobado la asignatura';
  END IF;
END$$
DELIMITER ; 

-------------------------------------------------------- CONSULTAS --------------------------------------------------------

----------------------------------------------------- NO REVISADAS PERO NI PROBADAS -----------------------------------------------------

-- Obtener información la información de un grupo de clase: la asigatura que se dicta, el número de créditos y su horario
SELECT asignatura.nombre, asignatura.num_creditos, clase.hora_inicio, clase.hora_final, dia_semana.nombre_dia_semana
FROM asignatura 
INNER JOIN curso ON asignatura.id_asignatura = curso.fk_id_asignatura
INNER JOIN grupo ON curso.id = grupo.fk_id_curso
INNER JOIN horario_clase ON grupo.id = horario_clase.fk_id_grupo
INNER JOIN clase_dia ON horario_clase.fk_id_clase_dia = clase_dia.id_clase_dia
INNER JOIN clase ON clase_dia.fk_id_clase=clase.id_clase 
INNER JOIN dia_semana ON clase_dia.fk_id_dia_semana=dia_semana.id_dia_semana

-- Obtener información curso de extensión en detalle 
SELECT asignatura.nombre, asignatura.num_creditos, asignatura.max_estudiantes, prerequisitos_asignatura.fk_id_asignatura_prerequisito,
       clase.hora_inicio, clase.hora_final, dia_semana.nombre_dia_semana, usuario.nombres AS nombre_docente, usuario.apellidos AS apellidos_docente,
       ubicacion_clase.id_edificio, ubicacion_clase.id_salon
FROM asignatura 
INNER JOIN curso ON asignatura.id_asignatura = curso.fk_id_asignatura
INNER JOIN grupo ON curso.id = grupo.fk_id_curso
INNER JOIN horario_clase ON grupo.id = horario_clase.fk_id_grupo
INNER JOIN clase_dia ON horario_clase.fk_id_clase_dia = clase_dia.id_clase_dia
INNER JOIN clase ON clase_dia.fk_id_clase=clase.id_clase 
INNER JOIN dia_semana ON clase_dia.fk_id_dia_semana=dia_semana.id_dia_semana 
INNER JOIN usuario ON grupo.fk_id_docente_asignado=usuario.id_usuario
INNER JOIN prerequisitos_asignatura ON asignatura.id_asignatura = prerequisitos_asignatura.fk_id_asignatura_prerequisito
INNER JOIN ubicacion_clase ON horario_clase.fk_id_ubicacion_clase = ubicacion_clase.id_ubicacion_clase
WHERE asignatura.nombre = "Laboratorio de Software";

    --Para obtener el nombre de la asignatura prerrequisito
    SELECT asignatura.nombre
    FROM asignatura 
    INNER JOIN prerequisitos_asignatura ON asignatura.id_asignatura = prerequisitos_asignatura.fk_id_asignatura_prerequisito
    WHERE prerequisitos_asignatura.fk_id_asignatura_prerequisito = "IS673"


-- Log in, no sé cual de los campos de contrasena se debe utilizar :°D (pero creo que se entiende la idea)
SELECT usuario.id_usuario, usuario.contrasena, asignacion_roles.fk_id_rol, usuario.nombres, usuario.apellidos
FROM usuario 
INNER JOIN asignacion_roles ON usuario.id_usuario=asignacion_roles.fk_id_usuario
WHERE usuario.id_usuario = '123456789' AND usuario.contrasena = 'contrasena123'; 

-- Ver informacion personal 
SELECT  usuario.sexo, usuario.nombres, usuario.apellidos, usuario.correo_electronico, usuario.telefono, usuario.contrasena_salt,
        direccion.direccion, direccion.barrio, direccion.ciudad, direccion.departamento
FROM usuario 
INNER JOIN direccion ON usuario.id_usuario=direccion.id_direccion
WHERE usuario.id_usuario="12345";
           
-- Ver información laboral
SELECT detalle_docente.url_hoja_de_vida, detalle_docente.salario, tipo_contrato.nombre_contrato, departamento.nombre_departamento
FROM detalle_docente 
INNER JOIN tipo_contrato ON detalle_docente.fk_id_tipo_contrato = tipo_contrato.id_tipo_contrato
INNER JOIN departamento ON detalle_docente.fk_id_departamento = departamento.nombre_departamento
WHERE detalle_docente.id_docente ="12345";


  -- Insertar tipo contrato (si sabe bien cuales son se pueden agregar)
    INSERT INTO tipo_contrato (id_tipo_contrato, nombre_contrato)
    VALUES ('1', 'Planta'), ('2', 'Transitorio'), ('3', 'Catedratico');


-- Ver información académica (créditos disponibles es un valor estático en la UTP son como 27 creditos por semestre)
-- Nota: no sé como poner la ubicación semestral
SELECT estado_academico.nombre_estado_academico, programa_academico.nombre AS programa_academico, SUM(asignatura.num_creditos) AS creditos_matriculados
FROM detalle_estudiante 
INNER JOIN estado_academico ON detalle_estudiante.fk_id_estado_academico = estado_academico.id_estado_academico
INNER JOIN matricula_academica ON matricula_academica.fk_id_estudiante = detalle_estudiante.id_estudiante
INNER JOIN oferta_academica ON oferta_academica.id_oferta_academica = matricula_academica.fk_id_oferta_academica
INNER JOIN programa_academico ON programa_academico.id_programa_academico = oferta_academica.fk_id_programa_academico
INNER JOIN curso ON oferta_academica.id_oferta_academica = curso.fk_id_oferta_academica
INNER JOIN asignatura ON curso.fk_id_asignatura = asignatura.id_asignatura
WHERE detalle_estudiante.id_estudiante = "12345"

    -- Insertar estado academico (si sabe bien cuales son se pueden agregar)
    INSERT INTO estado_academico (id_estado_academico, nombre_estado_academico)
    VALUES ('1', 'Activo'), ('2', 'Inactivo');

-- Editar perfil (Para la direccion tendría que poner en el formulario los campos necesarios)
UPDATE usuarios SET telefono = '555-4321' WHERE documento_identidad = '123456789';
UPDATE direccion SET direccion = 'Carrera 1 Calle 2-3' WHERE id_direccion = '123456789';

-- Registrar informacion personal y de usuario de nuevo usuario (suponiendo que id_rol 1 equivale a Administrativo)
INSERT INTO direccion(id_direccion, direccion, barrio, ciudad, departamento)
VALUES ('123456789', 'Carrera 1 Calle 2-3', 'Un barrio','Pereira', 'Risaralda');

INSERT INTO usuario (id_usuario, sexo, nombres, apellidos, correo_electronico, telefono, contrasena_salt, contrasena.hash)
VALUES ('123456789', '1', 'Juan','Perez', 'juanperez@institucion.edu.co', '555-1234', '123', 'contrasena123','ef4536abcd689');

INSERT INTO asignacion_roles(id, fk_id_usuario, fk_id_rol)
VALUES (NULL, '123456789', '1');

-- Registrar informacion laboral de nuevo usuario
INSERT INTO detalle_docente (id_docente, fk_id_departamento, url_hoja_de_vida, salario. fk_id_tipo_contrato)
VALUES ('987654321', '1', 'Www.unaurl.com', '5 000 000', '3');

-- Registrar informacion academica de nuevo usuario 
INSERT INTO detalle_estudiante(id_estudiante, fk_id_estado_academico)
VALUES ('123456789', '1');

INSERT INTO (id_matricula_academica, fk_id_oferta_academica, fk_id_estudiante)
VALUES (NULL, '1','123456789');

-- Ver información de docentes y estudiantes desde Rol administrativo (suponiendo id_rol: 2-Docente y 3-Estudiante)

    --Por documento de identidad
    SELECT usuario.id_usuario, usuario.nombres, usuario.apellidos 
    FROM usuario
    INNER JOIN asignacion_roles ON usuario.id_usuario = asignacion_roles.fk_id_usuario
    WHERE asignacion_roles.fk_id_usuario = '2' AND usuario.id_usuario LIKE "123%"
    ORDER BY usuario.id_usuario ASC;

    --Por Apellidos
    SELECT usuario.id_usuario, usuario.nombres, usuario.apellidos 
    FROM usuario
    INNER JOIN asignacion_roles ON usuario.id_usuario = asignacion_roles.fk_id_usuario
    WHERE asignacion_roles.fk_id_usuario = '3' AND usuario.apellidos LIKE "Pe%"
    ORDER BY usuario.apellidos ASC;

--Editar información laboral docentes desde Rol Administrativo (2 = Transitorio)
UPDATE detalle_docente SET fk_id_tipo_contrato = '2' WHERE id_docente = '987654321';

-- Facultad
INSERT INTO facultad (id_facultad, nombre_facultad, ubicacion, fk_id_institucion_educativa, fk_id_director_facultad)
VALUES ('1', 'Facultad de ingenierías','Edificio 3', '1', '1');

-- Programa academico
INSERT INTO programa_academico (id_programa_academico, fk_id_facultad, nombre, total_creditos, fk_id_director)
VALUES ('1', '1','Ingenieria de Sistemas', 183, '1');

-- Periodo academico 
INSERT INTO periodo_academico (id_periodo_academico, nombre, descripcion)
VALUES ('1', 'Semestre 1','Blah blah blah');

-- anio periodo academico 
INSERT INTO periodo_academico (id_anio_periodo_academico,anio, fk_id_periodo_academico, fk_id_institucion_educativa, fecha_matricula, fecha_inicio, fecha_final)
VALUES ('1', '2023', '1', '1', '24-01-2023', '06-02-2023','16-06-2023', 'Blah blah blah');

-- Periodo academico 
INSERT INTO periodo_academico (id_periodo_academico, nombre, descripcion)
VALUES ('1', 'Semestre 1','Blah blah blah');

-- Crear asignatura (Los id de asignatura los puse así (y no como int) por que es mas facil de visualizar)
    --Información de asignatura (intensidad horaria puede ser 4 horas semanales)
    INSERT INTO asignatura (id_asignatura, fk_id_departamento, nombre, num_creditos, max_estudiantes)
    VALUES ('IS873','1', 'Laboratorio de software','3', 36);

    INSERT INTO pensum_programa_academico (id, fk_id_programa_academico, fk_id_asignatura)
    VALUES (NULL,'1', 'IS873',);

    INSERT INTO prerequisitos_asignatura (id, fk_id_asignatura, fk_id_asignatura_prerequisito)
    VALUES (NULL,'IS873', 'IS714',);


    --Información de grupo o de clase (Suponiendo que este es el curso 1)
    INSERT INTO curso (id, fk_id_oferta_academica, fk_id_asignatura)
    VALUES (NULL, '1', 'IS873');

    INSERT INTO grupo (id, fk_id_curso, numero_grupo, id_docente_asignado)
    VALUES ('1', '1', '987654321');

    INSERT INTO clase (id_clase, hora_inicio, hora_final)
    VALUES ('11', '2', '4');

    INSERT INTO clase_dia (id_clase_dia, fk_id_dia_semana, fk_id_clase)
    VALUES ('111', '2', '11');

    INSERT INTO horario_clase (id, fk_id_grupo, fk_id_clase_dia, fk_id_ubicacion_clase)
    VALUES (NULL, '1', '111', '1');

    --Ubicación clase no está atado a una clase, simplemente estan los salones de clase
    INSERT INTO clase_dia (id_ubicacion_clase, id_edificio, id_salon, nombre, descripcion)
    VALUES ('1', '3', '201','Edificio 3', 'Salon maximo 30 estudiantes');

-- Ver asignatura desde rol administrativo (Cuando se busca, la informacion es resumida)
  --Por Codigo (en el docente no inclute asignatura.programa_academico)
    SELECT asignatura.id_asignatura, asignatura.nombre, programa_academico.nombre AS programa_academico
    FROM asignatura 
    INNER JOIN pensum_programa_academico ON asignatura.id_asignatura = pensum_programa_academico.fk_id_asignatura
    INNER JOIN programa_academico ON pensum_programa_academico.fk_id_programa_academico = programa_academico.id_programa_academico
    WHERE asignatura.id_asignatura LIKE "IS8%"
    ORDER BY asignatura.id_asignatura ASC;

  --Por Nombre
    SELECT asignatura.id_asignatura, asignatura.nombre, programa_academico.nombre AS programa_academico
    FROM asignatura 
    INNER JOIN pensum_programa_academico ON asignatura.id_asignatura = pensum_programa_academico.fk_id_asignatura
    INNER JOIN programa_academico ON pensum_programa_academico.fk_id_programa_academico = programa_academico.id_programa_academico
    WHERE asignatura.nombre LIKE "Labora%"
    ORDER BY asignatura.nombre ASC;

-- Ver información de asignatura en detalle
SELECT asignatura.nombre, asignatura.num_creditos, asignatura.max_estudiantes, prerequisitos_asignatura.fk_id_asignatura_prerequisito,
       clase.hora_inicio, clase.hora_final, dia_semana.nombre_dia_semana, usuario.nombres AS nombre_docente, usuario.apellidos AS apellidos_docente,
       ubicacion_clase.id_edificio, ubicacion_clase.id_salon
FROM asignatura 
INNER JOIN curso ON asignatura.id_asignatura = curso.fk_id_asignatura
INNER JOIN grupo ON curso.id = grupo.fk_id_curso
INNER JOIN horario_clase ON grupo.id = horario_clase.fk_id_grupo
INNER JOIN clase_dia ON horario_clase.fk_id_clase_dia = clase_dia.id_clase_dia
INNER JOIN clase ON clase_dia.fk_id_clase=clase.id_clase 
INNER JOIN dia_semana ON clase_dia.fk_id_dia_semana=dia_semana.id_dia_semana 
INNER JOIN usuario ON grupo.fk_id_docente_asignado=usuario.id_usuario
INNER JOIN prerequisitos_asignatura ON asignatura.id_asignatura = prerequisitos_asignatura.fk_id_asignatura_prerequisito
INNER JOIN ubicacion_clase ON horario_clase.fk_id_ubicacion_clase = ubicacion_clase.id_ubicacion_clase
WHERE asignatura.nombre = "Laboratorio de Software";

--Para obtener el nombre de la asignatura prerrequisito
    SELECT asignatura.nombre
    FROM asignatura 
    INNER JOIN prerequisitos_asignatura ON asignatura.id_asignatura = prerequisitos_asignatura.fk_id_asignatura_prerequisito
    WHERE prerequisitos_asignatura.fk_id_asignatura_prerequisito = "IS673"

-- Ver asignatura de mi programa academico (Se debe conocer el programa academico)
SELECT asignatura.id_asignatura, asignatura.nombre, pensum_programa_academico.fk_id_programa_academico
FROM asignatura 
INNER JOIN pensum_programa_academico ON asignatura.id_asignatura = pensum_programa_academico.fk_id_asignatura
WHERE pensum_programa_academico.fk_id_programa_academico = '1'

-- Ver mis asignaturas docente
SELECT asignatura.id_asignatura, asignatura.nombre, asignatura.num_creditos, grupo.numero_grupo, grupo.id_docente_asignado
FROM asignatura 
INNER JOIN curso ON asignatura.id_asignatura = curso.fk_id_asignatura
INNER JOIN grupo ON grupo.fk_id_curso = curso.id
WHERE grupo.id_docente_asignado = "987654321";

-- Ver mis asignaturas estudiante
SELECT asignatura.id_asignatura, asignatura.nombre, asignatura.num_creditos
FROM historial_academico
INNER JOIN grupo ON historial_academico.fk_id_grupo = grupo.id
INNER JOIN curso ON grupo.fk_id_curso = curso.id
INNER JOIN asignatura ON asignatura.id_asignatura = curso.fk_id_asignatura
WHERE historial_academico.fk_id_estudiante = "123456789";


-- Ver información de MIS estudiantes (Vista docente)
SELECT usuario.id_usuario, usuario.nombres, usuario.apellidos, usuario.correo_electronico, usuario.telefono
FROM usuario
INNER JOIN historial_academico ON usuario.id_usuario = fk_id_estudiante
INNER JOIN grupo ON grupo.id = historial_academico.fk_id_grupo
WHERE grupo.id_docente_asignado = "987654321";


-- Consulta para obtener el horario
  -- NO ESTOY TAN SEGURA SI DEBE SER ID_EDIFICIO, ID_SALON O SIMPLEMENTE NOMBRE 
    -- Horario docente
      SELECT asignatura.id_asignatura, asignatura.nombre, grupo.numero_grupo AS grupo, 
      clase.hora_inicio, clase.hora_final, dia_semana.nombre_dia_semana AS dia, ubicacion_clase.id_edificio,
      ubicacion_clase.id_salon, usuario.nombres AS nombres_docente, usuario.apellidos AS apellidos_docente
      FROM asignatura 
      INNER JOIN curso ON asignatura.id_asignatura = curso.fk_id_asignatura
      INNER JOIN grupo ON grupo.fk_id_curso = curso.id
      INNER JOIN horario_clase ON horario_clase.fk_id_grupo = grupo.id
      INNER JOIN clase_dia ON clase_dia.id_clase_dia = horario_clase.fk_id_clase_dia
      INNER JOIN clase ON clase.id_clase = clase_dia.fk_id_clase
      INNER JOIN ubicacion_clase ON ubicacion_clase.id_ubicacion_clase = horario_clase.fk_id_ubicacion_clase  
      INNER join dia_semana ON dia_semana.id_dia_semana = clase_dia.fk_id_dia_semana
      INNER JOIN usuario ON usuario.id_usuario = grupo.id_docente_asignado
      WHERE grupo.id_docente_asignado = "12345";

    -- Horario estudiante (Falta hacer mas pruebas)
      SELECT asignatura.id_asignatura, asignatura.nombre, grupo.numero_grupo AS grupo, 
      clase.hora_inicio, clase.hora_final, dia_semana.nombre_dia_semana AS dia, ubicacion_clase.id_edificio,
      ubicacion_clase.id_salon, usuario.nombres AS nombres_docente, usuario.apellidos AS apellidos_docente
      FROM asignatura 
      INNER JOIN curso ON asignatura.id_asignatura = curso.fk_id_asignatura
      INNER JOIN grupo ON grupo.fk_id_curso = curso.id
      INNER JOIN historial_academico ON historial_academico.fk_id_grupo = grupo.id
      INNER JOIN horario_clase ON horario_clase.fk_id_grupo = grupo.id
      INNER JOIN clase_dia ON clase_dia.id_clase_dia = horario_clase.fk_id_clase_dia
      INNER JOIN clase ON clase.id_clase = clase_dia.fk_id_clase
      INNER JOIN ubicacion_clase ON ubicacion_clase.id_ubicacion_clase = horario_clase.fk_id_ubicacion_clase  
      INNER join dia_semana ON dia_semana.id_dia_semana = clase_dia.fk_id_dia_semana
      INNER JOIN usuario ON usuario.id_usuario = grupo.id_docente_asignado
      WHERE historial_academico.fk_id_estudiante = "123456789";

-- Crear curso de extension (se usa la tabla de asignaturas)
    -- Lo unico que cambia es que en num_creditos guardará costo, no tendria prerrequisitos


-- Ver curso de extension desde rol administrativo (Cuando se busca, la informacion es resumida)
  --Por Codigo (en el docente no inclute asignatura.programa_academico)
    SELECT asignatura.id_asignatura, asignatura.nombre, asignatura.num_creditos
    FROM asignatura 
    WHERE asignatura.id_asignatura LIKE "IS8%"
    ORDER BY id_asignatura ASC;

  --Por Nombre
    SELECT asignatura.id_asignatura, asignatura.nombre, asignatura.num_creditos
    FROM asignatura 
    WHERE asignatura.nombre LIKE "Labora%"
    ORDER BY nombre ASC;

-- Gestionar notas desde rol docente 
SELECT asignatura.id_asignatura, asignatura.nombre, grupo.numero_grupo, grupo.id_docente_asignado
FROM asignatura 
INNER JOIN curso ON asignatura.id_asignatura = curso.fk_id_asignatura
INNER JOIN grupo ON grupo.fk_id_curso = curso.id
WHERE grupo.id_docente_asignado = "987654321";

-------------------------------------------------------- REVISADAS Y PROBADAS --------------------------------------------------------



-------------------------------------------------------- PENDIENTES --------------------------------------------------------
--0. Eliminar tabla curso y pasar sus datos a la tabla grupo
--1. Módulo de notas detallado y personalizable en cuanto a porcentajes
--2. Consulta que retorne el promedio de un estudiante en un programa academico en un periodo académico
--3. Consulta que retorne el promedio global de un estudiante en un programa academico
--4. Habilitaciones 
--5. Cancelaciones 
--6. Validar que el jefe de departamento y facultad solo dirija una cosa a la vez 
--7. Validar que el rector no pueda dirigir facultades ni departamentos 
--8. trigger para llenar los horarios de la tabla clase
--9. Historial académico completo del estudiante
--10. Añadir el anio_periodo_academico en la tabla docente_asignatura


//! REQUERIMIENTOS DE BASE DE DATOS

/*//! Landing page
//*Lista de programas académicos, malla curricular de cada programa, asignaturas cursos de extensión y detalles de cada uno, lista de profesores con sus fotos de perfil:
//? 1. Lista de programas académicos() => TODO de tabla programa_academico
SELECT * FROM programa_academico;
//? 2. Malla curricular de cada programa(id_programa_academico) => todos los id_asignatura de tabla pensum_programa_academico
SELECT p.id_programa_academico, pa.fk_id_asignatura
FROM programa_academico p
INNER JOIN pensum_programa_academico pa ON p.id_programa_academico = pa.fk_id_programa_academico;

//? 3. Signaturas cursos de extensión + detalle() => TODO de tabla asignatura where asigatura.curso_extension == true
SELECT a.*, d.*
FROM asignatura a
INNER JOIN detalle d ON a.id_asignatura = d.fk_id_asignatura
WHERE a.curso_extension = true;

//? 4. Lista de profesores + detalle() => todos los id_usuario de tabla asignacion_roles where rol == 2 => lista docentes
SELECT * FROM Usuario AS usuario
LEFT JOIN asignacion_roles AS asignacion
ON asignacion.id_usuario = usuario.id_usuario
LEFT JOIN rol AS rol
ON rol.id_rol = asignacion.id_rol
WHERE rol.nombre_rol = 2
//? 5. Lista de profesores + detalle(lista docentes) => todos los (nombres, apellidos, url_foto) de tabla usuario
SELECT nombres, apellidos, url_foto FROM Usuario
LEFT JOIN detalle_docente
ON id_usuario = id_docente
//? 6. Lista de profesores + detalle(lista docentes) => todos los (id_docente, fk_id_departamento) de tabla detalle_docente
SELECT id_docente, fk_id_departamento FROM detalle_docente

//! LOGIN
//*Con el número de cédula y el rol (dado por el endpoint desde donde intenta acceder), consultar si el usuario existe, y si tiene ese rol asignado en la tabla asignacion_roles. Si es así, retornar el hash, la salt y validar la contraseña en el back.
//? 1. Login(id_usuario, id_rol) => en la tabla asignacion_roles if(registroX.id_usuario == id_usuario and registroX.id_rol == id_rol) => de la tabla usuario retornar contrasena_salt y contrasena_hash del id_usuario
SELECT contrasena_salt, contrasena_hash
FROM usuario
INNER JOIN asignacion_roles ON usuario.id_usuario = asignacion_roles.id_usuario
WHERE asignacion_roles.id_usuario = 'valor_id_usuario'
AND asignacion_roles.id_rol = 'valor_id_rol'
//! PORTAL ADMINISTRATIVO
//*CREATE y UPDATE tablas: (id) => CREATE o UPDATE en tabla: usuario, asignatura, prerequisitos_asignatura, curso, grupo, horario_clase, docente_asignatura, matricula_academica
//? 1.1. CREAR usuario(TODOS los datos del usuario) => crear en tabla usuario
INSERT INTO usuario (id_usuario, sexo, nombres, apellidos, correo_electronico, telefono, contrasena_salt, contrasena_hash)
VALUES (1, 1, 'John', 'Doe', 'johndoe@example.com', '123456789', 'salt123', 'hash123')
		(1115090873,1,'Jose','Salazar','neabyop@gmail.com','123456789', 'salt123', 'hash123'),
		(2,2,'Juan Sebastian' , 'Florez' , 'sebastianflorez3@gmail.com','123456789', 'salt123', 'hash123');

    INSERT INTO direccion (id_direccion, direccion, barrio, ciudad, departamento)
VALUES (1, 'Calle Principal 123', 'Centro', 'Ciudad Principal', 'Departamento Principal'),

INSERT INTO asignacion_roles (fk_id_usuario, fk_id_rol)
VALUES (1, (SELECT id_rol FROM rol WHERE nombre_rol = 'administrativo'));

//? 1.2. CREAR detalle_estudiante(TODOS los detalles del usuario + id_rol) => crear en tabla detalle_estudiante
INSERT INTO detalle_estudiante (id_estudiante, fk_id_estado_academico)
VALUES (2, 1);  
//? 1.3. CREAR detalle_docente(TODOS los detalles del usuario + id_rol) => crear en tabla detalle_docente
INSERT INTO detalle_docente (id_docente, fk_id_departamento, url_hoja_de_vida, salario, fk_id_tipo_contrato)
VALUES (3, 2, '<url_hoja_de_vida>', 10000, 1);
//? 2.3. CREAR detalle_administrativo(TODOS los detalles del usuario + id_rol) => crear en tabla detalle_administrativo
INSERT INTO `detalle_administrativo` (`id_administrativo`)
VALUES
  (1);
  
INSERT INTO `detalle_administrativo_cargo_administrativo` (`nombre_cargo_administrativo),(descripcion_cargo_administrativo);
//? 2.1. UPDATE usuario(TODOS los datos del usuario) => crear en tabla usuario
INSERT INTO usuario (id_usuario, sexo, nombres, apellidos, correo_electronico, telefono, contrasena_salt, contrasena_hash)
VALUES (1, 1, 'John', 'Doe', 'johndoe@example.com', '123456789', 'salt123', 'hash123')
		(1115090873,1,'Jose','Salazar','neabyop@gmail.com','123456789', 'salt123', 'hash123'),
		(2,2,'Juan Sebastian' , 'Florez' , 'sebastianflorez3@gmail.com','123456789', 'salt123', 'hash123');
VALUES (2, 1);  
//? 2.2. UPDATE detalle_estudiante(TODOS los detalles del usuario + id_rol) => crear en tabla detalle_estudiante
UPDATE usuario
SET sexo = 1,
    nombres = 'Juan Sebastian',
    apellidos = 'Florez',
    correo_electronico = 'sebastianflorez3@gmail.com',
    telefono = '123456789',
    contrasena_salt = 'salt123',
    contrasena_hash = 'hash123'
WHERE id_usuario = 2;
//? 2.3. UPDATE detalle_docente(TODOS los detalles del usuario + id_rol) => crear en tabla detalle_docente
UPDATE detalle_docente
SET fk_id_departamento = 2,
    url_hoja_de_vida = '<url_hoja_de_vida>',
    salario = 10000,
    fk_id_tipo_contrato = 1
WHERE id_docente = 3;

//? 2.3. UPDATE detalle_administrativo(TODOS los detalles del usuario + id_rol) => crear en tabla detalle_administrativo
UPDATE detalle_administrativo
SET id_administrativo = 1
WHERE <condición_de_actualización>;

-- 3.1. SELECT usuario(id_usuario) HECHO: (portal docente 2.2)

-- 3.2. SELECT detalle_usuario(id_usuario) HECHO: (portal docente 2.2)

-- 4. Cambiar contraseña HECHA: Portal docente: 7

//? 5. Total de estudiantes matriculados en un periodo académico en TODA la institución educativa(anio, id_periodo_academico)
SELECT COUNT(DISTINCT m.fk_id_estudiante) AS total_estudiantes
FROM matricula_academica AS m
INNER JOIN oferta_academica AS oa ON m.fk_id_oferta_academica = oa.id_oferta_academica
WHERE oa.fk_id_anio_periodo_academico = (
    SELECT id_anio_periodo_academico
    FROM anio_periodo_academico
    WHERE anio = <anio> AND id_periodo_academico = <id_periodo_academico>
  )

//? 6. Total de estudiantes matriculados en un periodo académico en un programa académico(anio, id_periodo_academico, id_programa_academico)
SELECT COUNT(DISTINCT m.fk_id_estudiante) AS total_estudiantes
FROM matricula_academica AS m
INNER JOIN oferta_academica AS oa ON m.fk_id_oferta_academica = oa.id_oferta_academica
INNER JOIN anio_periodo_academico AS ap ON oa.fk_id_anio_periodo_academico = ap.id_anio_periodo_academico
WHERE ap.anio = <anio> AND ap.id_periodo_academico = <id_periodo_academico> AND oa.fk_id_programa_academico = <id_programa_academico>; 

//! PORTAL DOCENTE
//*Ver lista de grupos con la asignatura de cada grupo (docente_asignatura), ver los horarios de todos los cursos, ver los estudiantes, el grupo al que pertenecen y sus notas, agregar y editar notas (historial_academico), información de perfil (usuario y detalle), cambiar contraseña
//? 1. Ver las asignaturas que enseña un docente(id_docente) => saca de la tabla docente_asignatura una lista de todos los id_asignatura donde docente_asignatura.id_docente = id_docente
SELECT id_asignatura
FROM docente_asignatura
WHERE id_docente = id_docente;
//? 2. Ver las asignaturas que enseña un docente (lista de todos los id_asignatura) => retorna una lista con TODO de la tabla asignatura de cada uno de los id_asignatura por cada item de la lista
SELECT grupo.id_curso, grupo.numero_grupo, oferta_academica.id_oferta_academica, oferta_academica.programa_academico_id, programa_academico.nombre
FROM grupo
INNER JOIN curso ON grupo.id_curso = curso.id_curso
INNER JOIN oferta_academica ON curso.id_oferta_academica = oferta_academica.id_oferta_academica
INNER JOIN programa_academico ON oferta_academica.programa_academico_id = programa_academico.id_programa_academico
WHERE grupo.id_docente = id_docente
  AND oferta_academica.id_anio_periodo_academico = id_anio_periodo_academico;

//? 3. Ver horario de un docente(id_docente, anio_periodo_academico) => sacar de la tabla grupo una lista de todos los id_curso y todos los numero_grupo donde grupo.id_docente = id_docente AND grupo.id_curso.oferta_academica.id_anio_periodo_academico = id_anio_periodo_academico
SELECT id_curso, numero_grupo
FROM grupo
WHERE id_docente = id_docente;
WHERE id_docente = id
//? 4. (lista de todos los id_grupo) => retornar una lista de TODOS los datos de la tabla horario_clase. cada elemento de la lista debe tener esta estructura:
//? grupo.id_grupo | asignatura.nombre | dia_semana.nombre_dia_semana | clase.hora_inicio | clase.hora_final | ubicacion_clase.edificio | ubicacion_clase.salon_clase
SELECT
  grupo.id_grupo,
  asignatura.nombre,
  dia_semana.nombre_dia_semana,
  clase.hora_inicio,
  clase.hora_final,
  ubicacion_clase.edificio,
  ubicacion_clase.salon_clase
FROM
  horario_clase
SELECT grupo.id_grupo, asignatura.nombre, dia_semana.nombre_dia_semana, clase.hora_inicio, clase.hora_final, ubicacion_clase.edificio, ubicacion_clase.salon_clase
FROM horario_clase
INNER JOIN grupo ON horario_clase.id_grupo = grupo.id_grupo
INNER JOIN curso ON grupo.id_curso = curso.id_curso
INNER JOIN asignatura ON curso.id_asignatura = asignatura.id_asignatura
INNER JOIN dia_semana ON horario_clase.id_dia_semana = dia_semana.id_dia_semana
INNER JOIN clase ON horario_clase.id_clase = clase.id_clase
INNER JOIN ubicacion_clase ON horario_clase.id_ubicacion_clase = ubicacion_clase.id_ubicacion_clase
WHERE grupo.id_grupo IN (lista_de_todos_los_id_grupo)
//? 5.1. Lista de grupos de un docente (id_docente) => sacar de la tabla grupo una lista de todos los id_grupo donde grupo.id_docente = id_docente
SELECT id_grupo
FROM grupo
WHERE id_docente = 'id_docente'
//? 5.2. Horario de todos los grupos de un profesor(lista de todos los id_grupo) => retorna TODO de la tabla horario_clase donde horario_clase.id_grupo == id_grupo. cada elemento de la lista debe tener esta estructura: 
//? id_grupo | numero_grupo | asignatura.id_asignatura | asignatura.nombre
SELECT horario_clase.id_grupo, grupo.numero_grupo, curso.id_asignatura, asignatura.nombre
FROM horario_clase
JOIN grupo ON horario_clase.id_grupo = grupo.id_grupo
JOIN curso ON grupo.id_curso = curso.id_curso
JOIN asignatura ON curso.id_asignatura = asignatura.id_asignatura
WHERE horario_clase.id_grupo IN (lista_de_id_grupo)

//? 6.1. Obtener usuario(id_usuario) => TODOS los datos de la tabla usuario 
SELECT *
FROM usuario
WHERE id_usuario = tu_id_usuario
//? 6.2. Obtener detalle_usuario(id_usuario + id_rol) => TODOS los datos de la tabla detalle_*ROL*
SELECT *
FROM detalleROL
WHERE id_usuario = tu_id_usuario
  AND id_rol = tu_id_rol

//? 7. Cambiar contraseña usuario (id_usuario, nueva_contrasena_salt, nueva_contrasena_hash) => UPDATE en tabla usuario.id_usuario contrasena_salt y contrasena_hash
UPDATE usuario
SET contrasena_salt = 'nueva_contrasena_salt',
    contrasena_hash = 'nueva_contrasena_hash'
WHERE id_usuario = tu_id_usuario;

//? 8. Modificar notas(id_grupo, nota1, nota2, nota3, nota4) => UPDATE en tabla historial_academico * notas
UPDATE historial_academico
SET nota1 = tu_nota1,
    nota2 = tu_nota2,
    nota3 = tu_nota3,
    nota4 = tu_nota4
WHERE id_grupo = tu_id_grupo;
//! PORTAL ESTUDIANTIL
//*Ver los cursos en los que está matriculado y su horario, ver lista de asignaturas matriculadas (ambas cosas se miran en la tabla grupo). ver los programas académicos en los que está registrado, --- la malla curriculado --- y las ---asignaturas aprobadas, matriculadas y no aprobadas --- (nota_estudiante_asignatura_matriculada), ver notas parciales (historial_academico) y notas finales (nota_estudiante_asignatura_matriculada), información de perfil (usuario y detalle), cambiar contraseña
//? 1. SELECT id_anio_periodo_academico() retornar id_anio_periodo_academico donde anio_periodo_academico.anio = institucion_educativa.anio_vigente AND anio_periodo_academico.id_periodo_academico = institucion_educativa.periodo_academico_vigente
SELECT id_anio_periodo_academico
FROM anio_periodo_academico
JOIN institucion_educativa ON anio_periodo_academico.anio = institucion_educativa.anio_vigente
                            AND anio_periodo_academico.id_periodo_academico = institucion_educativa.periodo_academico_vigente;
//? 2. Lista de ofertas académicas de un estudiante(id_estudiante, id_anio_periodo_academico) retorna de la tabla matricula_academica una lista de elementos en donde matricula_academica.id_estudiante = id_estudiante AND matricula_academica.id_oferta_academica.id_anio_periodo_academico = id_anio_periodo_academico. cada uno tenga la siguiente estructura: oferta_academica.id_oferta_academica | oferta_academica.programa_academico.id_programa_academico | oferta_academica.programa_academico.nombre | programa_academico.total_creditos
SELECT
  ma.id_oferta_academica,
  pa.id_programa_academico,
  pa.nombre,
  pa.total_creditos
FROM
  matricula_academica ma
JOIN
  oferta_academica oa ON ma.id_oferta_academica = oa.id_oferta_academica
JOIN
  programa_academico pa ON oa.programa_academico = pa.id_programa_academico
WHERE
  ma.id_estudiante = id_estudiante
  AND oa.id_anio_periodo_academico = id_anio_periodo_academico;

//? 3.1. Lista de grupos de un estudiante en una oferta académica (id_estudiante, id_oferta_academica) => sacar de la tabla historial_academico una lista de todos los id_grupo donde historial_academico.id_estudiante = id_estudiante AND historial_academico.id_grupo.id_curso.id_oferta_academica = id_oferta_academica
SELECT historial_academico.id_grupo
FROM historial_academico
INNER JOIN grupo ON historial_academico.id_grupo = grupo.id_grupo
INNER JOIN curso ON grupo.id_curso = curso.id_curso
WHERE historial_academico.id_estudiante = <id_estudiante>
  AND curso.id_oferta_academica = <id_oferta_academica>;

-- 3.2 Horario de clases(lista de todos los id_grupo) HECHO: (portal docente 2.2)

-- 4.1. Lista de grupos de un estudiante en una oferta académica (id_estudiante, id_oferta_academica) HECHO: 3.1
//? 4.2. Historial del estudiante en todos sus grupos de una oferta académica(lista de todos los id_grupo) => sacar de la tabla historial_academico una lista de elementos donde cada elemento de la lista debe tener esta estructura: 
//? historial_academico.id_grupo | historial_academico.id_grupo.numero_grupo | historial_academico.id_grupo.id_curso.id_asignatura | historial_academico.id_grupo.id_curso.id_asignatura.nombre | historial_academico. nota1 | historial_academico. nota2 | historial_academico. nota3 | historial_academico. nota4
SELECT
  historial_academico.id_grupo,
  grupo.numero_grupo,
  curso.id_asignatura,
  asignatura.nombre AS nombre_asignatura,
  historial_academico.nota1,
  historial_academico.nota2,
  historial_academico.nota3,
  historial_academico.nota4
FROM
  historial_academico
JOIN
  grupo ON historial_academico.id_grupo = grupo.id_grupo
JOIN
  curso ON grupo.id_curso = curso.id_curso
JOIN
  asignatura ON curso.id_asignatura = asignatura.id_asignatura
WHERE
  historial_academico.id_grupo IN (lista_de_id_grupo)
//? 5. Obtener la matrícula académica de un estudiante(id_estudiante, id_oferta_academica) => SELECT id_matricula_academica FROM matricula_academica WHERE matricula_academica.id_estudiante = id_estudiante AND matricula_academica.id_oferta_academica = id_oferta_academica
SELECT id_matricula_academica
FROM matricula_academica
WHERE id_estudiante = 'id_estudiante' AND id_oferta_academica = 'id_oferta_academica';

//? 6. Historial de notas del semestre(id_estudiante, id_oferta_academica) => sacar de la tabla nota_estudiante_asignatura_matriculada los datos con el siguiente formato:
//? nota_estudiante_asignatura_matriculada.fk_id_asignatura.id_asignatura | nota_estudiante_asignatura_matriculada.fk_id_asignatura.nombre | nota_estudiante_asignatura_matriculada.nota_final_estudiante_asignatura
SELECT a.id_asignatura, a.nombre, n.nota_final_estudiante_asignatura
FROM nota_estudiante_asignatura_matriculada n
JOIN asignatura a ON n.fk_id_asignatura = a.id_asignatura
WHERE n.fk_id_estudiante = 'id_estudiante' AND n.fk_id_oferta_academica = 'id_oferta_academica';

-- 7.1. Obtener usuario(id_usuario) HECHO: Portal docente: 6.1

-- 7.2. Obtener detalle_usuario(id_usuario + id_rol) HECHO: Portal docente: 6.2

-- 8. Cambiar contraseña usuario (id_usuario, nueva_contrasena_salt, nueva_contrasena_hash) HECHO: Portal docente: 7

//? 9. creditos matriculados por un estudiante en un periodo académico y en un programa académico(d_estudiante, id_programa_academico, anio, id_periodo_tiempo)
SELECT SUM(a.num_creditos) AS total_creditos_matriculados
FROM nota_estudiante_asignatura_matriculada AS n
INNER JOIN matricula_academica AS m ON n.fk_id_matricula_academica = m.id_matricula_academica
INNER JOIN oferta_academica AS o ON m.fk_id_oferta_academica = o.id_oferta_academica
INNER JOIN asignatura AS a ON n.fk_id_asignatura = a.id_asignatura
WHERE m.fk_id_estudiante = <id_estudiante>
  AND o.fk_id_programa_academico = <id_programa_academico>
  AND o.id_anio_periodo_academico = (
    SELECT id_anio_periodo_academico
    FROM anio_periodo_academico
    WHERE anio = <anio> AND id_periodo_tiempo = <id_periodo_tiempo>
  );

//? 10. ubicación semestral de un estudiante en un programa académico(id_estudiante, id_programa_academico)
SELECT ROUND(c.total_creditos_aprobados / p.total_creditos, 2) AS ratio_creditos
FROM creditos_aprobados_estudiante_programa_academico AS c
INNER JOIN programa_academico AS p ON c.id_programa_academico = p.id_programa_academico
WHERE c.id_estudiante = <id_estudiante> AND c.id_programa_academico = <id_programa_academico>;

//? 11. último periodo académico que matriculó un estudiante(id_estudiante)
SELECT ap.anio, pt.id_periodo_academico AS periodo
FROM matricula_academica AS ma
INNER JOIN oferta_academica AS oa ON ma.fk_id_oferta_academica = oa.id_oferta_academica
INNER JOIN anio_periodo_academico AS ap ON oa.fk_id_anio_periodo_academico = ap.id_anio_periodo_academico
INNER JOIN periodo_academico AS pt ON ap.id_periodo_academico = pt.id_periodo_academico
WHERE ma.fk_id_estudiante = <id_estudiante>
ORDER BY ap.anio DESC, pt.id_periodo_academico DESC
LIMIT 1;
*/