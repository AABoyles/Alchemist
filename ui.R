library(shiny)
library(DT)

shinyUI(navbarPage("Alchemist",
  tabPanel("Data Exchanger",
    column(3,
      fileInput("dataset", "Present Data File", width = '100%')
    ),
    column(6,
      dataTableOutput('table')
    ),
    column(3,
      downloadButton('downloadData', 'Recieve CSV')
    )
  )
))
