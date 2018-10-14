#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  
  datos <- reactive({ 
    subset(gapminder, year ==input$years)						
  }) 
  
  
  output$distPlot <- renderPlot({
    
    p <- ggplot(datos(), aes(x = gdpPercap, y = lifeExp, size = lifeExp, colour = continent )) + 
      geom_point() + scale_size("", breaks = seq(20,70,10), guide = "none") + xlim(0,50000) + ylim(0,100) + 
      geom_text(x = 45000, y = 90, label = as.character(input$years), colour = 'grey50', size = 15, alpha = .5)
    
    ggplotly(p, tooltip = c("color"))
    
  })
  
  output$disYears <- renderText({
    input$years
    
  })
  
})
