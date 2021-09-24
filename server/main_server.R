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
rating_options <- function(score_index){
 renderUI({selectizeInput(score_index, choices=c("1) Excellent",
                                                 "2) Good",
                                                 "3) Some issues",
                                                 "4) Needs improvement",
                                                 "5) Significant issues",
                                                 "N/A",
                                                 "TO BE CHECKED"
 ),
                          selected="TO BE CHECKED", label=NULL)})}

output$scoreSelectorDG1 <- rating_options("scoreDG1")

output$scoreSelectorDG2 <- rating_options("scoreDG2")

output$scoreSelectorDG3 <- rating_options("scoreDG3")

output$scoreSelectorDG4 <- rating_options("scoreDG4")

output$scoreSelectorDG5 <- rating_options("scoreDG5")

output$scoreSelectorDG6 <- rating_options("scoreDG6")

output$scoreSelectorDG7 <- rating_options("scoreDG7")

output$scoreSelectorDG8 <- rating_options("scoreDG8")

#--- Functions for calculating scores -----

#calculate_score gives a base score (in probability) for each QA activity
calculate_score <- function(inputscore){
    if(inputscore == "1) Excellent")
      return(100)
    else if(inputscore == "2) Good")
      return(80)
    else if(inputscore == "3) Some issues")
      return(60)
    else if (inputscore == "4) Needs improvement")
      return(40)
    else if (inputscore == "5) Significant issues")
      return(20)
    else
      return(0)
}

#adds up number of non-zero scores
iszero <- function(inputscore){
  if(inputscore == "TO BE CHECKED")
    return(0)
  else if(inputscore == "N/A")
    return(0)
  else
    return(1)
}

#---- Calculating scores ----

reactive_score_DG1 <- reactive({calculate_score(input$scoreDG1)})

reactive_score_DG2 <- reactive({calculate_score(input$scoreDG2)})

reactive_score_DG3 <- reactive({calculate_score(input$scoreDG3)})

reactive_score_DG4 <- reactive({calculate_score(input$scoreDG4)})

reactive_score_DG5 <- reactive({calculate_score(input$scoreDG5)})

reactive_score_DG6 <- reactive({calculate_score(input$scoreDG6)})

reactive_score_DG7 <- reactive({calculate_score(input$scoreDG7)})

reactive_score_DG8 <- reactive({calculate_score(input$scoreDG8)})

#adds up all percentages
total_DG <- reactive({reactive_score_DG1() + reactive_score_DG2() + reactive_score_DG3() + reactive_score_DG4() + reactive_score_DG5() + reactive_score_DG6() + reactive_score_DG7() + reactive_score_DG8()})

#adds up number of ratings
number_DG <- reactive({iszero(input$scoreDG1)+iszero(input$scoreDG2)+iszero(input$scoreDG3)+iszero(input$scoreDG4)+iszero(input$scoreDG5)+iszero(input$scoreDG6)+iszero(input$scoreDG7)+iszero(input$scoreDG8)})

#calculates average rating
percentage_DG <- reactive(if(number_DG()==0){0}
                          else{round(total_DG()/number_DG())})

output$scoreDG <- renderValueBox({valueBox(paste(percentage_DG()," %"),subtitle="Documentation and Governance")})