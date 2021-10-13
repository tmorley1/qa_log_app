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
  
  #select correct row from SQL
  selectrow <- paste("SELECT * FROM ", databasename, ".[dbo].[test] WHERE ProjectID = ", chosennumber, sep="")
  
  #now run the query to get our output.
  selectrow <- sqlQuery(myConn, selectrow)
  
  #if project ID does not already exist, create new entry
  if(nrow(selectrow)==0) {
    newRow <- c(input$projectID,paste(input$projectname),
                paste(input$version),
                paste(input$leadanalyst),
                paste(input$analyticalassurer),
                paste(input$BCM),
                paste(input$QAlogtype),
                writing_score_DG1(),
                paste(input$assessDG1),paste(input$summaryDG1),paste(input$obsDG1),paste(input$outDG1),
                writing_score_DG2(),
                paste(input$assessDG2),paste(input$summaryDG2),paste(input$obsDG2),paste(input$outDG2),
                writing_score_DG3(), 
                paste(input$assessDG3),paste(input$summaryDG3),paste(input$obsDG3),paste(input$outDG3),
                writing_score_DG4(), 
                paste(input$assessDG4),paste(input$summaryDG4),paste(input$obsDG4),paste(input$outDG4),
                writing_score_DG5(), 
                paste(input$assessDG5),paste(input$summaryDG5),paste(input$obsDG5),paste(input$outDG5),
                writing_score_DG6(), 
                paste(input$assessDG6),paste(input$summaryDG6),paste(input$obsDG6),paste(input$outDG6),
                writing_score_DG7(), 
                paste(input$assessDG7),paste(input$summaryDG7),paste(input$obsDG7),paste(input$outDG7),
                writing_score_DG8(),
                paste(input$assessDG8),paste(input$summaryDG8),paste(input$obsDG8),paste(input$outDG8),
                writing_score_DG9(),
                paste(input$assessDG9),paste(input$summaryDG9),paste(input$obsDG9),paste(input$outDG9))
    
    newRowQuery <- paste("INSERT INTO", databasename,".dbo.test VALUES ();")
    
    newRowSQL <- InsertListInQuery(newRowQuery, newRow)
    
    newRowSet <- sqlQuery(myConn,newRowSQL)

  }
  
  #if project ID does exist, update existing row
  else{
    rowEditQuery <- paste("UPDATE ", databasename,".dbo.test 
                          SET ProjectName = '", input$projectname,
                          "', DG1 = ", writing_score_DG1(),
                          ", DG2 = ", writing_score_DG2(),
                          ", DG3 = ", writing_score_DG3(),
                          ", DG4 = ", writing_score_DG4(),
                          ", DG5 = ", writing_score_DG5(),
                          ", DG6 = ", writing_score_DG6(),
                          ", DG7 = ", writing_score_DG7(),
                          ", DG8 = ", writing_score_DG8(),
                          ", DG9 = ", writing_score_DG9(),
                          ", vers = '", input$version,
                          "', leadanalyst = '", input$leadanalyst,
                          "', AnalyticalAssurer = '", input$analyticalassurer,
                          "', BusinessCritical = '", input$BCM,
                          "', DG1Assessor = '", input$assessDG1,
                          "', DG1Evidence = '", input$summaryDG1,
                          "', DG1Observations ='", input$obsDG1,
                          "', DG1Outstanding = '", input$outDG1,
                          "', DG2Assessor = '", input$assessDG2,
                          "', DG2Evidence = '", input$summaryDG2,
                          "', DG2Observations ='", input$obsDG2,
                          "', DG2Outstanding = '", input$outDG2,
                          "', DG3Assessor = '", input$assessDG3,
                          "', DG3Evidence = '", input$summaryDG3,
                          "', DG3Observations ='", input$obsDG3,
                          "', DG3Outstanding = '", input$outDG3,
                          "', DG4Assessor = '", input$assessDG4,
                          "', DG4Evidence = '", input$summaryDG4,
                          "', DG4Observations ='", input$obsDG4,
                          "', DG4Outstanding = '", input$outDG4,
                          "', DG5Assessor = '", input$assessDG5,
                          "', DG5Evidence = '", input$summaryDG5,
                          "', DG5Observations ='", input$obsDG5,
                          "', DG5Outstanding = '", input$outDG5,
                          "', DG6Assessor = '", input$assessDG6,
                          "', DG6Evidence = '", input$summaryDG6,
                          "', DG6Observations ='", input$obsDG6,
                          "', DG6Outstanding = '", input$outDG6,
                          "', DG7Assessor = '", input$assessDG7,
                          "', DG7Evidence = '", input$summaryDG7,
                          "', DG7Observations ='", input$obsDG7,
                          "', DG7Outstanding = '", input$outDG7,
                          "', DG8Assessor = '", input$assessDG8,
                          "', DG8Evidence = '", input$summaryDG8,
                          "', DG8Observations ='", input$obsDG8,
                          "', DG8Outstanding = '", input$outDG8,
                          "', DG9Assessor = '", input$assessDG9,
                          "', DG9Evidence = '", input$summaryDG9,
                          "', DG9Observations ='", input$obsDG9,
                          "', DG9Outstanding = '", input$outDG9,
                          "' WHERE projectID = ", input$projectID, ";", sep="")
    
    rowEditSet <- sqlQuery(myConn,rowEditQuery)
  }
 
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
#select correct row from SQL
selectcurrentrow <- reactive({paste("SELECT * FROM ", databasename, ".[dbo].[test] WHERE ProjectID = ", currentid(), sep="")})
#now run the query to get our output.
currentrow <- reactive({sqlQuery(myConn, selectcurrentrow())})

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
comparison <- reactive({applist()==currentrow()})
#display warning message if there are unsaved changes
savetext <- reactive({
  #if project id is not in SQL database print error message
  if(nrow(currentrow())==0){
  "You have unsaved changes!"
    #if it is then we need to compare lists
  } else {
    #if both lists are the same, no error message
    if ("FALSE" %in% comparison() == "FALSE"){""}
    #otherwise, print error message
    else {"You have unsaved changes!"}}})

output$savedialogue <- renderText(paste(savetext()))

#we need to update the list each time new data is saved, and re-compare lists
observeEvent(input$saveSQL, {
  #select correct row from SQL
  selectonsave <- reactive({paste("SELECT * FROM ", databasename, ".[dbo].[test] WHERE ProjectID = ", currentid(), sep="")})
  #now run the query to get our output.
  currentrow <- reactive({sqlQuery(myConn, selectonsave())})
  #re-compare the lists
  comparison <- reactive({applist()==currentrow()})
  #display warning message if there are unsaved changes
  savetext <- reactive({if ("FALSE" %in% comparison() == "FALSE"){""}
    else {"You have unsaved changes!"}})
  output$savedialogue <- renderText(paste(savetext()))
})