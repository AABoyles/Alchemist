library(shiny)
library(DT)

shinyUI(navbarPage("Alchemist",
  tabPanel("Data Exchanger",
    column(3,
      fileInput("inputDataset", "Present Data File", width = '100%'),
      selectInput("dataset", "Choose a dataset:", choices = c("rock", "pressure", "cars"))
    ),
    column(6,
      dataTableOutput('table')
    ),
    column(3,
      downloadButton('downloadData', 'Recieve CSV')
    )
  )
))
