#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("GAPMINDER"),

  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      # Con sep = "" se quita la coma del año
      sliderInput("years", "", min = 1952, max = 2007, step = 5, sep = "", value = 1952, animate=TRUE)
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot"),
       textOutput("disYears")
    )
  )
))
