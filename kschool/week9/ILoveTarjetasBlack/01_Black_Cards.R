###
###  BANKIA - BLACK CARDS 
###

########
# USEFUL STUFF
#
# ?bind_rows
# ?read_excel
# ?list.files
# ?filter_all
# ?filter
# ?is.na
# https://regex101.com
# library(stringi) --> remove weird characters as "ñ", "'", etc.

# Bichear openRefine, que es muy util para limpiar datos: http://openrefine.org
########

# INSTALL packages
install.packages("pdftools")

# IMPORT LIBRARIES
library(tidyverse)
library(dplyr)
library(readxl)

# IMPORT THE DATA

files <- list.files('DATA', pattern = "Gasto*", full.names = T)

import_data_from_xls <- function (file) {
 
   sheets <- excel_sheets(file)
   sheet_data <- lapply(sheets, function (x) read_excel(file, sheet = x))
   sheet_data <- bind_rows(sheet_data)
   return(sheet_data)
}

excel_data <- lapply(files, function (x) import_data_from_xls (x))
excel_data <- bind_rows(excel_data)

# Comprobar que tras la importación tenemos los movimientos de 85 titulares de tarjetas black
names(excel_data)
length(unique(excel_data$NOMBRE))
nrow(excel_data)

# Calcular cuantos NA hay por variable y que porcentaje representa del total de observaciones.
summary(excel_data)

na_per_column <- sapply(excel_data, function(x) sum(is.na(x)))
per_na <- sapply(excel_data, function(x) (mean(is.na(x))))

# Eliminar las filas en las que no hay datos
rows_with_all_na <- apply(excel_data, 1, function(x){all(is.na(x))})
sum(rows_with_all_na)
excel_data <- excel_data[!rows_with_all_na,]

# Otra manera de hacerlo
excel_data <- excel_data %>% 
  filter_all(any_vars(!is.na(.))) 
nrow(excel_data)
nrow(excel_data)

# Eliminamos NIF no informados
excel_data <- excel_data %>% 
  filter(!is.na(NIF)) 

# Crear una variable FECHA con formato HH-mm-dd HH:MM:SS y elimina la variable HORA_HOST
excel_data <- excel_data %>% 
  mutate( FECHA = as.POSIXct(paste(FECHA, HORA_HOST), format = "%Y-%m-%d %H.%M.%S") ) %>% 
  select(-HORA_HOST)

excel_data$`SIN MOVIMIENTOS` <- NULL

# Crear las variables APELLIDOS, NOMBRE y NOMBRE_Y_APELLIDOS del titular
excel_data <- excel_data %>% 
  separate(NOMBRE, into =  c("APELLIDOS", "NOMBRE"), ",", remove = F) %>% 
  unite(NOMBRE_Y_APELLIDOS, NOMBRE, APELLIDOS, sep = " ", remove = F)

# Poner en mayúsculas el nombre de todas las variables
names(excel_data) <- toupper(names(excel_data))

# Importar el texto de la sentencia en un objeto "text” (pdftools::pdf_text() )
pdf_text = pdftools::pdf_text("Data/2017_02_23_SENTENCIA_TARJETAS_BLACK.pdf")
class(pdf_text)

# Asignar al objeto "acusados" un data frame con el nombre de los 65 acusados que 
# están en las páginas 1 a 11 de la sentencia. (stringr::str_match_all)
#accussed <- str_match_all(pattern = "(?:\\d\\.\\s{3,}D?\\.?\\s)(.+?(?=,|\\.| nac))",
#             string =  pdf_text[c(1:11)])

# library(stringi)
# stri_trans_general("IGNACIO DE NAVASQ\u00dcES COBI\u00c1N", "Latin-ASCII")

# Aqui hay mucha chicha para practicar con expresiones regulares analizando el pdf
# Adicionalmente, los nombres en el pdf no son coherentes con los del excel, por 
# lo que hay que hacer un poco de limpieza previa. 
#
# Esto lo dejamos para mas adelante y nos centramos en exploración con ggplot, 
# cogiendo el xls ya limpito que nos ha dejado Jose: "DATA/movimientos_tarjetas_black.csv"


movements <- read.csv("DATA/movimientos_tarjetas_black.csv")
movements <- movements %>% 
  filter(!COD_OPERACION == 400)

movements$TARJETA <- as.character(movements$TARJETA)
 
# Comprobar que el número de apuntes y el dinero gastado de, por ejemplo, 
# MIGUEL BLESA DE LA PARRA, coincide con el disponible en 
# https://elpais.com/especiales/2014/tarjetas-opacas-caja-madrid/
# 423068.5 euros en 1565 transacciones

names(movements)
movements_blesa <- movements %>%  
  filter(NIF == "026166340E") %>%  
  summarise(TOTAL = sum(IMPORTE), N = n()) 

# Personas con mas de una tarjeta
card_per_person <- movements %>% 
  group_by(NOMBRE_Y_APELLIDOS) %>% 
  select( NOMBRE_Y_APELLIDOS, TARJETA) %>% 
  unique() %>% 
  group_by(NOMBRE_Y_APELLIDOS) %>% 
  summarise(NUM_TARJ = n())

View(card_per_person)

# Aseguramos que no es problema de datos, sino que realmente hay personas con mas
# de una tarjeta
movements %>% 
  filter(NOMBRE_Y_APELLIDOS == "ALBERTO RECARTE GARCIA ANDRADE") %>% 
  group_by(TARJETA) %>% 
  summarise(n=n())

# Habrá tarjetas asociadas a mas de una persona ?
movements %>% 
  group_by(TARJETA) %>% 
  select( NOMBRE_Y_APELLIDOS, TARJETA) %>% 
  unique() %>% 
  group_by(TARJETA) %>% 
  summarise(NUM_PERSONAS = n()) %>% 
  filter(NUM_PERSONAS > 1)

num_tarjetas_blac = 166


# Número de observaciones por titular de la tarjeta
movements_per_card <- movements %>% 
  group_by(TARJETA) %>% 
  summarise( OBSERVACIONES = n(), IMPORTE = sum(IMPORTE), TITULAR = unique(NOMBRE_Y_APELLIDOS)) 

View(movements_per_card)
names(movements_per_card)

movements_per_card <- movements_per_card %>% 
  unite (TARJETA_TITULAR, TARJETA, TITULAR, sep = "-", remove = F)

unique(movements_per_card$TARJETA_TITULAR)
qplot(OBSERVACIONES, reorder(TITULAR, OBSERVACIONES), data=movements_per_card)

ggplot(movements_per_card) +
  aes( x = OBSERVACIONES, y = TITULAR) +
    geom_point()

View(head(movements))

names(movements)

# Cada anotación tiene un código de operación ¿Qué significa cada uno de ellos?
cod_operacion <- movements %>% 
  group_by(COD_OPERACION) %>% 
  select(COD_OPERACION, COD_OPE_DESC) %>% 
  unique() %>% 
  filter(!is.na(COD_OPE_DESC))

View(cod_operacion)

# Calcula la media y la mediana de todos los importes excepto de los que son abonos.
movements %>% 
  select(IMPORTE) %>% 
  mutate(ABS = abs(IMPORTE)) %>% 
  summary()

# Quiénes son los titulares "extremos" que destacan por haber comprado 
# y a la vez retirado más dinero en efectivo

names(movements)
movements_per_customer <- movements %>% 
  group_by(NOMBRE_Y_APELLIDOS, COD_OPERACION) %>%
  summarise(IMPORTE_TOTAL = sum(IMPORTE), OBSERVACIONES = n()) %>% 
  filter(IMPORTE_TOTAL != 0)
  
ggplot(movements_per_customer, aes(x = IMPORTE_TOTAL, y = NOMBRE_Y_APELLIDOS, colour = COD_OPERACION, group= COD_OPERACION))
