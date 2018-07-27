## Sistemas de recomendacion

# Actores
Usuarios
Items
Relaciones
  implicitas (cuando no hay rating)
  explicitas (cuando hay rating)
  
  
 # PASOS RECOMENDACION
  1. Estimar preferencias ^p u i (preferencia estimada del usuario u al item i)
  2. Ordenar preferencias
  
  # MODELOS
  Tres modelos principales basados en recomendacion
  1. Basados en popularidad
    Ordenan las preferencias en base a frecuencia, esto es, el elemento mas consumido por todos nosotros.
    
  2. Filtrado colaborativo
    Noción de singularidad, con su concepto de distancia y representación asociados.
    Este tipo de algoritmos trata de averiguar la similaridad entre dos items
    La representación se refiere a cómo puedo proyectar el dato para que sea fácil encontrar la distancia.
    
    Para definir la similitud hay que definir una métric de distancia
    Otro concepto interesante es la representación, i.e., como represento mis datos para poder encontrar similitudes
    
    
  3. Basados en contenido
    El conjunto de caracteristicas que define el producto es el elemento que se explota para hacer la recomendación.
    
  # METRICAS
  Responde a la pregunta de cómo se evalua la calidad de una recomendación.
  
  1. Accuracy (RMSE) 
  Distancia medio-promedio. Es muy usada cuando se trabaja con ratings explicitos.
  No suele ser la mas usada.
  
  2. Relevancia
  
    a)  Sin orden
        Serían las métricas mas usadas
        De la recomendación que yo hago, cuál es el % de aciertos.
        recall@k, precision@k
  
    b) Ordenadas
        Dónde penaliza las recomendaciones mas alejadas
        MAP
  
