## Load the library
library(shiny)
library(tidyverse)
library(shinythemes) #theme -> css
library(shinydashboard)
library(shinyWidgets)
library(RODBC)
library(stringr)
library(shinyjs)
library(shinyBS)

#defining server and database
servername<-"T1PRMDRSQL\\SQLPROD,55842"
databasename <- "MDR_Modelling_DSAGT1"

currentnumber <- 9830
#Create connection to the SQL server
myConn <- odbcDriverConnect(connection=paste("Driver={SQL Server}; Server=", servername, "; Database=", databasename, "; Trusted_Connection=yes", sep=""))

#----Reading in table ----

selectdatelog <- paste("SELECT EndDate FROM ", databasename, ".[dbo].[QA_log_SCD] WHERE ProjectID = ", currentnumber, sep="")
#selecting date from QA_checks_SCD
selectdatechecks <- paste("SELECT EndDate FROM ", databasename, ".[dbo].[QA_checks_SCD] WHERE ProjectID = ", currentnumber, sep="")
selectdatelog <- sqlQuery(myConn, selectdatelog)
selectdatechecks <- sqlQuery(myConn, selectdatechecks)

EndDate <- unique(c(selectdatechecks$EndDate, selectdatelog$EndDate))
alldatesdf <- as.data.frame(EndDate)%>%arrange(desc(EndDate))

forversions <- paste("SELECT * FROM ", databasename, ".[dbo].[QA_log_SCD] WHERE ProjectID = ", currentnumber, sep="")
forversions <- sqlQuery(myConn, forversions)

forversionsdf <- as.data.frame(forversions)%>%select(vers,EndDate)

datesdf <- (full_join(alldatesdf,forversionsdf)%>%mutate(vers=lag(vers)))[-1,]

datesdf %>% mutate()















#-----Old Bits----
#Create the query to pull in data - make sure you run this whole block at once,
# as running it line by line won't work.
myTable <- paste("
SELECT *
FROM ", databasename, ".[dbo].[QA_log]
WHERE projectID = '1'
", sep="")
#Tidy it up a bit
myTable <- gsub("\n","", myTable)
myTable <- gsub("\t","", myTable)

#now run the query to get our output.
myTable <- sqlQuery(myConn, myTable)

#Create the query to pull in data - make sure you run this whole block at once,
# as running it line by line won't work.
myTable1 <- paste("
SELECT *
FROM ", databasename, ".[dbo].[QA_checks]
WHERE projectID = '1'
", sep="")
#Tidy it up a bit
myTable1 <- gsub("\n","", myTable1)
myTable1 <- gsub("\t","", myTable1)

#now run the query to get our output.
myTable1 <- sqlQuery(myConn, myTable1)

DG1bits <- myTable1[myTable1$checkID %in% c("DG1"),]

listoftable <- c(myTable,myTable1[1])

testrow <- myTable1[myTable1$checkID %in% c("DG2"),]
#---- Adding extra row of data----

#Now we want to export data. We can add a new row of data to the table as follows:

#Adding an extra row of data
sql<- paste("
INSERT INTO ", databasename, ".dbo.test
VALUES ('3', 'Test Project from R', '5', '5');
",sep="")
saveConn<- odbcDriverConnect(connection=paste("Driver={SQL Server}; Server=", servername, "; Database=", databasename, "; Trusted_Connection=yes", sep=""))
resultset <- sqlQuery(saveConn,sql)

#---- Adding extra row of data from list----

#But what if data is already defined in R? For example:

#defining new row of data
newRow <- c('4','Second Test Project from R', '4', '5')

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

query <- paste("INSERT INTO", databasename,".dbo.test VALUES ();")

sql2 <- InsertListInQuery(query, newRow)

resultset2 <- sqlQuery(saveConn,sql2)

#---- Reading in specific row from SQL-----

#Reading in specific output from SQL database
chosennumber=6

selectrow <- paste("SELECT * FROM ", databasename, ".[dbo].[test] WHERE ProjectID = ", chosennumber, sep="")

#now run the query to get our output.
selectrow <- sqlQuery(myConn, selectrow)

#---- Updating row in table----
newDG1 <- 2
chosenid <- 6

rowEditQuery <- paste("UPDATE ", databasename,".dbo.test SET DG1 = ", newDG1,
                      " WHERE projectID =", chosenid, ";", sep="")
rowEditSet <- sqlQuery(myConn,rowEditQuery)
