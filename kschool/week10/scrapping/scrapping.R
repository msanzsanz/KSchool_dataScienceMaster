Sys.setlocale("LC_ALL", 'en_US.UTF-8')
require(rvest)
require(tidyverse)

########################
###### IMDB

amanece <- read_html("https://www.imdb.com/title/tt0094641/?ref_=nv_sr_1")

amanece %>% html_nodes("title")

amanece %>% 
  html_node("title") %>% 
  html_text()

amanece %>% html_nodes("p")

root = "https://www.imdb.com/"

amanece %>% 
  html_nodes("table") %>% .[[1]]
  html_nodes("table a") %>% 
  html_attr("href")
  

  ########################
  ###### PAIS

elpais <- read_html("https://resultados.elpais.com/resultats/eleccions/2016/generals/congreso/")

elpais %>% html_table(header=TRUE) %>% .[[2]] %>% .[[3]]

elpais_df <- data.frame(elpais %>% 
                          html_table(header=TRUE) %>% 
                          .[[2]] )

View(elpais_df)

names(elpais_df) <- c("Partido", "Escanios", "Votos", "Votos_per")

ggplot(elpais_df, aes(x = Partido, y = Votos)) + geom_bar(stat="identity") 

########################
###### WIKIPEDIA

wiki <- read_html("https://es.wikipedia.org/wiki/Provincia_de_Espa%C3%B1a")
wiki %>% html_table(fill=T)


#############
###  ReY

casaReal <- read_html("http://www.casareal.es/ES/Actividades/Paginas/actividades_discursos_detalle.aspx?data=5000")
casaReal %>% 
  html_nodes("p") %>% 
  html_text() %>% 
  paste(collapse = " ")


######
## Bolsa

ibex35 <- read_html("http://www.bolsamadrid.es/esp/aspx/Mercados/Precios.aspx?indice=ESI100000000")

ibex35 %>% 
  html_nodes("table") %>% 
  html_table(fill = TRUE) %>% 
  lapply(dim)


cotizacion_ibex35 <- ibex35 %>% 
  html_nodes("table") %>% 
  html_table(fill = TRUE) %>% 
  .[[5]] 

#### Navegacion #####
sesion <- html_session("http://www.imdb.com")
sesion %>% 
  jump_to("boxoffice") %>% 
  html_nodes("table") %>% 
  .[[1]] %>% 
  html_table()

sesion %>%  jump_to("boxoffice")%>% session_history()

sesion %>% follow_link("Indian")

html_form(sesion)

busqueda <-html_form(sesion)[[1]] %>% set_values(q = "amanece", s="Titles") 

busqueda %>% 
  submit_form(session=sesion) %>% 
  html_nodes("table")

busqueda %>% 
  submit_form(session=sesion) %>% 
  html_nodes("td.result_text") %>% html_text()


########
##  Introducción a la minería de texto
########

# Dos paquetes interesantes. base y stringr en tidyverse

gsub("h", "H", c("hola", "búho"))
gsub("^h", "H", c("hola", "búho"))
str_replace(c("hola", "búho"), "^h", "H")
str_to_upper(c("hola", "búho"))
gsub("a$", "as", c("pera", "sandias"))


grep("a$", c("pera", "sandia", "platano"), value = TRUE)

head(colors(),10)

# Todos los colores que terminan por blue
grep("blue$", colors(), value = TRUE)

msg <- paste("A", 1:6, sep = ".", collapse = "\n")
cat(msg)


# Crea una función que tome los nombres de ficheros
# 
# ficheros <- c(“ventas_20160522_zaragoza.csv”, “pedidos_firmes_20160422_soria.csv”)
# 
# y genere una tabla con una fila por fichero y tres columnas: el nombre del fichero, 
# la fecha y y la provincia. Nota: puedes crear una función que procese solo un nombre 
# de fichero y aplicársela convenientemente al vector de nombres.

ficheros <- c("ventas_20160522_zaragoza.csv", "pedidos_firmes_20160422_soria.csv")
strsplit()

separa <- function (name){
  
  palabras <- strsplit(name, split = "_\\d{8}_")
  fecha <- str_extract ("\\d{8}")
  palabras[[1]][2]
}

kk <- separa("ventas_20160522_zaragoza.csv")
kk[[1]][2]


########
## WIKI
########
mfield<-read_html("https://es.wikipedia.org/w/index.php?title=Medalla_Fields&oldid=103644843")
Medallistas <- mfield %>% 
  html_nodes("table") %>% 
  .[[2]] %>% 
  html_table() %>% 
  .[[2]]
  
class(Medallistas)
names(Medallistas)


paises <- str_extract(Medallistas, "\\([^()]+\\)") %>% 
  str_replace_all("[()]", "") %>% 
  str_split(" y ") %>% 
  unlist() %>%
  #str_replace("^[:blank:", "")
  str_trim() 

texto<-c("Eso es insultar al lector, es llamarle torpe","Es decirle: ¡fíjate, hombre, fíjate, que aquí hay intención!","Y por eso le recomendaba yo a un señor que escribiese sus artículos todo en bastardilla","Para que el público se diese cuenta de que eran intencionadísimos desde la primera palabra a la última.")
texto

texto_df <- data_frame(fila = 1:4, texto = texto)
texto_df

require(tidytext)

unnest <- texto_df %>% 
  unnest_tokens(palabra, texto)

View(unnest)

unnest %>% 
  group_by(palabra) %>% 
  summarise(total = n())

texto_df %>% 
  unnest_tokens(palabra, texto, token = "ngrams", n=3)

?unnest_tokens

# JANE AUSTIN
################

require(janeaustenr)
libros <- austen_books() %>%
  group_by(book) %>%
  mutate(linenumber = row_number(),
         chapter = cumsum(str_detect(text, regex("^chapter [[:digit:]ivxlc]", ignore_case=TRUE)))) %>%
  ungroup()

tokens <- libros %>% unnest_tokens(word, text)
tokens

library(stopwords)
stopwords(language="es", source="stopwords-iso")

tokens <- tokens %>% anti_join(stop_words)

freq <- tokens %>% count(word, sort = TRUE) 

require(ggplot2)
freq %>%
  filter(n > 600) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip()

install.packages("wordcloud")
require(wordcloud)
wordcloud(words = freq$word, freq = freq$n, min.freq = 300,
          max.words=100, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
