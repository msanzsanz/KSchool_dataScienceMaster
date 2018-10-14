## -------------------------------------------------------------------------
## SCRIPT: Introducción a la Modelización Estadística.R
## CURSO: Master en Data Science
## SESIÓN: Introducción a la Modelización Estadística
## PROFESOR: Antonio Pita Lozano
## -------------------------------------------------------------------------

###
#
# External sources for a better understanding:
#
#   http://www.learnbymarketing.com/tutorials/linear-regression-in-r/
#   Really good tutorial explaining how to digess each variable output by lm in R
###

## -------------------------------------------------------------------------

##### 1. Bloque de inicializacion de librerias #####

if(!require("ggplot2")){
  install.packages("ggplot2")
  library("ggplot2")
}

if (!require("gap")){
  install.packages("gap")
  library(gap)
}

setwd("~/Documents/MSS/Personales/GitRepos/KSchool_dataScienceMaster/kschool/week11/Introducción a la Modelización Estadística")

## -------------------------------------------------------------------------
##       PARTE 1: INTRODUCCIÓN A LA REGRESION LINEAL
## -------------------------------------------------------------------------

## -------------------------------------------------------------------------

##### 2. Bloque de carga de datos #####

creditos=read.csv("data/creditos.csv",stringsAsFactors = FALSE)

View(creditos)
## -------------------------------------------------------------------------

##### 3. Bloque de revisión basica del dataset #####

str(creditos)
head(creditos)
summary(creditos)

# La regresión lineal puede estar influenciada por outliers
## 1. Decidir que es un outlier 
## 2. Decidir que hacer con ellos (no se deberían eliminar)
##    La teoría de la estadística robusta tiene técnicas que no son afectadas por outliers
##    
##
## -------------------------------------------------------------------------

##### 4. Bloque de tratamiento de variables #####

creditos$Gender=as.factor(creditos$Gender)
creditos$Mortgage=as.factor(creditos$Mortgage)
creditos$Married=as.factor(creditos$Married)
creditos$Ethnicity=as.factor(creditos$Ethnicity)

summary(creditos)

## -------------------------------------------------------------------------

##### 5. Bloque de test de diferencia de medias mediante regresion lineal #####

t.test(Income ~ Gender, data = creditos)
# el p-value es 0.7, por lo que no parece que haya una diferencia estadísticamente significativa

# mediante un modelo lineal
modeloT=lm(Income ~ Gender, data = creditos)
summary(modeloT)

# 
# El problema del R^2 es que, cuanto mas variables, mas mejora
# De ahí el R^2, para que penalize un poco la adición de mas variables. Aunque con muchos registros,
# tampoco vale para nada. (echad un ojo a la fórmula de R^2)
# Es por ello que no se puede usar el R^2 para comparar
# R o R^2 solo vale para regresion lineal
# Cuanto mas pequeño sea el BIC o el AIC, mejor es el modelo

# Contrastre F: solo con regresión lineal y comparando dos modelos con relación parental
# y = a + b1x1 + b2x2 + b3x3
# y = a + b1x1 + b2x2 + b3x3 + b4x4 + b5x5 + b6x6 

# de esa manera se va evaluando donde está el tradeoff, evaluando cuales son las variables que mas 
# aporten al modelo
# Se puede ir de menos a mas (forward) o de mas a menos (backward)
# Tambien poquito a poco, step-wise forward and step-wise backward

#
# el contraste F lo que dice es que si meter estas variables mejora o no el modelo, pero compara con el primero,
# no contra el anterior
# y = a
# y = a + bx1
# y =  a + bx1 + cx2
# y =  a + bx1 + cx2 + dx3
# 
# y = 44.8 - 1.3 Ifemale
# 
# Error standar = 3.9 
# Rule of thumb (redonde0 el std a 4 para que sea mas facil)
# 68%  [-5.3      2.7]
# 95%  [-9        6]
# 99% 

## -------------------------------------------------------------------------

##### 6. Bloque de regresion lineal individual #####

modeloInd1=lm(Income ~ Rating, data = creditos)
summary(modeloInd1)

# y = -16.2 + 0.17 Rating
# All models are wrong, but some are useful
## -------------------------------------------------------------------------

##### 7. Bloque de representación gráfica #####

ggplot(creditos, aes(x = Rating, y = Income)) + geom_point() + 
  geom_smooth(method = "lm", se=TRUE, color="red", formula = y ~ x)

## -------------------------------------------------------------------------

##### 8. Bloque de regresion lineal otras variables #####

# MAchine learning tiene puntaje o score, no en probabilidad como hace la distribución estadística
# i.e. en probabilidad da un 60% u 6 de cada 10 contratan
# en ML, los individuos con puntaje mas alto tienen mas opciones de contratar

modeloInd2=lm(Income ~ Products, data = creditos)
summary(modeloInd2)

# Con los datos no se puede concluir que haya una relación entre productos e income

modeloInd3=lm(Income ~ Age, data = creditos)
summary(modeloInd3)

# # 0.05 ???? 
# Al 95% de confianza
# 1 de cada 20 veces una te va a salir significativa aunque realmente no lo sea 
# Cocinado de NATURE --> no se publican los datos de los experimentos fallidos y solo se publica el positivo
# Hay que poner todas las hipótesis, contrastarlas todas a la vez, y luego irse a un dataset limpio
# para sacar conclusiones

modeloInd4=lm(Income ~ Education, data = creditos)
summary(modeloInd4)

modeloInd5=lm(Income ~ Gender, data = creditos)
summary(modeloInd5)

modeloInd6=lm(Income ~ Mortgage, data = creditos)
summary(modeloInd6)

modeloInd7=lm(Income ~ Married, data = creditos)
summary(modeloInd7)

modeloInd8=lm(Income ~ Ethnicity, data = creditos)
summary(modeloInd8)

modeloInd9=lm(Income ~ Balance, data = creditos)
summary(modeloInd9)

## -------------------------------------------------------------------------

##### 9. Bloque de regresion lineal multiple #####

modeloGlobal=lm(Income ~ ., data = creditos)
summary(modeloGlobal)
## Mortgage is bastante alto, puede haber multicolinealidad o no...

## -------------------------------------------------------------------------

##### 10. Bloque de comparacion de modelos #####

anova(modeloInd1,modeloGlobal)

## -------------------------------------------------------------------------

##### 11. Bloque de Ejercicio #####

## ¿Cuales serian las variables que incluiriamos en el modelo?

modeloMultiple=lm(Income ~            , data = creditos)
summary(modeloMultiple)

anova(modeloInd1,modeloMultiple)
anova(modeloMultiple,modeloGlobal)

## -------------------------------------------------------------------------

##### 12. Bloque de analisis del modelo #####

modeloFinal=lm(Income ~ Rating+Mortgage+Balance, data = creditos)
summary(modeloFinal)
plot(modeloFinal$residuals)
hist(modeloFinal$residuals) 
# con la inforamción que yo tengo es el mejor modelo, aunque los residuos son 
qqnorm(modeloFinal$residuals); qqline(modeloFinal$residuals,col=2)
# Si los puntos superponen la linea roja la distrubución de residuos es perfectamente normal
# 
confint(modeloFinal,level=0.95)
# TE calcula los intervalos de confianza

# La correlación de los residuos y las variables salga cero es necesario para 
# asegurar que no hay relación ninguna
cor(modeloFinal$residuals,creditos$Rating)
cor(modeloFinal$residuals,creditos$Balance)

boxplot(modeloFinal$residuals~creditos$Mortgage)
aggregate(modeloFinal$residuals~creditos$Mortgage,FUN=mean)

shapiro.test(modeloFinal$residual)

anova(modeloFinal,modeloGlobal)
# RSS = numero de errores
# Df es el número de variables menos variables
# en este caso, el modelo 1 es mucho mas sencillo y proporciona la misma información. Claro qué hacer, no?
## -------------------------------------------------------------------------

##### 13. Bloque de analisis de variable Balance #####

modeloBalance=lm(Balance ~ ., data = creditos) # con función a todas las variables del data set
summary(modeloBalance)
# Echar un ojo a que el coeficiente del income es negativo... probablemante por el rating

## -------------------------------------------------------------------------

##### 14. Bloque de ejercicio #####

## ¿Cuales serian las variables que incluiriamos en el modelo?

modeloBalanceFin=lm(Balance ~                    , data = creditos)
summary(modeloBalanceFin)

anova(modeloBalance,modeloBalanceFin)

## -------------------------------------------------------------------------

##### 15. Bloque de modelado (stepwise) backward #####

ModelAutoBackward=step(modeloBalance,direction="backward",trace=1)
# Sum of Sq contabiliza el nimero de errores que incorpora
# los coefcientes categoricos siempre contempla 1 menos
summary(ModelAutoBackward)
ModelAutoStepwise=step(modeloBalance,direction="both",trace=1)
summary(ModelAutoStepwise)
anova(ModelAutoBackward,modeloBalance)
anova(ModelAutoStepwise,modeloBalance)

# CTRL + L para pasar la escoba en la consola
## -------------------------------------------------------------------------
##       PARTE 2: REGRESIÓN MULTIPLE:
##                  APLICACIONES AL ESTUDIO DE LA OFERTA y LA DEMANDA
## -------------------------------------------------------------------------

## -------------------------------------------------------------------------

##### 16. Bloque de carga de datos #####

Ventas=read.csv2("data/ventas.csv",stringsAsFactors = FALSE)

## -------------------------------------------------------------------------

##### 17. Bloque de revisión basica del dataset #####

str(Ventas)
head(Ventas)
summary(Ventas)

## -------------------------------------------------------------------------

##### 18. Bloque de formateo de variables #####

Ventas$Fecha=as.Date(Ventas$Fecha)
Ventas$Producto=as.factor(Ventas$Producto)

str(Ventas)
head(Ventas)
summary(Ventas)

## -------------------------------------------------------------------------

##### 19. Bloque de Estimación de ventas en función al precio #####

modelo1=lm(Cantidad~Precio,data=Ventas)
summary(modelo1)
# 
# 3304.87 - 251.79 * precio
# es significativa por el p-valor. El p-valor dice si la varianza del coeficiente es 0 o distinto de 0.
# Es decir, si rechazamos o no la hipotesis
# cuando el precio aumenta una unidad, las ventas se reducen en 251
# cuanto de significativo es el 251? hay que mirar el std

plot(modelo1$residuals)
smoothScatter(modelo1$residuals)
hist(modelo1$residuals)
qqnorm(modelo1$residuals); qqline(modelo1$residuals,col=2)

confint(modelo1,level=0.95)

## -------------------------------------------------------------------------

##### 20. Bloque de Estimación de semielasticidad de las ventas con respecto al precio #####

modelo2=lm(log(Cantidad)~Precio,data=Ventas)
summary(modelo2)
# Si aumento en 1 euro el precio, las ventas se reducen un 14%

plot(modelo2$residuals)
smoothScatter(modelo2$residuals)
hist(modelo2$residuals)
qqnorm(modelo2$residuals); qqline(modelo2$residuals,col=2)
confint(modelo2,level=0.95)

## -------------------------------------------------------------------------

##### 21. Bloque de Estimación de elasticidad de las ventas con respecto al precio #####

modelo3=lm(log(Cantidad)~log(Precio),data=Ventas)
# Es el modelo que tiene mas sentido en el mundo económico
# que porcentaje de variacion en el precio tiene influencia en el % de ventas
# cuando el precio se aumenta en un 1%, la cantidad vendida se reduce en un 0.87%
summary(modelo3)
plot(modelo3$residuals)
hist(modelo3$residuals)
qqnorm(modelo3$residuals); qqline(modelo3$residuals,col=2)
confint(modelo3,level=0.95)

## -------------------------------------------------------------------------
##       PARTE 3: REGRESIÓN LINEAL MULTIPLE: 
##                  ESTUDIO DE CAMBIOS ESTRUCTURALES
## -------------------------------------------------------------------------

## -------------------------------------------------------------------------

##### 22. Bloque de análisis gráfico por tipo producto #####

plot(Ventas$Precio,Ventas$Cantidad)
abline(modelo1,col=2)
plot(modelo1$residuals,col=Ventas$Producto)
plot(modelo2$residuals,col=Ventas$Producto)
plot(modelo3$residuals,col=Ventas$Producto)

## -------------------------------------------------------------------------

##### 23. Bloque de análisis de estructuras por producto #####

modelo1_A0143=lm(Cantidad~Precio,data=Ventas[Ventas$Producto=="A0143",])
modelo1_A0351=lm(Cantidad~Precio,data=Ventas[Ventas$Producto=="A0351",])

plot(Ventas$Precio,Ventas$Cantidad)
abline(modelo1,col="red",lty = "dashed")
abline(modelo1_A0143,col="blue")
abline(modelo1_A0351,col="green")

summary(modelo1)
summary(modelo1_A0143)
summary(modelo1_A0351)
# 
# Al poner los dos juntos, el error proporcional es mejor...
# Poner atención a que el R2 cae drásticamente
# El R2 solo se puede comparar en modelos creados con el mismo conjunto de datos 
# Si el r2 es bajo no se puede predecir mucho 
# Tiene pinta que estos dos productos son estructuralmente diferentes, por lo que habria que mirar el
# test de chow

## -------------------------------------------------------------------------

##### 24. Bloque de contraste de Chow de diferencias estructurales #####

chow.test(Ventas$Cantidad[Ventas$Producto=="A0143"],Ventas$Precio[Ventas$Producto=="A0143"],Ventas$Cantidad[Ventas$Producto=="A0351"],Ventas$Precio[Ventas$Producto=="A0351"])
# 
# Si hay varias variables la salida del test de chow no es demasiada clara

# y = a + b*Precio + c * ind_143 + d * ind_341 
modelo1_Chow=lm(Cantidad~Precio*Producto,data=Ventas)

summary(modelo1)
summary(modelo1_Chow)
# el efecto del precio en las ventas es diferente por tipo de productos
# si los dos ultimos variables hubieran salido que no son distinto de cero, entonces no hay diferencia

### el valor que aporta la publicidad se hace de esta manera


plot(modelo1$residuals,col=Ventas$Producto)
plot(modelo1_Chow$residuals,col=Ventas$Producto)

plot(Ventas$Precio,Ventas$Cantidad)
abline(modelo1,col="red",lty = "dashed")
abline(a=7264.56,b=-1139.53,col="blue")
abline(a=7264.56-3244.34,b=-1139.53+796.03,col="green")


anova(modelo1,modelo1_Chow)

## -------------------------------------------------------------------------
##       PARTE 3: REGRESIÓN MULTIPLE:
##                  OUTLIERS Y LA FALTA DE ROBUSTEZ
## -------------------------------------------------------------------------

## -------------------------------------------------------------------------

##### 25. Bloque de creación de datos simulados #####

x=c(1,2,3,4,5,6,7,8,9,10)
y=3*x+2+rnorm(length(x),0,1) # al no fijar semilla, a cada uno nos sale una cosa distinta
Datos=data.frame(x,y)
modelolm=lm(y~x, data=Datos)
summary(modelolm)
plot(Datos)

xOut=c(x,15)
yOut=c(y,300)
DatosOut=data.frame(xOut,yOut)
modelolmOut=lm(yOut~xOut,data=DatosOut)
summary(modelolmOut)

## -------------------------------------------------------------------------

##### 26. Bloque de representación gráfica #####

plot(xOut,yOut)
abline(modelolm,col="blue")
abline(modelolmOut,col="red")
# un solo outlier puede condicionar los resultados una barbaridad
abline(a=modelolm$coefficients[1],b=modelolm$coefficients[2],col="blue")
abline(a=modelolmOut$coefficients[1],b=modelolmOut$coefficients[2],col="red")

ggplot(Datos, aes(x = x, y = y)) + geom_point() + 
  geom_smooth(method = "lm", se=TRUE, color="red", formula = y ~ x)

ggplot(DatosOut, aes(x = xOut, y = yOut)) + geom_point() + 
  geom_smooth(method = "lm", se=TRUE, color="red", formula = y ~ x)

## -------------------------------------------------------------------------

library(MASS)
modelorlm = rlm(y ~ x, data = Datos)
modelorlmOut = rlm(yOut ~ xOut, data = DatosOut)

abline(modelorlm,col="green")
abline(modelorlmOut,col="brown")


abline(a=modelolm$coefficients[1],b=modelolm$coefficients[2],col="blue")
abline(a=modelolmOut$coefficients[1],b=modelolmOut$coefficients[2],col="red")
# con rlm se da cuenta que hay outliers y se los calza