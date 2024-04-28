USE `TRIVIAL`;

INSERT INTO `DIFICULTADES` 
    (`dificultadId`, `nomDificultad`, `tiempoRespuesta`) 
VALUES
    ( null, 'Fácil',        60  ),
    ( null, 'Intermedio',   40  ),
    ( null, 'Difícil',      30  ),
    ( null, 'Maestro',      20  );

INSERT INTO `GENEROS` 
    ( `generoId`, `genero` ) 
VALUES 
    ( null, "hombre"                ),
    ( null, "mujer"                 ),
    ( null, "prefiero no decirlo"   );

INSERT INTO `CATEGORIAS`
    ( `categoriaId`, `nomcategoria` ) 
VALUES 
    ( null, "Geografía"     ),
    ( null, "Arte"          ),
    ( null, "Ciencia"       ),
    ( null, "Historia"      ),
    ( null, "Deportes"      ),
    ( null, "Cine"          ),
    ( null, "Literatura"    ),
    ( null, "Música"        );

INSERT INTO `USUARIOS` 
    (
        `usuarioId`,
        `nombre`, 
        `apellidos` ,
        `email` ,
        `fecnacimiento`,
        `generoId`
    ) 
VALUES 
    (
        null,
        "Marcos",
        "González",
        "marcos.gonzalez@gmail.com",
        "2000-10-15",
        ( SELECT `generoId` FROM `GENEROS` WHERE `genero` = "hombre" )
    ),
    (
        null,
        "Katy",
        "Douglas",
        "katy.douglas@gmail.com",
        "1998-06-02",
        ( SELECT `generoId` FROM `GENEROS` WHERE `genero` = "mujer" )
    ),
    (
        null,
        "Carlos",
        "Pérez",
        "carlos.perez@gmail.com",
        "1985-03-20",
        ( SELECT `generoId` FROM `GENEROS` WHERE `genero` = "hombre" )
    ),
    (
        null,
        "Laura",
        "Martínez",
        "laura.martinez@gmail.com",
        "1992-12-10",
        ( SELECT `generoId` FROM `GENEROS` WHERE `genero` = "mujer" )
    ),
    (
        null,
        "David",
        "López",
        "david.lopez@gmail.com",
        "1988-08-25",
        ( SELECT `generoId` FROM `GENEROS` WHERE `genero` = "hombre" )
    );

INSERT INTO `PARTIDASTIEMPOS` 
    ( `tiempoId`, `partidatiempo` ) 
VALUES 
    ( null, 10 ),
    ( null, 15 ),
    ( null, 30 );

INSERT INTO `PARTIDAS` 
    (
        `partidaId`,  
        `fecpartida`,
        `tiempoId`,  
        `dificultadId`, 
        `usuarioId`   
    ) 
VALUES
    ( 
        null,
        "2024-01-15 12:05:58",
        ( SELECT `tiempoId` FROM `PARTIDASTIEMPOS` WHERE `partidatiempo` = 10 ),
        ( SELECT `dificultadId` FROM `DIFICULTADES` WHERE `nomDificultad` = "Intermedio" ),
        ( SELECT `usuarioId` FROM `USUARIOS` WHERE `email` = "marcos.gonzalez@gmail.com" )
    ),
    (
        null,
        "2024-01-15 21:05:45",
        (SELECT `tiempoId` FROM `PARTIDASTIEMPOS` WHERE `partidatiempo` = 10),
        (SELECT `dificultadId` FROM `DIFICULTADES` WHERE `nomDificultad` = "Intermedio"),
        (SELECT `usuarioId` FROM `USUARIOS` WHERE `email` = "katy.douglas@gmail.com")
    ),
    (
        null,
        "2024-01-16 13:05:58",
        (SELECT `tiempoId` FROM `PARTIDASTIEMPOS` WHERE `partidatiempo` = 15),
        (SELECT `dificultadId` FROM `DIFICULTADES` WHERE `nomDificultad` = "Dificil"),
        (SELECT `usuarioId` FROM `USUARIOS` WHERE `email` = "marcos.gonzalez@gmail.com")
    );

INSERT INTO `AMISTADES` 
    (   `usuarioId`, `amigoId`, `fecinicio` ) 
VALUES
    ( 
        ( SELECT `usuarioId` FROM `USUARIOS` WHERE `email` = "marcos.gonzalez@gmail.com" ), 
        ( SELECT `usuarioId` FROM `USUARIOS` WHERE `email` = "katy.douglas@gmail.com" ),
        '2024-01-29 12:48:29' 
    ), 
    ( 
        ( SELECT `usuarioId` FROM `USUARIOS` WHERE `email` = "marcos.gonzalez@gmail.com" ), 
        ( SELECT `usuarioId` FROM `USUARIOS` WHERE `email` = "carlos.perez@gmail.com" ),
        '2024-01-30 12:48:29' 
    ),
    ( 
        ( SELECT `usuarioId` FROM `USUARIOS` WHERE `email` = "laura.martinez@gmail.com" ), 
        ( SELECT `usuarioId` FROM `USUARIOS` WHERE `email` = "carlos.perez@gmail.com" ),
        '2024-02-01 12:48:29' 
    );

INSERT INTO `FINAMISTADES` 
    ( `usuarioId`, `amigoId`, `fecinicio`, `fecfin` ) 
VALUES
    ( 
        ( SELECT `usuarioId` FROM `USUARIOS` WHERE `email` = "laura.martinez@gmail.com" ), 
        ( SELECT `usuarioId` FROM `USUARIOS` WHERE `email` = "carlos.perez@gmail.com" ),
        '2024-02-01 12:48:29',
        '2024-02-01 21:48:29' 
    ); 

INSERT INTO `PARTIDASCATEGORIAS` (
    `categoriaId`,
    `partidaId`
) 
VALUES
    ( 
        (SELECT `categoriaId` FROM `CATEGORIAS` WHERE `nomcategoria` = "Geografía" ),
        (SELECT `partidaID` FROM `PARTIDAS` WHERE `partidaId` = 1)
    ),
    (
        (SELECT `categoriaId` FROM `CATEGORIAS` WHERE `nomcategoria` = "Arte"),
        (SELECT `partidaID` FROM `PARTIDAS` WHERE `partidaId` = 2)  
    ),
    (
        
        (SELECT `categoriaId` FROM `CATEGORIAS` WHERE `nomcategoria` = "Ciencia"),
        (SELECT `partidaID` FROM `PARTIDAS` WHERE `partidaId` = 2)
    ),
    (
        (SELECT `categoriaId` FROM `CATEGORIAS` WHERE `nomcategoria` = "Arte"),
        (SELECT `partidaID` FROM `PARTIDAS` WHERE `partidaId` = 3)
    ),
    ( 
        (SELECT `categoriaId` FROM `CATEGORIAS` WHERE `nomcategoria` = "Historia"),
        (SELECT `partidaID` FROM `PARTIDAS` WHERE `partidaId` = 3)
    ),
    (
        (SELECT `categoriaId` FROM `CATEGORIAS` WHERE `nomcategoria` = "Deportes"),
        (SELECT `partidaID` FROM `PARTIDAS` WHERE `partidaId` = 3)
    );

INSERT INTO `PREGUNTAS` 
    (
        `preguntaId`, 
        `categoriaId`, 
        `texto`
    ) 
 VALUES
    (
        1, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Geografía" ),
        "¿Cuál es la capital de Francia?"
    ),
    (
        2, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Arte" ),
        "¿Quién pintó la Mona Lisa?"
    ),
    (
        3, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Geografía" ),
        "¿Cual es la capital de España?"
    ),
    (
        4, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Ciencia" ),
        "¿Cuál es el elemento más abundante en la Tierra?"
    ),
    (
        5, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Historia" ),
        "¿En qué año comenzó la Primera Guerra Mundial?"
    ),
    
    (
        6, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Deportes" ),
        "¿Cuál es el deporte más popular en Brasil?"
    ),
     (
        7, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Historia" ),
        "¿En qué año se firmó la Declaración de Independencia de los Estados Unidos?"
    ),
    (
        8, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Ciencia" ),
        "¿Cuál es el componente principal del aire que respiramos?"
    ),
    (
        9, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Cine" ),
        "¿Quién dirigió la película 'El Padrino'?"
    ),
    (
        10, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Literatura" ),
        "¿Quién escribió 'Don Quijote de la Mancha'?"
    ),
    (
        11, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Música" ),
        "¿Cuál es el género musical característico de Bob Marley?"
    ),
    (
        12, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Ciencia" ),
        "¿Cuál es la molécula responsable del color de las hojas de las plantas?"
    ),
    (
        13, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Geografía" ),
        "¿Cuál es el río más largo del mundo?"
    ),
    (
        14, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Arte" ),
        "¿Quién pintó 'La Noche Estrellada'?"
    ),
    (
        15, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Historia" ),
        "¿En qué año se inauguró la Torre Eiffel?"
    ),
    (
        16, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Ciencia" ),
        "¿Cuál es el elemento más abundante en la corteza terrestre?"
    ),
    (
        17, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Arte" ),
        "¿Quién es el autor de la obra 'El Guernica'?"
    ),
    (
        18, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Literatura" ),
        "¿Cuál es el autor de 'Romeo y Julieta'?"
    ),
    (
        19, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Música" ),
        "¿Quién fue el líder de la banda 'Queen'?"
    ),
    (
        20, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Deportes" ),
        "¿En qué deporte se utiliza una pista de hielo?"
    ),
    (
        21, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Geografía" ),
        "¿Cuál es el país más grande del mundo?"
    ),
    (
        22, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Cine" ),
        "¿Quién interpretó a Forrest Gump en la película del mismo nombre?"
    ),
   (
        23, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Ciencia" ),
        "¿Cuál es el proceso mediante el cual las plantas fabrican su propio alimento?"
    ),
    (
        24, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Historia" ),
        "¿Cuál fue la primera civilización en la historia?"
    ),
    (
        25, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Literatura" ),
        "¿Quién escribió 'Orgullo y prejuicio'?"
    ),
    (
        26, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Música" ),
        "¿Cuál es el álbum más vendido de todos los tiempos?"
    ),
    (
        27, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Arte" ),
        "¿Quién es el autor de la escultura 'El Pensador'?"
    ),
    (
        28, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Geografía" ),
        "¿Cuál es el océano más grande del mundo?"
    ),
    (
        29, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Deportes" ),
        "¿Cuántos jugadores hay en un equipo de fútbol?"
    ),
    (
        30, 
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Ciencia" ),
        "¿Cuál es el elemento más abundante en el universo?"
    );

INSERT INTO `PREGUNTASSIMILARES` 
    (
        `preguntaId_1`, `preguntaId_2`, `categoriaId`
    ) 
VALUES 
    (
        (SELECT `preguntaId` FROM `PREGUNTAS` WHERE `preguntaId` = 1 ),
        (SELECT `preguntaId` FROM `PREGUNTAS` WHERE `preguntaId` = 3 ),
        -- (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Geografía" )
        (SELECT `categoriaid` FROM `PREGUNTAS` WHERE `preguntaId` = 1 )
    ),
    (
        (SELECT `preguntaId` FROM `PREGUNTAS` WHERE `preguntaId` = 4 ),
        (SELECT `preguntaId` FROM `PREGUNTAS` WHERE `preguntaId` = 8 ),
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Ciencia" )
    ),
    (
        (SELECT `preguntaId` FROM `PREGUNTAS` WHERE `preguntaId` = 2 ),
        (SELECT `preguntaId` FROM `PREGUNTAS` WHERE `preguntaId` = 17 ),
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Arte" )
    ),
    (
        (SELECT `preguntaId` FROM `PREGUNTAS` WHERE `preguntaId` = 14 ),
        (SELECT `preguntaId` FROM `PREGUNTAS` WHERE `preguntaId` = 17 ),
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Arte" )
    ),
    (
        (SELECT `preguntaId` FROM `PREGUNTAS` WHERE `preguntaId` = 4 ),
        (SELECT `preguntaId` FROM `PREGUNTAS` WHERE `preguntaId` = 30 ),
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Ciencia" )
    ),
     (
        (SELECT `preguntaId` FROM `PREGUNTAS` WHERE `preguntaId` = 18 ),
        (SELECT `preguntaId` FROM `PREGUNTAS` WHERE `preguntaId` = 25 ),
        (SELECT `categoriaid` FROM `CATEGORIAS` WHERE `nomcategoria` = "Literatura" )
    );

INSERT INTO `JUGADORES` 
    (
        `partidaId`, 
        `usuarioId`, 
        `fechoraunionpartida`
    ) 
 VALUES 
    (
        ( SELECT `partidaId` FROM `PARTIDAS` WHERE `partidaId` = 1 ),
        ( SELECT `usuarioId` FROM `USUARIOS` WHERE `email` = "marcos.gonzalez@gmail.com" ),
        "2024-01-15 12:05:58"
    ),
    (
        ( SELECT `partidaId` FROM `PARTIDAS` WHERE `partidaId` = 2 ),
        (SELECT `usuarioId` FROM `USUARIOS` WHERE `email` = "katy.douglas@gmail.com"),
        "2024-01-15 21:05:45"
    ),
    (
        ( SELECT `partidaId` FROM `PARTIDAS` WHERE `partidaId` = 2 ),
        ( SELECT `usuarioId` FROM `USUARIOS` WHERE `email` = "marcos.gonzalez@gmail.com" ),
        "2024-01-15 21:06:45"
    ),
    (
        ( SELECT `partidaId` FROM `PARTIDAS` WHERE `partidaId` = 3 ),
        (SELECT `usuarioId` FROM `USUARIOS` WHERE `email` = "marcos.gonzalez@gmail.com"),
        "2024-01-16 13:05:58"
    ),
    (
        ( SELECT `partidaId` FROM `PARTIDAS` WHERE `partidaId` = 3 ),
        (SELECT `usuarioId` FROM `USUARIOS` WHERE `email` = "katy.douglas@gmail.com"),
        "2024-01-16 13:06:08"
    ),
    (
        ( SELECT `partidaId` FROM `PARTIDAS` WHERE `partidaId` = 3 ),
        ( SELECT `usuarioId` FROM `USUARIOS` WHERE `email` = "carlos.perez@gmail.com" ),
        @horacomienzo_partida3 := "2024-01-16 13:06:19"
    );

/* SELECT `nomcategoria`, `preguntaId`, `texto`
FROM `PARTIDASCATEGORIAS`
INNER JOIN `CATEGORIAS`
ON `PARTIDASCATEGORIAS`.`categoriaid` = `CATEGORIAS`.`categoriaid`
INNER JOIN `PREGUNTAS`
ON `CATEGORIAS`.`categoriaid` = `PREGUNTAS`.`categoriaid`
WHERE `partidaId` = 3
ORDER BY RAND()
LIMIT 1;

SELECT `categoriaid`, `preguntaId`
FROM `PARTIDASCATEGORIAS`
INNER JOIN `CATEGORIAS`
ON `PARTIDASCATEGORIAS`.`categoriaid` = `CATEGORIAS`.`categoriaid`
INNER JOIN `PREGUNTAS`
ON `CATEGORIAS`.`categoriaid` = `PREGUNTAS`.`categoriaid`
WHERE `partidaId` = 3
ORDER BY RAND()
LIMIT 1; */

/* SET @partidaId := 3;
SET @dataCategoriaId := ( SELECT `categoriaid`
                FROM `PARTIDASCATEGORIAS`
                WHERE `partidaId` = @partidaId
                ORDER BY RAND()
                LIMIT 1 );

SET @dataPreguntaId := ( SELECT `preguntaId`
                FROM `PARTIDASCATEGORIAS`
                INNER JOIN `CATEGORIAS`
                ON `PARTIDASCATEGORIAS`.`categoriaid` = `CATEGORIAS`.`categoriaid`
                INNER JOIN `PREGUNTAS`
                ON `CATEGORIAS`.`categoriaid` = `PREGUNTAS`.`categoriaid`
                WHERE `partidaId` = @partidaId
                AND `PARTIDASCATEGORIAS`.`categoriaid` = @dataCategoriaId
                ORDER BY RAND()
                LIMIT 1 );

INSERT INTO `PARTIDAPREGUNTAS` 
    (
        `categoriaId`, 
        `partidaId`, 
        `preguntaId`, 
        `fechorapregunta`
    ) 
VALUES 
    (
        @dataCategoriaId,
        @partidaId,
        @dataPreguntaId,
        @horacomienzo_partida3 + INTERVAL 2 SECOND
    );
*/
/* INSERT INTO `PARTIDAPREGUNTAS` 
    (
        `categoriaId`, 
        `partidaId`, 
        `preguntaId`, 
        `fechorapregunta`
    ) 
VALUES 
    (
        @dataCategoriaId := ( SELECT `categoriaid`
                FROM `PARTIDASCATEGORIAS`
                WHERE `partidaId` = @partidaId
                ORDER BY RAND()
                LIMIT 1 ),
        @partidaId,
        ( SELECT `preguntaId`
                FROM `PARTIDASCATEGORIAS`
                INNER JOIN `CATEGORIAS`
                ON `PARTIDASCATEGORIAS`.`categoriaid` = `CATEGORIAS`.`categoriaid`
                INNER JOIN `PREGUNTAS`
                ON `CATEGORIAS`.`categoriaid` = `PREGUNTAS`.`categoriaid`
                WHERE `partidaId` = @partidaId
                AND `PARTIDASCATEGORIAS`.`categoriaid` = @dataCategoriaId
                ORDER BY RAND()
                LIMIT 1 ),
        @horacomienzo_partida3 + INTERVAL 21 SECOND
    ); 
    */
 
INSERT INTO `PARTIDAPREGUNTAS` 
    (
        `categoriaId`, 
        `partidaId`, 
        `preguntaId`, 
        `fechorapregunta`
    ) 
VALUES 
    (
        ( SELECT `categoriaId` FROM `CATEGORIAS` WHERE `nomcategoria` = 'Geografía' ),
        1,
        1,
        "2024-06-02 14:06:30"
    ),
    (
        ( SELECT `categoriaId` FROM `CATEGORIAS` WHERE `nomcategoria` = 'Arte' ),
        2,
        17,
        "2024-06-02 14:07:50"
    ),
    (
        ( SELECT `categoriaId` FROM `CATEGORIAS` WHERE `nomcategoria` = 'Ciencia' ),
        2,
        23,
        "2024-06-11 15:06:50"
    ); 

INSERT INTO `RESPUESTAS`
    (`respuestaId`, `preguntaId`, `correcta`)
VALUES
    -- "0001"
    (NULL, 1, 1),
    (NULL, 1, 0),
    (NULL, 1, 0),
    (NULL, 1, 0),
    -- "0002"
    (NULL, 2, 0),         
    (NULL, 2, 1),
    (NULL, 2, 0),
    (NULL, 2, 0),
    -- "0003"
    (NULL, 3, 0),
    (NULL, 3, 1),
    (NULL, 3, 0),
    (NULL, 3, 0),
    -- "0004"
    (NULL, 4, 0),
    (NULL, 4, 0),
    (NULL, 4, 0),
    (NULL, 4, 1),
    -- "0005"
    (NULL, 5, 0),
    (NULL, 5, 1),
    (NULL, 5, 0),
    (NULL, 5, 0),
    -- "0006"
    (NULL, 6, 1),
    (NULL, 6, 0),
    (NULL, 6, 0),
    (NULL, 6, 0),
    -- "0007"
    (NULL, 7, 1),
    (NULL, 7, 0),
    (NULL, 7, 0),
    (NULL, 7, 0),
    -- "0008"
    (NULL, 8, 1),
    (NULL, 8, 0),
    (NULL, 8, 0),
    (NULL, 8, 0),
    -- "0009"
    (NULL, 9, 0),
    (NULL, 9, 1),
    (NULL, 9, 0),
    (NULL, 9, 0),
    -- "0010"
    (NULL, 10, 0),
    (NULL, 10, 1),
    (NULL, 10, 0),
    (NULL, 10, 0),
    -- "0011"
    (NULL, 11, 0),
    (NULL, 11, 1),
    (NULL, 11, 0),
    (NULL, 11, 0),
    -- "0012"
    (NULL, 12, 1),         
    (NULL, 12, 0),
    (NULL, 12, 0),
    (NULL, 12, 0),
    -- "0013"
    (NULL, 13, 1),
    (NULL, 13, 0),
    (NULL, 13, 0),
    (NULL, 13, 0),
    -- "0014"
    (NULL, 14, 1),
    (NULL, 14, 0),
    (NULL, 14, 0),
    (NULL, 14, 0),
    -- "0015"
    (NULL, 15, 1),
    (NULL, 15, 0),
    (NULL, 15, 0),
    (NULL, 15, 0),
    -- "0016"
    (NULL, 16, 0),
    (NULL, 16, 1),
    (NULL, 16, 0),
    (NULL, 16, 0),
    -- "0017"
    (NULL, 17, 0),
    (NULL, 17, 1),
    (NULL, 17, 0),
    (NULL, 17, 0),
    -- "0018"
    (NULL, 18, 0),
    (NULL, 18, 1),
    (NULL, 18, 0),
    (NULL, 18, 0),
    -- "0019"
    (NULL, 19, 0),
    (NULL, 19, 1),
    (NULL, 19, 0),
    (NULL, 19, 0),
    -- "0020"
    (NULL, 20, 0),
    (NULL, 20, 1),
    (NULL, 20, 0),
    (NULL, 20, 0), 
    -- "0021"
    (NULL, 21, 1),
    (NULL, 21, 0),
    (NULL, 21, 0),
    (NULL, 21, 0),
    -- "0022"
    (NULL, 22, 1),
    (NULL, 22, 0),
    (NULL, 22, 0),
    (NULL, 22, 0),
    -- "0023"
    (NULL, 23, 1),
    (NULL, 23, 0),
    (NULL, 23, 0),
    (NULL, 23, 0),
    -- "0024"
    (NULL, 24, 0),
    (NULL, 24, 1),
    (NULL, 24, 0),
    (NULL, 24, 0),
    -- "0025"
    (NULL, 25, 0),
    (NULL, 25, 1),
    (NULL, 25, 0),
    (NULL, 25, 0),
    -- "0026"
    (NULL, 26, 0),
    (NULL, 26, 1),
    (NULL, 26, 0),
    (NULL, 26, 0),
    -- "0027"
    (NULL, 27, 0),
    (NULL, 27, 1),
    (NULL, 27, 0),
    (NULL, 27, 0),
    -- "0028"
    (NULL, 28, 0),
    (NULL, 28, 0),
    (NULL, 28, 0),
    (NULL, 28, 1),
    -- "0029"
    (NULL, 29, 0),
    (NULL, 29, 0),
    (NULL, 29, 0),
    (NULL, 29, 1),
    -- "0030"
    (NULL, 30, 1),
    (NULL, 30, 0),
    (NULL, 30, 0),
    (NULL, 30, 0);

INSERT INTO `RESPUESTAIMAGENES`
    (`respuestaId`, `imagen`)
VALUES
    -- "0001"
    (1, "C:\imagenes\respuestas\00000001.svg"),
    (2, "C:\imagenes\respuestas\00000002.svg"),
    (3, "C:\imagenes\respuestas\00000003.svg"),
    (4, "C:\imagenes\respuestas\00000004.svg"),
    -- "0006"
    (21, "C:\imagenes\respuestas\00000021.svg"),
    (22, "C:\imagenes\respuestas\00000022.svg"),
    (23, "C:\imagenes\respuestas\00000023.svg"),
    (24, "C:\imagenes\respuestas\00000024.svg"),
    -- "0019"
    (73, "C:\imagenes\respuestas\00000073.svg"),
    (74, "C:\imagenes\respuestas\00000074.svg"),
    (75, "C:\imagenes\respuestas\00000075.svg"),
    (76, "C:\imagenes\respuestas\00000076.svg"),
    -- "0020"
    (77, "C:\imagenes\respuestas\00000077.svg"),
    (78, "C:\imagenes\respuestas\00000078.svg"),
    (79, "C:\imagenes\respuestas\00000079.svg"),
    (80, "C:\imagenes\respuestas\00000080.svg"),
    -- "0026"
    (101, "C:\imagenes\respuestas\00000101.svg"),
    (102, "C:\imagenes\respuestas\00000102.svg"),
    (103, "C:\imagenes\respuestas\00000103.svg"),
    (104, "C:\imagenes\respuestas\00000104.svg");

INSERT INTO `RESPUESTATEXTOS`
    (`respuestaId`, `texto`)
VALUES
    -- "0001"
    /* (@respuestaId = 1,                  "París"                 ),
    (@respuestaId = @respuestaId + 1,   "Londres"               ),
    (@respuestaId = @respuestaId + 1,   "Madrid"                ),
    (@respuestaId = @respuestaId + 1,   "Lisboa"                ), */
    -- "0002"
    (@respuestaId := 5, "Pablo Picasso"                          ),         
    (@respuestaId := @respuestaId + 1, "Leonardo da Vinci"       ),
    (@respuestaId := @respuestaId + 1, "Vincent van Gogh"        ),
    (@respuestaId := @respuestaId + 1, "Salvador Dalí"           ),
    -- "0003"
    (9, "Venezuela"),
    (10, "Madrizzz"),
    (11, "Guarromán"),
    (12, "Benalmádena"),
    -- "0004"
    (13, "Oxígeno"),
    (14, "Carbono"),
    (15, "Hierro"),
    (16, "Hidrógeno"),
    -- "0005"
    (17, "1912"),
    (18, "1914"),
    (19, "1918"),
    (20, "1922"),
    -- "0006"
    (21, "Fútbol"),
    (22, "Voleibol"),
    (23, "Tenis"),
    (24, "Atletismo"),
    -- "0007"
    (25, "1776"),
    (26, "1789"),
    (27, "1804"),
    (28, "1820"),
    -- "0008"
    (29, "Nitrógeno"),
    (30, "Oxígeno"),
    (31, "Dióxido de carbono"),
    (32, "Aragón"),
    -- "0009"
    (33, "Martin Scorsese"),
    (34, "Francis Ford Coppola"),
    (35, "Steven Spielberg"),
    (36, "Quentin Tarantino"),
    -- "0010"
    (37, "Gabriel García Márquez"),
    (38, "Miguel de Cervantes"),
    (39, "Federico García Lorca"),
    (40, "Jorge Luis Borges"),
    -- "0011"
    (41, "Rock"),
    (42, "Reggae"),
    (43, "Pop"),
    (44, "Hip-hop"),
    -- "0012"
    (45, "Clorofila"),
    (46, "Melanina"),
    (47, "Hemoglobina"),
    (48, "Antocianina"),
    -- "0013"
    (49, "Amazonas"),
    (50, "Nilo"),
    (51, "Misisipi"),
    (52, "Yangtsé"),
    -- "0014"
    (53, "Vincent van Gogh"),
    (54, "Leonardo da Vinci"),
    (55, "Pablo Picasso"),
    (56, "Claude Monet"),
    -- "0015"
    (57, "1889"),
    (58, "1901"),
    (59, "1925"),
    (60, "1950"),
    -- "0016"
    (61, "Oxígeno"),
    (62, "Silicio"),
    (63, "Hierro"),
    (64, "Aluminio"),
    -- "0017"
    (65, "Vincent van Gogh"),
    (66, "Pablo Picasso"),
    (67, "Salvador Dalí"),
    (68, "Claude Monet"),
    -- "0018"
    (69, "Charles Dickens"),
    (70, "William Shakespeare"),
    (71, "Jane Austen"),
    (72, "Fyodor Dostoevsky"),
    -- "0019"
    (73, "John Lennon"),
    (74, "Freddie Mercury"),
    (75, "Elvis Presley"),
    (76, "Mick Jagger"),
    -- "0020"
    (77, "Fútbol"),
    (78, "Hockey sobre hielo"),
    (79, "Baloncesto"),
    (80, "Golf"),
    -- "0021"
    (81, "China"),
    (82, "Estados Unidos"),
    (83, "Rusia"),
    (84, "India"),
    -- "0022"
    (85, "Tom Hanks"),
    (86, "Leonardo DiCaprio"),
    (87, "Brad Pitt"),
    (88, "Johnny Depp"),
    -- "0023"
    (89, "Fotosíntesis"),
    (90, "Respiración celular"),
    (91, "Mitosis"),
    (92, "Transpiración"),
    -- "0024"
    (93, "Egipcia"),
    (94, "Mesopotamia"),
    (95, "Romana"),
    (96, "China"),
    -- "0025"
    (97, "Charlotte Brontë"),
    (98, "Jane Austen"),
    (99, "Emily Brontë"),
    (100, "Charles Dickens"),
    -- "0026"
    (101, "Abbey Road (The Beatles)"),
    (102, "Thriller (Michael Jackson)"),
    (103, "Dark Side of the Moon (Pink Floyd)"),
    (104, "Back in Black (AC/DC)"),
    -- "0027"
    (105, "Michelangelo"),
    (106, "Auguste Rodin"),
    (107, "Pablo Picasso"),
    (108, "Leonardo da Vinci"),
    -- "0028"
    (109, "Atlántico"),
    (110, "Índico"),
    (111, "Antártico"),
    (112, "Pacífico"),
    -- "0029"
    (113, "8"),
    (114, "10"),
    (115, "11"),
    (116, "12"),
    -- "0030"
    (117, "Hidrógeno"),
    (118, "Helio"),
    (119, "Oxígeno"),
    (120, "Carbono");
