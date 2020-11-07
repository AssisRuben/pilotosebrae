library(shiny)

pageWithSidebar(
  
  # Page header
  headerPanel('Vai ser lucrativo?'),
  
  # Input values
  sidebarPanel(
    HTML("<h3>Input parameters</h3>"),
    
    selectInput("regiao", label = "Região:", 
                choices = list("Norte" = "norte",  "Sul" = "sul"), 
                selected = "Norte"),
    sliderInput("area", "Área (ha):",
                min = 5, max = 140,
                value = 70),
    numericInput("pl", 
                 label = "Produção de leite (L):", 
                 value = 12),
    sliderInput("femea", "Fêmeas (%):",
                min = 19, max = 90,
                value = 40),
    selectInput("sistema", label = "Sistemas de criação:", 
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
