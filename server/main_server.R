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
    params <- list(DG1 = input$scoreDG1,
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

#--- Scores selector DG ------

output$scoreSelectorDG1 <- renderUI({
  selectInput("scoreDG1", "Rating:", c("1) Excellent", "2) Good", "3) Some issues", "4) Needs improvement", "5) Significant issues", "N/A", "TO BE CHECKED"), selected = "TO BE CHECKED")
})

output$scoreSelectorDG2 <- renderUI({
  selectInput("scoreDG2", "Rating:", c("1) Excellent", "2) Good", "3) Some issues", "4) Needs improvement", "5) Significant issues", "N/A", "TO BE CHECKED"), selected = "TO BE CHECKED")
})

output$scoreSelectorDG3 <- renderUI({
  selectInput("scoreDG3", "Rating:", c("1) Excellent", "2) Good", "3) Some issues", "4) Needs improvement", "5) Significant issues", "N/A", "TO BE CHECKED"), selected = "TO BE CHECKED")
})

output$scoreSelectorDG4 <- renderUI({
  selectInput("scoreDG4", "Rating:", c("1) Excellent", "2) Good", "3) Some issues", "4) Needs improvement", "5) Significant issues", "N/A", "TO BE CHECKED"), selected = "TO BE CHECKED")
})

output$scoreSelectorDG5 <- renderUI({
  selectInput("scoreDG5", "Rating:", c("1) Excellent", "2) Good", "3) Some issues", "4) Needs improvement", "5) Significant issues", "N/A", "TO BE CHECKED"), selected = "TO BE CHECKED")
})

output$scoreSelectorDG6 <- renderUI({
  selectInput("scoreDG6", "Rating:", c("1) Excellent", "2) Good", "3) Some issues", "4) Needs improvement", "5) Significant issues", "N/A", "TO BE CHECKED"), selected = "TO BE CHECKED")
})

output$scoreSelectorDG7 <- renderUI({
  selectInput("scoreDG7", "Rating:", c("1) Excellent", "2) Good", "3) Some issues", "4) Needs improvement", "5) Significant issues", "N/A", "TO BE CHECKED"), selected = "TO BE CHECKED")
})

output$scoreSelectorDG8 <- renderUI({
  selectInput("scoreDG8", "Rating:", c("1) Excellent", "2) Good", "3) Some issues", "4) Needs improvement", "5) Significant issues", "N/A", "TO BE CHECKED"), selected = "TO BE CHECKED")
})

#--- Calculating scores -------

DGscore <- reactiveVal(0)#score initially set to zero

observeEvent(input$scoreDG1,
             {DGscore<-if(input$scoreDG1=="1) Excellent"){DGscore()+5}
             else if(input$scoreDG1=="2) Good"){DGscore()+4}
             else if(input$scoreDG1=="3) Some issues"){DGscore()+3}
             else if(input$scoreDG1=="4) Needs improvement"){DGscore()+2}
             else if(input$scoreDG1=="5) Significant issues"){DGscore()+1}
             else {DGscore()}
             })

output$scoreDG <- renderValueBox({valueBox(paste(DGscore()),subtitle="Documentation and Governance")})