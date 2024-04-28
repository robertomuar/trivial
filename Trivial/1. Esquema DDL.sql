DROP DATABASE IF EXISTS TRIVIAL;
CREATE DATABASE TRIVIAL DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE TRIVIAL;

CREATE TABLE `GENEROS` (
	`generoId`	 	TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	`genero`		VARCHAR(20) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE `USUARIOS` (
	`usuarioId`	 	SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	`generoId`	 	TINYINT UNSIGNED NOT NULL,
	`nombre`		VARCHAR(20) NOT NULL,
	`apellidos`		VARCHAR(40) NOT NULL,
	`email`			VARCHAR(35) NOT NULL UNIQUE,
	`fecnacimiento`	DATE NOT NULL,
	CONSTRAINT `fk_GENEROS_USUARIOS`
		FOREIGN KEY (`generoId`)
		REFERENCES `GENEROS`(`generoId`)
) ENGINE=InnoDB;

CREATE TABLE `AMISTADES` (
	`usuarioId`	 	SMALLINT UNSIGNED,
	`amigoId`	 	SMALLINT UNSIGNED,
	PRIMARY KEY (`usuarioId`, `amigoId`, `fecinicio`),
	CHECK (`usuarioId` != `amigoId`),
	UNIQUE (`amigoId`, `usuarioId`),
	`fecinicio`	DATETIME NOT NULL,
	CONSTRAINT `fk_USUARIOS_AMISTADES`
		FOREIGN KEY (`usuarioId`)
		REFERENCES `USUARIOS`(`usuarioId`),
	CONSTRAINT `fk_USUARIOS_AMISTADES2`
		FOREIGN KEY (`amigoId`)
		REFERENCES `USUARIOS`(`usuarioId`)
) ENGINE=InnoDB;

CREATE TABLE `FINAMISTADES` (
	`usuarioId`	 	SMALLINT UNSIGNED,
	`amigoId`	 	SMALLINT UNSIGNED,
	`fecinicio`		DATETIME,
	PRIMARY KEY (`usuarioId`, `amigoId`, `fecinicio`),
	`fecfin`		DATETIME NOT NULL,
	CONSTRAINT `fk_AMISTADES_FINAMISTADES`
		FOREIGN KEY (`usuarioId`, `amigoId`, `fecinicio`)
		REFERENCES `AMISTADES`(`usuarioId`, `amigoId`, `fecinicio`)
) ENGINE=InnoDB;

CREATE TABLE `DIFICULTADES` (
	`dificultadId`	 	TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	`nomDificultad` 	VARCHAR(10) NOT NULL UNIQUE,
	`tiempoRespuesta`	TINYINT UNSIGNED NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE `PARTIDASTIEMPOS` (
	`tiempoId`	 	TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	`partidatiempo`	TINYINT UNSIGNED NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE `PARTIDAS` (
	`partidaId`	 	SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	`dificultadId`	TINYINT UNSIGNED NOT NULL,
	`tiempoId`	 	TINYINT UNSIGNED NOT NULL,
	`usuarioId`	 	SMALLINT UNSIGNED NOT NULL,
	`fecpartida`	DATETIME NOT NULL,
	CONSTRAINT `fk_DIFICULTADES_PARTIDAS`
		FOREIGN KEY (`dificultadId`)
		REFERENCES `DIFICULTADES`(`dificultadId`),
	CONSTRAINT `fk_PARTIDASTIEMPOS_PARTIDAS`
		FOREIGN KEY (`tiempoId`)
		REFERENCES `PARTIDASTIEMPOS`(`tiempoId`),
	CONSTRAINT `fk_USUARIOS_PARTIDAS`
		FOREIGN KEY (`usuarioId`)
		REFERENCES `USUARIOS`(`usuarioId`)
) ENGINE=InnoDB;

CREATE TABLE `JUGADORES` (
	`partidaId`			 	SMALLINT UNSIGNED,
	`usuarioId`			 	SMALLINT UNSIGNED,
	PRIMARY KEY (`partidaId`, `usuarioId`),
	`fechoraunionpartida`	DATETIME NOT NULL,
	CONSTRAINT `fk_PARTIDAS_JUGADORES`
		FOREIGN KEY (`partidaId`)
		REFERENCES `PARTIDAS`(`partidaId`),
	CONSTRAINT `fk_USUARIOS_JUGADORES`
		FOREIGN KEY (`usuarioId`)
		REFERENCES `USUARIOS`(`usuarioId`)
) ENGINE=InnoDB;

CREATE TABLE `CATEGORIAS` (
	`categoriaId` 	TINYINT UNSIGNED ZEROFILL PRIMARY KEY AUTO_INCREMENT,
	`nomcategoria`	VARCHAR (10) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE `PARTIDASCATEGORIAS` (
	`categoriaId`	TINYINT UNSIGNED ZEROFILL,
	`partidaId`	 	SMALLINT UNSIGNED,
	PRIMARY KEY (`categoriaId`, `partidaId`),
	CONSTRAINT `fk_CATEGORIAS_PARTIDASCATEGORIAS`
		FOREIGN KEY (`categoriaId`)
		REFERENCES `CATEGORIAS`(`categoriaId`),
	CONSTRAINT `fk_PARTIDAS_PARTIDASCATEGORIAS`
		FOREIGN KEY (`partidaId`)
		REFERENCES `PARTIDAS`(`partidaId`)
) ENGINE=InnoDB;

CREATE TABLE `PREGUNTAS` (
	`preguntaId`	SMALLINT UNSIGNED AUTO_INCREMENT UNIQUE,
	`categoriaId`	TINYINT UNSIGNED ZEROFILL,
	PRIMARY KEY (`preguntaId`, `categoriaId`),
	`texto`			VARCHAR (100) NOT NULL,
	CONSTRAINT `fk_CATEGORIAS_PREGUNTAS`
		FOREIGN KEY (`categoriaId`)
		REFERENCES `CATEGORIAS`(`categoriaId`)
) ENGINE=InnoDB;

CREATE TABLE `PREGUNTASSIMILARES` (
	`preguntaId_1`	SMALLINT UNSIGNED,
	`preguntaId_2`	SMALLINT UNSIGNED,
	`categoriaId`	TINYINT UNSIGNED ZEROFILL,
	PRIMARY KEY (`preguntaId_1`, `preguntaId_2`, `categoriaId`),
	CHECK (`preguntaId_1` != `preguntaId_2`),
	UNIQUE (`preguntaId_2`, `preguntaId_1`),
	CONSTRAINT `fk_PREGUNTAS_PREGUNTASSIMILARES`
		FOREIGN KEY (`preguntaId_1`, `categoriaId` )
		REFERENCES `PREGUNTAS`(`preguntaId`, `categoriaId` ),
	CONSTRAINT `fk_PREGUNTAS_PREGUNTASSIMILARES2`
		FOREIGN KEY (`preguntaId_2`, `categoriaId` )
		REFERENCES `PREGUNTAS`(`preguntaId`, `categoriaId` )
) ENGINE=InnoDB;

CREATE TABLE `IMAGENES` (
	`preguntaId`	SMALLINT UNSIGNED PRIMARY KEY,
	`imagen`		CHAR (35) NOT NULL,
	CONSTRAINT `fk_PREGUNTAS_IMAGENES`
		FOREIGN KEY (`preguntaId`)
		REFERENCES `PREGUNTAS`(`preguntaId`)
) ENGINE=InnoDB;

CREATE TABLE `PARTIDAPREGUNTAS` (
	`categoriaId`		TINYINT UNSIGNED ZEROFILL,
	`partidaId`	 		SMALLINT UNSIGNED,
	`preguntaId`		SMALLINT UNSIGNED,	
	PRIMARY KEY (`categoriaId`, `partidaId`, `preguntaId`),
	`fechorapregunta`	DATETIME NOT NULL,
	CONSTRAINT `fk_PARTIDASCATEGORIAS_PARTIDAPREGUNTAS`
		FOREIGN KEY (`categoriaId`, `partidaId`)
		REFERENCES `PARTIDASCATEGORIAS`(`categoriaId`, `partidaId`),
	CONSTRAINT `fk_PREGUNTAS_PARTIDAPREGUNTAS`
		FOREIGN KEY (`preguntaId`, `categoriaId`)
		REFERENCES `PREGUNTAS`(`preguntaId`, `categoriaId`)
) ENGINE=InnoDB;

CREATE TABLE `RESPUESTAS` (
	`respuestaId`	SMALLINT UNSIGNED AUTO_INCREMENT UNIQUE,
	`preguntaId`	SMALLINT UNSIGNED,
	PRIMARY KEY (`respuestaId`, `preguntaId`),
	`correcta`		BOOLEAN NOT NULL,
	CONSTRAINT `fk_PREGUNTAS_RESPUESTAS`
		FOREIGN KEY (`preguntaId`)
		REFERENCES `PREGUNTAS`(`preguntaId`)
) ENGINE=InnoDB;

CREATE TABLE `RESPUESTAIMAGENES` (
	`respuestaId`	SMALLINT UNSIGNED PRIMARY KEY,
	`imagen`		CHAR (35) NOT NULL,
	CONSTRAINT `fk_RESPUESTAS_RESPUESTAIMAGENES`
		FOREIGN KEY (`respuestaId`)
		REFERENCES `RESPUESTAS`(`respuestaId`)
) ENGINE=InnoDB;

CREATE TABLE `RESPUESTATEXTOS` (
	`respuestaId`	SMALLINT UNSIGNED PRIMARY KEY,
	`texto`			VARCHAR (35) NOT NULL,
	CONSTRAINT `fk_RESPUESTAS_RESPUESTATEXTOS`
		FOREIGN KEY (`respuestaId`)
		REFERENCES `RESPUESTAS`(`respuestaId`)
) ENGINE=InnoDB;

CREATE TABLE `USUARIOSRESPUESTAS` (
	`categoriaId`	TINYINT UNSIGNED ZEROFILL,
	`partidaId`	 	SMALLINT UNSIGNED,
	`usuarioId`		SMALLINT UNSIGNED,
	`preguntaId`	SMALLINT UNSIGNED,
	`respuestaId`	SMALLINT UNSIGNED,
	PRIMARY KEY (`categoriaId`, `partidaId`, `usuarioId`, `preguntaId`, `respuestaId`),
	`fechorarespuesta`	DATETIME NOT NULL,
	CONSTRAINT `fk_PARTIDAPREGUNTAS_USUARIOSRESPUESTAS`
		FOREIGN KEY (`categoriaId`, `partidaId`, `preguntaId`)
		REFERENCES `PARTIDAPREGUNTAS`(`categoriaId`, `partidaId`, `preguntaId`),
	CONSTRAINT `fk_JUGADORES_USUARIOSRESPUESTAS`
		FOREIGN KEY (`partidaId`, `usuarioId`)
		REFERENCES `JUGADORES`(`partidaId`, `usuarioId`),
	CONSTRAINT `fk_RESPUESTAS_USUARIOSRESPUESTAS`
		FOREIGN KEY (`respuestaId`, `preguntaId`)
		REFERENCES `RESPUESTAS`(`respuestaId`, `preguntaId`)
) ENGINE=InnoDB;
