USE `TRIVIAL`;

SET @partida = JSON_OBJECT (
    -- "partidaId",             5,
    "fecpartida",           "2024-01-26",
    "partidatiempo",        11,
    "nomDificultad",        "Intermedio",
    "emailuser",            "ana@gmail.com"
);

SELECT JSON_VALID( @partida );
CALL AddGame( @partida );

SET @dataQuestions = JSON_OBJECT (
    "categories", JSON_ARRAY ( 
        JSON_OBJECT ( 
            "category",     "Geografía",
            "questions", JSON_ARRAY ( 
                JSON_OBJECT ( 
                    "questiontext",         "¿Cuál es la capital de España?",
                    /* "answers", JSON_ARRAY(
                        JSON_OBJECT ( 
                            "answertext",          "Madrid",
                            "correct",             true
                        ),
                        JSON_OBJECT ( 
                            "answertext",          "Barcelona"
                        ),
                        JSON_OBJECT ( 
                            "answertext",          "Toledo"
                        ),
                        JSON_OBJECT ( 
                            "answertext",          "Sevilla"
                        )

                    ) */
                    "answertext1",          "Madrid",
                    "answertext2",          "Barcelona",
                    "answertext3",          "Toledo",
                    "answertext4",          "Sevilla",
                    "correctanswer",        1
                ),
                JSON_OBJECT ( 
                    "questiontext",         "¿Qué pinto el Guernica?",
                    
                    
                    "answerimage1",         "images/ruta/200001.jpg", -- Vincent Van Gogh
                    "answerimage2",         "images/ruta/200002.jpg", -- Picasso
                    "answerimage3",         "images/ruta/200003.jpg", -- Goya
                    "answerimage4",         "images/ruta/200004.jpg", -- Dali
                    "correctanswer",        2
                ),
                JSON_OBJECT ( 
                    "questiontext",         "¿Quién pintó La habitación?",
                    -- "questionimage",        "images/ruta/101010.jpg",

                    "answertext1",          "Vincent Van Gogh",
                    "answertext2",          "Picasso",
                    "answertext3",          "Goya",
                    "answertext4",          "Dali",
                    "answerimage1",         "images/ruta/300001.jpg", -- Vincent Van Gogh
                    "answerimage2",         "images/ruta/300002.jpg", -- Picasso
                    "answerimage3",         "images/ruta/300003.jpg", -- Goya
                    "answerimage4",         "images/ruta/300004.jpg", -- Dali
                    "correctanswer",        1
                ),
                JSON_OBJECT ( 
                    "questiontext",         "¿Cuál es la capital de España?",
                    "questionimage",        "images/ruta/españa.jpg",
                    "answertext1",          "Madrid",
                    "answertext2",          "Barcelona",
                    "answertext3",          "Toledo",
                    "answertext4",          "Sevilla",
                    "correctanswer",        1
                ),
                JSON_OBJECT ( 
                    "questiontext",         "¿Quién pinto el siguiente cuadro?",
                    "questionimage",        "images/ruta/000005.jpg",
                    
                    "answerimage1",         "images/ruta/200001.jpg", -- Vincent Van Gogh
                    "answerimage2",         "images/ruta/200002.jpg", -- Picasso
                    "answerimage3",         "images/ruta/200003.jpg", -- Goya
                    "answerimage4",         "images/ruta/200004.jpg", -- Dali
                    "correctanswer",        4
                ),
                JSON_OBJECT ( 
                    "questiontext",         "¿Quién pinto el siguiente cuadro-6?",
                    "questionimage",        "images/ruta/000006.jpg",

                    "answertext1",          "Vincent Van Gogh",
                    "answertext2",          "Picasso",
                    "answertext3",          "Goya",
                    "answertext4",          "Dali",
                    "answerimage1",         "images/ruta/300001.jpg", -- Vincent Van Gogh
                    "answerimage2",         "images/ruta/300002.jpg", -- Picasso
                    "answerimage3",         "images/ruta/300003.jpg", -- Goya
                    "answerimage4",         "images/ruta/300004.jpg", -- Dali
                    "correctanswer",        3
                )
            )
        ),
        JSON_OBJECT ( 
            "category",     "Arte",
            "questions", JSON_ARRAY (                     
                JSON_OBJECT ( 
                    "questiontext",         "Arte.¿Qué pinto el Guernica?",
                    
                    
                    "answerimage1",         "images/ruta/200001.jpg", -- Vincent Van Gogh
                    "answerimage2",         "images/ruta/200002.jpg", -- Picasso
                    "answerimage3",         "images/ruta/200003.jpg", -- Goya
                    "answerimage4",         "images/ruta/200004.jpg", -- Dali
                    "correctanswer",        2
                ),
                JSON_OBJECT ( 
                    "questiontext",         "Arte.¿Quién pintó La habitación?",
                    -- "questionimage",        "images/ruta/101010.jpg",

                    "answertext1",          "Vincent Van Gogh",
                    "answertext2",          "Picasso",
                    "answertext3",          "Goya",
                    "answertext4",          "Dali",
                    "answerimage1",         "images/ruta/300001.jpg", -- Vincent Van Gogh
                    "answerimage2",         "images/ruta/300002.jpg", -- Picasso
                    "answerimage3",         "images/ruta/300003.jpg", -- Goya
                    "answerimage4",         "images/ruta/300004.jpg", -- Dali
                    "correctanswer",        1
                ),
                JSON_OBJECT ( 
                    "questiontext",         "Arte.¿Cuál es la capital de España?",
                    "questionimage",        "images/ruta/españa.jpg",
                    "answertext1",          "Madrid",
                    "answertext2",          "Barcelona",
                    "answertext3",          "Toledo",
                    "answertext4",          "Sevilla",
                    "correctanswer",        1
                ),
                JSON_OBJECT ( 
                    "questiontext",         "Arte.¿Quién pinto el siguiente cuadro?",
                    "questionimage",        "images/ruta/000005.jpg",
                    
                    "answerimage1",         "images/ruta/200001.jpg", -- Vincent Van Gogh
                    "answerimage2",         "images/ruta/200002.jpg", -- Picasso
                    "answerimage3",         "images/ruta/200003.jpg", -- Goya
                    "answerimage4",         "images/ruta/200004.jpg", -- Dali
                    "correctanswer",        4
                ),
                JSON_OBJECT ( 
                    "questiontext",         "Arte.¿Quién pinto el siguiente cuadro-6?",
                    "questionimage",        "images/ruta/000006.jpg",

                    "answertext1",          "Vincent Van Gogh",
                    "answertext2",          "Picasso",
                    "answertext3",          "Goya",
                    "answertext4",          "Dali",
                    "answerimage1",         "images/ruta/300001.jpg", -- Vincent Van Gogh
                    "answerimage2",         "images/ruta/300002.jpg", -- Picasso
                    "answerimage3",         "images/ruta/300003.jpg", -- Goya
                    "answerimage4",         "images/ruta/300004.jpg", -- Dali
                    "correctanswer",        3
                )
            )
        )
    )
);
SELECT JSON_VALID( @dataQuestions );
CALL AddQuestions( @dataQuestions );
/* 
{  "categorias": [    
        {      
            "nombre": "Categoria1",      
            "preguntas": [        
                {          
                    "id": 1,          
                    "pregunta": "¿Cuál es la capital de Francia?",          
                    "respuesta": "París",          
                    "imagen": "imagen1.jpg"        
                },        
                {          
                    "id": 2,          
                    "pregunta": "¿En qué año se descubrió América?",          
                    "respuesta": "1492",          
                    "imagen": "imagen2.jpg"        
                }      
            ]    
        },    
        {      
            "nombre": "Categoria2",      
            "preguntas": [        
                {          
                    "id": 3,          
                    "pregunta": "¿Quién escribió Romeo y Julieta?",          
                    "respuesta": "William Shakespeare",          "imagen": "imagen3.jpg"        },        {          "id": 4,          "pregunta": "¿Cuántos planetas hay en nuestro sistema solar?",          "respuesta": "Ocho",          "imagen": "imagen4.jpg"        }      ]    }  ]}

{   
    "arte": 
    {     
        "question": "What is the most famous painting in the world?",     
        "answer": "The Mona Lisa by Leonardo da Vinci"  
    },
    {     
        "question": "What is the most famous painting in the world?",     
        "answer": "The Mona Lisa by Leonardo da Vinci"  
    }   
    "historia": 
    {     
        "question": "Who is considered the father of modern art?",     
        "answer": "Pablo Picasso"  
    } 
} */