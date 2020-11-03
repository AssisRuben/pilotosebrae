library(data.table)
library(randomForest)

# Read in the RF model
model <- readRDS("model.rds")

shinyServer(function(input, output, session) {
  
  # Input Data
  datasetInput <- reactive({  
    
    # regiao,area,femea,sistema,play
    df <- data.frame(
      Name = c("regiao",
               "area",
               "femea",
               "pl",
               "sistema"),
      Value = as.character(c(input$regiao,
                             input$area,
                             input$femea,
                             input$pl,
                             input$sistema)),
      stringsAsFactors = FALSE)
    
    play <- "play"
    df <- rbind(df, play)
    input <- transpose(df)
    write.table(input,"input.csv", sep=",", quote = FALSE, row.names = FALSE, col.names = FALSE)
    
    test <- read.csv(paste("input", ".csv", sep=""), header = TRUE)
    
    test$regiao <- factor(test$regiao, levels = c("norte", "sul"))
    test$sistema <- factor(test$sistema, levels = c("extensivo", "confinado"))
    
    
    Output <- data.frame(Prediction=predict(model,test), round(predict(model,test,type="prob"), 3))
    print(Output)
    
  })
  
  # Status/Output Text Box
  output$contents <- renderPrint({
    if (input$submitbutton>0) { 
      isolate("Calculation complete.") 
    } else {
      return("Server is ready for calculation.")
    }
  })
  
  # Prediction results table
  output$tabledata <- renderTable({
    if (input$submitbutton>0) { 
      isolate(datasetInput()) 
    } 
  })
  
})
