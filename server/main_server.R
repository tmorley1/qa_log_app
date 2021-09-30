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

#--- Functions for reading in from SQL ----

#Selected rating based on number
readingOutput <- function(number){if(number==1){"1) Excellent"}
  else if(number==2){"2) Good"}
  else if(number==3){"3) Some issues"}
  else if(number==4){"4) Needs improvement"}
  else if(number==5){"5) Significant issues"}
  else if(number==6){"N/A"}
  else {"TO BE CHECKED"}}

#--- Reading in data from SQL database----
observeEvent(input$submitprojectID, {
  chosennumber <- input$projectID
  
  #select correct row from SQL
  selectrow <- paste("SELECT * FROM ", databasename, ".[dbo].[test] WHERE ProjectID = ", chosennumber, sep="")
  
  #now run the query to get our output.
  selectrow <- sqlQuery(myConn, selectrow)
  
  #Error if project ID does not exist
  if(nrow(selectrow)==0) {
    output$projectname <- renderText({"Error: Project ID invalid"})
    #RESET ALL CHECKS
    updateSelectizeInput(session, inputId = "scoreDG1", selected = "TO BE CHECKED")
    updateSelectizeInput(session, inputId = "scoreDG2", selected = "TO BE CHECKED")
    updateSelectizeInput(session, inputId = "scoreDG3", selected = "TO BE CHECKED")
    updateSelectizeInput(session, inputId = "scoreDG4", selected = "TO BE CHECKED")
    updateSelectizeInput(session, inputId = "scoreDG5", selected = "TO BE CHECKED")
    updateSelectizeInput(session, inputId = "scoreDG6", selected = "TO BE CHECKED")
    updateSelectizeInput(session, inputId = "scoreDG7", selected = "TO BE CHECKED")
    updateSelectizeInput(session, inputId = "scoreDG8", selected = "TO BE CHECKED")
  }
  else{
  output$projectname <- renderText({selectrow[1,2]})
  
  #UPDATE ALL DG CHECKS
  DG1output <- readingOutput(selectrow[1,3])
  updateSelectizeInput(session, inputId = "scoreDG1", selected = DG1output)
  
  DG2output <- readingOutput(selectrow[1,4])
  updateSelectizeInput(session, inputId = "scoreDG2", selected = DG2output)
  
  DG3output <- readingOutput(selectrow[1,5])
  updateSelectizeInput(session, inputId = "scoreDG3", selected = DG3output)
  
  DG4output <- readingOutput(selectrow[1,6])
  updateSelectizeInput(session, inputId = "scoreDG4", selected = DG4output)
  
  DG5output <- readingOutput(selectrow[1,7])
  updateSelectizeInput(session, inputId = "scoreDG5", selected = DG5output)
  
  DG6output <- readingOutput(selectrow[1,8])
  updateSelectizeInput(session, inputId = "scoreDG6", selected = DG6output)
  
  DG7output <- readingOutput(selectrow[1,9])
  updateSelectizeInput(session, inputId = "scoreDG7", selected = DG7output)
  
  DG8output <- readingOutput(selectrow[1,10])
  updateSelectizeInput(session, inputId = "scoreDG8", selected = DG8output)
  
  }
})

#---- Functions for saving to SQL----

#function to insert list in SQL query
InsertListInQuery <- function(querySentence, InList) {
  InValues <- ""
  for (i in 1:length(InList)){
    if (i < length(InList)) {
      InValues <- paste(InValues,"'",InList[[i]],"', ",sep="")}
    else {
      InValues <- paste(InValues,"'",InList[[i]],"'",sep="")
    }
    
  }
  LocOpenParenthesis <- gregexpr('[(]', querySentence)[[1]][[1]]
  LocCloseParenthesis <- gregexpr('[)]', querySentence)[[1]][[1]]
  if (LocCloseParenthesis-LocOpenParenthesis==1) {
    querySentence<- gsub("[(]", paste("(",InValues,sep = ""), querySentence)
  }
  return (querySentence )
}

#writing score as an integer for SQL table
write_score <- function(inputscore){
  if(inputscore == "1) Excellent")
    return('1')
  else if(inputscore == "2) Good")
    return('2')
  else if(inputscore == "3) Some issues")
    return('3')
  else if (inputscore == "4) Needs improvement")
    return('4')
  else if (inputscore == "5) Significant issues")
    return('5')
  else if (inputscore == "N/A")
    return('6')
  else{
    return('7')}
}

#---- Saving to SQL database----
observeEvent(input$saveSQL, {
  chosennumber <- input$projectID
  
  #select correct row from SQL
  selectrow <- paste("SELECT * FROM ", databasename, ".[dbo].[test] WHERE ProjectID = ", chosennumber, sep="")
  
  #now run the query to get our output.
  selectrow <- sqlQuery(myConn, selectrow)
  
  writing_score_DG1 <- reactive({write_score(input$scoreDG1)})
  
  writing_score_DG2 <- reactive({write_score(input$scoreDG2)})
  
  writing_score_DG3 <- reactive({write_score(input$scoreDG3)})
  
  writing_score_DG4 <- reactive({write_score(input$scoreDG4)})
  
  writing_score_DG5 <- reactive({write_score(input$scoreDG5)})
  
  writing_score_DG6 <- reactive({write_score(input$scoreDG6)})
  
  writing_score_DG7 <- reactive({write_score(input$scoreDG7)})
  
  writing_score_DG8 <- reactive({write_score(input$scoreDG8)})
  
  #if project ID does not already exist, create new entry
  if(nrow(selectrow)==0) {
    newRow <- c(input$projectID,input$newprojectname,
                writing_score_DG1(),
                writing_score_DG2(), 
                writing_score_DG3(), 
                writing_score_DG4(), 
                writing_score_DG5(), 
                writing_score_DG6(), 
                writing_score_DG7(), 
                writing_score_DG8())
    
    newRowQuery <- paste("INSERT INTO", databasename,".dbo.test VALUES ();")
    
    newRowSQL <- InsertListInQuery(newRowQuery, newRow)
    
    newRowSet <- sqlQuery(myConn,newRowSQL)

  }
  
  #if project ID does exist, update existing row
  else{
    rowEditQuery <- paste("UPDATE ", databasename,".dbo.test 
                          SET DG1=", writing_score_DG1(),
                          ", DG2 = ", writing_score_DG2(),
                          ", DG3 = ", writing_score_DG3(),
                          ", DG4 = ", writing_score_DG4(),
                          ", DG5 = ", writing_score_DG5(),
                          ", DG6 = ", writing_score_DG6(),
                          ", DG7 = ", writing_score_DG7(),
                          ", DG8 = ", writing_score_DG8(),
                          " WHERE projectID = ", input$projectID, ";", sep="")
    
    rowEditSet <- sqlQuery(myConn,rowEditQuery)
  }
 
})

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

#calculates average percentage rating
percentage_DG <- reactive(if(number_DG()==0){0}
                          else{round(total_DG()/number_DG())})

#score colours
output$scorecolour <- renderText({
  if(percentage_DG() >= 90) {
    "GREEN"
  }
  else if (percentage_DG() >= 70){
    "YELLOW"
  }
  else if (percentage_DG() >= 50){
    "ORANGE"
  }
  else{
    "RED"
  }
})
outputOptions(output, "scorecolour", suspendWhenHidden=FALSE)

output$scoreDGgreen <- renderValueBox({valueBox(paste(percentage_DG()," %"),subtitle="Documentation and Governance")})
output$scoreDGyellow <- renderValueBox({valueBox(paste(percentage_DG()," %"),subtitle="Documentation and Governance")})
output$scoreDGorange <- renderValueBox({valueBox(paste(percentage_DG()," %"),subtitle="Documentation and Governance")})
output$scoreDGred <- renderValueBox({valueBox(paste(percentage_DG()," %"),subtitle="Documentation and Governance")})