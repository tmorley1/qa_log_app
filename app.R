## Loading Libraries Needed
library(shiny)
library(tidyverse)
library(shinythemes) #theme -> css
library(plotly) # plotlyOutputs - graphs
library(DT)
library(stringr)
library(shinydashboard)
library(treemap)
library(lubridate)

username <- "tmorley"#change to be your username
pathway <- paste("C:\\Users\\",username,"\\OneDrive - Department for Education\\Documents\\Projects\\qa_log_app", sep="")

#---App--------------------------------------------------------

ui <- navbarPage("QA Log",
                 theme = shinytheme("united"),
                 source(paste(pathway,"\\ui\\main_ui.R", sep=""), local=TRUE)$value
                 )

server <- function(input, output, session) {
  source(paste(pathway,"\\server\\main_server.R", sep=""), local=TRUE)$value
}

shinyApp(ui,server)
