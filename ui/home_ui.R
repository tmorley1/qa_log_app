tabPanel(title = "Home", value = "panel1",
         
  h1(strong("Department for Education QA Log"), align="center"),
  
  #Choose to create new or update       
  uiOutput('startPanel'),
  
  #If creating new, choose type of QA log
  uiOutput('newPanel'),
  
  #If user is unsure what type of log to choose
  uiOutput('unsurePanel'),
  
  #If updating log, enter project ID  
  uiOutput('updatePanel'),
  
  #Hidden panel - user cannot manually update log type
  uiOutput('logtypepanel')
)