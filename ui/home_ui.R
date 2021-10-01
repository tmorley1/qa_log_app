tabPanel(title = "Home", value = "panel1",
         
  h1(strong("Department for Education QA Log"), align="center"),
  
  #Choose to create new or update       
  fluidRow(column(12,"Welcome to the Department for Education QA log.
         Would you like to create a new QA log, or update an existing one?",
         align="center")),
  fluidRow(br(),
           column(6,actionButton("newlog","New QA Log"), align="right"),
           column(6,actionButton("updatelog","Update QA Log"),align="left")),
  
  #If creating new, choose type of QA log
  uiOutput('newPanel'),
  
  #If updating log, enter project ID  
  uiOutput('updatePanel')
)