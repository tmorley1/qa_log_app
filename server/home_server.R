#----Selecting type of log----
types <- reactiveValues(log = "blank")
unsure <- reactiveValues(log = "blank")
nexttab <- reactiveValues(log= "blank")

output$startPanel <- renderUI({
  if (types$log == "blank"){
    fluidRow(column(12,"Welcome to the Department for Education QA log.
         Would you like to create a new QA log, or update an existing one?",
         align="center"),
         br(),
         column(6,actionButton("newlog","New QA Log"), align="right"),
         column(6,actionButton("updatelog","Update QA Log"),align="left"))
  }
})

observeEvent(input$newlog, {
  types$log <- "new"
})

#----Modelling QA log----
observeEvent(input$modelling,{
  create_log("modelling","Modelling",session,types,nexttab)
})

#----Data analysis QA log----
observeEvent(input$analysis,{
  create_log("analysis","Data Analysis",session,types,nexttab)
})

#----Dashboard QA log----
observeEvent(input$dashboard,{
  create_log("dashboard","Dashboard",session,types,nexttab)
})

#----Official Statistics QA log----
observeEvent(input$statistics,{
  create_log("statistics","Official Statistics",session,types,nexttab)
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
             column(12,actionButton("unsure", "Unsure which to use?"), align="center"),
             br(), br(), br(),
             column(12,actionButton("back", "Back"), align="center"))
  }
})

observeEvent(input$unsure, {
  unsure$log <- "unsure"
})

#Pressing 'Back' reverts app to original state
observeEvent(input$back, {
  types$log <- "blank"
  unsure$log <- "blank"
})

#Pressing unsure offers more information about each log
output$unsurePanel <- renderUI({
  if (unsure$log == "unsure"){
    fluidRow(br(),
             column(12,"Here is some information on the different logs to help you decide.", align="center"))
  }
})

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
    updateSelectizeInput(session, inputId = "scoreDG9", selected = "TO BE CHECKED")
  }
  else{
    output$errormessage <- renderText({""})
    updateTabsetPanel(session, "inTabset", selected="panel2")
    nexttab$log <- "next"
    
    #UPDATE ANALYST INPUTS
    updateTextInput(session, inputId = "projectname", value = paste(selectrow[1,2]))
    
    updateTextInput(session, inputId = "version", value = paste(selectrow[1,3]))
    
    updateTextInput(session, inputId = "leadanalyst", value = paste(selectrow[1,4]))
    
    updateTextInput(session, inputId = "analyticalassurer", value = paste(selectrow[1,5]))
    
    updateSelectizeInput(session, inputId = "BCM", selected = selectrow[1,6])
    
    updateTextInput(session, inputId = "QAlogtype", value = paste(selectrow[1,7]))
    
    #UPDATE ALL DG CHECKS
    #DG1
    DG1output <- readingOutput(selectrow[1,8])
    updateSelectizeInput(session, inputId = "scoreDG1", selected = DG1output)
    updateTextInput(session, inputId = "assessDG1", value=paste(selectrow[1,9]))
    updateTextInput(session, inputId = "summaryDG1", value=paste(selectrow[1,10]))
    updateTextInput(session, inputId = "obsDG1", value=paste(selectrow[1,11]))
    updateTextInput(session, inputId = "outDG1", value=paste(selectrow[1,12]))
    
    DG2output <- readingOutput(selectrow[1,13])
    updateSelectizeInput(session, inputId = "scoreDG2", selected = DG2output)
    updateTextInput(session, inputId = "assessDG2", value=paste(selectrow[1,14]))
    updateTextInput(session, inputId = "summaryDG2", value=paste(selectrow[1,15]))
    updateTextInput(session, inputId = "obsDG2", value=paste(selectrow[1,16]))
    updateTextInput(session, inputId = "outDG2", value=paste(selectrow[1,17]))
    
    DG3output <- readingOutput(selectrow[1,18])
    updateSelectizeInput(session, inputId = "scoreDG3", selected = DG3output)
    updateTextInput(session, inputId = "assessDG3", value=paste(selectrow[1,19]))
    updateTextInput(session, inputId = "summaryDG3", value=paste(selectrow[1,20]))
    updateTextInput(session, inputId = "obsDG3", value=paste(selectrow[1,21]))
    updateTextInput(session, inputId = "outDG3", value=paste(selectrow[1,22]))
    
    DG4output <- readingOutput(selectrow[1,23])
    updateSelectizeInput(session, inputId = "scoreDG4", selected = DG4output)
    updateTextInput(session, inputId = "assessDG4", value=paste(selectrow[1,24]))
    updateTextInput(session, inputId = "summaryDG4", value=paste(selectrow[1,25]))
    updateTextInput(session, inputId = "obsDG4", value=paste(selectrow[1,26]))
    updateTextInput(session, inputId = "outDG4", value=paste(selectrow[1,27]))
    
    DG5output <- readingOutput(selectrow[1,28])
    updateSelectizeInput(session, inputId = "scoreDG5", selected = DG5output)
    updateTextInput(session, inputId = "assessDG5", value=paste(selectrow[1,29]))
    updateTextInput(session, inputId = "summaryDG5", value=paste(selectrow[1,30]))
    updateTextInput(session, inputId = "obsDG5", value=paste(selectrow[1,31]))
    updateTextInput(session, inputId = "outDG5", value=paste(selectrow[1,32]))
    
    DG6output <- readingOutput(selectrow[1,33])
    updateSelectizeInput(session, inputId = "scoreDG6", selected = DG6output)
    updateTextInput(session, inputId = "assessDG6", value=paste(selectrow[1,34]))
    updateTextInput(session, inputId = "summaryDG6", value=paste(selectrow[1,35]))
    updateTextInput(session, inputId = "obsDG6", value=paste(selectrow[1,36]))
    updateTextInput(session, inputId = "outDG6", value=paste(selectrow[1,37]))
    
    DG7output <- readingOutput(selectrow[1,38])
    updateSelectizeInput(session, inputId = "scoreDG7", selected = DG7output)
    updateTextInput(session, inputId = "assessDG7", value=paste(selectrow[1,39]))
    updateTextInput(session, inputId = "summaryDG7", value=paste(selectrow[1,40]))
    updateTextInput(session, inputId = "obsDG7", value=paste(selectrow[1,41]))
    updateTextInput(session, inputId = "outDG7", value=paste(selectrow[1,42]))
    
    DG8output <- readingOutput(selectrow[1,43])
    updateSelectizeInput(session, inputId = "scoreDG8", selected = DG8output)
    updateTextInput(session, inputId = "assessDG8", value=paste(selectrow[1,44]))
    updateTextInput(session, inputId = "summaryDG8", value=paste(selectrow[1,45]))
    updateTextInput(session, inputId = "obsDG8", value=paste(selectrow[1,46]))
    updateTextInput(session, inputId = "outDG8", value=paste(selectrow[1,47]))
    
    DG9output <- readingOutput(selectrow[1,48])
    updateSelectizeInput(session, inputId = "scoreDG9", selected = DG9output)
    updateTextInput(session, inputId = "assessDG9", value=paste(selectrow[1,49]))
    updateTextInput(session, inputId = "summaryDG9", value=paste(selectrow[1,50]))
    updateTextInput(session, inputId = "obsDG9", value=paste(selectrow[1,51]))
    updateTextInput(session, inputId = "outDG9", value=paste(selectrow[1,52]))
  }
})

#----Generating UI when "Update log" selected----
observeEvent(input$updatelog, {
  types$log <- "update"
})

output$updatePanel <- renderUI({
  if(types$log=="update" || types$log=="modelling" || types$log=="analysis" || types$log=="dashboard" || types$log=="statistics"){
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

#Don't want user to be able to edit QAlogtype manually
#So this panel is only visible once we have moved to next tab
output$logtypepanel <- renderUI({
  if(nexttab$log=="next"){
    fluidRow(column(12, textInput("QAlogtype", "QA Log Type", value=""), align="center"))
  }
})