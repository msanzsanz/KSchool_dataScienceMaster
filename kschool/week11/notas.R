N = 10000
x = runif(N,-1,1)
y = runif(N,-1,1)
plot(x,y)
plot(x,y,cex=.1)

# Superficie = pi * r^2
# x^2 + y^2 <= 1

c = (x^2 + y^2 <= 1)

plot ( x,y, cex=0.05, col=c)

mean(c) # con la media de los TRUE, FALSE saco la proporción de los puntos que están en el círculo

pi

(mean(c) * 4) / 4

# Reduciendo el tamaño muestral, la aproximación es mucho peor
N = 100000
x = runif(N,-1,1)
y = runif(N,-1,1)
c = (x^2 + y^2 <= 1)
mean(c)

# Importante saber que si aumentamos mucho el tamaño muestral se gana algo, pero no
# demasiado 

## ## ## ##
# El error muestral es la variación del resultado de una muestra a otra.
## ## ## ## 

library(dplyr)
library(ggplot2)

set.seed(1234) # la generación de numeros "aleatorios" es determinista.
#por lo que, fijando la semilla, estamos seguros que obtenemos la misma
# secuencia de numeros
library(rvest)
Sys.setlocale("LC_ALL", 'en_US.UTF-8')
url <- "https://es.wikipedia.org/wiki/Provincia_de_España"
provincias <- read_html(url) %>% html_nodes("table") %>% .[[2]] %>% 
  html_attr("href")


sample(state.name, 5)
sample(letters,5)
sample(colors(),5)

# 1 millon de individuos
NN <- 1e6

height_females <- rnorm(NN, 100, 5) # sacamos una muestra normal, con media 100 y std 10
hist(height)
summary(height)

sd(height) # std


height_males <- rnorm(NN, 100, 10) # sacamos una muestra normal, con media 100 y std 10

nn <- 1000

sample <- sample(height_males, nn)
mean(sample)
sample <- sample(height_males, nn)
mean(sample)
# con una muestra de 1000, ya vamos teniendo la misma media

summary(height_males)

# muestreo siemple con reposicion
sample(letters, 20, replace=T)


length(unique(sample(letters, 20, replace=T)))

# strating sampling
# Se considera que la población está dividida por stratos (sexo, edad, etc)
# Es decir, en función de algunas caracteristicas 

# La estratificación puede ser una buena estrategia de muestreo si el subconjunto 
# de individuos dentro de un estrato son muy similares entre si y muy separados 
# del resto

# Hay que hacer mas esfuerzos donde hay mas variabilidad, xq sino todos los data poitns
# # serán iguales
# Pero claro, require un Analysis exploratorio de los datos

library(ggplot2)
diamonds

NN = nrow(diamonds) # Tamaño de la población
nn = 250 # Tamaño muestral

sample <- diamonds %>% sample_n(nn)
mean(diamonds$price)
for (i in seq(1:10)) {
  sample <- diamonds %>% sample_n(nn)
  print(paste("price mean per sample", ))
  mean(sample$price)
}


 
diamonds_per_cut <- diamonds %>% group_by(cut) %>% sample_frac(nn/NN)
 # HAz un esfuerzo muestral al igual que la población en el seno de cada estrato
 mean(diamonds_per_cut$price)
 
 diamonds_per_color <- diamonds %>% group_by(color) %>% sample_frac(nn/NN)
 # HAz un esfuerzo muestral al igual que la población en el seno de cada estrato
 mean(diamonds_per_color$price)
 
 # CONGLOMERADOS
 # Lo que se quiere es que cada conglomerado sea una imagen a pequeña escala de la población 
 # española
 # El objetivo principal es reducir costes, ya que las muestras están cerca unas de otras
 
 provincias <- c("A", "B", "C", "D")
 diamonds$origen <- sample(provincias, NN, replace = TRUE)
 diamonds %>% group_by(origen) %>% summarise(media = mean(price), n = n())
 
 
 ###########################################
 ####
 ####   INFERENCIA
 ####
 ###########################################
 
 N <- 1E6
 n <- 100
 altura_ninias <- rnorm(N, 100, 7)
 sample_ninias <- sample(altura_ninias, n); mean(sample_ninias)
 
 t.test(sample_ninias) # A partir de una sóla muestra te hace un 
 
 # LA estadística deductiva es mas estilo C.Holmes, de saberlo todo y  
# se usa std en vez de la varianza, para que esté en la misma unidad que la media
 
 # # Teorea central del límite
 # n > 50
 nn <- 200
 K <-- 1000
 distrib <- rnorm (108, 5)
 medias <- replicate(K, mean(sample()))
 
 
 qnorm(.95) # esto da los quantiles para sacar los intervalos de confianzq
 
 qt(.95, nn-1) # esto da los quantiles de la student
 
 resumen <- function () {
   muestra <- sample (poblacion, nn)
   c(mean = mean(muestra), std = sd(muestra))
 }
 
 
 
 # Función t() para transponer 

 
 
 
 
 
 
 