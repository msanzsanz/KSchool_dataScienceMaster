library(tidyverse)
library(gapminder)
library(shiny)
library(plotly)

  
require(plotly)
p <- ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, size = lifeExp, colour = continent )) + 
  geom_point() + scale_size("", breaks = seq(20,70,10), guide = "none") + xlim(0,50000) + ylim(0,100) + 
  geom_text(x = 45000, y = 90, label = as.character(1999), colour = 'grey50', size = 15, alpha = .5)

ggplotly(p,tooltip = c("label", "color"))