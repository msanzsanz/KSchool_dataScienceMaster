# Machine learning notes from Sept 14th 

## Introduction
Goal: Automatizar tareas cognitivas. Aún estamos lejos de la automatización total, suele hacer falta un humano como fase final (concedemos créditos si/no, etc)

## Feature extraction

Varias cosas:

1. Localizar nan y ver qué hacer con ellos (reemplazarlos por mean, eliminar la columna si hay muchos nan, etc.)
2. Localizar outliers y ver qué hacer con ellos (eliminarlos, hacer dos grupos separados, etc.)
3. Convertir variables categoricas con onehotencoder pero, puedes tener la maldición por muchas features.
Si esto ocurre, puedo transformar mis variables categóricas a números.
Dos opciones para transformar las variables categóricas: Dummies o pesos
4. Normalizar variables continas (RobustScaler)
Para el randomforex el scalado no sería tan importante, pero como luego se compara con otros algoritmos, pues es bueno hacerlo.
5. Pipeline
6. Echar un ojo a TPOT

## Cómo aprenden las máquinas:

### 1. Por generalización (aprendizaje supervisado)
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

### 2. Por comparación (aprendizaje no supervisado)
Igual que antes, pero no hay etiqueta. 
Los objetos se agrupan por similitud.

Ej: Segmentación clientes, detección fraude (anomalía con respecto a las otras),  sistemas recomendación (gente que mas se parezca a ti, articulos semejantes a los articulos comprados por ti, intentar comprender la música (energia, como de famosa es)

#### Clustering
#### Reducción de dimensionalidad
#### Motores de recomendación

### 3. Por refuerzo (reinforcement learning)
Según la acción que haga el algoritmo se le da una recompensa.
Parecido a lo que se hace con las palomas, dándoles un premio cuando aciertan. Lo mismo ocurre con los coches que conducen solos. (el algoritmo se realimenta con la métrica según la acción que haces. El algoritmo siempre intenta maximizar la métrica)
Lo mismo hizo el MIT con su algoritmo para volar.


Deep learning automatiza de cierta forma la extracción de características y ademas puede llegar mas lejos que los algoritmos tradiccionales.


## Algoritmos de clasificación

### Should the car go fast or slow?

Features: Baches de la carretera + pendiente


### Arboles de decision
En cada fase del arbol, divido mi dataset en dos dataset mas homogéneos que el original.
echar un ojo al gini y entropia


## Ensemble methods

### Votación
Mergear diferentes algoritmos de clasificación no siempre da resultados mejores, como vimos en el ejemplo.

### Stacking
En vez de hacer una votación simple, en la caja que agrupa los resultados se aplica también ML para intentar dar una votación algo mas inteligente.
Al igual que antes, stacking no siempre da mejor resultado que los clasificadores aisladamente.

### Ensemble learning
El ensamblado se hace secuencialmente, contando con la respuesta de los clasificadores anteriores.

#### Bagging
El clasificador es el mismo, pero los datos de entrada son diferentes. Puedes entrenar cada modelo con diferentes muestras de tu población, o con diferentes features por modelo.
Curioso, porque esto suele mejorar mas que voting o stacking. Conclusion: se obtienen mejores modelos variando los datos de entrada que los clasificadores.
La manera de fusionar las respuestas es por votación sencilla.

**Random forest**
No es mas que un bagging donde el clasificador base es un decision tree.
Usa feature importances 

#### Bosted learn

**Adaboost**
En cada paso el método acierta o falla. En el siguiente paso, se intenta acertar cuando antes se equivocó
pone un coeficiente a cada experimento (número de errores del experimento) y luego pone un peso a cada error.

**XGBoost**
este ganaba casi todas las combinaciones de kaggle.
Lo que hace es ir que predice el valor y predice el error. Y adicionalmente, los siguientes expertos lo que hacen es predecir el error del anterior e intentar predecirlo.

Para limitar la complejidad del modelo (numero de capas predictoras del error), se añade lo que se denomina reguralizacion. 

XGBoost se hace con arboles de decisión
En cada bucle el algoritmo se pregunta: debería crecer en el arbol en el que estoy o debería crear uno nuevo?

## Algoritmos de regresión

| Alg           | Variabl       | Metrics   | 
| ------------- |:-------------:| -----:| 
| KNN      | n_neigbors       |    MAE: meanAbsoluteError | 
|       |      |    MSE: meanSquaredError | 
|       |      |    RMSE: squaredRoot (MSE) |
|       |      |    MAPE: como MAE, pero % | 
| DecissionTree      | min_leaf, max_depth       |     | 
| Lineal regression      |      |     | 
| RandomForest      |      |     |
| XGBoost      |      |    | 
