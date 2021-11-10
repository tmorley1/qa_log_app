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
#paste_score_input <- function(checkname){
#  eval(parse(text=paste0("input$score",checkname)))
#}
#Applying above function to all checks
#scoreinput <- reactive({sapply(logspecificchecks(),paste_score_input)})
#Writing all checks as numbers 1-7
#writing_score <- reactive({sapply(scoreinput(), write_score)})

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
  time <- paste(Sys.time())
  chosennumber <- input$projectID
  
  #read in current sql data
  selectrow <- paste("SELECT * FROM ", databasename, ".[dbo].[QA_log] WHERE ProjectID = ", chosennumber, sep="")
  
  #now run the query to get our output.
  selectrow <- sqlQuery(myConn, selectrow)%>%replace(.,is.na(.),"")
  
  #create new row with app data
  newRow <- c(input$projectID,paste(input$projectname),
              paste(input$version),
              paste(input$leadanalyst),
              paste(input$analyticalassurer),
              paste(input$BCM),
              paste(types$log),
              paste(weightings_save()))

  if(nrow(selectrow)==0) {#if project ID does not already exist, create new entry
    newRowQuery <- paste("INSERT INTO", databasename,".dbo.QA_log VALUES ();")
    
    newRowSQL <- InsertListInQuery(newRowQuery, newRow)
    
    newRowSet <- sqlQuery(myConn,newRowSQL)
    
    #Add an empty row to SCD database to log when this was created
    emptyRow <- c(input$projectID,"","","","","","","",time)
    
    newRowQuerySCD <- paste("INSERT INTO", databasename,".dbo.QA_log_SCD VALUES ();")
    
    newRowSQLSCD <- InsertListInQuery(newRowQuerySCD, emptyRow)
    
    newRowSetSCD <- sqlQuery(myConn,newRowSQLSCD)

  }#if project ID does exist, then check if app row is equal to sql row
  else{
    comparerows <- selectrow == newRow
    if(FALSE %in% comparerows){#rows are not the same
    #we need to add a new row to SCD and then update current SQL
    
    #adding row to SCD
    lognew_row_SCD <- c(selectrow,paste(time))
    
    lognewRowQuerySCD <- paste("INSERT INTO", databasename, ".dbo.QA_log_SCD VALUES ();")
    
    lognewRowSQLSCD <- InsertListInQuery(lognewRowQuerySCD,lognew_row_SCD)
    
    lognewRowSetSCD <- sqlQuery(myConn,lognewRowSQLSCD)
    
    #updating row in QA_log
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
    else{#row has not been updated so we don't need to do anything
    }
  }
  
  #now we edit QA_checks SQL database
  qacheckSave <- paste("SELECT * FROM ", databasename, ".[dbo].[QA_checks] WHERE ProjectID = ", chosennumber, sep="")
  
  #now run the query to get our output.
  qacheckSave <- sqlQuery(myConn, qacheckSave)%>%replace(.,is.na(.),"")

  #Saving scores

  lapply(logspecificchecks(),savingscore, dataframe=otherinputdf(),qacheckSave=qacheckSave,projectID=input$projectID,databasename=databasename,myConn=myConn,time=time)

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

#---- Error messages----

#Display error message if mandatory checks are marked TO BE CHECKED

check_mandatory <- function(checkID,types,names_df){
  score <-input[[paste0("score",checkID)]]
  check_row <- names_df%>%filter(QAcheckslist==checkID)
  mandatory <- (check_row%>%select(paste0(types$log,"_mandatory")))[1,1]
  to_return <- if(mandatory==1 && score=="TO BE CHECKED"){1}
               else {0}
  return(to_return)
}

listofmandatory <- reactive({sapply(logspecificchecks(),check_mandatory,types=types,names_df=names_df)})

numberchecks <- reactive({sum(listofmandatory())})

mandatory_error <- reactive({
  #if both lists are the same, no error message
  if (numberchecks()==0){""}
  #otherwise, print error message
  else {paste0("There are ",numberchecks()," mandatory checks marked 'TO BE CHECKED'.")}})

output$mandatory_dialogue <- renderValueBox({valueBox(value=tags$p(mandatory_error(),style="font-size: 75%"),subtitle="")})

#Display error message if mandatory checks are marked NA

check_NA_mandatory <- function(checkID,types,names_df){
  score <-input[[paste0("score",checkID)]]
  check_row <- names_df%>%filter(QAcheckslist==checkID)
  mandatory <- (check_row%>%select(paste0(types$log,"_mandatory")))[1,1]
  to_return <- if(mandatory==1 && score=="N/A"){1}
  else {0}
  return(to_return)
}

listofmandatoryNA <- reactive({sapply(logspecificchecks(),check_NA_mandatory,types=types,names_df=names_df)})

numberchecksNA <- reactive({sum(listofmandatoryNA())})

mandatory_error_NA <- reactive({
  #if both lists are the same, no error message
  if (numberchecksNA()==0){""}
  #otherwise, print error message
  else {paste0("There are ",numberchecksNA()," mandatory checks marked 'N/A'.")}})

output$mandatory_dialogueNA <- renderValueBox({valueBox(value=tags$p(mandatory_error_NA(),style="font-size: 75%"),subtitle="")})

#Display error message if checks are marked "5) Significant issues"

check_significant <- function(checkID,types,names_df){
  score <-input[[paste0("score",checkID)]]
  to_return <- if(score=="5) Significant issues"){1}
  else {0}
  return(to_return)
}

listofsignificant <- reactive({sapply(logspecificchecks(),check_significant,types=types,names_df=names_df)})

numbercheckssignificant <- reactive({sum(listofsignificant())})

significant_error <- reactive({
  #if both lists are the same, no error message
  if (numbercheckssignificant()==0){""}
  #otherwise, print error message
  else {paste0("There are ",numbercheckssignificant()," checks marked 'Significant issues'.")}})

output$significant_dialogue <- renderValueBox({valueBox(value=tags$p(significant_error(),style="font-size: 75%"), subtitle="")})

#---- Back to home-----
observeEvent(input$backtohome,{
  if(savetext()=="You have unsaved changes!"){
    showModal(modalDialog(
    "Are you sure you want to go back? Your work will not be saved!",
    br(), br(),
    actionButton("definitelygoback","I'm sure")))
  }
  else {
    #switch tabs
    updateTabsetPanel(session, "inTabset", selected="panel1")
    #reset all checks
    #resetting data at top of log
    updateTextInput(session, inputId = "projectname", value = "")
    updateTextInput(session, inputId = "version", value = "")
    updateTextInput(session, inputId = "leadanalyst", value = "")
    updateTextInput(session, inputId = "analyticalassurer", value = "")
    updateSelectizeInput(session, inputId = "BCM", selected = "No")
    updateTextInput(session, inputId = "QAlogtype", value = "")
    weightings$DG <- 0.2
    weightings$SC <- 0.2
    weightings$VE <- 0.2
    weightings$VA <- 0.2
    weightings$DA <- 0.2
    #resetting documentation and governance checks
    lapply(logspecificchecks(),reset_checks,session1=session)
    
    #reset home screen
    types$log <- "blank"
    unsure$log <- "blank"
    nexttab$log <- "blank"
  }
})

observeEvent(input$definitelygoback,{
  #switch tabs
  updateTabsetPanel(session, "inTabset", selected="panel1")
  removeModal()
  
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
allsqlinfodf2 <- reactive(allsqlinfodf()%>%replace(.,is.na(.),""))

output$writingtest<-renderDataTable(allsqlinfodf())

#now create the same data frame, with info taken from the app
appinfo <- reactive({data.frame(column1=c(input$projectname,"NA","NA","NA","NA","NA"),
                                column2=c(input$version,
                       input$leadanalyst, input$analyticalassurer, input$BCM,
                       types$log, weightings_save()))})
appinfodf <- reactive({data.frame(cbind(appinfo(),otherinput()))})

output$writingtest2<-renderDataTable(appinfodf())

#we now compare the lists
comparison <- reactive({appinfodf()==allsqlinfodf2()})
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
  allsqlinfodf2 <- reactive(allsqlinfodf()%>%replace(.,is.na(.),""))
  
  output$writingtest<-renderDataTable(allsqlinfodf())
  
  #re-compare the lists
  comparison <- reactive({appinfodf()==allsqlinfodf2()})
  #display warning message if there are unsaved changes
  savetext <- reactive({if ("FALSE" %in% comparison() == "FALSE"){""}
    else {"You have unsaved changes!"}})
  output$savedialogue <- renderText(paste(savetext()))
})
#---- Reading in old versions ----

reading_dates <- reactive({
  #Read in all relevant dates from both SCD databases
  chosennumber <- input$projectID

  #selecting date from QA_log_SCD
  selectdatelog <- paste("SELECT EndDate FROM ", databasename, ".[dbo].[QA_log_SCD] WHERE ProjectID = ", chosennumber, sep="")
  #selecting date from QA_checks_SCD
  selectdatechecks <- paste("SELECT EndDate FROM ", databasename, ".[dbo].[QA_checks_SCD] WHERE ProjectID = ", chosennumber, sep="")
  #now run the query to get our output.
  selectdatelog <- sqlQuery(myConn, selectdatelog)
  selectdatechecks <- sqlQuery(myConn, selectdatechecks)

  #Only look at unique dates, and read is as date-time
  EndDate <- if(nrow(selectdatechecks)==0){unique(c(selectdatelog$EndDate))}
  else {unique(c(selectdatechecks$EndDate, selectdatelog$EndDate))}

  #arrange in order, with most recent at top
  alldatesdf <- as.data.frame(EndDate)%>%arrange(desc(EndDate))

  #reading in version numbers
  forversions <- paste("SELECT * FROM ", databasename, ".[dbo].[QA_log_SCD] WHERE ProjectID = ", chosennumber, sep="")
  forversions <- sqlQuery(myConn, forversions)
  #create dataframe of version number and dates
  forversionsdf <- as.data.frame(forversions)%>%select(vers,EndDate)
  #join dataframes together
  datesdf <- full_join(alldatesdf,forversionsdf)
  #Push version numbers in line with date they were created (rather than date discarded)
  #swap round days and months because for some reason SQL puts them the wrong way round
  datesdf <- datesdf%>%mutate(vers=lag(vers))%>%mutate(EndDate=paste(EndDate))%>%
    mutate(EndDate=as.POSIXct(EndDate, format="%Y-%d-%m %H:%M:%S"))%>%
    mutate(EndDate=paste(EndDate))%>%
    rename(Version=vers,Date=EndDate)
  #remove first row (as this is current version)
  datesdf <- datesdf[-1,]

  return(datesdf)})
output$datesdfoutput <- DT::renderDataTable(reading_dates(), server=FALSE, selection='single')

select_old_check <- function(checkid,dateselect, chosennumber){
  selectolddate <- paste("SELECT * FROM ", databasename, ".[dbo].[QA_checks_SCD] WHERE ProjectID = ", chosennumber, " and checkID = '", checkid, "' and EndDate > '", dateselect, "'", sep="") 
  selectolddate <- sqlQuery(myConn, selectolddate)%>%replace(.,is.na(.),"")
  return(selectolddate)
}

#this function will create each individual row for checks in the preview pane  

displayingoldchecks <- function(checkid,dateselect,chosennumber,types,names_df){
  #This is reading in from SCD table
  checkSCD <- select_old_check(checkid,dateselect,chosennumber)
  
  selectcurrentdate <- paste("SELECT * FROM ", databasename, ".[dbo].[QA_checks] WHERE ProjectID = ", chosennumber, " and checkID = '", checkid, "'", sep="") 
  selectcurrentdate <- sqlQuery(myConn, selectcurrentdate)%>%replace(.,is.na(.),"")
  
  #if checkSCD is empty, then look at current table
  if (nrow(checkSCD)==0 && nrow(selectcurrentdate)==0) {
    oldcheckrow <- c(chosennumber,checkid,7,"","","","")
  }
  else if (nrow(checkSCD)==0 && nrow(selectcurrentdate)!=0) {#current data is still relevant at current date
    oldcheckrow <- selectcurrentdate
  }
  else { #if checkSCD is not empty, select first row
    oldcheckrow <- checkSCD%>%top_n(EndDate,n=-1)%>%select(-EndDate)
  }
  #now old check row contains all information about the relevant check
  #so we now update all relevant text outputs for this check
  
  #first off, read in names of checks
  check_row <- names_df%>%filter(QAcheckslist==checkid)
  checkname <- (check_row%>%select(paste0(types$log,"_names")))[1,1]
  
  #next, convert checkscore to words
  checkscore <-readingOutput(oldcheckrow[3])
  assessor <- oldcheckrow[4]
  summary <- oldcheckrow[5]
  obs <- oldcheckrow[6]
  out <- oldcheckrow[7]
  
  #create preview ui
  uihistory <- fixedRow(
    column(2, paste(checkname)),
    column(2, paste(checkscore)),
    column(2, paste(assessor)),
    column(2, paste(summary)),
    column(2, paste(obs)),
    column(2, paste(out))
  )
  
  return(uihistory)
  
}

previous_list <- reactiveValues(log = "blank")

observeEvent(input$previous, {
  if(previous_list$log=="blank"){
  #Modal displays all dates of recent saves, and upon selecting one, there is an option to preview
  showModal(modalDialog(
    renderUI({
      fixedRow(column(8,
                      DT::dataTableOutput('datesdfoutput'),
                      actionButton("preview","Preview")))
    })
  ))}
  else{showModal(modalDialog(
    renderUI({
      fixedRow(column(8,
                      "Something has gone wrong."))
    })
  ))}
})

observeEvent(input$preview, {
  previous_list$log<-"preview"
  chosennumber <- input$projectID
  #dateselect is the selected date of the preview
  projectnumber <- input$datesdfoutput_rows_selected
  dateselect <- reading_dates()[projectnumber,1]
  
  #apply above function to all checks
  output$DGhistory <- renderUI(lapply(justDGchecks(),displayingoldchecks,dateselect=dateselect,chosennumber=chosennumber,types=types,names_df=names_df))
  outputOptions(output, "DGhistory", suspendWhenHidden=FALSE)

  output$SChistory <- renderUI(lapply(justSCchecks(),displayingoldchecks,dateselect=dateselect,chosennumber=chosennumber,types=types,names_df=names_df))
  outputOptions(output, "SChistory", suspendWhenHidden=FALSE)

  output$VEhistory <- renderUI(lapply(justVEchecks(),displayingoldchecks,dateselect=dateselect,chosennumber=chosennumber,types=types,names_df=names_df))
  outputOptions(output, "VEhistory", suspendWhenHidden=FALSE)

  output$VAhistory <- renderUI(lapply(justVAchecks(),displayingoldchecks,dateselect=dateselect,chosennumber=chosennumber,types=types,names_df=names_df))
  outputOptions(output, "VAhistory", suspendWhenHidden=FALSE)

  output$DAhistory <- renderUI(lapply(justDAchecks(),displayingoldchecks,dateselect=dateselect,chosennumber=chosennumber,types=types,names_df=names_df))
  outputOptions(output, "DAhistory", suspendWhenHidden=FALSE)
  
  #this is the ui for the preview pane
  removeModal()
  
  showModal(modalDialog(
    renderUI({
        #----DG checks----
        fixedRow(
          column(12,
                 h2("Documentation and Governance")), br(),
          column(2, h5("QA area")),
          column(2, h5("Rating")),
          column(2, h5("Assessed by")),
          column(2, h5("Summary...")),
          column(2, h5("Observations")),
          column(2, h5("Outstanding (potential) work")), br(),
        uiOutput("DGhistory"),br(),
        #----SC checks-----
          column(12,
                 h2("Structure and Clarity")), br(),
          column(2, h5("QA area")),
          column(2, h5("Rating")),
          column(2, h5("Assessed by")),
          column(2, h5("Summary...")),
          column(2, h5("Observations")),
          column(2, h5("Outstanding (potential) work")), br(),
        uiOutput("SChistory"),br(),
        #----VE Checks----
          column(12,
                 h2("Verification")), br(),
          column(2, h5("QA area")),
          column(2, h5("Rating")),
          column(2, h5("Assessed by")),
          column(2, h5("Summary...")),
          column(2, h5("Observations")),
          column(2, h5("Outstanding (potential) work")), br(),
        uiOutput("VEhistory"), br(),
        #----VA checks-----
          column(12,
                 h2("Validation")), br(),
          column(2, h5("QA area")),
          column(2, h5("Rating")),
          column(2, h5("Assessed by")),
          column(2, h5("Summary...")),
          column(2, h5("Observations")),
          column(2, h5("Outstanding (potential) work")), br(),
        uiOutput("VAhistory"), br(),
        #----DA checks----
          column(12,
                 h2("Data and assumptions")), br(),
          column(2, h5("QA area")),
          column(2, h5("Rating")),
          column(2, h5("Assessed by")),
          column(2, h5("Summary...")),
          column(2, h5("Observations")),
          column(2, h5("Outstanding (potential) work")), br(),
        uiOutput("DAhistory"), br(),
        column(4, actionButton("restore", "Restore this version")),
        column(2, actionButton("backpreview", "Back")))
      })
    ))
  })

observeEvent(input$backpreview,{
  removeModal()
  previous_list$log<-"blank"
})