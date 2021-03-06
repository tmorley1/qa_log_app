#----Selecting type of log----
types <- reactiveValues(log = "blank")
unsure <- reactiveValues(log = "blank")
nexttab <- reactiveValues(log= "blank")

output$startPanel <- renderUI({
  if (types$log == "blank"){
    fixedRow(column(12,"Welcome to the Department for Education QA log.
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

lapply(logslist,observe_logtype,session=session,types=types,nexttab=nexttab)

#list of weightings to edit in app
weightings <- reactiveValues(DG = "0.2", SC = "0.2", VA = "0.2", VE = "0.2", DA = "0.2")

#list of links to edit in app
links <- reactiveValues(log = "")
#list of links in sql
sqllinks <- reactiveValues(log="")

#----Generating UI when "Create New Log" selected----

output$newPanel <- renderUI({
  if (types$log=="new"){
    fixedRow(br(),
             column(12,"What type of QA log would you like to create?",align="center"),
             br(),
             column(12,lapply(logslist,create_actionbutton), align="center"),
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
    fixedRow(br(),
             column(12,"Here is some information on the different logs to help you decide.", align="center"))
  }
})

#--- Reading in data from SQL database----
observeEvent(input$submitprojectID, {
  chosennumber <- input$projectID
  
  #selecting project name, SRO, AA, BCM from SQL
  selectrow <- paste("SELECT * FROM ", databasename, ".[dbo].[QA_log] WHERE ProjectID = ", chosennumber, sep="")
  
  #now run the query to get our output.
  selectrow <- sqlQuery(myConn, selectrow)%>%replace(.,is.na(.),"")
  
  #Error if project ID does not exist
  if(nrow(selectrow)==0) {
    output$errormessage <- renderText({"Error: Project ID invalid"})
  }
  else{
    output$errormessage <- renderText({""})
    types$log <- paste(selectrow[1,7])
    nexttab$log <- "next"
    
    #UPDATE ANALYST INPUTS
    updateTextInput(session, inputId = "projectID", value = paste(selectrow[1,1]))
    
    updateTextInput(session, inputId = "projectname", value = paste(selectrow[1,2]))
    
    updateTextInput(session, inputId = "version", value = paste(selectrow[1,3]))
    
    updateTextInput(session, inputId = "leadanalyst", value = paste(selectrow[1,4]))
    
    updateTextInput(session, inputId = "analyticalassurer", value = paste(selectrow[1,5]))
    
    updateSelectizeInput(session, inputId = "BCM", selected = selectrow[1,6])
    
    updateTextInput(session, inputId = "QAlogtype", value = logname(paste(selectrow[1,7])))
    
    weightings_sql <- strsplit(selectrow$weighting,split=" ")
    
    weightings$DG <- paste(weightings_sql[[1]][1])
    weightings$SC <- paste(weightings_sql[[1]][2])
    weightings$VE <- paste(weightings_sql[[1]][3])
    weightings$VA <- paste(weightings_sql[[1]][4])
    weightings$DA <- paste(weightings_sql[[1]][5])
    
    #selecting QA check scores from SQL
    qachecks <- paste("SELECT * FROM ", databasename, ".[dbo].[QA_checks] WHERE ProjectID = ", chosennumber, sep="")
    #now run the query to get our output.
    qachecks <- sqlQuery(myConn, qachecks)%>%replace(.,is.na(.),"")
    
    #UPDATE ALL CHECKS
    lapply(logspecificchecks(),update_checks,session1 = session,qachecks = qachecks)
    
    updateTabsetPanel(session, "inTabset", selected="panel2")
    
    #UPDATE LINKS DATABASE
    selectlinks <- paste("SELECT * FROM ", databasename, ".[dbo].[QA_hyperlinks] WHERE ProjectID = ", chosennumber, sep="")
    #read from sql
    selectlinks <- sqlQuery(myConn, selectlinks)%>%replace(.,is.na(.),"")
    
    links$log <- if(nrow(selectlinks)==0){data.frame(projectID="",checkID="",Link="",DisplayText="",LinkID="")}
    else{selectlinks}
    
    sqllinks$log <- if(nrow(selectlinks)==0){data.frame(projectID="",checkID="",Link="",DisplayText="",LinkID="")}
    else{selectlinks}
  }
})

#----Generating UI when "Update log" selected----
observeEvent(input$updatelog, {
  types$log <- "update"
})

output$updatePanel <- renderUI({
  if(types$log=="update" || types$log %in% logslist){
    fixedRow(br(),
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
    fixedRow(column(12, textInput("QAlogtype", "QA Log Type", value=""), align="center"))
  }
})