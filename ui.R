library(shiny)
library(shinyBS)
library(DT)

shinyUI(navbarPage("Alchemist",
  tabPanel("Data Transmutation",
    column(6, offset = 3,
      fluidRow(
        fileInput("dataset", "Input Data File", width = '100%')
      ),
      conditionalPanel(
        condition = "output.fileUploaded",
        fluidRow(
          bsCollapse(
            bsCollapsePanel("Preview Data", dataTableOutput('table'))
          )
        ),
        fluidRow(
          selectInput('outputFormat', 'Output Format', c('arff', 'csv', 'dbf', 'dta', 'rds', 'sav', 'tsv')),
          downloadButton('downloadData', 'Download Dataset')
        )
      )
    )
  ),
  tabPanel("About",
    column(6, offset = 3,
      includeMarkdown("README.md")
    )
  )
))
