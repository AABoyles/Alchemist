library(shiny)
library(DT)
library(readr)
library(readxl)
library(haven)

shinyServer(function(input, output) {
    datasetInput <- reactive({
      switch(input$dataset,
        "rock" = rock,
        "pressure" = pressure,
        "cars" = cars
      )
    })
    
    output$table <- renderDataTable({
      datasetInput()
    })
    
    output$downloadData <- downloadHandler(
      filename = function() { paste(input$dataset, '.csv', sep='') },
      content = function(file) {
        write.csv(datasetInput(), file)
      }
    )
})
