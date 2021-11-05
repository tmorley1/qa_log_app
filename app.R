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

#Reading in information about QA checks
source(paste(pathway, "\\functions\\edit_lists.R", sep=""))

#Reading in functions necessary to build UI
source(paste(pathway, "\\functions\\functions_for_ui.R", sep=""))

#---App--------------------------------------------------------
ui <- fixedPage( #Removing navigation bar between tabs
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

#Creating file paths for comments files
comments_paths <- function(log,pathway){
  filepath <- paste0(pathway,"\\comments\\comments_",log,"_log.R")
  sourcepath <- source(filepath)
  return(sourcepath)
}

#Creating file paths for tooltips files
tooltips_paths <- function(log,pathway){
  filepath <- paste0(pathway,"\\tooltips\\tooltips_",log,"_log.R")
  sourcepath <- source(filepath)
  return(sourcepath)
}

server <- function(input, output, session) {
  #removing navigation bar between tabs
  observe({
    hide(selector = "#inTabset li a[data-value=panel02]")
    hide(selector = "#inTabset")
    })
  #Reading in server files
  source(paste(pathway,"\\functions\\functions.R", sep=""), local=TRUE)$value
  source(paste(pathway,"\\server\\home_server.R", sep=""), local=TRUE)$value
  source(paste(pathway,"\\server\\main_server.R", sep=""), local=TRUE)$value
  lapply(logslist,comments_paths,pathway=pathway)
  lapply(logslist,tooltips_paths,pathway=pathway)
}

shinyApp(ui,server)
