#####
##
##  Exercise
##
####


library(tidyverse)

customers <- read_csv('http://archive.ics.uci.edu/ml/machine-learning-databases/00292/Wholesale%20customers%20data.csv')

# Canal y region son variables discretas

summary(customers)

customers <- mutate (customers, Channel = factor(Channel))

head(customers)

# cuantos clientes por canal
customers %>% 
  group_by(Channel) %>% 
  summarise(n())

install.packages("GGally")
library (GGally)

ggpairs(customers)

install.packages("corrplot")
library (corrplot)

# Explorar la correlación
customers %>% 
  select(Fresh:Delicassen) %>% 
  cor() %>% 
  corrplot(method = 'number') # corrplot() nos muestra circulos visualmente

customers_scaled <- customers %>% 
  select(Fresh:Delicassen) %>% 
  scale ()   # Por defecto, este modo de escalar es restando media / std

fit <- kmeans(customers_scaled, 5)

customers <- mutate (customers, custer = as.factor(fit$cluster))

install.packages("ggfortify")
install.packages("cluster")

library(ggfortify)
library(cluster)
autoplot(fit, data = customers, frame = T, frame.type = 'norm')

customers %>% 
  group_by(custer) %>%
  summ
  