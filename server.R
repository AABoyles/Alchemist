library(readr)
library(readxl)
library(haven)
library(foreign)

options(shiny.maxRequestSize = .2*1024^3)

getName <- function(filename){
  if(!is.character(filename)){
    filename <- toString(filename)
  }
  parsed <- strsplit(filename, ".", TRUE)[[1]]
  num    <- length(parsed)
  return(tolower(parsed[1:num-1]))
}

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
  switch(extension,
    arff     = return(read.arff(path)),
    csv      = return(read_csv(path)),
    dat      = return(read_fwf(path, fwf_empty(path))),
    dbf      = return(read.dbf(path)),
    dta      = return(read_dta(path)),
    fwf      = return(read_fwf(path, fwf_empty(path))),
    sasb7dat = return(read_sas(path)),
    sav      = return(read_sav(path)),
    tsv      = return(read_tsv(path)),
    txt      = return(read_fwf(path, fwf_empty(path))),
    xls      = return(read_excel(path)),
    xlsx     = return(read_excel(path)),
    return(data.frame(readFile="This dataset is empty", extension=extension, path=path))
  )
}

writeFile <- function(data, path, format="csv"){
  if(!is.character(path)){
    path <- toString(path)
  }
  switch(format,
    arff = return(write.arff(data, path)),
    csv  = return(write_csv(data, path)),
    dbf  = return(write.dbf(data, path)),
    dta  = return(write_dta(data, path)),
    rds  = return(write_rds(data, path)),
    sav  = return(write_sav(data, path)),
    tsv  = return(write_tsv(data, path)),
    return(write_csv(data, path))
  )
}

shinyServer(function(input, output, session) {

  datasetInput <- reactive({
    if("dataset" %in% names(input)){
      if("datapath" %in% names(input$dataset)){
        if(input$inputFormat=="Best Guess"){
          extension <- getExtension(input$dataset$name[1])
        } else {
          extension <- input$inputFormat
        }
        if(! extension %in% inputFormats){
          formats <- paste(inputFormats, collapse=", ")
          createAlert(session, "invalidInputFormatAlert", style="warning", title="Oops!", content=paste0("Sorry, the only formats I understand right now are ", formats), append=FALSE)
        } else {
          return(readFile(input$dataset$datapath[1], extension))
        }
      }
      return(input$dataset)
    }
    return(NULL)
  })
  
  output$fileUploaded <- reactive({
    return(!is.null(datasetInput()))
  })
  outputOptions(output, 'fileUploaded', suspendWhenHidden=FALSE)
  
  output$table <- renderDataTable(datasetInput())
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(getName(input$dataset$name[1]), input$outputFormat, sep = ".")
    },
    content = function(file) {
      writeFile(datasetInput(), file, input$outputFormat)
    }
  )
})
