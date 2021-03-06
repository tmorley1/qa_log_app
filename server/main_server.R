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
  time <- format(Sys.time(), "%Y-%d-%m %X")
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
    lognew_row_SCD <- c(selectrow,time)
    
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
  
  lapply(logspecificchecks(),savingeditedlinks,time=time)
  
  lapply(logspecificchecks(),savingnewlinks,time=time)

})
  
#---- Calculating scores----

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

lapply(QAcheckslist,observe_info,types=types)

#This displays extra tips on ratings when hovering over selection menu
#Tips are different depending on type of log

#This applies the above function to every QA check
output$tooltips <- renderUI(lapply(QAcheckslist,tooltip_ui_render,types=types))

#---- Displaying and adding links -----

 #Read in function to create modals for each check
lapply(QAcheckslist,observe_links)

# #Read in function to create modals for adding new link
 lapply(QAcheckslist,observe_addlinks)
 
 #Read in function to save new links
 lapply(QAcheckslist,observe_savelinks)

#Read in function to create modals for editing new link
lapply(QAcheckslist,observe_editlinks)

#Read in function to save edited links
lapply(QAcheckslist,observe_saveeditlinks)

#---- Error messages----

#Display error message if mandatory checks are marked TO BE CHECKED

listofmandatory <- reactive({sapply(logspecificchecks(),check_mandatory,types=types,names_df=names_df)})

numberchecks <- reactive({sum(listofmandatory())})

mandatory_error <- reactive({
  #if both lists are the same, no error message
  if (numberchecks()==0){""}
  #otherwise, print error message
  else {paste0("There are ",numberchecks()," mandatory checks marked 'TO BE CHECKED'.")}})

output$mandatory_dialogue <- renderValueBox({valueBox(value=tags$p(mandatory_error(),style="font-size: 75%"),subtitle="")})

#Display error message if mandatory checks are marked NA

listofmandatoryNA <- reactive({sapply(logspecificchecks(),check_NA_mandatory,types=types,names_df=names_df)})

numberchecksNA <- reactive({sum(listofmandatoryNA())})

mandatory_error_NA <- reactive({
  #if both lists are the same, no error message
  if (numberchecksNA()==0){""}
  #otherwise, print error message
  else {paste0("There are ",numberchecksNA()," mandatory checks marked 'N/A'.")}})

output$mandatory_dialogueNA <- renderValueBox({valueBox(value=tags$p(mandatory_error_NA(),style="font-size: 75%"),subtitle="")})

#Display error message if checks are marked "5) Significant issues"

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

#we now compare the lists
comparison <- reactive({appinfodf()==allsqlinfodf2()})

#for hyperlinks, we have the app database already - this is links$log
#and what is saved in sql is sqllinks$log

comparison_link <- reactive({links$log == sqllinks$log})

output$writingtest2<-renderDataTable(comparison_link())

#display warning message if there are unsaved changes
savetext <- reactive({
    #if both lists are the same, no error message
    if ("FALSE" %in% comparison() == "FALSE" && "FALSE" %in% comparison_link() == "FALSE"){""}
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
  #We still need if statement because a new project could be created by clicking
  #back and then creating a new project
  logrowfinal <- reactive({if(nrow(logrow())==0){
    data.frame(column1=c("NA","NA","NA","NA","NA","NA","NA"),
               column2=c("NA","NA","NA","NA","NA","NA","NA"))
  } else{data.frame(column1=c("NA",logrow()[1,2],"NA","NA","NA","NA","NA"),
                    column2=t(logrow()[- 1]))}})
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
  
  #UPDATE LINKS DATABASE
  selectlinks <- paste("SELECT * FROM ", databasename, ".[dbo].[QA_hyperlinks] WHERE ProjectID = ", currentid(), sep="")
  #read from sql
  selectlinks <- sqlQuery(myConn, selectlinks)%>%replace(.,is.na(.),"")
  
  links$log <- if(nrow(selectlinks)==0){data.frame(projectID="",checkID="",Link="",DisplayText="",LinkID="")}
  else{selectlinks}
  
  sqllinks$log <- if(nrow(selectlinks)==0){data.frame(projectID="",checkID="",Link="",DisplayText="",LinkID="")}
  else{selectlinks}
  
  #re-compare the lists
  comparison <- reactive({appinfodf()==allsqlinfodf2()})
  
  comparison_link <- reactive({links$log == sqllinks$log})
  
  output$writingtest2<-renderDataTable(comparison_link())
  
  #display warning message if there are unsaved changes
  savetext <- reactive({if ("FALSE" %in% comparison() == "FALSE" && "FALSE" %in% comparison_link() == "FALSE"){""}
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
  #selecting data from QA_hyperlinks_SCD
  selectdatelinks <- paste("SELECT EndDate FROM ", databasename, ".[dbo].[QA_hyperlinks_SCD] WHERE ProjectID = ", chosennumber, sep="")
  #now run the query to get our output.
  selectdatelog <- sqlQuery(myConn, selectdatelog)
  selectdatechecks <- sqlQuery(myConn, selectdatechecks)
  selectdatelinks <- sqlQuery(myConn, selectdatelinks)

  #Only look at unique dates, and read in as date-time
  EndDate <- unique(c(selectdatechecks$EndDate, selectdatelog$EndDate, selectdatelinks$EndDate))

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
     rename(Version=vers,Date=EndDate)
   #remove first row (as this is current version)
   datesdf <- datesdf[-1,]

  return(datesdf)})
output$datesdfoutput <- DT::renderDataTable(reading_dates(), server=FALSE, selection='single')

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
                      "Something has gone wrong."))#Hopefully we never see this message!
    })
  ))}
})

date_list <- reactiveValues(log = "blank")

observeEvent(input$preview, {
  previous_list$log<-"preview"
  chosennumber <- input$projectID
  #dateselect is the selected date of the preview
  projectnumber <- input$datesdfoutput_rows_selected
  dateselect <- reading_dates()[projectnumber,1]
  
  #To search in SQL, we need to swap around days and months
  dateselect <- paste(format(as.POSIXct(dateselect),"%Y-%d-%m %H:%M:%S"))
  
  date_list$log <- dateselect

  output$QAloghistory <- renderUI(displayingoldlog(dateselect,chosennumber))

  #generating display for each individual check
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

  #calculating overall check score for each pillar
  DGscorehistory <- mapply(checkscorehistory,justDGchecks(),dateselect=dateselect,chosennumber=chosennumber)
  DGzerohistory <- mapply(zeroscorehistory, justDGchecks(), dateselect=dateselect,chosennumber=chosennumber)
  DGpercenthistory <- if(sum(DGzerohistory)==0){0} else{round(sum(DGscorehistory)/sum(DGzerohistory))}

  SCscorehistory <- mapply(checkscorehistory,justSCchecks(),dateselect=dateselect,chosennumber=chosennumber)
  SCzerohistory <- mapply(zeroscorehistory, justSCchecks(), dateselect=dateselect,chosennumber=chosennumber)
  SCpercenthistory <- if(sum(SCzerohistory)==0){0} else{round(sum(SCscorehistory)/sum(SCzerohistory))}

  VEscorehistory <- mapply(checkscorehistory,justVEchecks(),dateselect=dateselect,chosennumber=chosennumber)
  VEzerohistory <- mapply(zeroscorehistory, justVEchecks(), dateselect=dateselect,chosennumber=chosennumber)
  VEpercenthistory <- if(sum(VEzerohistory)==0){0} else{round(sum(VEscorehistory)/sum(VEzerohistory))}

  VAscorehistory <- mapply(checkscorehistory,justVAchecks(),dateselect=dateselect,chosennumber=chosennumber)
  VAzerohistory <- mapply(zeroscorehistory, justVAchecks(), dateselect=dateselect,chosennumber=chosennumber)
  VApercenthistory <- if(sum(VAzerohistory)==0){0} else{round(sum(VAscorehistory)/sum(VAzerohistory))}

  DAscorehistory <- mapply(checkscorehistory,justDAchecks(),dateselect=dateselect,chosennumber=chosennumber)
  DAzerohistory <- mapply(zeroscorehistory, justDAchecks(), dateselect=dateselect,chosennumber=chosennumber)
  DApercenthistory <- if(sum(DAzerohistory)==0){0} else{round(sum(DAscorehistory)/sum(DAzerohistory))}

  #Reading in weightings and calculating overall QA log score
   weightings_separate <- weightings_old(dateselect,chosennumber)

   DGweightingshistory <- weightings_separate[[1]][1]
   SCweightingshistory <- weightings_separate[[1]][2]
   VEweightingshistory <- weightings_separate[[1]][3]
   VAweightingshistory <- weightings_separate[[1]][4]
   DAweightingshistory <- weightings_separate[[1]][5]

   totalQAhistory <- as.numeric(DGweightingshistory)*DGpercenthistory + as.numeric(SCweightingshistory)*SCpercenthistory + as.numeric(VEweightingshistory)*VEpercenthistory + as.numeric(VAweightingshistory)*VApercenthistory + as.numeric(DAweightingshistory)*DApercenthistory

  removeModal()

  #this is the ui for the preview pane
  showModal(modalDialog(
    renderUI({
        fixedRow(
          column(2, h5("Project name")),
          column(2, h5("Version")),
          column(2, h5("Lead Analyst")),
          column(2, h5("Analytical Assurer")),
          column(2, h5("Business Critical")),
          column(2, "", br(), "", br(), "", br(), ""), br(),
        uiOutput("QAloghistory"), br(),hr(),
        #----Score summary---
        column(2, h5("DG")),
        column(2, h5("SC")),
        column(2, h5("Ve")),
        column(2, h5("Va")),
        column(2, h5("DA")),
        column(2, h5("Overall score")), br(),
        column(2, HTML(paste0("<span style=\"",scorecolours(DGpercenthistory),"\">",DGpercenthistory, "% </span>"))),
        column(2, HTML(paste0("<span style=\"",scorecolours(SCpercenthistory),"\">",SCpercenthistory, "% </span>"))),
        column(2, HTML(paste0("<span style=\"",scorecolours(VEpercenthistory),"\">",VEpercenthistory, "% </span>"))),
        column(2, HTML(paste0("<span style=\"",scorecolours(VApercenthistory),"\">",VApercenthistory, "% </span>"))),
        column(2, HTML(paste0("<span style=\"",scorecolours(DApercenthistory),"\">",DApercenthistory, "% </span>"))),
        column(2, HTML(paste0("<span style=\"",scorecolours(DApercenthistory),"\">",totalQAhistory, "% </span>"))), br(),hr(),
        #----DG checks----
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
      }),
    footer=NULL))
  })

observeEvent(input$backpreview,{
  removeModal()
  previous_list$log<-"blank"
  date_list$log <- "blank"
})

observeEvent(input$restore,{
  removeModal()
  chosennumber <- input$projectID
  dateselect <- date_list$log
  restore_log(session,dateselect,chosennumber)
  lapply(logspecificchecks(),restore_checks,session = session,dateselect=dateselect,chosennumber=chosennumber)
  lapply(logspecificchecks(),read_links,session=session,dateselect=dateselect,chosennumber=chosennumber)
  previous_list$log<-"blank"
  date_list$log <-"blank"
})