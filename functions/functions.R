#------Functions for generating log-------------
#create_log is called when button to create new log is pressed
#Generates project ID and fills in relevant text boxes to display log type
create_log <- function(log_type,log_type_name,session1,types1,nexttab1){
  types1$log <- log_type
  nexttab1$log <- "next"
  #we generate a random 4 digit number for the project ID
  newID <- floor(runif(1, 1000, 9999))
  #we need to test to check that the number generated is not already being used
  #select relevant row from SQL database
  checkselect <- paste("SELECT * FROM ", databasename, ".[dbo].[QA_log] WHERE ProjectID = ", newID, sep="")
  checkselect <- sqlQuery(myConn, checkselect)
  if(nrow(checkselect)==0){
    updateTextInput(session1,inputId = "projectID", value = newID)
    updateTextInput(session1,inputId = "QAlogtype", value =  log_type_name)
    updateTabsetPanel(session1, "inTabset", selected="panel2")}
  #if the ID isn't being used, the project ID gets updated and the log is displayed.
  #if the ID is being used, nothing happens and the user has to click on the button again
}

#Observing what type of new log is to be created, and then calling create_log
observe_logtype <- function(log,session,types,nexttab){
  observeEvent(input[[paste0(log)]],{
    create_log(log,logname(log),session,types,nexttab)
  })
}

create_actionbutton<-function(log){
  actionButton(log,label=logname(log))
}

#--- Functions for reading in from SQL ----

#Selected rating based on number
readingOutput <- function(number){if(number==1){"1) Excellent"}
  else if(number==2){"2) Good"}
  else if(number==3){"3) Some issues"}
  else if(number==4){"4) Needs improvement"}
  else if(number==5){"5) Significant issues"}
  else if(number==6){"N/A"}
  else {"TO BE CHECKED"}}

#Updating checks
#'number' is the relevant column number within SQL database
update_checks <- function(checkID1, session1, qachecks){
  specificrow <- qachecks[qachecks$checkID %in% c(checkID1),]
  
  if(nrow(specificrow)==0) {
    updateSelectizeInput(session1, inputId = paste("score", checkID1,sep=""), selected="TO BE CHECKED")
  }
  else{
  checkoutput <- readingOutput(specificrow[1,3])
  updateSelectizeInput(session1, inputId = paste("score",checkID1,sep=""), selected = checkoutput)
  updateTextInput(session1, inputId = paste("assess", checkID1,sep=""), value=paste(specificrow[1,4]))
  updateTextInput(session1, inputId = paste("summary", checkID1,sep=""), value=paste(specificrow[1,5]))
  updateTextInput(session1, inputId = paste("obs", checkID1,sep=""), value=paste(specificrow[1,6]))
  updateTextInput(session1, inputId = paste("out", checkID1,sep=""), value=paste(specificrow[1,7]))
}}

#Reset checks
reset_checks <- function(checkID1,session1){
  updateSelectizeInput(session1, inputId = paste("score",checkID1,sep=""), selected = "TO BE CHECKED")
  updateTextInput(session1, inputId = paste("assess", checkID1,sep=""), value="")
  updateTextInput(session1, inputId = paste("summary", checkID1,sep=""), value="")
  updateTextInput(session1, inputId = paste("obs", checkID1,sep=""), value="")
  updateTextInput(session1, inputId = paste("out", checkID1,sep=""), value="")
}

#---- Functions for saving to SQL----

#function to insert list in SQL query
InsertListInQuery <- function(querySentence, InList) {
  InValues <- ""
  for (i in 1:length(InList)){
    if (i < length(InList)) {
      InValues <- paste(InValues,"'",InList[[i]],"', ",sep="")}
    else {
      InValues <- paste(InValues,"'",InList[[i]],"'",sep="")
    }
    
  }
  LocOpenParenthesis <- gregexpr('[(]', querySentence)[[1]][[1]]
  LocCloseParenthesis <- gregexpr('[)]', querySentence)[[1]][[1]]
  if (LocCloseParenthesis-LocOpenParenthesis==1) {
    querySentence<- gsub("[(]", paste("(",InValues,sep = ""), querySentence)
  }
  return (querySentence )
}

#writing score as an integer for SQL table
write_score <- function(inputscore){
  if(inputscore == "1) Excellent")
    return('1')
  else if(inputscore == "2) Good")
    return('2')
  else if(inputscore == "3) Some issues")
    return('3')
  else if (inputscore == "4) Needs improvement")
    return('4')
  else if (inputscore == "5) Significant issues")
    return('5')
  else if (inputscore == "N/A")
    return('6')
  else{
    return('7')}
}

#Function for saving to QA_checks SQL DB
savingscore <- function(scoreID, dataframe,qacheckSave,projectID,databasename,myConn,time){
  #select correct column of dataframe
  correct_column <- dataframe %>% select(scoreID)
  #Assign checkscore, assessor, evidence, obs, out
  checkscore <- correct_column[2,1]
  assessor <- correct_column[3,1]
  evidence <- correct_column[4,1]
  obs <- correct_column[5,1]
  out <- correct_column[6,1]
  #Write correct column as row that matches SQL output
  correct_row <- c(projectID,scoreID,checkscore,assessor,evidence,obs,out)
  
  #selects specific row with matching projectID and checkID from SQL
  specificrow <- qacheckSave[qacheckSave$checkID %in% c(scoreID),]
  
  #Does row for corresponding SQL data exist?
  if(nrow(specificrow)==0) {#If no, is app data blank?
    if(checkscore=='7' && assessor=="" && evidence=="" && obs=="" && out==""){
    #If yes, then data hasn't been added for this check. Do nothing  
  }
    else {#If no, then this is new data, so add a new row to dbo.QA_checks
      newRowQuery <- paste("INSERT INTO", databasename,".dbo.QA_checks VALUES ();")
      
      newRowSQL <- InsertListInQuery(newRowQuery, correct_row)
      
      newRowSet <- sqlQuery(myConn,newRowSQL)
      
      #also add row to dbo.QA_checks_SCD
      #This tells us when data was first changed
      
      empty_row <- c(projectID,scoreID,7,"","","","",time)
      
      newRowQuerySCD <- paste("INSERT INTO", databasename,".dbo.QA_checks_SCD VALUES ();")
      
      newRowSQLSCD <- InsertListInQuery(newRowQuerySCD, empty_row)
      
      newRowSetSCD <- sqlQuery(myConn,newRowSQLSCD)
      
    }}
  
  else{#If row for corresponding SQL data does exist, is app data equal to SQL data?
    comparerows <- specificrow == correct_row
    if(FALSE %in% comparerows){#Rows are not the same
       #Copy row from dbo.QA_checks into dbo.QA_checks_SCD, with date and time appended
       new_row_SCD <- c(specificrow,time)
        
       newRowQuerySCD <- paste("INSERT INTO", databasename, ".dbo.QA_checks_SCD VALUES ();")
        
       newRowSQLSCD <- InsertListInQuery(newRowQuerySCD,new_row_SCD)
        
       newRowSetSCD <- sqlQuery(myConn,newRowSQLSCD)
        
       #Overwrite row in dbo.QA_checks
       rowEditQuerysave <- paste("UPDATE ", databasename,".dbo.QA_checks 
                          SET checkscore = '", checkscore,
                                "', Assessor = '", assessor,
                                "', Evidence = '", evidence,
                                "', Observations = '", obs,
                                "', Outstanding = '", out,
                                "' WHERE projectID = ", projectID, " AND checkID = '", scoreID, "';", sep="")
      
        rowEditSetsave <- sqlQuery(myConn,rowEditQuerysave)
    }
  else{#Both rows are the same, so check hasn't been updated since last save
    #Do nothing
    }
  }
}

#Pull in info on individual checks
#And insert "dummy info" where there is no data for that check
individualChecks <- function(checkIDtext,checks){
  somebits <- checks %>% filter(checkID==checkIDtext)
  if (nrow(somebits)==0){
    newrow <- c("ID",checkIDtext,7,"","","","")
    somebits <- rbind(somebits,newrow)
  }
  return(somebits)
}

#--- Functions for calculating scores -----

#calculate_score gives a base score (in probability) for each QA activity
calculate_score <- function(qacheck){
  inputscore<-input[[paste0("score",qacheck)]]
  if(inputscore == "1) Excellent")
    return(100)
  else if(inputscore == "2) Good")
    return(80)
  else if(inputscore == "3) Some issues")
    return(60)
  else if (inputscore == "4) Needs improvement")
    return(40)
  else if (inputscore == "5) Significant issues")
    return(20)
  else
    return(0)
}

#adds up number of non-zero scores
iszero <- function(qacheck){
  inputscore<-input[[paste0("score",qacheck)]]
  if(inputscore == "TO BE CHECKED")
    return(0)
  else if(inputscore == "N/A")
    return(0)
  else
    return(1)
}

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

#--- Functions for displaying extra info on checks-----

#This function creates modals to show extra info
observe_info <- function(qacheck,types){
  observeEvent(input[[paste0(qacheck,"info")]],{
    showModal(modalDialog(
      eval(parse(text=paste(qacheck,types$log,sep="")))
    ))
  })
}

#This function creates the UI necessary to render the tooltips
tooltip_ui_render <- function(checkid,types){
  bsTooltip(id=paste0("score",checkid),
            title=eval(parse(text=paste0(checkid,"tooltip",types$log))),
            trigger="hover",placement="right")
}

#--- Functions for displaying links ------

#function for displaying link as a hyperlink
createLink <- function(val) {
  sprintf('<a href="%s" target="_blank" >%s</a>',val,val)
}

#Creates the modal and displays the DT dataframe
observe_links <- function(qacheck){
  observeEvent(input[[paste0(qacheck,"link")]],{
    
    check_row <- names_df%>%filter(QAcheckslist==qacheck)
    checkname <- (check_row%>%select(paste0(types$log,"_names")))[1,1]
    
    dataframelink <- as.data.frame(links$log)%>%mutate(Description=DisplayText, Hyperlink=createLink(Link))
    
    df <- dataframelink%>%filter(checkID==qacheck)%>%select(-Link,-DisplayText,-LinkID,-projectID,-checkID)
    
    output$dflink <- DT::renderDataTable(df, server=FALSE, selection='single',escape = FALSE)
    
    showModal(modalDialog(
     h5(paste(checkname)),
     br(),
     DT::dataTableOutput('dflink'),
     actionButton(paste(qacheck,"addlink",sep=""), "Add link"),
     conditionalPanel(
       condition = "input.dflink_rows_selected != 0",
       br(),
       actionButton(paste(qacheck,"editlink",sep=""), "Edit link")
     )
    ))
  })
}

 #This function is for adding a link
 observe_addlinks <- function(qacheck){
   observeEvent(input[[paste0(qacheck,"addlink")]],{
     showModal(modalDialog(
       textInput("newlink", "Link", value=""),
       textInput("linkdescription", "Description", value=""),
       br(),
       actionButton(paste(qacheck,"savelink",sep=""), "Enter")
     ))
   })
 }
 
 #This function is for saving a new link
 observe_savelinks <- function(qacheck){
   observeEvent(input[[paste0(qacheck,"savelink")]],{
   
     chosennumber <- input$projectID
     newlink <- input$newlink
     linkdesc <- input$linkdescription
     
     dataframelink <- as.data.frame(links$log)
     idnumber <- nrow(dataframelink%>%filter(checkID==qacheck))+1
     newrow <- c(chosennumber, qacheck, newlink, linkdesc, idnumber)
     
     dataframelink1 <- rbind(dataframelink,newrow)
     
     links$log <- dataframelink1

     
     #     #First, save new link to dbo.QA_hyperlinks
#     chosennumber <- input$projectID
#     newlink <- input$newlink
#     linkdesc <- input$linkdescription
#     idnumber <- nrow(dataframelink())+1
#     listforsave <- c(chosennumber, qacheck, newlink, linkdesc, idnumber)
#     
#     newRowQuery <- paste("INSERT INTO", databasename,".dbo.QA_hyperlinks VALUES ();")
#     
#     newRowSQL <- InsertListInQuery(newRowQuery, listforsave)
#     
#     newRowSet <- sqlQuery(myConn,newRowSQL)
#     
#     #Second, save blank data with current date time
#     
#     timelink <- format(Sys.time(), "%Y-%d-%m %X")
#     
#     blanklink <- c(chosennumber, qacheck, "", "", idnumber,timelink)
#     
#     blankRowQuery <- paste("INSERT INTO", databasename,".dbo.QA_hyperlinks_SCD VALUES ();")
#     
#     blankRowSQL <- InsertListInQuery(blankRowQuery, blanklink)
#     
#     blankRowSet <- sqlQuery(myConn,blankRowSQL)
#     
     removeModal()
   })
 }
 
 #This function is for editing a link
 observe_editlinks <- function(qacheck){
   observeEvent(input[[paste0(qacheck,"editlink")]],{
     dataframelink <- as.data.frame(links$log)%>%filter(checkID==qacheck)
     rownumber<- input$dflink_rows_selected
     showModal(modalDialog(
       textInput("editlink","Link",value=dataframelink$Link[rownumber]),
       textInput("editlinkinfo", "Description", value=dataframelink$DisplayText[rownumber]),
       br(),
       actionButton(paste(qacheck,"saveeditlink",sep=""), "Save")
     ))
   })
 }
 
 #This function is for saving an edited link
 observe_saveeditlinks <- function(qacheck){
   observeEvent(input[[paste0(qacheck,"saveeditlink")]],{
#     #Save old data to SCD table
#     edittime <- format(Sys.time(), "%Y-%d-%m %X")
#     df<-dataframelink()
#     rownumber<- input$dflink_rows_selected
      chosennumber <- input$projectID
#     oldrow <- c(chosennumber,qacheck,df$Link[rownumber],df$DisplayText[rownumber],rownumber,edittime)
#     oldRowQuery <- paste("INSERT INTO", databasename,".dbo.QA_hyperlinks_SCD VALUES ();")
#     
#     oldRowSQL <- InsertListInQuery(oldRowQuery, oldrow)
#     
#     oldRowSet <- sqlQuery(myConn,oldRowSQL)
     
     dataframelink <- as.data.frame(links$log)
     rownumber<- input$dflink_rows_selected
     
     #Overwrite data in current table
     newlink <- input$editlink
     linkdesc <- input$editlinkinfo
     
     dataframelink$Link <- ifelse(dataframelink$projectID==chosennumber & dataframelink$checkID==qacheck & dataframelink$LinkID == rownumber,
                                  newlink,dataframelink$Link)
     
     dataframelink$DisplayText <- ifelse(dataframelink$projectID==chosennumber & dataframelink$checkID==qacheck & dataframelink$LinkID == rownumber,
                                  linkdesc,dataframelink$DisplayText)
     
     links$log <- dataframelink
#     
#     linkEditQuery <- paste("UPDATE ", databasename,".dbo.QA_hyperlinks 
#                           SET Link = '", newlink,
#                           "', DisplayText = '", linkdesc,
#                           "' WHERE projectID = ", chosennumber, "AND checkID = '", qacheck, "' AND LinkID = ", rownumber, ";", sep="")
#     
#     linkEditSet <- sqlQuery(myConn,linkEditQuery)
#     
     removeModal()
#     
#     checksreact$log <- "blank"
  })
 }
 
 #this function sees what new links have been added, and then runs the saving function for these new links
 savingnewlinks <- function(qacheck,time){
   #Read in from SQL
   chosennumber <- input$projectID
   selectlinks <- paste("SELECT * FROM ", databasename, ".[dbo].[QA_hyperlinks] WHERE ProjectID = ", chosennumber, " AND checkID = '", qacheck, "'", sep="")
   selectlinks <- sqlQuery(myConn, selectlinks)%>%replace(.,is.na(.),"")
   
   #Read in from app
   dataframelink <- as.data.frame(links$log)%>%filter(projectID == chosennumber)%>%filter(checkID == qacheck)
   
   sqlnumber <- nrow(selectlinks)+1
   appnumber <- nrow(dataframelink)
   
   if (sqlnumber == appnumber){
     #No additional rows, so no need to add new link
   }
   else {
     listnewrows <- list(sqlnumber:appnumber)[[1]]
     lapply(listnewrows,newlinks_sql,qacheck=qacheck,dataframelink=dataframelink, time=time)
   }
 }
 
 newlinks_sql <- function(rownumber,qacheck,dataframelink,time){
   #saving new row to SQL
   newrow <- dataframelink[rownumber,]
   newRowQuery <- paste("INSERT INTO", databasename,".dbo.QA_hyperlinks VALUES ();")
        
   newRowSQL <- InsertListInQuery(newRowQuery, newrow)
        
   newRowSet <- sqlQuery(myConn,newRowSQL)
   
   #saving empty row to SCD table
   emptyrow <- c(input$projectID, qacheck, "", "", rownumber,time)
   emptyRowQuery <- paste("INSERT INTO", databasename,".dbo.QA_hyperlinks_SCD VALUES ();")
   
   emptyRowSQL <- InsertListInQuery(emptyRowQuery, emptyrow)
   
   emptyRowSet <- sqlQuery(myConn,emptyRowSQL)
 }
 

#--- Functions for error messages----
#checks whether a mandatory check has been left as "To be Checked"
check_mandatory <- function(checkID,types,names_df){
  score <-input[[paste0("score",checkID)]]
  check_row <- names_df%>%filter(QAcheckslist==checkID)
  mandatory <- (check_row%>%select(paste0(types$log,"_mandatory")))[1,1]
  to_return <- if(mandatory==1 && score=="TO BE CHECKED"){1}
  else {0}
  return(to_return)
}
#checks whether a mandatory check has been marked "N/A"
check_NA_mandatory <- function(checkID,types,names_df){
  score <-input[[paste0("score",checkID)]]
  check_row <- names_df%>%filter(QAcheckslist==checkID)
  mandatory <- (check_row%>%select(paste0(types$log,"_mandatory")))[1,1]
  to_return <- if(mandatory==1 && score=="N/A"){1}
  else {0}
  return(to_return)
}

#checks whether any "Significant issues" exist
check_significant <- function(checkID,types,names_df){
  score <-input[[paste0("score",checkID)]]
  to_return <- if(score=="5) Significant issues"){1}
  else {0}
  return(to_return)
}
#--- Functions for reading in historical records-----
#this function selects correct rows from QA_log_SCD
select_old_log <- function(dateselect, chosennumber){
  selectolddate <- paste("SELECT * FROM ", databasename, ".[dbo].[QA_log_SCD] WHERE ProjectID = ", chosennumber, " and EndDate > '", dateselect, "'", sep="") 
  selectolddate <- sqlQuery(myConn, selectolddate)%>%replace(.,is.na(.),"")
  return(selectolddate)
}

#this function reads in correct information from previous versions
read_old_log <- function(dateselect, chosennumber){
  #This is reading in from SCD table
  checkSCD <- select_old_log(dateselect,chosennumber)
  
  selectcurrentdate <- paste("SELECT * FROM ", databasename, ".[dbo].[QA_log] WHERE ProjectID = ", chosennumber, sep="") 
  selectcurrentdate <- sqlQuery(myConn, selectcurrentdate)%>%replace(.,is.na(.),"")
  
  #if checkSCD is empty, then look at current table
  if (nrow(checkSCD)==0) {
    oldcheckrow <- selectcurrentdate
  }
  else { #if checkSCD is not empty, select first row
    oldcheckrow <- checkSCD%>%top_n(EndDate,n=-1)%>%select(-EndDate)
  }
  
  return(oldcheckrow)
}

#this function will create top row of log preview
displayingoldlog <- function(dateselect,chosennumber){
  #This is reading in table of log data
  oldcheckrow <- read_old_log(dateselect, chosennumber)
  
  #read in various categories
  projectname <-oldcheckrow[2]
  vers <- oldcheckrow[3]
  leadanalyst <- oldcheckrow[4]
  analyticalassurer <- oldcheckrow[5]
  BCM <- oldcheckrow[6]
  
  #create preview ui
  uihistory <- fixedRow(
    column(2, paste(projectname)),
    column(2, paste(vers)),
    column(2, paste(leadanalyst)),
    column(2, paste(analyticalassurer)),
    column(2, paste(BCM)),
    column(2, paste(""))
  )
  
  return(uihistory)
}

#this function selects correct rows from QA_checks_SCD
select_old_check <- function(checkid,dateselect, chosennumber){
  selectolddate <- paste("SELECT * FROM ", databasename, ".[dbo].[QA_checks_SCD] WHERE ProjectID = ", chosennumber, " and checkID = '", checkid, "' and EndDate > '", dateselect, "'", sep="") 
  selectolddate <- sqlQuery(myConn, selectolddate)%>%replace(.,is.na(.),"")
  return(selectolddate)
}

#this function reads in correct information for previous versions
read_old_check <- function(checkid,dateselect,chosennumber){
  #this is reading in from SCD table
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
  
  return(oldcheckrow)
}

#this function will create each individual row for checks in the preview pane  
displayingoldchecks <- function(checkid,dateselect,chosennumber,types,names_df){
  
  oldcheckrow <- read_old_check(checkid,dateselect,chosennumber)
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
  
  #adding colours to check ratings
  checkscorecolour <- if(checkscore=="TO BE CHECKED"){HTML(paste0("<span style=\"background-color: #00bfff\">",checkscore,"</span>"))}
  else if(checkscore=="1) Excellent"){HTML(paste0("<span style=\"background-color: #32cd32\">",checkscore,"</span>"))}
  else if(checkscore=="2) Good"){HTML(paste0("<span style=\"background-color: #a4c639\">",checkscore,"</span>"))}
  else if(checkscore=="3) Some issues"){HTML(paste0("<span style=\"background-color: #ffff00\">",checkscore,"</span>"))}
  else if(checkscore=="4) Needs improvement"){HTML(paste0("<span style=\"background-color: #ffa500\">",checkscore,"</span>"))}
  else if(checkscore=="5) Significant issues"){HTML(paste0("<span style=\"background-color: #ff0000\">",checkscore,"</span>"))}
  else if(checkscore=="N/A"){HTML(paste0("<span style=\"background-color: #d3d3d3\">",checkscore,"</span>"))}
  else {paste(checkscore)}
  
  #create preview ui
  uihistory <- fixedRow(
    hr(),
    column(2, paste(checkname)),
    column(2, eval(checkscorecolour)),
    column(2, paste(assessor)),
    column(2, paste(summary)),
    column(2, paste(obs)),
    column(2, paste(out))
  )
  
  return(uihistory)
  
}

#this function reads in scores, to allow us to calculate overall pillar scores
#operates in similar way to calculate_score, but reading from SCD table rather than from app inputs
checkscorehistory <- function(checkid,dateselect,chosennumber){
  #This is reading in from SCD table
  oldcheckrow <- read_old_check(checkid,dateselect,chosennumber)
  
  checkscore <- oldcheckrow[3]
  
  score_to_calc <- if(checkscore==1){100}
  else if(checkscore==2){80}
  else if(checkscore==3){60}
  else if(checkscore==4){40}
  else if(checkscore==5){20}
  else {0}
  
  return(score_to_calc)
}

#this function checks if score is zero, to allow us to calculate overall pillar scores
#operates in similar way to is_zero, but reading from SCD table rather than from app inputs
zeroscorehistory <- function(checkid,dateselect,chosennumber){
  #This is reading in from SCD table
  oldcheckrow <- read_old_check(checkid,dateselect,chosennumber)
  
  checkscore <- readingOutput(oldcheckrow[3])
  
  score_to_zero <- if(checkscore=="TO BE CHECKED"){0}
  else if(checkscore=="N/A"){0}
  else {1}
  
  return(score_to_zero)
}

#this function reads in previous weightings to allow us to calculate scores
weightings_old <- function(dateselect,chosennumber){
  #Reading in weightings and calculating overall QA log score
  weightingshistory <- read_old_log(dateselect,chosennumber)
  
  weightings_separate <- strsplit(weightingshistory$weighting,split=" ")
}

#this function restores information in project log bar
restore_log <- function(session,dateselect,chosennumber){
  #reading in from SCD table
  oldcheckrow <- read_old_log(dateselect,chosennumber)
  
  updateTextInput(session, inputId = "projectname", value = paste(oldcheckrow[2]))
  
  updateTextInput(session, inputId = "version", value = paste(oldcheckrow[3]))
  
  updateTextInput(session, inputId = "leadanalyst", value = paste(oldcheckrow[4]))
  
  updateTextInput(session, inputId = "analyticalassurer", value = paste(oldcheckrow[5]))
  
  updateSelectizeInput(session, inputId = "BCM", selected = oldcheckrow[6])
  
  weightings_separate <- weightings_old(dateselect,chosennumber)
  
  weightings$DG <- paste(weightings_separate[[1]][1])
  weightings$SC <- paste(weightings_separate[[1]][2])
  weightings$VE <- paste(weightings_separate[[1]][3])
  weightings$VA <- paste(weightings_separate[[1]][4])
  weightings$DA <- paste(weightings_separate[[1]][5])
}

#this function restores information in the individual checks
restore_checks <- function(session,checkid,dateselect,chosennumber){
  oldcheckrow <- read_old_check(checkid,dateselect,chosennumber)
  
  checkoutput <- readingOutput(oldcheckrow[3])
  updateSelectizeInput(session, inputId = paste("score",checkid,sep=""), selected = checkoutput)
  updateTextInput(session, inputId = paste("assess", checkid,sep=""), value=paste(oldcheckrow[4]))
  updateTextInput(session, inputId = paste("summary", checkid,sep=""), value=paste(oldcheckrow[5]))
  updateTextInput(session, inputId = paste("obs", checkid,sep=""), value=paste(oldcheckrow[6]))
  updateTextInput(session, inputId = paste("out", checkid,sep=""), value=paste(oldcheckrow[7]))
}

#This function restores links
restore_links <- function(linkid, session, checkid, dateselect,chosennumber,selectcurrentlink){
  #read in from SQL
  selectoldlink <- paste("SELECT * FROM ", databasename, ".[dbo].[QA_hyperlinks_SCD] WHERE ProjectID = ", chosennumber, " and checkID = '", checkid, "' and linkID = ", linkid, " and EndDate > '", dateselect, "'", sep="") 
  selectoldlink <- sqlQuery(myConn, selectoldlink)%>%replace(.,is.na(.),"")
  
  if(nrow(selectoldlink)==0){
     #then current data is still relevant, so do nothing
  }
  else{
    #select relevant row
    oldlink <- selectoldlink%>%top_n(EndDate,n=-1)
    
    #Add new row to SCD table
    restoretime <- format(Sys.time(), "%Y-%d-%m %X")
    correctid <- selectcurrentlink%>%filter(LinkID == linkid)
    currentlink <- c(correctid,restoretime)
    currentRowQuery <- paste("INSERT INTO", databasename,".dbo.QA_hyperlinks_SCD VALUES ();")
    currentRowSQL <- InsertListInQuery(currentRowQuery, currentlink)
    currentRowSet <- sqlQuery(myConn,currentRowSQL)
    
    #Overwrite data in current table
    link <- oldlink[3]
    linkdesc <- oldlink[4]
    
    oldlinkQuery <- paste("UPDATE ", databasename,".dbo.QA_hyperlinks 
                          SET Link = '", link,
                           "', DisplayText = '", linkdesc,
                           "' WHERE projectID = ", chosennumber, "AND checkID = '", checkid, "' AND LinkID = ", linkid, ";", sep="")
    
    oldlinkSet <- sqlQuery(myConn,oldlinkQuery)
  }
}

#This function reads in linkIDs for links, and applies restore_links
read_links <- function(session,checkid,dateselect,chosennumber){
  #First, read in current links to see how many link ID numbers there are
  selectcurrentlink <- paste("SELECT * FROM ", databasename, ".[dbo].[QA_hyperlinks] WHERE projectID = ", chosennumber, " and checkID = '", checkid, "'", sep="")
  selectcurrentlink <- sqlQuery(myConn, selectcurrentlink)%>%replace(.,is.na(.),"")
  numberofrows <- nrow(selectcurrentlink)
  if(numberofrows==0){
    #do nothing
  }
  else{
    listofid <- list(1:numberofrows)[[1]]
    lapply(listofid,restore_links,session=session,checkid=checkid,dateselect=dateselect,chosennumber=chosennumber,selectcurrentlink=selectcurrentlink)
  }
}