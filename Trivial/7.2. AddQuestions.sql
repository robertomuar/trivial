USE `TRIVIAL`;

DROP PROCEDURE IF EXISTS `AddQuestions`;
DROP FUNCTION IF EXISTS `InsertAnswers`;

DROP PROCEDURE IF EXISTS `InsertAnswersText`;
DROP PROCEDURE IF EXISTS `InsertAnswersImage`;

DELETE FROM `RESPUESTATEXTOS`;
DELETE FROM `RESPUESTAIMAGENES`;
DELETE FROM `RESPUESTAS`;
DELETE FROM `IMAGENES`;
DELETE FROM `PREGUNTAS`;
DELETE FROM `LOGPROCEDIMIENTOS`;



DELIMITER //
CREATE PROCEDURE `AddQuestions` ( `dataQuestions` JSON )
BEGIN
    SET @totalCategories     = JSON_LENGTH( dataQuestions, '$.categories' ); 
    INSERT INTO `LOGPROCEDIMIENTOS` 
                VALUES ( 
                    CONCAT( "totalCategories ", @totalCategories ) 
                );
    SET @iCat = 0;
    WHILE @iCat < @totalCategories DO
    -- Extraigo la información del objeto.
        SET @category       = REPLACE( JSON_EXTRACT( dataQuestions, CONCAT( '$.categories[' , @iCat , '].category' ) ), '"', '' );
        -- SET @category2      = REPLACE( JSON_EXTRACT( dataQuestions, '$.categories[0].category' ), '"', '' );
        INSERT INTO `LOGPROCEDIMIENTOS` 
                VALUES ( 
                    CONCAT( "category ", @category ) 
                );
        
        SET @categoryId =  ( SELECT `categoriaId` FROM `CATEGORIAS` WHERE `nomcategoria` = @category );

        
        SET @totalQuestions     = JSON_LENGTH( dataQuestions, CONCAT( '$.categories[' , @iCat , '].questions' ) ); 
         INSERT INTO `LOGPROCEDIMIENTOS` 
                VALUES ( 
                    CONCAT( "totalQuestions ", @totalQuestions ) 
                );
        SET @i = 0;

        WHILE @i < @totalQuestions DO
            SET @questionText       = REPLACE( JSON_EXTRACT( dataQuestions, CONCAT( '$.categories[' , @iCat , '].questions[' , @i , '].questiontext' )), '"', '' );
        

            SET @questionImage      = REPLACE( JSON_EXTRACT( dataQuestions, CONCAT( '$.categories[' , @iCat , '].questions[' , @i , '].questionimage' )), '"', '' );
            SET @answerText1        = REPLACE( JSON_EXTRACT( dataQuestions, CONCAT( '$.categories[' , @iCat , '].questions[' , @i , '].answertext1' )), '"', '' );
            SET @answerText2        = REPLACE( JSON_EXTRACT( dataQuestions, CONCAT( '$.categories[' , @iCat , '].questions[' , @i , '].answertext2' )), '"', '' );
            SET @answerText3        = REPLACE( JSON_EXTRACT( dataQuestions, CONCAT( '$.categories[' , @iCat , '].questions[' , @i , '].answertext3' )), '"', '' );
            SET @answerText4        = REPLACE( JSON_EXTRACT( dataQuestions, CONCAT( '$.categories[' , @iCat , '].questions[' , @i , '].answertext4' )), '"', '' );
            SET @answerImage1       = REPLACE( JSON_EXTRACT( dataQuestions, CONCAT( '$.categories[' , @iCat , '].questions[' , @i , '].answerimage1' )), '"', '' );
            SET @answerImage2       = REPLACE( JSON_EXTRACT( dataQuestions, CONCAT( '$.categories[' , @iCat , '].questions[' , @i , '].answerimage2' )), '"', '' );
            SET @answerImage3       = REPLACE( JSON_EXTRACT( dataQuestions, CONCAT( '$.categories[' , @iCat , '].questions[' , @i , '].answerimage3' )), '"', '' );
            SET @answerImage4       = REPLACE( JSON_EXTRACT( dataQuestions, CONCAT( '$.categories[' , @iCat , '].questions[' , @i , '].answerimage4' )), '"', '' );

            SET @bCorrectAnswer     = JSON_EXTRACT( dataQuestions, CONCAT( '$.categories[' , @iCat , '].questions[' , @i , '].correctanswer' ));
            INSERT INTO `LOGPROCEDIMIENTOS` 
                VALUES ( 
                    CONCAT( "correctAnswer ", @bCorrectAnswer ) 
                );
                
            START TRANSACTION;
                INSERT INTO `PREGUNTAS` 
                    (
                        `preguntaId`, 
                        `categoriaId`,
                        `texto`
                    ) 
                VALUES 
                    (
                        null,
                        @categoryId,
                        @questionText
                    );
                SELECT LAST_INSERT_ID() INTO @questionId;
                INSERT INTO `LOGPROCEDIMIENTOS` 
                    VALUES ( 
                        CONCAT( "2. questionText ", @questionText ) 
                    );
                INSERT INTO `LOGPROCEDIMIENTOS` 
                    VALUES ( 
                        CONCAT( "2. questionImage ", @questionImage ) 
                    );
                IF @questionImage IS NOT NULL THEN
                    INSERT INTO `LOGPROCEDIMIENTOS` 
                        VALUES ( 
                        CONCAT( "Insertando imagen: ", @questionImage ) 
                    );
                    INSERT INTO `IMAGENES` 
                        (
                            `preguntaId`, 
                            `imagen`
                        ) 
                    VALUES
                        ( 
                            @questionId,
                            @questionImage
                        );
                END IF;

                /* SET @answerId =  InsertAnswers( @questionId );
                IF @answerText1 IS NOT NULL AND @answerImage1 IS NOT NULL THEN 
                    CALL InsertAnswersText(  @answerId, @answerText1 );
                    CALL InsertAnswersImage(  @answerId, @answerImage1 ); 
                ELSEIF @answerText1 IS NOT NULL AND @answerImage1 IS NULL THEN 
                    CALL InsertAnswersText(  @answerId, @answerText1 );
                ELSE 
                    CALL InsertAnswersImage(  @answerId, @answerImage1 ); 
                END IF; */

                -- bCorrectAnswer = 1 | 2 | 3 | 4;

                -- La 1ª respuesta.
                IF @bCorrectAnswer = 1 THEN 
                    SET @answerId =  InsertAnswers( @questionId, true );
                ELSE 
                    SET @answerId =  InsertAnswers( @questionId, false );
                END IF;
                IF @answerText1 IS NOT NULL THEN 
                    CALL InsertAnswersText(  @answerId, @answerText1 );
                END IF;
                IF @answerImage1 IS NOT NULL THEN 
                    CALL InsertAnswersImage(  @answerId, @answerImage1 );
                END IF;

                -- La 2ª respuesta.
                IF @bCorrectAnswer = 2 THEN 
                    SET @answerId =  InsertAnswers( @questionId, true );
                ELSE 
                    SET @answerId =  InsertAnswers( @questionId, false );
                END IF;
                
                IF @answerText2 IS NOT NULL THEN 
                    CALL InsertAnswersText(  @answerId, @answerText2 );
                END IF;
                IF @answerImage2 IS NOT NULL THEN 
                    CALL InsertAnswersImage(  @answerId, @answerImage2 );
                END IF;

                -- La 3ª respuesta.
                IF @bCorrectAnswer = 3 THEN 
                    SET @answerId =  InsertAnswers( @questionId, true );
                ELSE 
                    SET @answerId =  InsertAnswers( @questionId, false );
                END IF;
                IF @answerText3 IS NOT NULL THEN 
                    CALL InsertAnswersText(  @answerId, @answerText3 );
                END IF;
                IF @answerImage3 IS NOT NULL THEN 
                    CALL InsertAnswersImage(  @answerId, @answerImage3 );
                END IF;

                -- La 4ª respuesta.
                IF @bCorrectAnswer = 4 THEN 
                    SET @answerId =  InsertAnswers( @questionId, true );
                ELSE 
                    SET @answerId =  InsertAnswers( @questionId, false );
                END IF;
                IF @answerText4 IS NOT NULL THEN 
                    CALL InsertAnswersText(  @answerId, @answerText4 );
                END IF;
                IF @answerImage4 IS NOT NULL THEN 
                    CALL InsertAnswersImage(  @answerId, @answerImage4 );
                END IF;

            COMMIT;

            SET @i = @i + 1;
        END WHILE;

        SET @iCat = @iCat + 1;
    END WHILE;
END //

CREATE FUNCTION InsertAnswers( questionId INT, bCorrectAnswer BOOLEAN ) RETURNS INT
BEGIN
    -- Insertar en respuestas y en respuestas textos.
    INSERT INTO `RESPUESTAS` 
        (
            `respuestaId`, 
            `preguntaId`,
            `correcta`
        )
    VALUES 
        ( 
            null,
            questionId,
            bCorrectAnswer
        );
    SELECT LAST_INSERT_ID() INTO @answerId;
    RETURN @answerId;
END //


CREATE PROCEDURE InsertAnswersText( answerId INT, answerText VARCHAR( 35 ) ) 
BEGIN
    INSERT INTO `RESPUESTATEXTOS` 
        (
            `respuestaId`, 
            `texto`
        )
    VALUES 
        ( 
            @answerId,
            answerText
        );
END //

CREATE PROCEDURE InsertAnswersImage( answerId INT, answerImage CHAR( 35 ) ) 
BEGIN
    INSERT INTO `RESPUESTAIMAGENES` 
        (
            `respuestaId`, 
            `imagen`
        )
    VALUES 
        ( 
            @answerId,
            answerImage
        );
END //



/*
    Preguntas 
        - con texto solo.         RESPUESTAS y RESPUESTATEXTOS.
        - con imagenes solo.      RESPUESTAS y RESPUESTAIMAGENES.
        - con texto e imagenes.   RESPUESTAS y RESPUESTATEXTOS y RESPUESTAIMAGENES.
        

        procedure InsertAnswers
            -- RESPUESTAS

        procedure InsertAnswersText
            -- RESPUESTATEXTOS.

        procedure InsertAnswersImage
            -- RESPUESTAIMAGENES.

       





*/