const trivial = {
    "0001": {
        isShown: false,
        category: "Geografía",
        question: "¿Cuál es la capital de Francia?",
        answers: {
            A: {
                textanswer: "París",
                right: true // trivial[ 0 ].respuestas[ 0 ][ "right" ] o trivial[ 0 ].respuestas[ 0 ].right.
            },
            B: {
                textanswer: "Londres"
            },
            C: {
                textanswer: "Madrid"
            },
            D: {
                textanswer: "Lisboa"
            }
        }
    },
    "0002": {
        isShown: false,
        category: "Arte",
        question: "¿Quién pintó la Mona Lisa?",
        answers: {
            A: {
                textanswer: "Pablo Picasso",
            },
            B: {
                textanswer: "Vincent van Gogh"
            },
            C: {
                textanswer: "Salvador Dalí"
            },
            D: {
                textanswer: "Leonardo da Vinci",
                right: true // trivial[ 0 ].respuestas[ 0 ][ "right" ] o trivial[ 0 ].respuestas[ 0 ].right.
            }
        }
    },
    "0003": {
        isShown: false,
        category: "Geografía",
        question: "¿Cuál es la capital de España?",
        answers: {
            A: {
                textanswer: "París"

            },
            B: {
                textanswer: "Londres"
            },
            C: {
                textanswer: "Madrid",
                right: true // trivial[ 0 ].respuestas[ 0 ][ "right" ] o trivial[ 0 ].respuestas[ 0 ].right.
            },
            D: {
                textanswer: "Lisboa"
            }
        }
    }
};

// Cambiar false isShown a true.
// Cuando la pregunta haya sido contestada o el tiempo haya acabado, genero un nuevo numero aleatorio.


let GLOBAL_idTimeOut;

document.addEventListener("DOMContentLoaded", ready);

function getQuestionsShownNumber() {
    let iQuestionsShown = 0;
    for (const key in trivial) {
        console.log(key);
        console.log(trivial[key].isShown);
        if (trivial[key].isShown) {
            iQuestionsShown++;
        }
    }
    console.log(`iQuestionsShown = ${iQuestionsShown}`);

    return iQuestionsShown;
}

function ready(event) {
    

    const nodesButton = document.querySelectorAll(".respuestas button");
    // Tenemos que inicializar a 30 segundos el timer. OK
    // Borrar las clases right, wrong, righthighlighted y waitingright OK.
    // Comprobar si el código de la pregunta tiene el isShown a true, si es así que me genere otro código.

    const nodeTimer = document.querySelector ( ".timer" );
    nodeTimer.innerText = 5;

    if (sihaypreguntasdisponibles() ) {
        const keyQuestion =  setNewRandomQuestion();
        
        // Coger los valores del objeto y al DOM.
        setQuestionDOM(keyQuestion); 
        setAnswersDOM(keyQuestion);

        nodesButton.forEach(nodeButton => {
            // Definimos los eventos de los button (respuestas posibles.)
            nodeButton.addEventListener("click", onClickAnswer);
            // Inicializar las clases de los button
            nodeButton.classList.remove("right", "wrong", "righthighlighted", "waitingright");
        });                                                

        changeAutomatically();
        
    } else {
        console.log("Todas las preguntas han sido contestadas.");
        const nodeOverlayGameOver = document.querySelector(".overlay.gameover");
        nodeOverlayGameOver.classList.remove("hiddend");
    }
}

function sihaypreguntasdisponibles() {
    const iQuestionsShown = getQuestionsShownNumber();
    if (iQuestionsShown !== Object.keys(trivial).length ) {
        return true;
    } else {
        return false;
    }
    
}

function setNewRandomQuestion() {
    let iQuestion;
    let keyQuestion;
    
    do {
        iQuestion = getRandomIntNumber(1, Object.keys(trivial).length);
        console.log(iQuestion);
        // Llamamos a una función que me completa con ceros.
        keyQuestion = getKeyQuestion(iQuestion);
    //} while ( keyQuestion isShown === true )
    } while ( trivial[ keyQuestion ].isShown )
    // Damos la pregunta por mostrada, así tenemos la posibilidad de hacer que la pregunta no aparezca de nuevo en la partida.
    trivial[keyQuestion].isShown = true;
    
    return keyQuestion;
}

// Función que gestiona el contador del tiempo.
function changeAutomatically() {
    GLOBAL_idTimeOut = setTimeout(() => {
        const nodeTimer = document.querySelector(".timer");
        --nodeTimer.innerText;

        if (nodeTimer.innerText !== "0") {
            changeAutomatically();
        } else {
            // El usuario ya no puede pulsar.
            disabledClickAnswer();
            // Averiguar la respuesta correcta y señalarla en el pantalla.
            const nodeRightAnswer = getNodeAnswerRight();
            console.log(nodeRightAnswer);
            nodeRightAnswer.classList.add("righthighlighted");
            xxxx();
        }
    }, 1000);
}

function getNodeAnswerRight() {
    let i = 0;
    const nodesButton = document.querySelectorAll(".respuestas button");
    /* console.log( nodesButton ); */
    const nodeQuestion = document.querySelector("span.imagenquiz");
    const keyQuestion = nodeQuestion.getAttribute("data-idQuestion");
    for (let key in trivial[keyQuestion].answers) {
        if (trivial[keyQuestion].answers[key].right) {
            console.log(i);
            return nodesButton[i]; // Retorno el nodo button de la respuesta que es correcta.
        }
        i++;
    }
}

// Borra los eventos en los nodos de las respuestas.
function disabledClickAnswer() {
    const nodesButton = document.querySelectorAll(".respuestas button");
    nodesButton.forEach(nodeButton => {
        nodeButton.removeEventListener("click", onClickAnswer);
    });
}

function onClickAnswer() {
    let keyQuestion;
    let i = 0;

    clearTimeout(GLOBAL_idTimeOut);

    disabledClickAnswer();

    const nodeQuestion = document.querySelector("span.imagenquiz");
    console.log(`Has pulsado en ${this.innerText}`);

    keyQuestion = nodeQuestion.getAttribute("data-idQuestion");

    for (let key in trivial[keyQuestion].answers) {
        if (trivial[keyQuestion].answers[key].right) {
            if (this.innerText === trivial[keyQuestion].answers[key].textanswer) {
                controlAnimation(this, null);

                //this.classList.add( "right" );
            } else {
                const nodeAnswers = document.querySelectorAll(".respuestas button");
                controlAnimation(nodeAnswers[i], this);
                /* 
                this.classList.add( "wrong" );
                nodeAnswers[ i ].classList.add ( "right" ); */
            }
        }
        i++;
    }

    /*  console.log( trivial[ keyQuestion ].answers.A.right );
     console.log( trivial[ keyQuestion ].answers.B.right );
     console.log( trivial[ keyQuestion ].answers.C.right );
     console.log( trivial[ keyQuestion ].answers.D.right ); */

}

function setQuestionDOM(keyQuestion) {
    const nodeQuestion = document.querySelector("span.imagenquiz");
    nodeQuestion.innerText = trivial[keyQuestion].question;
    nodeQuestion.setAttribute("data-idQuestion", keyQuestion);
}

// Escribe en el DOM las respuestas del objeto de pregunta trivial.
function setAnswersDOM(keyQuestion) {
    const answers = trivial[keyQuestion].answers;
    const nodeAnswers = document.querySelectorAll(".respuestas button");
    let i;
    /* nodeAnswers[ 0 ].innerText = answers[ "A" ].textanswer;
    nodeAnswers[ 1 ].innerText = answers[ "B" ].textanswer;
    nodeAnswers[ 2 ].innerText = answers[ "C" ].textanswer;
    nodeAnswers[ 3 ].innerText = answers[ "D" ].textanswer; */
    i = 0;
    for (let key in answers) {
        nodeAnswers[i].innerText = answers[key].textanswer;
        i++;
    }
}

// Transformar el numero aleatorio en el formato de nuestra estructura.
function getKeyQuestion(iQuestion) {
    return iQuestion.toString().padStart(4, '0');
}

function controlAnimation(nodeRight, nodeWrong) {
    const nodeAnswers = document.querySelectorAll(".respuestas button");

    //
    nodeAnswers.forEach(element => {
        element.classList.add("waitingright");
    });

    // Declaramos evento de animationend en el nodo[ 0 ] que pertenece a la primera respuesta posible
    nodeAnswers[0].addEventListener("animationend", function (event) {
        console.log(nodeRight);
        onAnimationEnd(nodeRight, nodeWrong, event);
    });
}

function onAnimationEnd(nodeRight, nodeWrong, event) {
    console.log("Animación finalizada.");

    console.log(event);
    console.log(nodeRight);
    nodeRight.classList.add("right");
    if (nodeWrong !== null) {
        nodeWrong.classList.add("wrong");
    }
    xxxx();
}

function xxxx() {
    setTimeout(() => {
        const nodeAnswers = document.querySelectorAll(".respuestas button");
        const nodeParent = nodeAnswers[0].parentElement;
        nodeAnswers[0].remove();

        nodeParent.innerHTML = "<button></button>";

        ready();

    }, 3000);
}