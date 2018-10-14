################
################  DIA 2
################
################
#  
#  Si un modelo acierta siempre --> nos hemos equivocado
#  Hay que buscar algo que generalize. Modelos generalizables
#  Vale para lo general, pero no para lo particular
#  
#  El objetivo no es el número, sino el intervalo de confianza
#  
#  MCO = mínimos cuadrados ordinarios. Es el sistema que nos permite sacar una formula en 
#  la regresion lineal
# El objetivo es que los residuos sean lo mas pequeños posible. Minimizar la suma de los residuos al cuadrado 
# (también se podrían coger el absuluto)

# 
# Esto realmente es la funcion de coste.
# En Machine learning la función de coste puede ser diferente (xej, maximizar beneficio, minimizar coste)
# )


# Regresion lineal ---> Lineal en coeficientes. 
# Me da igual lo que tenga las x (puede ser logaritmo, exponencial, etc)
# 
# La estadistica mide la relación entre las variables
# El machine learning lo que quiere es predecir, le da igual la relacion entre las variables
# 
# La estadística se centra en los coeficientes y machine learning en la variable dependiente
# 
# En estadistica no se divide el set de datos entre entrenamiento, validación y test. Sino que se cogen todos los datos
# Aunque la recomendación es hacerlo para testear las nuevas hipotesis que vayan surgiendo
# 
# REGRESION LNEAL SIMPLE (x = a + bx)
#    b = pendiente
#      positiva (directo) o negativa (inverso)
# 
# La correlación es simétrica. Si hay relación entre peso y altura, también la hay entre altura y peso
# El análisis de causa y efecto no es regresion. No mide la correlación entre variables sino la causa-efecto
# Si un hombre crece, pesará mas???  Eso es causa efecto, no correlación
# 
# multicolinealidad == No puede haber una variable que se construya a partir de las otras de manera exacta
# # 
# Exogeneidad debil ya está incluido en los algorithmos implementados, al igualqque la multicolinealidad perfecta

# 
#  ln y = a + b ln x, la hiperbola que pinta la relación entre precio y ventas.

# 
# Business inteligence: Certidumbre. Estudio de lo que pasó en el pasado
# Data science: incertidumbre. Se estudia intentar predecir el futuro 

# maneras de mejorar un modelo
#   1. metiendo mas datos
#   2. aumentando la complejidad del modelo (metiendo mas variables)
# 
