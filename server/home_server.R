#----Selecting type of log----
types <- reactiveValues(log = "blank")

observeEvent(input$newlog, {
  types$log <- "new"
})

observeEvent(input$modelling,{
  updateTabsetPanel(session, "inTabset", selected="panel2")
})

observeEvent(input$analysis,{
  updateTabsetPanel(session, "inTabset", selected="panel2")
})

observeEvent(input$dashboard,{
  updateTabsetPanel(session, "inTabset", selected="panel2")
})

observeEvent(input$statistics,{
  updateTabsetPanel(session, "inTabset", selected="panel2")
})

observeEvent(input$updatelog, {
  types$log <- "update"
})

#----Generating UI when "Create New Log" selected----
output$newPanel <- renderUI({
  if (types$log=="new"){
    fluidRow(br(),
             column(12,"What type of QA log would you like to create?",align="center"),
             br(),
             column(12,actionButton("modelling","Modelling"),
                       actionButton("analysis", "Data Analysis"),
                       actionButton("dashboard", "Dashboard"),
                       actionButton("statistics", "Official Statistics"), align="center"),
             br(), br(), br(),
             column(12,actionButton("unsure", "Unsure which to use?"), align="center"))
  }
})

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
    output$errormessage <- renderText({"Error: Project ID invalid"})
    #RESET ALL CHECKS
    updateTextInput(session, inputId = "projectname", value="")
    updateTextInput(session, inputId = "version", value="")
    updateTextInput(session, inputId = "leadanalyst", value="")
    updateTextInput(session, inputId = "analyticalassurer", value="")
    updateSelectizeInput(session, inputId = "BCM", selected = "No")
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
    output$errormessage <- renderText({""})
    updateTabsetPanel(session, "inTabset", selected="panel2")
    #UPDATE ANALYST INPUTS
    updateTextInput(session, inputId = "projectname", value = paste(selectrow[1,2]))
    
    updateTextInput(session, inputId = "version", value = paste(selectrow[1,11]))
    
    updateTextInput(session, inputId = "leadanalyst", value = paste(selectrow[1,12]))
    
    updateTextInput(session, inputId = "analyticalassurer", value = paste(selectrow[1,13]))
    
    updateSelectizeInput(session, inputId = "BCM", selected = selectrow[1,14])
    
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

#----Generating UI when "Update log" selected----
output$updatePanel <- renderUI({
  if(types$log=="update"){
    fluidRow(br(),
             column(12, textInput("projectID", "Project ID", value=""), align="center"),
             br(),
             column(12, actionButton("submitprojectID", "Submit"), align="center"),
             #Error message if project ID does not exist
             column(12,br(),
                    textOutput("errormessage"),
                    tags$head(tags$style("#errormessage{color: red;
                  font-size: 20px;
                  }"
                    )), align="center"))
  }
})