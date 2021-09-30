## Loading Libraries Needed
library(shiny)
library(tidyverse)
library(shinythemes) #theme -> css
library(shinydashboard)
library(shinyWidgets)
library(RODBC)

#location of app files
username <- "tmorley"
pathway <- paste("C:\\Users\\",username,"\\OneDrive - Department for Education\\Documents\\Projects\\qa_log_app", sep="")

#sql server and database
servername<-"T1PRMDRSQL\\SQLPROD,55842"
databasename <- "MDR_Modelling_DSAGT1"

#Create connection to the SQL server
myConn <- odbcDriverConnect(connection=paste("Driver={SQL Server}; Server=", servername, "; Database=", databasename, "; Trusted_Connection=yes", sep=""))

#---App--------------------------------------------------------

ui <- navbarPage("QA Log",
                 theme = shinytheme("united"),
                 source(paste(pathway,"\\ui\\main_ui.R", sep=""), local=TRUE)$value
                 )

server <- function(input, output, session) {
  source(paste(pathway,"\\server\\main_server.R", sep=""), local=TRUE)$value
}

shinyApp(ui,server)
