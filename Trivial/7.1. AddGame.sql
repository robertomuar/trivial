USE `trivialvBeta001`;

DROP PROCEDURE IF EXISTS `AddGame`;
DELIMITER //
CREATE PROCEDURE `AddGame` ( `dataGame` JSON )
BEGIN
    -- Extraigo la información del objeto.
    SET @gameDate       = REPLACE( JSON_EXTRACT( dataGame, '$.fecpartida' ), '"', '' );
    SET @timeGame       = JSON_EXTRACT( dataGame, '$.partidatiempo' ); 
    SET @difficulty     = REPLACE( JSON_EXTRACT( dataGame, '$.nomDificultad' ), '"', '' );
    SET @emailuser      = REPLACE( JSON_EXTRACT( dataGame, '$.emailuser' ), '"', '' );

    -- SELECT @gameDate, @timeGame, @difficulty, @emailuser;

    -- Recupero el valor el tiempoId con el valor partidatiempo suministrado.
    SET @tiempoId       = ( SELECT `tiempoId` FROM `PARTIDASTIEMPOS` WHERE `partidatiempo` = @timeGame );
    SET @dificultadId   = ( SELECT `dificultadId` FROM `DIFICULTADES` WHERE `nomDificultad` = @difficulty );
    SET @usuarioId      = ( SELECT `usuarioId` FROM `USUARIOS` WHERE `email` = @emailuser );
    IF @tiempoId <> null THEN
        INSERT INTO `PARTIDAS` (
            `partidaId`, 
            `fecpartida`, 
            `tiempoId`, 
            `dificultadId`, 
            `usuarioId`
        ) 
        VALUES 
        (
            null,
            @gameDate,
            @tiempoId,
            @dificultadId,
            @usuarioId
        );
    ELSE
        -- SELECT CONCAT( "La partida del usuario ", @emailuser, " no se dado de alta. Error en el valor del campo tiempoId" ) AS "msgerror";
        INSERT INTO `LOGPROCEDIMIENTOS` 
        VALUES ( 
            CONCAT( "La partida del usuario ", @emailuser, " no se dado de alta. Error en el valor del campo tiempoId" ) 
        );
    END IF;
END //

