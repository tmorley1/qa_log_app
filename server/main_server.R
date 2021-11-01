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

#Reading in weightings as one entry
weightings_save <- reactive({paste(weightings$DG,weightings$SC,weightings$VE,weightings$VA,weightings$DA)})

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
                paste(types$log),
                paste(weightings_save()))
    
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
                          "', weighting = '", weightings_save(),
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

#---- Pillar weighting----
observeEvent(input$weighting,{
  showModal(modalDialog(
    renderUI({
      fixedRow(column(2,
          numericInput("DGweight",label="Documentation and Governance",value=as.numeric(weightings$DG), min=0, max=1, step=0.1),
          numericInput("SCweight",label="Structure and Clarity",value=as.numeric(weightings$SC), min=0, max=1, step=0.1),
          numericInput("VEweight",label="Verification",value=as.numeric(weightings$VE), min=0, max=1, step=0.1),
          numericInput("VAweight",label="Validation",value=as.numeric(weightings$VA), min=0, max=1, step=0.1),
          numericInput("DAweight",label="Data and Assumptions",value=as.numeric(weightings$DA), min=0, max=1, step=0.1),
          actionButton("submitWeighting","Submit")
      ),
     column(6,
          uiOutput("weights")
      ))
    })
  ))
})

weighttotal <- reactive({as.numeric(input$DGweight) + as.numeric(input$SCweight) + as.numeric(input$VEweight)  + as.numeric(input$VAweight) + as.numeric(input$DAweight)
})

weightingerror <- reactive({if (length(weighttotal())==0){""}
  else if(weighttotal()== 1){""}
   else {"Pillar weighting must add up to 1"}})

output$weights <- renderValueBox({valueBox(paste(weightingerror()),subtitle="")})

observeEvent(input$submitWeighting,{
             weightings$DG <- input$DGweight
             weightings$SC <- input$SCweight
             weightings$VE <- input$VEweight
             weightings$VA <- input$VAweight
             weightings$DA <- input$DAweight
             removeModal()}
             )
#---- Calculating total log score----
#Calculate total percentage, taking weightings into account
totalscore <- reactive({(as.numeric(scoresfunc(justDGchecks()))*as.numeric(weightings$DG))+(as.numeric(scoresfunc(justSCchecks()))*as.numeric(weightings$SC))+(as.numeric(scoresfunc(justVEchecks()))*as.numeric(weightings$VE))+(as.numeric(scoresfunc(justVAchecks()))*as.numeric(weightings$VA))+(as.numeric(scoresfunc(justDAchecks()))*as.numeric(weightings$DA))})
#Display total score in value Box
output$totalscores <- renderValueBox({valueBox(paste(totalscore()," %"),subtitle="Overall QA score")})
#Colour value box depending on score
output$totalscorescolours <- renderUI(scorecolour("totalscores",scorecolours(totalscore())))

#---- Displaying more info on checks -----
#The following code provides the extra info when you click on the checks.
#Info is different for each type of log
#The info is read in from comments_'log name'_log.R

observe_info <- function(qacheck,types){
  observeEvent(input[[paste0(qacheck,"info")]],{
      showModal(modalDialog(
      eval(parse(text=paste(qacheck,types$log,sep="")))
    ))
  })
}

lapply(QAcheckslist,observe_info,types=types)

#---- Tooltips-----
#This displays extra tips on ratings when hovering over selection menu
#Tips are different depending on type of log

#This function creates the UI necessary to render the tooltips
tooltip_ui_render <- function(checkid,types){
    bsTooltip(id=paste0("score",checkid),
              title=eval(parse(text=paste0(checkid,"tooltip",types$log))),
              trigger="hover",placement="right")
}

#This applies the above function to every QA check
output$tooltips <- renderUI(lapply(QAcheckslist,tooltip_ui_render,types=types))

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
  data.frame(column1=c("NA","NA","NA","NA","NA","NA","NA"),
               column2=c("NA","NA","NA","NA","NA","NA","NA"))
} else{data.frame(column1=c("NA",logrow()[1,2],"NA","NA","NA","NA","NA"),
                  column2=t(logrow()[- 1]))}})

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
allsqlinfodf <- reactive({cbind(logrowfinal(),sqlinfodf())[-1,]})

output$writingtest<-renderDataTable(allsqlinfodf())

#now create the same data frame, with info taken from the app
appinfo <- reactive({data.frame(column1=c(input$projectname,"NA","NA","NA","NA","NA"),
                                column2=c(input$version,
                       input$leadanalyst, input$analyticalassurer, input$BCM,
                       types$log, weightings_save()))})
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
  #now run the query to get our output
  logrow <- reactive({sqlQuery(myConn, selectlogrow())})
  #No need for if statement because Project ID will now definitely exist
  logrowfinal <- reactive({data.frame(column1=c("NA",logrow()[1,2],"NA","NA","NA","NA","NA"),
                    column2=t(logrow()[- 1]))})
  #select correct rows from QA_checks SQL
  selectchecks <- reactive({paste("SELECT * FROM ", databasename, ".[dbo].[QA_checks] WHERE ProjectID = ", currentid(), sep="")})
  #now run the query to get our output.
  checks <- reactive({sqlQuery(myConn, selectchecks())})
  #build a dataframe with all current SQL data
  sqlinfo <- reactive({sapply(logspecificchecks(),individualChecks,checks=checks())})
  sqlinfodf <- reactive({data.frame(sqlinfo())})
  allsqlinfodf <- reactive({cbind(logrowfinal(),sqlinfodf())[-1,]})
  
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
