#----Documentation and governance

#----DG1 Scope and specification----
output$DG1dataanalysis <- renderUI({fluidRow(column(12,
      "Scope and specification",
      br(), br(),
      "Does a clear and comprehensive project scope and specification exist with 
      evidence of key stakeholder involvement and sign off?",
      br(),
      "This may take a number of different forms, e.g., separate scope and 
      specification document(s), an exchange of emails or embedded into the 
      code/spreadsheet itself.",
      br(),br(),
      "See QA Guidance chapter 3."))})

#----DG2 User guide----
output$DG2dataanalysis <- renderUI({fluidRow(column(12,
      "User guide",
      br(), br(),
      "Is the user documentation sufficiently clear to support independent use 
      of the analysis for a new user who needs to run/operate the analysis and 
      view outputs?"))})

#----DG3 Technical guide----
output$DG3dataanalysis <- renderUI({fluidRow(column(12,
      "This check is not required."))})

#----DG4 KIM----
output$DG4dataanalysis <- renderUI({fluidRow(column(12,
      "KIM",
      br(), br(),
      "Is the analysis and documentation stored according to DfE and local
      protocols?",
      br(),
      "Are files appropriately labelled? Has an appropriate rating been
      applied?",
      br(),
      "Who can access data files, outputs?",
      br(),
      "When will it be archived?"))})

#----DG5 Version Control----
output$DG5dataanalysis <- renderUI({fluidRow(column(12,
      "Version Control",
      br(), br(),
      "Does an up to date and informative version control log exist?",
      br(),
      "Version control log can be a separate document or embedded in the
      code/spreadsheet."))})

#----DG6 Responsibilities----
output$DG6dataanalysis <- renderUI({fluidRow(column(12,
      "Responsibilities",
      br(), br(),
      "Have responsibilities and accountabilities laid out in the DfE guidance
      been assigned with sign-off process completed?",
      br(),
      "Have the following roles been allocated -",
      br(),
      "- a lead analyst",
      br(),
      "- a commissioner (or SRO)",
      br(),
      "- an analytical assurer"))})

#----DG7 QA Planning and Resourcing----
output$DG7dataanalysis <- renderUI({fluidRow(column(12,
      "QA Planning and Resourcing",
      br(), br(),
      "Has an appropriate QA plan been agreed with adequate consideration of
      resource quantity and skills required?",
      br(),
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
      "Record of QA",
      br(), br(),
      "Have all the checks and tests been recorded with evidence available to 
      review?",
      br(),
      "This log, along with linked evidence to actual QA activities, will 
      provide most of the evidence needed."))})

#----DG9 Risk and issues log
output$DG9dataanalysis <- renderUI({fluidRow(column(12,
      "This check is not required."))})

#----Structure and Clarity-----

#----SC1 Structure of model----
output$SC1analysis <- renderUI({fluidRow(column(12,
      "Structure of analysis",
      br(), br(),
      "Is the analysis set out in a clear way so that other analysts can follow 
      it systematically?",
      br(),
      "Does the main analysis file include a control section at the beginning,
      listing the version number, lead analyst, date of last edit and other
      important information?",
      br(),
      "Is the structure clear with obvious distinctions between inputs, 
      calculations and outputs?",
      br(),
      "Is the analysis structured as simply as it reasonably could be?",
      br(),
      "Does the file contain any data/structure/clutter which serves no apparent
      purpose?",
      br(),
      "Has coding/spreadsheet guidance been adhered to?"))})

#----SC2 Calculation structure----
output$SC2analysis <- renderUI({fluidRow(column(12,
      "This check is not required"))})

#----SC3 Variable names and units----
output$SC3analysis <- renderUI({fluidRow(column(12,
      "Variable names and units",
      br(), br(),
      "Are names, labels and units logical, appropriate and accurate?",
      br(),
      "Are user defined variables clearly indicated?",
      br(),
      "Are consistent and sensible naming conventions applied?",
      br(),
      "Is an index of names used avaliable?"))})

#----SC4 Analysis comments----
output$SC4analysis <- renderUI({fluidRow(column(12,
      "Analysis comments",
      br(), br(),
      "Is the analysis sufficiently and appropriately commented to follow the
      technical intention?",
      br(),
      "Are complex formulae sufficiently explained?",
      br(),
      "Are all the data sources explicitly documented in the code/spreadsheet?",
      br(),
      "Are there short descriptions of the content and logic of every step?"))})

#----SC5 Formula clarity and robustness----
output$SC5analysis <- renderUI({fluidRow(column(12,
      "Formula clarity and robustness",
      br(), br(),
      "Are the formulae easy to understand and designed to be easy to maintain
      and develop?",
      br(),
      "Is the code/spreadsheet free from hard coded values?",
      br(),
      "Are parameters uniquely defined?",
      br(),
      "Are complicated formuale broken down into manageable steps?",
      br(),
      "Do variable names and labels clearly identify data and assumptions?"))})

#----SC6 Accessibility----
output$SC6analysis <- renderUI({fluidRow(column(12,
      "This check is not required"))})

#----SC7 Caveats and footnotes----
output$SC7analysis <- renderUI({fluidRow(column(12,
      "This check is not required"))})

#----SC8 Output formatting----
output$SC8analysis <- renderUI({fluidRow(column(12,
      "This check is not required"))})

#----SC9 RAP----
output$SC9analysis <- renderUI({fluidRow(column(12,
      "This check is not required"))})