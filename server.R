library(shiny)
library(DT)
library(readr)
library(readxl)
library(haven)

options(shiny.maxRequestSize = .2*1024^3)

getExtension <- function(filename){
  if(!is.character(filename)){
    filename <- toString(filename)
  }
  parsed <- strsplit(filename, ".", TRUE)[[1]]
  num    <- length(parsed)
  return(tolower(parsed[num]))
}

readFile <- function(path, extension="csv"){
  if(!is.character(path)){
    path <- toString(path)
  }
  if(extension=="xls" || extension=="xlsx"){
    return(read_excel(path))
  }else if(extension=="csv"){
    return(read_csv(path))
  } else if(extension=="tsv"){
    return(read_tsv(path))
  } else if(extension=="dta"){
    return(read_dta(path))
  } else if(extension=="b7dat"){
    return(read_sas(path))
  }
  return(data.frame(readFile="This dataset is empty", extension=extension, path=path))
}

shinyServer(function(input, output) {
  datasetInput <- reactive({
    if("dataset" %in% names(input)){
      if("datapath" %in% names(input$dataset)){
        extension<-getExtension(input$dataset$name[1])
        return(readFile(input$dataset$datapath[1], extension))
      }
    }
    return(input$dataset)
    return(data.frame(datasetInput="This Data Frame is Empty"))
  })
  
  output$table <- renderDataTable(datasetInput())
  
  output$downloadData <- downloadHandler(
    filename = function() {
      meta <- datasetInput()
      paste0(meta$name, '.csv')
    },
    content = function(file) {
      datasetInput() %>% write_csv(file)
    }
  )
})
