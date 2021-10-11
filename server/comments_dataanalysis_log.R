#----Documentation and governance

#----DG1 Scope and specification----
output$DG1dataanalysis <- renderUI({fluidRow(column(12,
      "Does a clear and comprehensive project scope and specification exist with 
      evidence of key stakeholder involvement and sign off?",
      br(), br(),
      "This may take a number of different forms, e.g., separate scope and 
      specification document(s), an exchange of emails or embedded into the 
      code/spreadsheet itself.",
      br(),br(),
      "See QA Guidance chapter 3."))})

#----DG2 User guide----
output$DG2dataanalysis <- renderUI({fluidRow(column(12,
      "Is the user documentation sufficiently clear to support independent use 
      of the analysis for a new user who needs to run/operate the analysis and 
      view outputs?"))})

#----DG3 Technical guide----
#Not required for this log

#----DG4 KIM----
output$DG4dataanalysis <- renderUI({fluidRow(column(12,
      "Is the analysis and documentation stored according to DfE and local
      protocols?",
      br(), br(),
      "Are files appropriately labelled? Has an appropriate rating been
      applied?",
      br(),
      "Who can access data files, outputs?",
      br(),
      "When will it be archived?"))})

#----DG5 Version Control----
output$DG5dataanalysis <- renderUI({fluidRow(column(12,
      "Does an up to date and informative version control log exist?",
      br(), br(),
      "Version control log can be a separate document or embedded in the
      code/spreadsheet."))})

#----DG6 Responsibilities----
output$DG6dataanalysis <- renderUI({fluidRow(column(12,
      "Have responsibilities and accountabilities laid out in the DfE guidance
      been assigned with sign-off process completed?",
      br(), br(),
      "Have the following roles been allocated -",
      br(),
      "- a lead analyst",
      br(),
      "- a commissioner (or SRO)",
      br(),
      "- an analytical assurer"))})

#----DG7 QA Planning and Resourcing----
output$DG7dataanalysis <- renderUI({fluidRow(column(12,
      "Has an appropriate QA plan been agreed with adequate consideration of
      resource quantity and skills required?",
      br(), br(),
      "Has this been agreed between analyst, analytical assurer and
      commissioner/SRO?",
      br(),
      "Is there a clear list of QA tasks that must be completed to provide
      sufficient assurance before delivery of output?",
      br(),
      "Is the planned governance adequate with appropriate levels of
      sign-off?"))})

#----DG8 Record of QA----
output$DG8dataanalysis <- renderUI({fluidRow(column(12,
      "Have all the checks and tests been recorded with evidence available to 
      review?",
      br(), br(),
      "This log, along with linked evidence to actual QA activities, will 
      provide most of the evidence needed."))})