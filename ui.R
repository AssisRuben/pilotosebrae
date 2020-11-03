library(shiny)

# Training set
TrainSet <- read.csv("training.csv", header = TRUE)
TrainSet <- TrainSet[,-1]

####################################
# User interface                   #
####################################

ui <- fluidPage(theme = shinytheme("united"),
                
                # Page header
                headerPanel('Sebrae um passa a frente'),
                
                # Input values
                sidebarPanel(
                  HTML("<h3>Input parameters</h3>"),
                  
                  selectInput("regiao", label = "Regi�o:", 
                              choices = list("Norte" = "norte",  "Sul" = "sul"), 
                              selected = "Norte"),
                  sliderInput("area", "�rea (ha):",
                              min = 5, max = 140,
                              value = 70),
                  numericInput("pl", 
                               label = "Produ��o de leite (L):", 
                               value = 12),
                  sliderInput("femea", "F�meas (%):",
                              min = 19, max = 90,
                              value = 40),
                  selectInput("sistema", label = "Sistemas de cria��o:", 
                              choices = list("Confinado" = "confinado", "Extensivo" = "extensivo"), 
                              selected = "Confinado"),
                  
                  actionButton("submitbutton", "Avaliar", class = "btn btn-primary")
                ),
                
                mainPanel(
                  tags$label(h3('Status/Output')), # Status/Output Text Box
                  verbatimTextOutput('contents'),
                  tableOutput('tabledata') # Prediction results table
                  
                )
)