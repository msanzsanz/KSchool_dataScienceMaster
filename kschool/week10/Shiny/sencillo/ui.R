# Definción del UI
shinyUI(fluidPage(
  
	# Titulo
	titlePanel("Una regresión"),
  
	sidebarLayout(
	# Barra lateral
		sidebarPanel(
		  sliderInput("grosor","Tamaño de los puntos:",min = 0,max = 20,value = 10,step=2),
		  selectInput("color_in", "Choose a colour:", choices = c("Red", "Blue", "Yellow")),
		  dateInput("date_in", "Choose a date:"),
		  checkboxInput("checkBox_in", "Checkbox"),
		  submitButton("Apply Changes"),
		  fileInput("file_in", "Chose a file", multiple = TRUE, buttonLabel = "Browse ...", placeholder = "no file"),
		  actionButton("action_in", "Action button")
	  ),
		
	# Muestra el grafico en el panel principal
		mainPanel(
			plotOutput("grafico")
			
		)
)
)
)
