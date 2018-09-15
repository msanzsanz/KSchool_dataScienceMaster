# Machine learning notes from Sept 14th 

## Introduction
Goal: Automatizar tareas cognitivas. Aún estamos lejos de la automatización total, suele hacer falta un humano como fase final (concedemos créditos si/no, etc)

## Cómo aprenden las máquinas:

### Por generalización (aprendizaje supervisado)
Extracción de características e identificación de reglas para clasificar los modelos no vistos.

| Forma         | Color         | Area  | Etiqueta |
| ------------- |:-------------:| -----:| --------:|
| cuadrada      | rellena       |    16 | Tipo1    |
| circular      | noRellena     |    12 | Tipo2    |
| cuadrada      | noRellena     |     1 | Tipo1    |

Ej: Reconocimiento facial, estimación precio casas, spam filter, identificación caracteres escritos, 

#### Regresión
Predict a continuous value
#### Clasifiación
Predict a discrite value

### Por comparación (aprendizaje no supervisado)
Igual que antes, pero no hay etiqueta. 
Los objetos se agrupan por similitud.

Ej: Segmentación clientes, detección fraude (anomalía con respecto a las otras),  sistemas recomendación (gente que mas se parezca a ti, articulos semejantes a los articulos comprados por ti, intentar comprender la música (energia, como de famosa es)

#### Clustering
#### Reducción de dimensionalidad
#### Motores de recomendación

### Por refuerzo (reinforcement learning)
Según la acción que haga el algoritmo se le da una recompensa.
Parecido a lo que se hace con las palomas, dándoles un premio cuando aciertan. Lo mismo ocurre con los coches que conducen solos. (el algoritmo se realimenta con la métrica según la acción que haces. El algoritmo siempre intenta maximizar la métrica)
Lo mismo hizo el MIT con su algoritmo para volar.


Deep learning automatiza de cierta forma la extracción de características y ademas puede llegar mas lejos que los algoritmos tradiccionales.


## Ejemplos:

### Should the car go fast or slow?

Features: Baches de la carretera + pendiente


### Arboles de decision
En cada fase del arbol, divido mi dataset en dos dataset mas homogéneos que el original.
echar un ojo al gini y entropia


### Ensemble methods
