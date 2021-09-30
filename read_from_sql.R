## Load the library
library(RODBC)

#defining server and database
servername<-"T1PRMDRSQL\\SQLPROD,55842"
databasename <- "MDR_Modelling_DSAGT1"

#Create connection to the SQL server
myConn <- odbcDriverConnect(connection=paste("Driver={SQL Server}; Server=", servername, "; Database=", databasename, "; Trusted_Connection=yes", sep=""))

#----Reading in table ----

#Create the query to pull in data - make sure you run this whole block at once,
# as running it line by line won't work.
myTable <- paste("
SELECT *
FROM ", databasename, ".[dbo].[test] 
", sep="")
#Tidy it up a bit
myTable <- gsub("\n","", myTable)
myTable <- gsub("\t","", myTable)

#now run the query to get our output.
myTable <- sqlQuery(myConn, myTable)

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
