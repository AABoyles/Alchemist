shinyUI(navbarPage("Alchemist",
  tabPanel("Data Transmutation",
    column(6, offset = 3,
      fluidRow(
        column(6, fileInput("dataset", "Input Data File", width = '100%')),
        column(6, selectInput('inputFormat', 'Input Format', inputFormats, selected="Best Guess"))
      ),
      bsAlert("invalidInputFormatAlert"),
      conditionalPanel(
        condition = "output.fileUploaded",
        fluidRow(
          bsCollapse(
            bsCollapsePanel("Preview Data", dataTableOutput('table'))
          )
        ),
        fluidRow(
          column(6, tags$label("Output Data File"), br(), downloadButton('downloadData', 'Download Dataset')),
          column(6, selectInput('outputFormat', 'Output Format', outputFormats, selected = "csv"))
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
