# Definición de la parte server
shinyServer(function(input, output) {
  
  output$grafico <- renderPlot({
    ggplot(cars,aes(x=dist,y=speed))+
		geom_point(size=input$grosor,color=input$color_in,alpha=.3) +
		geom_smooth(method='lm')
  })
})
