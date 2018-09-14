# Machine learning notes from Sept 14th 

## Introduction
Goal: Automatizar tareas cognitivas. Aún estamos lejos de la automatización total, suele hacer falta un humano como fase final (concedemos créditos si/no, etc)

## Cómo aprenden las máquinas:

### Por generalización
Extracción de características e identificación de reglas para clasificar los modelos no vistos.

| Forma         | Color         | Area  | Etiqueta |
| ------------- |:-------------:| -----:| --------:|
| cuadrada      | rellena       |    16 | Tipo1    |
| circular      | noRellena     |    12 | Tipo2    |
| cuadrada      | noRellena     |     1 | Tipo1    |

### Por comparación
Igual que antes, pero no hay etiqueta. 
Los objetos se agrupan por similitud.

### Por refuerzo
Según la acción que haga el algoritmo se le da una recompensa.
Parecido a lo que se hace con las palomas, dándoles un premio cuando aciertan. Lo mismo ocurre con los coches que conducen solos. (el algoritmo se realimenta con la métrica según la acción que haces. El algoritmo siempre intenta maximizar la métrica)
Lo mismo hizo el MIT con su algoritmo para volar.







