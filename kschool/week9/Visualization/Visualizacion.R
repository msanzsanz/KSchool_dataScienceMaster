
library(tidyverse)

N = 5000

salaries = runif(100, 1000, 3000) # 100 datapoints between 1000 and 3000

summary(salaries)

hist(salaries) # basic R hist


# input1 equal to the number of data points, 
# input2 equal to the mean, input 3 equal to std
salaries = rnorm(N, 2000, 100) 

summary(salaries)

qplot(salaries)

# Now we incorporate a second variable, to associate salaries to ages
ages = rpois(N, salaries / 40)
summary(ages)

qplot(ages, salaries) # Using two arguments it creates a scatter    

qplot(ages, salaries, geom = "smooth")

# sample randomly chooses elements from a set
sample(1:10, 3)
sample(letters, 5)

sample(c("M","F"), N) # you cannot get more elemets than the existing ones

genders = sample(c("M", "F"), N, replace=TRUE)

employees = data_frame(salary = salaries, age = ages, gender = genders)
employees

qplot(salary, data = employees)

qplot(salary, age, data = employees)

qplot(salary, data = employees, color=gender, xlab = "Salary", 
      ylab = "Number of employees", main = "Scatter example")

qplot(salary, data = employees, fill=gender)

qplot(salary, data = employees, fill=gender, col=I("grey60"))

qplot(gender, salary, data = employees, geom = "boxplot")

qplot(age, salary, data = employees,  color=gender)
qplot(age, salary, data = employees, geom = "smooth", color=gender)


employees <- employees %>% 
  mutate(age_range = cut(age, seq(25, 80, 5)))

View(employees)

qplot(age_range, salary, data = employees, geom = "boxplot")
qplot(age_range, salary, data = employees, geom = "boxplot", color=gender)
qplot(age_range, salary, data = employees, geom = "boxplot", fill=gender)

qplot(age_range, salary, data = employees, geom = "boxplot", color = gender, xlab = "Age Range", ylab = "Salary")

#########################
#
#  MPG
#
#########################

mpg <- mpg %>% mutate(consumo=235/hwy) # conversión  litros/100 km = 235/mpg
summary(mpg$consumo)

stem(mpg$consumo)

qplot(consumo, data = mpg)

qplot(consumo,data=mpg,bins=12,color=I("blue4"),fill=I("lightblue"))

num_rows = nrow(mpg)
sturges = 1 + log (num_rows, 2)
rule = 2 * num_rows^(1/3)

qplot(consumo,data=mpg,bins=sturges,color=I("darkblue"),fill=I("lightblue"))

qplot(consumo,data=mpg,bins=rule,color=I("blue4"),fill=I("lightblue"))

qplot(consumo,data=mpg,bins=12,fill=class) 

qplot( manufacturer, consumo, data=mpg,geom="boxplot") + coord_flip()


qplot( class, consumo, data=mpg, geom="boxplot", color=drv) + coord_flip()


##########################################
##
##  EJERCICIO. survay
##
##########################################
require(MASS)

# data(survey)

survey_df <- as.tibble(survey) %>% filter(!is.na(Sex))

qplot(W.Hnd, data = survey_df)
qplot(Age, Height, data = survey_df)

qplot(Age, Height, data = survey_df,  geom="boxplot")

survey_df <- survey_df %>% 
  mutate(Tabaco = factor((Smoke = factor(Smoke, levels=c("Never", "Occas", "Regul", "Heavy")))))

qplot(Sex, Height, data=survey_df, geom="boxplot", fill=Smoke)

# sort the legend as we want
qplot(Sex, Height, data=survey_df, geom="boxplot", fill=Tabaco)

qplot(class,data=mpg,fill=I("lightblue"), color=I("gray60")) 

qplot(class, data=mpg, fill=drv)

qplot(Tabaco, data = survey_df, fill = Sex)

qplot(Tabaco, data = survey_df, fill = Sex) + coord_flip()

qplot(Sex, data = survey_df, fill = Tabaco)

qplot(displ,consumo,data=mpg,xlab="cilindrada", alpha=I(.1))

qplot(displ,consumo,data=mpg,xlab="cilindrada", geom="jitter", size=I(.5))


qplot(displ,consumo,data=mpg,xlab="cilindrada", geom="jitter", size=I(.5), alpha=I(.5))

qplot(displ,consumo,data=mpg,xlab="cilindrada", geom=c("jitter", "smooth"), size=I(.7), alpha=I(.5))

qplot(consumo,model,data=mpg, col=cyl)

length(unique(mpg$displ))

mpg <- mpg %>% group_by(model) %>% mutate(media=mean(consumo))
qplot(consumo,reorder(model,media),data=mpg,col=cyl)


################################
##
##  islands
##
##
################################

length(islands)
islands[0:3]

islands_df = data_frame(name = names(islands), size = islands)

qplot(size, reorder(name,size), data = islands_df) 
qplot(size, reorder(name,size), data = islands_df, log="x") 

islands_df <- islands_df %>% 
  mutate (rel_size = (size / sum(size))*100)

################################
##
##  VADeaths
##
################################

VADeaths

mortalidad <- VADeaths %>% as.tibble() %>% mutate(edad = row.names(VADeaths))


mortalidad <- mortalidad %>% gather(grupo, tasa, "Rural Male": "Urban Female") 
mortalidad <- mortalidad %>% gather(grupo, tasa, -edad) 

temp <- VADeaths %>% as.tibble() %>% mutate(edad = row.names(VADeaths))
mortalidad <- gather(temp,grupo,tasa,-edad)
mortalidad

p <- ggplot(mortalidad) + aes (x = edad, y = tasa, color=grupo, group=grupo, alpha=0.4)
 
p + geom_point() + geom_line()

p <- ggplot(mortalidad) + aes (x = edad, y = tasa,  size = grupo)

p <- ggplot(mortalidad) + aes (x = edad, y = tasa,  colour = grupo)

p <- ggplot(mortalidad, aes(x = edad, y = tasa, colour = grupo, group= grupo))
p + geom_point() + geom_line()

p <- ggplot(mortalidad, aes(x = edad, y = tasa, linetype = grupo, group=grupo, colour = grupo))
p + geom_point() + geom_line()

p <- ggplot(mortalidad, aes(x = edad, y = tasa, colour = grupo))
p + geom_bar(stat="identity")


p <- ggplot(mortalidad, aes(x = edad, y = tasa, fill = grupo))
p + geom_bar(stat="identity")

p <- ggplot(mortalidad, aes(x = edad, y = tasa, fill = grupo))
p + geom_bar(stat="identity", position="dodge") #+ facet_wrap(-grupo)

mortalidad <- mortalidad %>% separate(grupo, c("area", "sexo"), " ")
ggplot(mortalidad, aes(x = edad, y = tasa, fill=sexo, label=tasa)) + 
  geom_bar(stat="identity", position="dodge") + 
  facet_grid(sexo~area) +
  geom_text()

ggplot(mortalidad, aes(x = edad, y = tasa, fill=area, label=tasa)) + 
  geom_bar(stat="identity") + 
  facet_grid(sexo~area) +
  geom_text(size=3, color="grey40", nudge_y = 3)

ggplot(mortalidad, aes(x = edad, y = tasa, fill=area, alpha=area)) + 
  geom_bar(stat="identity") + 
  facet_grid(sexo~area) +
  scale_alpha_manual(values=c(.3,.8), limits=c("Rural", "Urban"))



################################
##
##  Paro
##
################################

paro <- read_csv("Data/paro.csv")
names(paro) <- c("Anio", "Trimestre", "Tasa.paro", "Sexo", "Prov.id", "Provincia")

paro.ZHT <- paro %>% filter(Provincia %in% c('Zaragoza', 'Huesca', 'Teruel'))

ggplot(paro, aes(x = Trimestre, y = Tasa.paro, colour=Sexo)) + 
  geom_boxplot() +
  facet_grid(Sexo~Anio) 

ggplot(paro.ZHT, aes(x = Anio, y = Tasa.paro, colour=Sexo)) + 
  geom_point() + geom_line() +
  facet_grid(Provincia~Trimestre) 

################################
##
##  Paro
##
################################

install.packages("gapminder")
require(gapminder)
gapminder

summary(gapminder)

gapminder_wo_Outliers <- gapminder %>% 
  filter(gdpPercap <= 55555)

ggplot(gapminder_wo_Outliers, aes(x = gdpPercap, y = lifeExp, size = pop, colour=continent )) +
  geom_point() + 
  facet_wrap(~continent) 

################################
##
##  Obesidad
##
################################

obesidad<-read_csv("data/obesidad.csv")

unique(obesidad$region)
obesidad %>% 
  filter(region %in% c(' Asia  ')) %>% 
  summarise(total = sum())


p<-ggplot(obesidad,aes(x=renta,y=imc,color=region))+geom_smooth(method="lm")
p + ggtitle("Relación entre Indice de Masa Corporal (IMC) y renta") + 
  labs(x = "Renta (en miles de $ por año)", y = "IMC (kg/m2)", color = "Continente") +
  theme_light()

ggsave("prueba.jpg")

################################
##
##  GGmap
##
################################
install.packages("ggmap")
library(ggmap)
library(dplyr)

kschool <- geocode('Avenida de Brasil 6, Madrid, spain')

mapa <- get_map(location = kschool,zoom = 16,color = "bw")


tmpMap <- ggmap(mapa)

tmpMap + geom_point(aes(x = lon, y = lat, colour = offense), data = crimes.houston, size = 1)

crimes_houston <- crime  %>% 
  filter(!crime$offense %in% c("auto theft", "theft", "burglary"))

houston<-c(lon=-95.3698,lat= 29.76043)
HoustonMap <- ggmap(get_map(houston, zoom = 14, color = "bw"))
HoustonMap +
  geom_point(aes(x = lon, y = lat, colour = offense), data = crimes_houston, size = 1) +
  facet_wrap(~offense)


HoustonMap +
  stat_bin2d(aes(x = lon, y = lat, colour = offense), data = crimes_houston, size = 1) 

HoustonMap +
  stat_density2d(aes(x = lon, y = lat, alpha = ..level..),fill="red4",
                 size = 2, data = subset(crimes_houston,offense=="robbery"),
                 geom = "polygon")

HoustonMap +
  stat_density2d(aes(x = lon, y = lat, alpha = ..level..),fill="red4",
                 size = 2, data = subset(crimes_houston,offense=="robbery"))

HoustonMap +
  stat_density2d(aes(x = lon, y = lat, alpha = ..level..), fill = "red4",
                 size = 2, data = crimes_houston, geom = "polygon") +
                facet_wrap(~offense)

HoustonMap +
  stat_density2d(aes(x = lon, y = lat, alpha = ..level..), fill=offense,
                 size = 2, data = crimes_houston, geom = "polygon") 

require(raster)  
shape <- getData("GADM", country= "Spain", level = 2) #mapa administrativo a nivel provincial
peninsula <- subset(shape,!NAME_1=="Islas Canarias") #mapa sin las islas canarias
peninsula 

plot(peninsula)

str(shape)

coordinates(peninsula)

View(peninsula)

library(maptools)
library(gpclib)

gpclibPermit()

peninsula.df=ggplot2::fortify(peninsula,region="CCA_2") #convierte el shape en data.frames

peninsula.df=fortify(peninsula)

dim(peninsula.df)

ggplot() + geom_polygon(data = peninsula.df, aes(long, lat, group = group), 
                        fill="grey60",colour = "grey80", size = .1)+coord_quickmap()
View(head(peninsula.df))

summary(shape)
View(head(shape))
unique(shape$NAME_1)

names(crimes_houston)
# Echar un ojo a https://github.com/rOpenSpain/caRtociudad

install.packages("tidyverse")
library(tidyverse)
carburantes <- read_csv2("data/carburantes.csv") # con csv2 la separacion esperada es ;

View(head(carburantes))


paro <- read_csv("Data/paro.csv")
names(paro) <- c("Anio", "Trimestre", "Tasa.paro", "Sexo", "Prov.id", "Provincia")

require(plotly)
p<-ggplot(paro, aes(x = Anio, y = Tasa.paro, color=Sexo,label=Provincia)) +
  geom_jitter(alpha=.1) + geom_smooth(se=FALSE,method="lm") 
ggplotly(p,tooltip = c("label", "color"))

install.packages("tmap")
require(tmap)

require(tmap)
#vignette("tmap-nutshell")
paro.mujeres <- paro %>% filter(Sexo=="Mujeres" & Trimestre=="I" & Anio=="2011") 
peninsula@data=inner_join(peninsula@data,paro.mujeres,by=c("CCA_2"="Prov.id"))

tm_shape(peninsula) + tm_fill("Tasa.paro", style="quantile", palette="Reds",title="Tasa de paro",alpha=.8) +
  tm_borders("grey25", alpha=.5)
tmap_mode("view");last_map()    