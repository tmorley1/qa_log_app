## Loading Libraries Needed
library(shiny)
library(tidyverse)
library(shinythemes) #theme -> css
library(shinydashboard)
library(shinyWidgets)
library(RODBC)
library(stringr)
library(shinyjs)
library(shinyBS)

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
#So they cannot be included in server scripts

#List of checks
QAcheckslist <- c("DG1", "DG2", "DG3", "DG4", "DG5", "DG6", "DG7", "DG8", "DG9",
                  "SC1","SC2","SC3","SC4","SC5","SC6","SC7","SC8","SC9")

names_of_checks <- function(checkID,types){
  if(checkID=="DG1"){"Scope and Specification"}
  else if (checkID=="DG2"){"User guide"}
  else if (checkID=="DG3"){"Technical guide"}
  else if (checkID=="DG4"){"KIM"}
  else if (checkID=="DG5"){"Version control"}
  else if (checkID=="DG6"){"Responsibilities"}
  else if (checkID=="DG7"){"QA planning and resourcing"}
  else if (checkID=="DG8"){"Record of QA"}
  else if (checkID=="DG9"){"Risk and issues log"}
  else if (checkID=="SC1"){if(types$log=="modelling"){"Structure of model"}
                           else if(types$log=="analysis"){"Structure of analysis"}
                           else if(types$log=="dashboard"){"Structure of data model"}
                           else if(types$log=="statistics"){"Structure of analysis"}}
  else if (checkID=="SC2"){if(types$log=="dashboard"){"Dashboard structure"}
                           else {"Calculation structure"}}
  else if (checkID=="SC3"){"Variable names and units"}
  else if (checkID=="SC4"){if(types$log=="modelling"){"Model comments"}
                           else {"Analysis comments"}}
  else if (checkID=="SC5"){"Formula clarity and robustness"}
  else if (checkID=="SC6"){"Accessibility"}
  else if (checkID=="SC7"){"Caveats and footnotes"}
  else if (checkID=="SC8"){"Output formatting"}
  else if (checkID=="SC9"){"RAP"}
}

conditions <- function(checkID,QAlogtype){
  if(checkID=="DG3"){"QAlogtype == 'Official Statistics' || input.QAlogtype == 'Modelling'"}
  else if(checkID=="DG9"){"QAlogtype == 'Official Statistics'"}
  else if(checkID=="SC2"){"QAlogtype == 'Official Statistics' || input.QAlogtype == 'Modelling' || input.QAlogtype == 'Dashboard'"}
  else if(checkID=="SC4"){"QAlogtype == 'Official Statistics' || input.QAlogtype == 'Modelling' || input.QAlogtype == 'Data Analysis'"}
  else if(checkID=="SC6"){"QAlogtype == 'Dashboard'"}
  else if(checkID=="SC7"){"QAlogtype == 'Official Statistics'"}
  else if(checkID=="SC8"){"QAlogtype == 'Official Statistics'"}
  else if(checkID=="SC9"){"QAlogtype == 'Official Statistics'"}
  else {"No condition"}
}

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
UI_check <- function(checkID,types,QAlogtype){
    checkname <- names_of_checks(checkID,types)
    conditiontext <- conditions(checkID,QAlogtype)
    uicheck <- if(conditiontext=="No condition"){fluidRow(
      column(2, actionButton(paste(checkID,"info",sep=""), checkname)),
      column(2, rating_options(paste("score",checkID,sep=""))),
      column(2, textInput(paste("assess",checkID,sep=""),label=NULL, value="")),
      column(2, textInput(paste("summary",checkID,sep=""), label=NULL, value="")),
      column(2, textInput(paste("obs",checkID,sep=""), label=NULL, value="")),
      column(2, textInput(paste("out",checkID,sep=""), label=NULL, value=""))
    )}
    else{
      conditionalPanel(
      condition=conditiontext,
      fluidRow(
        column(2, actionButton(paste(checkID,"info",sep=""), checkname)),
        column(2, rating_options(paste("score",checkID,sep=""))),
        column(2, textInput(paste("assess",checkID,sep=""),label=NULL, value="")),
        column(2, textInput(paste("summary",checkID,sep=""), label=NULL, value="")),
        column(2, textInput(paste("obs",checkID,sep=""), label=NULL, value="")),
        column(2, textInput(paste("out",checkID,sep=""), label=NULL, value=""))
      ))
    }
    
  return(uicheck)
}

#---App--------------------------------------------------------
ui <- fluidPage( #Removing navigation bar between tabs
                 useShinyjs(),
                 tags$style(type='text/css', "nav.navbar.navbar-default.navbar-static-top{border-color: #f5f5f5;background-color: #f5f5f5;}"),
                 tags$style(type='text/css', ".navbar{min-height: 0px; margin-bottom: 0px;}"),
                 tags$style(type='text/css', ".navbar-brand{height: 0px; padding: 0px 0px;}"),
                 #Defining theme etc. and reading in UI files
                 navbarPage("QA Log", id="inTabset",
                 theme = shinytheme("united"),
                 source(paste(pathway,"\\ui\\home_ui.R",sep=""), local=TRUE)$value,
                 source(paste(pathway,"\\ui\\main_ui.R", sep=""), local=TRUE)$value
                 ))

server <- function(input, output, session) {
  #removing navigation bar between tabs
  observe({
    hide(selector = "#inTabset li a[data-value=panel02]")
    hide(selector = "#inTabset")
    })
  #Reading in server files
  source(paste(pathway,"\\server\\checks.R", sep=""), local=TRUE)$value
  source(paste(pathway,"\\server\\functions.R", sep=""), local=TRUE)$value
  source(paste(pathway,"\\server\\home_server.R", sep=""), local=TRUE)$value
  source(paste(pathway,"\\server\\main_server.R", sep=""), local=TRUE)$value
  source(paste(pathway,"\\server\\comments_modelling_log.R", sep=""), local=TRUE)$value
  source(paste(pathway,"\\server\\comments_dataanalysis_log.R", sep=""), local=TRUE)$value
  source(paste(pathway,"\\server\\comments_dashboard_log.R", sep=""), local=TRUE)$value
  source(paste(pathway,"\\server\\comments_statistics_log.R", sep=""), local=TRUE)$value
  source(paste(pathway,"\\server\\tooltips.R", sep=""), local=TRUE)$value
}

shinyApp(ui,server)
