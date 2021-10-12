## Loading Libraries Needed
library(shiny)
library(tidyverse)
library(shinythemes) #theme -> css
library(shinydashboard)
library(shinyWidgets)
library(RODBC)
library(stringr)

#location of app files
username <- "tmorley"
pathway <- paste("C:\\Users\\",username,"\\OneDrive - Department for Education\\Documents\\Projects\\qa_log_app", sep="")

#sql server and database
servername<-"T1PRMDRSQL\\SQLPROD,55842"
databasename <- "MDR_Modelling_DSAGT1"

#Create connection to the SQL server
myConn <- odbcDriverConnect(connection=paste("Driver={SQL Server}; Server=", 
           servername, "; Database=", databasename, "; Trusted_Connection=yes",
           sep=""))

#---Functions--------------------------------------------------
#These functions must be called before UI is read in
#So they cannot be included in functions.R in server

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

#Generating UI for different checks
UI_check <- function(checkID,checkname){
    uicheck <- fluidRow(
      column(2, actionButton(paste(checkID,"info",sep=""), checkname)),
      column(2, rating_options(paste("score",checkID,sep=""))),
      column(2, textInput(paste("assess",checkID,sep=""),label=NULL, value="")),
      column(2, textInput(paste("summary",checkID,sep=""), label=NULL, value="")),
      column(2, textInput(paste("obs",checkID,sep=""), label=NULL, value="")),
      column(2, textInput(paste("out",checkID,sep=""), label=NULL, value=""))
    )
    
  return(uicheck)
}

#---App--------------------------------------------------------

ui <- navbarPage("QA Log", id="inTabset",
                 theme = shinytheme("united"),
                 source(paste(pathway,"\\ui\\home_ui.R",sep=""), local=TRUE)$value,
                 source(paste(pathway,"\\ui\\main_ui.R", sep=""), local=TRUE)$value
                 )

server <- function(input, output, session) {
  source(paste(pathway,"\\server\\functions.R", sep=""), local=TRUE)$value
  source(paste(pathway,"\\server\\home_server.R", sep=""), local=TRUE)$value
  source(paste(pathway,"\\server\\main_server.R", sep=""), local=TRUE)$value
  source(paste(pathway,"\\server\\comments_modelling_log.R", sep=""), local=TRUE)$value
  source(paste(pathway,"\\server\\comments_dataanalysis_log.R", sep=""), local=TRUE)$value
  source(paste(pathway,"\\server\\comments_dashboard_log.R", sep=""), local=TRUE)$value
  source(paste(pathway,"\\server\\comments_statistics_log.R", sep=""), local=TRUE)$value
}

shinyApp(ui,server)
