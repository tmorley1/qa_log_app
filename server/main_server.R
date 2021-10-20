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

#---- UI output for checks----
justDGchecks<-(data.frame(QAcheckslist)%>%filter(grepl("DG",QAcheckslist)==TRUE))$QAcheckslist
output$DGuichecks <- renderUI(lapply(justDGchecks,UI_check,types=types,QAlogtype=input.QAlogtype))

justSCchecks<-(data.frame(QAcheckslist)%>%filter(grepl("SC",QAcheckslist)==TRUE))$QAcheckslist
output$SCuichecks <- renderUI(lapply(justSCchecks,UI_check,types=types,QAlogtype=input.QAlogtype))


#---- Saving to SQL database----

#This creates a list of current score inputs
paste_score_input <- function(checkname){
  eval(parse(text=paste0("input$score",checkname)))
}
#Applying above function to all checks
scoreinput <- reactive({sapply(QAcheckslist,paste_score_input)})
#Writing all checks as numbers 1-7
writing_score <- reactive({sapply(scoreinput(), write_score)})

paste_other_input <- function(checkname){
  c(checkname,
    write_score(eval(parse(text=paste0("input$score",checkname)))),
    eval(parse(text=paste0("input$assess",checkname))),
    eval(parse(text=paste0("input$summary",checkname))),
    eval(parse(text=paste0("input$obs",checkname))),
    eval(parse(text=paste0("input$out",checkname)))
  )
}
#Applying above function to all checks
otherinput <- reactive({sapply(QAcheckslist,paste_other_input)})
otherinputdf <- reactive({data.frame(otherinput())})

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

  lapply(QAcheckslist,savingscore, dataframe=otherinputdf(),qacheckSave=qacheckSave,projectID=input$projectID,databasename=databasename,myConn=myConn)

})
  
#---- Calculating scores ----
#Assigns a numerical score to each rating
allcheckscores<-reactive({sapply(QAcheckslist,calculate_score)})
#adds up all scores
total_DG <- reactive({sum(allcheckscores())})

#adds up number of ratings
numbercheckscores<-reactive({sapply(QAcheckslist,iszero)})
number_DG <- reactive({sum(numbercheckscores())})

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

observe_info <- function(qacheck){
  observeEvent(input[[paste0(qacheck,"info")]],{
    modal_check(qacheck)
  })
}

lapply(QAcheckslist,observe_info)

#---- Tooltips-----
#This displays extra tips on ratings when hovering over selection menu
#Tips are different depending on type of log

#This function decides which tips to display depending on type of log
tooltipfunc <- function(input,QAchecks){
  tooltiptext <- if (input == "Modelling") {eval(parse(text=paste0(QAchecks,"tooltipmodelling")))}
    else if (input == "Data Analysis") {eval(parse(text=paste0(QAchecks,"tooltipanalysis")))}
    else if (input == "Dashboard") {eval(parse(text=paste0(QAchecks,"tooltipdashboard")))}
    else if (input == "Official Statistics") {eval(parse(text=paste0(QAchecks,"tooltipstatistics")))}
    else {"Error"}
  return(tooltiptext)
}

#This function creates the UI necessary to render the tooltips
tooltip_ui_render <- function(checkid,input){
    bsTooltip(id=paste0("score",checkid),
              title=tooltipfunc(input,checkid),
              trigger="hover",placement="right")
}

#This applies the above function to every QA check
output$tooltips <- renderUI(lapply(QAcheckslist,tooltip_ui_render,input=input$QAlogtype))

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
    lapply(QAcheckslist,reset_checks,session1=session)
    
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
  lapply(QAcheckslist,reset_checks,session1=session)
  
  #reset home screen
  types$log <- "blank"
  unsure$log <- "blank"
  nexttab$log <- "blank"
  
  #switch tabs
  updateTabsetPanel(session, "inTabset", selected="panel1")
  removeModal()
})
#---- Checking for save----
#To check whether new changes have been saved or not, we generate a dataframe
#of current entries in app and compare with list from SQL

#first, read in list from SQL
currentid <- reactive({input$projectID})
#select correct row from QA_log SQL
selectlogrow <- reactive({paste("SELECT * FROM ", databasename, ".[dbo].[QA_log] WHERE ProjectID = ", currentid(), sep="")})
#now run the query to get our output.
logrow <- reactive({sqlQuery(myConn, selectlogrow())})
#if projectID doesn't exist in SQL, create dummy row of data
logrowfinal <- reactive({if(nrow(logrow())==0){
  t(c(input$projectID,"NA","NA","NA","NA","NA","NA"))
} else{logrow()}})

#select correct rows from QA_checks SQL
selectchecks <- reactive({paste("SELECT * FROM ", databasename, ".[dbo].[QA_checks] WHERE ProjectID = ", currentid(), sep="")})
#now run the query to get our output.
checks <- reactive({sqlQuery(myConn, selectchecks())})
#The function pulls in info on individual checks
#And inserts "dummy info" where there is no data for that check
individualChecks <- function(checkIDtext,checks){
  somebits <- checks %>% filter(checkID==checkIDtext)
  if (nrow(somebits)==0){
    newrow <- c("ID",checkIDtext,7,"","","","")
    somebits <- rbind(somebits,newrow)
  }
  return(somebits)
}
#build a dataframe with all current SQL data
sqlinfo <- reactive({sapply(QAcheckslist,individualChecks,checks=checks())})
sqlinfodf <- reactive({data.frame(sqlinfo())})
allsqlinfodf <- reactive({cbind(t(logrowfinal()),sqlinfodf())[-1,]})

output$writingtest<-renderDataTable(allsqlinfodf())

#now create the same data frame, with info taken from the app
appinfo <- reactive({c(input$projectname, input$version,
                       input$leadanalyst, input$analyticalassurer, input$BCM,
                       input$QAlogtype)})
appinfodf <- reactive({data.frame(cbind(appinfo(),otherinput()))})

output$writingtest2<-renderDataTable(appinfodf())

#we now compare the lists
comparison <- reactive({appinfodf()==allsqlinfodf()})
#display warning message if there are unsaved changes
savetext <- reactive({
    #if both lists are the same, no error message
    if ("FALSE" %in% comparison() == "FALSE"){""}
    #otherwise, print error message
    else {"You have unsaved changes!"}})

output$savedialogue <- renderText(paste(savetext()))

#we need to update the list each time new data is saved, and re-compare lists
observeEvent(input$saveSQL, {
  #first, read in list from SQL
  currentid <- reactive({input$projectID})
  #select correct row from QA_log SQL
  selectlogrow <- reactive({paste("SELECT * FROM ", databasename, ".[dbo].[QA_log] WHERE ProjectID = ", currentid(), sep="")})
  #now run the query to get our output.
  logrowfinal <- reactive({sqlQuery(myConn, selectlogrow())})
  #select correct rows from QA_checks SQL
  selectchecks <- reactive({paste("SELECT * FROM ", databasename, ".[dbo].[QA_checks] WHERE ProjectID = ", currentid(), sep="")})
  #now run the query to get our output.
  checks <- reactive({sqlQuery(myConn, selectchecks())})
  #build a dataframe with all current SQL data
  sqlinfo <- reactive({sapply(QAcheckslist,individualChecks,checks=checks())})
  sqlinfodf <- reactive({data.frame(sqlinfo())})
  allsqlinfodf <- reactive({cbind(t(logrowfinal()),sqlinfodf())[-1,]})
  
  output$writingtest<-renderDataTable(allsqlinfodf())
  
  #re-compare the lists
  comparison <- reactive({appinfodf()==allsqlinfodf()})
  #display warning message if there are unsaved changes
  savetext <- reactive({if ("FALSE" %in% comparison() == "FALSE"){""}
    else {"You have unsaved changes!"}})
  output$savedialogue <- renderText(paste(savetext()))
})