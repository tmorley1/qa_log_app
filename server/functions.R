#------Functions for generating log-------------
#Different rating options
rating_options <- function(score_index){selectizeInput(score_index, 
                                                       choices=c("1) Excellent",
                                                                 "2) Good",
                                                                 "3) Some issues",
                                                                 "4) Needs improvement",
                                                                 "5) Significant issues",
                                                                 "N/A",
                                                                 "TO BE CHECKED"
                                                       ),
                                                       selected="TO BE CHECKED", label=NULL)}

#create_log is called when button to create new log is pressed
#Generates project ID and fills in relevant text boxes to display log type
create_log <- function(log_type,log_type_name,session1,types1,nexttab1){
  types1$log <- log_type
  nexttab1$log <- "next"
  #we generate a random 4 digit number for the project ID
  newID <- floor(runif(1, 1000, 9999))
  #we need to test to check that the number generated is not already being used
  #select relevant row from SQL database
  checkselect <- paste("SELECT * FROM ", databasename, ".[dbo].[test] WHERE ProjectID = ", newID, sep="")
  checkselect <- sqlQuery(myConn, checkselect)
  if(nrow(checkselect)==0){
    updateTextInput(session1,inputId = "projectID", value = newID)
    updateTextInput(session1,inputId = "QAlogtype", value =  log_type_name)
    updateTabsetPanel(session1, "inTabset", selected="panel2")}
  #if the ID isn't being used, the project ID gets updated and the log is displayed.
  #if the ID is being used, nothing happens and the user has to click on the button again
}

#Generating UI for different checks
UI_check <- function(checkID,checkname){
  renderUI({
    fluidRow(
      column(2, actionButton(paste(checkID,"info",sep=""), checkname)),
      column(2, rating_options(paste("score",checkID,sep=""))),
      column(2, textInput(paste("assess",checkID,sep=""),label=NULL, value="")),
      column(2, textInput(paste("summary",checkID,sep=""), label=NULL, value="")),
      column(2, textInput(paste("obs",checkID,sep=""), label=NULL, value="")),
      column(2, textInput(paste("out",checkID,sep=""), label=NULL, value=""))
    )
  })
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

#--- Functions for calculating scores -----

#calculate_score gives a base score (in probability) for each QA activity
calculate_score <- function(inputscore){
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
iszero <- function(inputscore){
  if(inputscore == "TO BE CHECKED")
    return(0)
  else if(inputscore == "N/A")
    return(0)
  else
    return(1)
}