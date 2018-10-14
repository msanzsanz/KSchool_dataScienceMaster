# Definición de la parte server
shinyServer(function(input, output) {
  
  datos <- reactive({ 
						subset(gapminder,continent==input$continent)						
					}) 
  
  output$evolucion <- renderPlot({ 
    isolate({color=input$color})
	ggplot(datos(),aes(x=year,y=lifeExp,group=country)) + 
		geom_line(stat="smooth",method="loess",alpha=.2,color=color)
	})
	
  output$bigotes <- renderPlot({ 
	fill=input$color
	ggplot(datos(),aes(x=factor(year),y=lifeExp)) + 
		geom_boxplot(fill=fill)
	}) 	
})


