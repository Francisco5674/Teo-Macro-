# Tara 1 Teoría Macroeconómica 1

## Datos del alumno

| Nombre | Mail UC |
| :-: | :-: |
| {Francisco Fuentes} | {francisco.fuentes@uc.cl} |

## Consideraciones generales :thinking:

* El desarrollo de mi tarea en ocasiones se escapa de las peticiones del enunciado con el proposito de investigar el alcance de mi programa. Es más en muchas ocasiones realicé ciertas funciones o algoritmos antes de que me los pidieran puesto que facilitan el proceso de construcción de mi código. 
Espero que disculpen mi osadía, pero creo firmemente que mejoran mi exprincia de aprendizaje. 

## Ejecución :computer:
* Como fue solicitado, cada pregunta tiene un programa distinto, a decir verdad, planeaba hacerlo de esa manera desde el principio, pero entiendo porque lo están pidiendo. Cada pregunta parte con los comandos ```clear``` y ```clc```
para ser lo más ordenado posible.

## Funciones propias :books:
* ```All_betas``` **P1**: Basicamente usa la función ```Betas``` para crear tantos estimadores como muestras de cada variable se dispongan.
* ```BS``` **P3**: función basada en el algoritmo de bisección.
* ```Betas``` **P1**: está función entregará una matriz tridimencional, donde cada fila es un "beta" distinto, incluyendo el coeficiente de posición. El primer elemento de las filas es el coeficiente de posición y el resto es el beta de cada variable dependiente con respecto al orden al que fueron ingresados 
* ```Data_sample``` **P1**: cumple la función requerida por random, sin embargo, está no grafica las distribuciones.
* ```f1``` **P3**: función (12) del enunciado.
* ```fprima1``` **P3**: Primera derivada de la función (12) del enunciado.
* ```f2``` **P3**: función (13) del enunciado.
* ```fprima2``` **P3**: Primera derivada de la función (13) del enunciado.
* ```f3``` **P3**: función (14) del enunciado.
* ```fprima3``` **P3**: Primera derivada de la función (14) del enunciado.
* ```HP``` **P2**: función pedida en el enunciado.
* ```H``` **P3**: función descripción de la trayectoria en caida libre.
* ```Hprima``` **P3**: Primera derivada de ```H```.
* ```Hprimaprima``` **P3**: Segunda derivada de ```H```.
* ```MatrixA``` **P2**: crea la matriz A del enunciado en base a las dimensiones y un lambda.
* ```MatrixK``` **P2**: crea la matriz K del enunciado en base a las dimensiones.
* ```NR``` **P3**: función basada en el algoritmo de Newton-Raphson.
* ```points_xt``` **P4**: Genera "n" puntos de la sucesión descrita en el enunciado, es necesario entregarle una semilla inicial "x0" y los parametros de ```xt1```. Además puedes agregar tantos shocks como sean requridos, para esto es necsario indicar con un vector que periodos se verán afectados "t_p" y el tamaño de la perturbación "p".
* ```Sample``` **P1**: genera un vector columna que corresponde a una mustra aleatoria de tamaño "n" del vector "vector".
* ```xt1``` **P4**: función que genera cada punto de la sucesión. Esto lo logra usando el punto anterior y el parametro phi. Sin embargo, es posible añadir incertidumbre al resultado si ingresas el string "N" en el parametro "eps_d" y que tanta dispersión es requerida en los shocks "sd".


