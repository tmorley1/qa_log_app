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

#---- Saving to SQL database----
writing_score_DG1 <- reactive({write_score(input$scoreDG1)})

writing_score_DG2 <- reactive({write_score(input$scoreDG2)})

writing_score_DG3 <- reactive({write_score(input$scoreDG3)})

writing_score_DG4 <- reactive({write_score(input$scoreDG4)})

writing_score_DG5 <- reactive({write_score(input$scoreDG5)})

writing_score_DG6 <- reactive({write_score(input$scoreDG6)})

writing_score_DG7 <- reactive({write_score(input$scoreDG7)})

writing_score_DG8 <- reactive({write_score(input$scoreDG8)})

writing_score_DG9 <- reactive({write_score(input$scoreDG9)})

observeEvent(input$saveSQL, {
  chosennumber <- input$projectID
  
  #first we edit QA_log SQL database
  selectrow <- paste("SELECT * FROM ", databasename, ".[dbo].[QA_log] WHERE ProjectID = ", chosennumber, sep="")
  
  #now run the query to get our output.
  selectrow <- sqlQuery(myConn, selectrow)
  
  #if project ID does not already exist, create new entry
  if(nrow(selectrow)==0) {
    newRow <- c(input$projectID,paste(input$projectname),
                paste(input$version),
                paste(input$leadanalyst),
                paste(input$analyticalassurer),
                paste(input$BCM),
                paste(input$QAlogtype))
    
    newRowQuery <- paste("INSERT INTO", databasename,".dbo.QA_log VALUES ();")
    
    newRowSQL <- InsertListInQuery(newRowQuery, newRow)
    
    newRowSet <- sqlQuery(myConn,newRowSQL)

  }
  
  #if project ID does exist, update existing row
  else{
    rowEditQuery <- paste("UPDATE ", databasename,".dbo.QA_log 
                          SET ProjectName = '", input$projectname,
                          "', vers = '", input$version,
                          "', leadanalyst = '", input$leadanalyst,
                          "', AnalyticalAssurer = '", input$analyticalassurer,
                          "', BusinessCritical = '", input$BCM,
                          "' WHERE projectID = ", input$projectID, ";", sep="")
    
    rowEditSet <- sqlQuery(myConn,rowEditQuery)
  }
  
  #now we edit QA_checks SQL database
  qacheckSave <- paste("SELECT * FROM ", databasename, ".[dbo].[QA_checks] WHERE ProjectID = ", chosennumber, sep="")
  
  #now run the query to get our output.
  qacheckSave <- sqlQuery(myConn, qacheckSave)

  #Saving scores
  savingscore("DG1",qacheckSave,input$projectID, writing_score_DG1(),input$assessDG1,input$summaryDG1,input$obsDG1,input$outDG1,databasename,myConn)
  savingscore("DG2",qacheckSave,input$projectID, writing_score_DG2(),input$assessDG2,input$summaryDG2,input$obsDG2,input$outDG2,databasename,myConn)
  savingscore("DG3",qacheckSave,input$projectID, writing_score_DG3(),input$assessDG3,input$summaryDG3,input$obsDG3,input$outDG3,databasename,myConn)
  savingscore("DG4",qacheckSave,input$projectID, writing_score_DG4(),input$assessDG4,input$summaryDG4,input$obsDG4,input$outDG4,databasename,myConn)
  savingscore("DG5",qacheckSave,input$projectID, writing_score_DG5(),input$assessDG5,input$summaryDG5,input$obsDG5,input$outDG5,databasename,myConn)
  savingscore("DG6",qacheckSave,input$projectID, writing_score_DG6(),input$assessDG6,input$summaryDG6,input$obsDG6,input$outDG6,databasename,myConn)
  savingscore("DG7",qacheckSave,input$projectID, writing_score_DG7(),input$assessDG7,input$summaryDG7,input$obsDG7,input$outDG7,databasename,myConn)
  savingscore("DG8",qacheckSave,input$projectID, writing_score_DG8(),input$assessDG8,input$summaryDG8,input$obsDG8,input$outDG8,databasename,myConn)
  savingscore("DG9",qacheckSave,input$projectID, writing_score_DG9(),input$assessDG9,input$summaryDG9,input$obsDG9,input$outDG9,databasename,myConn)


})
  
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

output$projectIDtext <- renderValueBox({valueBox(paste(input$projectID), subtitle="Project ID")})

output$QAlogtypetext <- renderValueBox({valueBox(paste(input$QAlogtype), subtitle="QA log type")})

#---- Displaying more info on checks -----
#The following code provides the extra info when you click on the checks.
#Info is different for each type of log
#The info is read in from comments_'model name'_log.R

observeEvent(input$DG1info, {
  modal_check("Scope and specification", "DG1")
})
observeEvent(input$DG2info, {
  modal_check("User guide", "DG2")
})
observeEvent(input$DG3info, {
  modal_check("Technical guide", "DG3")
})
observeEvent(input$DG4info, {
  modal_check("KIM", "DG4")
})
observeEvent(input$DG5info, {
  modal_check("Version control", "DG5")
})
observeEvent(input$DG6info, {
  modal_check("Responsibilities", "DG6")
})
observeEvent(input$DG7info, {
  modal_check("QA planning and resourcing", "DG7")
})
observeEvent(input$DG8info, {
  modal_check("Record of QA", "DG8")
})
observeEvent(input$DG9info, {
  modal_check("Risk and Issues log", "DG9")
})
#---- Tooltips-----
#This displays extra tips on ratings when hovering over selection menu
#Tips are different depending on type of log
tooltipfunc <- function(modelling,analysis, dashboard, statistics){
  tooltiptext <- reactive({
    if (input$QAlogtype == "Modelling") {modelling}
    else if (input$QAlogtype == "Data Analysis") {analysis}
    else if (input$QAlogtype == "Dashboard") {dashboard}
    else if (input$QAlogtype == "Official Statistics") {statistics}
    else {"Error"}
  })
  return(tooltiptext)
}

DG1tip <- tooltipfunc(DG1tooltipmodelling,DG1tooltipanalysis,DG1tooltipdashboard,DG1tooltipstatistics)
DG2tip <- tooltipfunc(DG2tooltipmodelling,DG2tooltipanalysis,DG2tooltipdashboard,DG2tooltipstatistics)
DG3tip <- tooltipfunc(DG3tooltipmodelling,DG3tooltipanalysis,DG3tooltipdashboard,DG3tooltipstatistics)
DG4tip <- tooltipfunc(DG4tooltipmodelling,DG4tooltipanalysis,DG4tooltipdashboard,DG4tooltipstatistics)
DG5tip <- tooltipfunc(DG5tooltipmodelling,DG5tooltipanalysis,DG5tooltipdashboard,DG5tooltipstatistics)
DG6tip <- tooltipfunc(DG6tooltipmodelling,DG6tooltipanalysis,DG6tooltipdashboard,DG6tooltipstatistics)
DG7tip <- tooltipfunc(DG7tooltipmodelling,DG7tooltipanalysis,DG7tooltipdashboard,DG7tooltipstatistics)
DG8tip <- tooltipfunc(DG8tooltipmodelling,DG8tooltipanalysis,DG8tooltipdashboard,DG8tooltipstatistics)
DG9tip <- tooltipfunc(DG9tooltipmodelling,DG9tooltipanalysis,DG9tooltipdashboard,DG9tooltipstatistics)

#R Shiny only likes it when each tooltip is wrapped in a different renderUI function
output$tooltipsDG1 <- renderUI({
  bsTooltip(id="scoreDG1", title = paste0(DG1tip()), trigger= "hover", placement="right")
})
output$tooltipsDG2 <- renderUI({
  bsTooltip(id="scoreDG2", title = paste0(DG2tip()), trigger= "hover", placement="right")
})
output$tooltipsDG3 <- renderUI({
  bsTooltip(id="scoreDG3", title = paste0(DG3tip()), trigger= "hover", placement="right")
})
output$tooltipsDG4 <- renderUI({
  bsTooltip(id="scoreDG4", title = paste0(DG4tip()), trigger= "hover", placement="right")
})
output$tooltipsDG5 <- renderUI({
  bsTooltip(id="scoreDG5", title = paste0(DG5tip()), trigger= "hover", placement="right")
})
output$tooltipsDG6 <- renderUI({
  bsTooltip(id="scoreDG6", title = paste0(DG6tip()), trigger= "hover", placement="right")
})
output$tooltipsDG7 <- renderUI({
  bsTooltip(id="scoreDG7", title = paste0(DG7tip()), trigger= "hover", placement="right")
})
output$tooltipsDG8 <- renderUI({
  bsTooltip(id="scoreDG8", title = paste0(DG8tip()), trigger= "hover", placement="right")
})
output$tooltipsDG9 <- renderUI({
  bsTooltip(id="scoreDG9", title = paste0(DG9tip()), trigger= "hover", placement="right")
})

#---- Back to home-----
observeEvent(input$backtohome,{
  if(savetext()=="You have unsaved changes!"){
    showModal(modalDialog(
    "Are you sure you want to go back? Your work will not be saved!",
    br(), br(),
    actionButton("definitelygoback","I'm sure")))
  }
  else {
    #reset all checks
    #resetting data at top of log
    updateTextInput(session, inputId = "projectname", value = "")
    updateTextInput(session, inputId = "version", value = "")
    updateTextInput(session, inputId = "leadanalyst", value = "")
    updateTextInput(session, inputId = "analyticalassurer", value = "")
    updateSelectizeInput(session, inputId = "BCM", selected = "No")
    updateTextInput(session, inputId = "QAlogtype", value = "")
    #resetting documentation and governance checks
    reset_checks("DG1",session)
    reset_checks("DG2",session)
    reset_checks("DG3",session)
    reset_checks("DG4",session)
    reset_checks("DG5",session)
    reset_checks("DG6",session)
    reset_checks("DG7",session)
    reset_checks("DG8",session)
    reset_checks("DG9",session)
    
    #reset home screen
    types$log <- "blank"
    unsure$log <- "blank"
    nexttab$log <- "blank"
    
    #switch tabs
    updateTabsetPanel(session, "inTabset", selected="panel1")
  }
})

observeEvent(input$definitelygoback,{
  #reset all checks
  #resetting data at top of log
  updateTextInput(session, inputId = "projectname", value = "")
  updateTextInput(session, inputId = "version", value = "")
  updateTextInput(session, inputId = "leadanalyst", value = "")
  updateTextInput(session, inputId = "analyticalassurer", value = "")
  updateSelectizeInput(session, inputId = "BCM", selected = "No")
  updateTextInput(session, inputId = "QAlogtype", value = "")
  #resetting documentation and governance checks
  reset_checks("DG1",session)
  reset_checks("DG2",session)
  reset_checks("DG3",session)
  reset_checks("DG4",session)
  reset_checks("DG5",session)
  reset_checks("DG6",session)
  reset_checks("DG7",session)
  reset_checks("DG8",session)
  reset_checks("DG9",session)
  
  #reset home screen
  types$log <- "blank"
  unsure$log <- "blank"
  nexttab$log <- "blank"
  
  #switch tabs
  updateTabsetPanel(session, "inTabset", selected="panel1")
  removeModal()
})
#---- Checking for save----
#To check whether new changes have been saved or not, we generate a list
#of current entries in app and compare with list from SQL

#first, read in list from SQL
currentid <- reactive({input$projectID})
#select correct row from QA_log SQL
selectlogrow <- reactive({paste("SELECT * FROM ", databasename, ".[dbo].[QA_log] WHERE ProjectID = ", currentid(), sep="")})
#now run the query to get our output.
logrow <- reactive({sqlQuery(myConn, selectlogrow())})
#select correct rows from QA_checks SQL
selectchecks <- reactive({paste("SELECT * FROM ", databasename, ".[dbo].[QA_checks] WHERE ProjectID = ", currentid(), sep="")})
#now run the query to get our output.
checks <- reactive({sqlQuery(myConn, selectchecks())})
#The function pulls in info on individual checks
individualChecks <- function(checkIDtext,checks){
  somebits <- checks %>% filter(checkID==checkIDtext)
  if (nrow(somebits)==0){
    newrow <- c("ID",checkIDtext,7,"","","","")
    somebits <- rbind(somebits,newrow)
  }
  return(somebits)
}
#We create dataframe for each check
DG1bits <- reactive({individualChecks("DG1",checks())})
DG2bits <- reactive({individualChecks("DG2",checks())})
DG3bits <- reactive({individualChecks("DG3",checks())})
DG4bits <- reactive({individualChecks("DG4",checks())})
DG5bits <- reactive({individualChecks("DG5",checks())})
DG6bits <- reactive({individualChecks("DG6",checks())})
DG7bits <- reactive({individualChecks("DG7",checks())})
DG8bits <- reactive({individualChecks("DG8",checks())})
DG9bits <- reactive({individualChecks("DG9",checks())})

#Read out everything from SQL as one long row to compare with app input
finallist <- reactive({c(logrow()[1,1],logrow()[1,2],logrow()[1,3],logrow()[1,4],
                         logrow()[1,5],logrow()[1,6],logrow()[1,7],
                         DG1bits()[1,3],DG1bits()[1,4],DG1bits()[1,5],DG1bits()[1,6],DG1bits()[1,7],
                         DG2bits()[1,3],DG2bits()[1,4],DG2bits()[1,5],DG2bits()[1,6],DG2bits()[1,7],
                         DG3bits()[1,3],DG3bits()[1,4],DG3bits()[1,5],DG3bits()[1,6],DG3bits()[1,7],
                         DG4bits()[1,3],DG4bits()[1,4],DG4bits()[1,5],DG4bits()[1,6],DG4bits()[1,7],
                         DG5bits()[1,3],DG5bits()[1,4],DG5bits()[1,5],DG5bits()[1,6],DG5bits()[1,7],
                         DG6bits()[1,3],DG6bits()[1,4],DG6bits()[1,5],DG6bits()[1,6],DG6bits()[1,7],
                         DG7bits()[1,3],DG7bits()[1,4],DG7bits()[1,5],DG7bits()[1,6],DG7bits()[1,7],
                         DG8bits()[1,3],DG8bits()[1,4],DG8bits()[1,5],DG8bits()[1,6],DG8bits()[1,7],
                         DG9bits()[1,3],DG9bits()[1,4],DG9bits()[1,5],DG9bits()[1,6],DG9bits()[1,7])})

#now we create the same list, with all info taken from the app
applist <- reactive({c(input$projectID, input$projectname, input$version, 
                       input$leadanalyst, input$analyticalassurer, input$BCM, 
                       input$QAlogtype, writing_score_DG1(), input$assessDG1, 
                       input$summaryDG1, input$obsDG1, input$outDG1,
                       writing_score_DG2(), input$assessDG2, 
                       input$summaryDG2, input$obsDG2, input$outDG2,
                       writing_score_DG3(), input$assessDG3, 
                       input$summaryDG3, input$obsDG3, input$outDG3,
                       writing_score_DG4(), input$assessDG4, 
                       input$summaryDG4, input$obsDG4, input$outDG4,
                       writing_score_DG5(), input$assessDG5, 
                       input$summaryDG5, input$obsDG5, input$outDG5,
                       writing_score_DG6(), input$assessDG6, 
                       input$summaryDG6, input$obsDG6, input$outDG6,
                       writing_score_DG7(), input$assessDG7, 
                       input$summaryDG7, input$obsDG7, input$outDG7,
                       writing_score_DG8(), input$assessDG8, 
                       input$summaryDG8, input$obsDG8, input$outDG8,
                       writing_score_DG9(), input$assessDG9, 
                       input$summaryDG9, input$obsDG9, input$outDG9)})

#we now compare the lists
comparison <- reactive({applist()==finallist()})
#display warning message if there are unsaved changes
savetext <- reactive({
    #if both lists are the same, no error message
    if ("FALSE" %in% comparison() == "FALSE"){""}
    #otherwise, print error message
    else {"You have unsaved changes!"}})

output$savedialogue <- renderText(paste(savetext()))

#we need to update the list each time new data is saved, and re-compare lists
observeEvent(input$saveSQL, {
  #select correct row from SQL
  #select correct row from QA_log SQL
  selectlogrow <- reactive({paste("SELECT * FROM ", databasename, ".[dbo].[QA_log] WHERE ProjectID = ", currentid(), sep="")})
  #now run the query to get our output.
  logrow <- reactive({sqlQuery(myConn, selectlogrow())})
  #select correct rows from QA_checks SQL
  selectchecks <- reactive({paste("SELECT * FROM ", databasename, ".[dbo].[QA_checks] WHERE ProjectID = ", currentid(), sep="")})
  #now run the query to get our output.
  checks <- reactive({sqlQuery(myConn, selectchecks())})
  #We create dataframe for each check
  DG1bits <- reactive({individualChecks("DG1",checks())})
  DG2bits <- reactive({individualChecks("DG2",checks())})
  DG3bits <- reactive({individualChecks("DG3",checks())})
  DG4bits <- reactive({individualChecks("DG4",checks())})
  DG5bits <- reactive({individualChecks("DG5",checks())})
  DG6bits <- reactive({individualChecks("DG6",checks())})
  DG7bits <- reactive({individualChecks("DG7",checks())})
  DG8bits <- reactive({individualChecks("DG8",checks())})
  DG9bits <- reactive({individualChecks("DG9",checks())})
  #Read out everything from SQL as one long row to compare with app input
  finallist <- reactive({c(logrow()[1,1],logrow()[1,2],logrow()[1,3],logrow()[1,4],
                           logrow()[1,5],logrow()[1,6],logrow()[1,7],
                           DG1bits()[1,3],DG1bits()[1,4],DG1bits()[1,5],DG1bits()[1,6],DG1bits()[1,7],
                           DG2bits()[1,3],DG2bits()[1,4],DG2bits()[1,5],DG2bits()[1,6],DG2bits()[1,7],
                           DG3bits()[1,3],DG3bits()[1,4],DG3bits()[1,5],DG3bits()[1,6],DG3bits()[1,7],
                           DG4bits()[1,3],DG4bits()[1,4],DG4bits()[1,5],DG4bits()[1,6],DG4bits()[1,7],
                           DG5bits()[1,3],DG5bits()[1,4],DG5bits()[1,5],DG5bits()[1,6],DG5bits()[1,7],
                           DG6bits()[1,3],DG6bits()[1,4],DG6bits()[1,5],DG6bits()[1,6],DG6bits()[1,7],
                           DG7bits()[1,3],DG7bits()[1,4],DG7bits()[1,5],DG7bits()[1,6],DG7bits()[1,7],
                           DG8bits()[1,3],DG8bits()[1,4],DG8bits()[1,5],DG8bits()[1,6],DG8bits()[1,7],
                           DG9bits()[1,3],DG9bits()[1,4],DG9bits()[1,5],DG9bits()[1,6],DG9bits()[1,7])})
  #re-compare the lists
  comparison <- reactive({applist()==finallist()})
  #display warning message if there are unsaved changes
  savetext <- reactive({if ("FALSE" %in% comparison() == "FALSE"){""}
    else {"You have unsaved changes!"}})
  output$savedialogue <- renderText(paste(savetext()))
})