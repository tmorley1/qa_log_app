#---- Creating HTML report----
output$report <- downloadHandler(
  # For pdf output, change this to "report.pdf"
  filename = "report.html",
  content = function(file) {
    # Copy the report file to a temporary directory before processing it, in
    # case we don't have write permissions to the current working dir (which
    # can happen when deployed).
    tempReport <- file.path(tempdir(), "report.Rmd")
    file.copy(paste(pathway,"\\report.Rmd", sep=""), tempReport, overwrite = TRUE)
    
    # Set up parameters for Documentation and Governance to pass to Rmd document
    params <- list(id = input$projectID,
                   name = input$projectname,
                   version = input$version,
                   leadanalyst = input$leadanalyst,
                   analyticalassurer = input$analyticalassurer,
                   BCM = input$BCM,
                   DGscore = percentage_DG(),
                   DG1 = input$scoreDG1,
                   DG2 = input$scoreDG2,
                   DG3 = input$scoreDG3,
                   DG4 = input$scoreDG4,
                   DG5 = input$scoreDG5,
                   DG6 = input$scoreDG6,
                   DG7 = input$scoreDG7,
                   DG8 = input$scoreDG8)
    
    # Knit the document, passing in the `params` list, and eval it in a
    # child of the global environment (this isolates the code in the document
    # from the code in this app).
    rmarkdown::render(tempReport, output_file = file,
                      params = params,
                      envir = new.env(parent = globalenv())
    )
  }
)
