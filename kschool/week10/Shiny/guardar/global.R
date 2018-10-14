require(ggplot2)
require(tidyverse)
paro=read_csv("data/paro.csv")
names(paro) <- c("Anio", "Trimestre", "Tasa.paro", "Sexo", "Prov.id", "Provincia")

evolucion<-function(DF,alpha=.1){
	ggplot(DF,aes(x=Anio,y=Tasa.paro)) + 
		geom_smooth(se=FALSE,span=1,size=2,col="blue")+
		geom_line(alpha=alpha,size=1,aes(group=Provincia),col="blue")+
		facet_wrap(~Trimestre)+ylim(15,30)+
		theme_bw()
	}

	
# Realizar una interfaz shiny para explorar de manera interactiva la base de datos "gapminder" sobre evolución de la esperanza de vida
 	