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

observeEvent(input$modelling,{
  create_log("modelling","Modelling",session,types,nexttab)
})

observeEvent(input$analysis,{
  create_log("analysis","Data Analysis",session,types,nexttab)
})

observeEvent(input$dashboard,{
  create_log("dashboard","Dashboard",session,types,nexttab)
})

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
    update_checks("DG1",8,session, selectrow)
    update_checks("DG2",13,session,selectrow)
    update_checks("DG3",18,session,selectrow)
    update_checks("DG4",23,session,selectrow)
    update_checks("DG5",28,session,selectrow)
    update_checks("DG6",33,session,selectrow)
    update_checks("DG7",38,session,selectrow)
    update_checks("DG8",43,session,selectrow)
    update_checks("DG9",48,session,selectrow)
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
                    )), align="center"),
             br(),br(),
             column(12,actionButton("backupdate","Back"), align="center"))
  }
})

observeEvent(input$backupdate, {
  types$log <- "blank"
  unsure$log <- "blank"
})

#Don't want user to be able to edit QAlogtype manually
#So this panel is only visible once we have moved to next tab
output$logtypepanel <- renderUI({
  if(nexttab$log=="next"){
    fluidRow(column(12, textInput("QAlogtype", "QA Log Type", value=""), align="center"))
  }
})