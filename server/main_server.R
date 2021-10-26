#---- UI output for checks----
#Selecting specific pillar checks
justDGchecks<-reactive({(names_df%>%filter(grepl("DG",QAcheckslist)==TRUE)%>%filter(eval(parse(text=paste0(types$log,"_names")))!=0))$QAcheckslist})
justSCchecks<-reactive({(names_df%>%filter(grepl("SC",QAcheckslist)==TRUE)%>%filter(eval(parse(text=paste0(types$log,"_names")))!=0))$QAcheckslist})
justVEchecks<-reactive({(names_df%>%filter(grepl("VE",QAcheckslist)==TRUE)%>%filter(eval(parse(text=paste0(types$log,"_names")))!=0))$QAcheckslist})
justVAchecks<-reactive({(names_df%>%filter(grepl("VA",QAcheckslist)==TRUE)%>%filter(eval(parse(text=paste0(types$log,"_names")))!=0))$QAcheckslist})
justDAchecks<-reactive({(names_df%>%filter(grepl("DA",QAcheckslist)==TRUE)%>%filter(eval(parse(text=paste0(types$log,"_names")))!=0))$QAcheckslist})
logspecificchecks<-reactive({(names_df%>%filter(eval(parse(text=paste0(types$log,"_names")))!=0))$QAcheckslist})

output$projectIDtext <- renderValueBox({valueBox(paste(input$projectID), subtitle="Project ID")})

output$QAlogtypetext <- renderValueBox({valueBox(paste(input$QAlogtype), subtitle="QA log type")})

output$DGuichecks <- renderUI(lapply(justDGchecks(),UI_check,types=types,names_df=names_df))
outputOptions(output, "DGuichecks", suspendWhenHidden=FALSE)

output$SCuichecks <- renderUI(lapply(justSCchecks(),UI_check,types=types,names_df=names_df))
outputOptions(output, "SCuichecks", suspendWhenHidden=FALSE)

output$VEuichecks <- renderUI(lapply(justVEchecks(),UI_check,types=types,names_df=names_df))
outputOptions(output, "VEuichecks", suspendWhenHidden=FALSE)

output$VAuichecks <- renderUI(lapply(justVAchecks(),UI_check,types=types,names_df=names_df))
outputOptions(output, "VAuichecks", suspendWhenHidden=FALSE)

output$DAuichecks <- renderUI(lapply(justDAchecks(),UI_check,types=types,names_df=names_df))
outputOptions(output, "DAuichecks", suspendWhenHidden=FALSE)

#---- Saving to SQL database----

#This creates a list of current score inputs
paste_score_input <- function(checkname){
  eval(parse(text=paste0("input$score",checkname)))
}
#Applying above function to all checks
scoreinput <- reactive({sapply(logspecificchecks(),paste_score_input)})
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
otherinput <- reactive({sapply(logspecificchecks(),paste_other_input)})
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
                paste(types$log))
    
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

  lapply(logspecificchecks(),savingscore, dataframe=otherinputdf(),qacheckSave=qacheckSave,projectID=input$projectID,databasename=databasename,myConn=myConn)

})
  
#---- Calculating score functions----

scoresfunc <- function(listchecks){
  #Assigns a numerical score to each rating
  checkscores <- sapply(listchecks,calculate_score)
  #adds up all scores
  total <- sum(checkscores)
  
  #adds up number of ratings
  numberchecks<-sapply(listchecks,iszero)
  number <- sum(numberchecks)
  
  #calculates average percentage rating
  percentage <- if(number==0){0}
                         else{round(total/number)}
  
  return(percentage)
}

scorecolours<-function(percentage){  
  #score colours
  scorecolour <- if(percentage >= 90) {
    "Background-color: #32cd32;" #Green
  }
  else if (percentage >= 70){
    "Background-color: #ffff00;" #Yellow
  }
  else if (percentage >= 50){
    "Background-color: #ffa500;" #Orange
  }
  else{
    "Background-color: #ff0000;" #Red
  }
  
  return(scorecolour)
}

#Calculation for DG scores 
output$DGscores <- renderValueBox({valueBox(paste(scoresfunc(justDGchecks())," %"),subtitle="Documentation and governance")})

output$DGscorescolours <- renderUI(scorecolour("DGscores",scorecolours(scoresfunc(justDGchecks()))))

#Calculation for SC scores 
output$SCscores <- renderValueBox({valueBox(paste(scoresfunc(justSCchecks())," %"),subtitle="Structure and clarity")})

output$SCscorescolours <- renderUI(scorecolour("SCscores",scorecolours(scoresfunc(justSCchecks()))))

#Calculation for VE scores 
output$VEscores <- renderValueBox({valueBox(paste(scoresfunc(justVEchecks())," %"),subtitle="Verification")})

output$VEscorescolours <- renderUI(scorecolour("VEscores",scorecolours(scoresfunc(justVEchecks()))))

#Calculation for VA scores 
output$VAscores <- renderValueBox({valueBox(paste(scoresfunc(justVAchecks())," %"),subtitle="Validation")})

output$VAscorescolours <- renderUI(scorecolour("VAscores",scorecolours(scoresfunc(justVAchecks()))))

#Calculation for DA scores 
output$DAscores <- renderValueBox({valueBox(paste(scoresfunc(justDAchecks())," %"),subtitle="Data and assumptions")})

output$DAscorescolours <- renderUI(scorecolour("DAscores",scorecolours(scoresfunc(justDAchecks()))))

#---- Displaying more info on checks -----
#The following code provides the extra info when you click on the checks.
#Info is different for each type of log
#The info is read in from comments_'model name'_log.R

#Generating modal for more info on individual check

#modal_check <- function(checkID){
#  showModal(modalDialog(
#    conditionalPanel(condition="input.QAlogtype == 'Modelling'",
#                     uiOutput(paste(checkID,"modelling",sep=""))),
#    
#    conditionalPanel(condition="input.QAlogtype == 'Data Analysis'",
#                     uiOutput(paste(checkID,"dataanalysis",sep=""))),
#    
#    conditionalPanel(condition="input.QAlogtype == 'Dashboard'",
#                     uiOutput(paste(checkID,"dashboard",sep=""))),
#    
#    conditionalPanel(condition="input.QAlogtype == 'Official Statistics'",
#                     uiOutput(paste(checkID,"statistics",sep="")))
#  ))
#}

#observe_info <- function(qacheck){
#  observeEvent(input[[paste0(qacheck,"info")]],{
#    modal_check(qacheck)
#  })
#}
#
#lapply(QAcheckslist,observe_info)

#modal_check <- function(checkID,log){
#  showModal(modalDialog(
#    conditionalPanel(condition=paste0("input.QAlogtype == '",logname(log), "'"),
#                     uiOutput(paste(checkID,log,sep="")))
#  )
#}

#conditional_log <- function(log){
#  if(log=="modelling"){"input.QAlogtype == 'Modelling'"}
#  else if (log=="analysis"){"input.QAlogtype == 'Data Analysis'"}
#  else if (log=="dashboard"){"input.QAlogtype == 'Dashboard'"}
#  else if (log=="statistics"){"input.QAlogtype == 'Official Statistics'"}
#}
#
#create_modal <- function(qacheck,log){
#    showModal(modalDialog(uiOutput(paste(qacheck,log,sep=""))))
#  }
#
#observe_info <- function(qacheck,log){
#  observeEvent(input[[paste0(qacheck,"info",log)]],{
#    create_modal(qacheck, log)
#})}
#
#mapply(observe_info,qacheck=prepare_options$x,log=prepare_options$y)
#
#---- Tooltips-----
#This displays extra tips on ratings when hovering over selection menu
#Tips are different depending on type of log

#prepare_options <- expand.grid(x = QAcheckslist,y=logslist)

#This function decides which tips to display depending on type of log
#tooltipfunc <- function(QAchecks,log){
#  tooltiptext <- eval(parse(text=paste0(QAchecks,"tooltip",log)))
#  return(tooltiptext)
#}

#This function creates the UI necessary to render the tooltips
#tooltip_ui_render <- function(checkid,log){
#    bsTooltip(id=paste0("score",checkid),
#              title=tooltipfunc(checkid,log),
#              trigger="hover",placement="right")
#}

#This applies the above function to every QA check
#output$tooltips <- renderUI(mapply(tooltip_ui_render,checkid=prepare_options$x,log=prepare_options$y))

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
    lapply(logspecificchecks(),reset_checks,session1=session)
    
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
  lapply(logspecificchecks(),reset_checks,session1=session)
  
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
  t(c(input$projectID,"NA","NA","NA","NA","NA","NA")) #BATMAN!
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
sqlinfo <- reactive({sapply(logspecificchecks(),individualChecks,checks=checks())})
sqlinfodf <- reactive({data.frame(sqlinfo())})
allsqlinfodf <- reactive({cbind(t(logrowfinal()),sqlinfodf())[-1,]})

output$writingtest<-renderDataTable(allsqlinfodf())

#now create the same data frame, with info taken from the app
appinfo <- reactive({c(input$projectname, input$version,
                       input$leadanalyst, input$analyticalassurer, input$BCM,
                       types$log)})
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
  sqlinfo <- reactive({sapply(logspecificchecks(),individualChecks,checks=checks())})
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
