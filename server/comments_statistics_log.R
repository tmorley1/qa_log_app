#----Documentation and governance

#----DG1 Scope and specification----
output$DG1statistics <- renderUI({fluidRow(column(12,
    "Does a clear and comprehensive project scope and specification exist with
    evidence of key stakeholder involvement and sign off?",
    br(), br(),
    "Has the information in the scope template been identified?",
    br(),
    "Have all relevant stakeholders been identified and their requirements
    collected?",
    br(),
    "Has the methodology selection been documented and subject to appropriate
    scrutiny?",
    br(),
    "This may take a number of different forms, eg separate scope and
    specification document(s), an exchange of emails or embedded into the
    analysis itself.",
    br(), br(),
    "See QA Guidance chapter 3"))})

#----DG2 User guide----

output$DG2statistics <- renderUI({fluidRow(column(12,
    "Is the user documentation sufficiently clear to support independent use
    of the analysis for a new user who needs to run/operate the analysis and
    view outputs?",
    br(), br(),
    "User guide could be a separate document or instructions within the
    analysis."))})

#----DG3 Technical guide----

output$DG3statistics <- renderUI({fluidRow(column(12,
    "Is the technical documentation sufficiently clear to support independent
    maintenance and any future development of the analysis?",
    br(), br(),
    "Any decisions taken on methodology and implementation should be recorded
    in the technical guide.",
    br(),
    "Technical guide could be a separate document or recorded within the
    analysis."))})

#----DG4 KIM----

output$DG4statistics <- renderUI({fluidRow(column(12,
    "Is the analysis and documentation stored according to DfE and local
    protocols?",
    br(), br(),
    "Are files appropriately labelled? Has an appropriate rating been applied?",
    br(),
    "Who can access data files, analysis, outputs?",
    br(),
    "When will the analysis be archived?",
    br(),
    "If BCM, has entry on register been updated?"))})

#----DG5 Version Control----

output$DG5statistics <- renderUI({fluidRow(column(12,
    "Does an up to date and informative version control log exist?",
    br(), br(),
    "Is it clear what is the current working version?",
    br(),
    "Is it clear what has been changed since the previous version, who has made 
    the changes and whether it has been checked?",
    br(),
    "Is the version labelling consistent?",
    br(),
    "Is it clear what version was used to produce particular output?",
    br(), br(),
    "NB Version control log can be a separate document or embedded in the 
    analysis."))})

#----DG6 Responsibilities----

output$DG6statistics <- renderUI({fluidRow(column(12,
    "Have responsibilities and accountabilities laid out in the DfE guidance
    been assigned with sign-off process completed?",
    br(), br(),
    "Have the following roles been allocated - ",
    br(),
    "- a lead analyst",
    br(),
    "- an SRO",
    br(),
    "- an analytical assurer",
    br(),
    "- a comissioner (if different to SRO)",
    br(),
    " - Finance Business Partner"))})

#----DG7 QA Planning and Resourcing----

output$DG7statistics <- renderUI({fluidRow(column(12,
    "Has an appropriate QA plan been agreed with adequate consideration of
    resource quantity and skills required?",
    br(), br(),
    "Has this been agreed between analyst, analytical assurer and
    commissioner/analysis SRO?",
    br(),
    "Have recommendations from previous QA exercises been implemented (if
    applicable)?",
    br(),
    "Is there a clear list of QA tasks that must be completed to provide
    sufficient assurance before delivery of output?",
    br(),
    "Is the planned governance adequate with appropriate levels of
    sign-off?"))})

#----DG8 Record of QA----

output$DG8statistics <- renderUI({fluidRow(column(12,
    "Have all the checks and tests been recorded with evidence available to 
    review?",
    br(), br(),
    "This log, along with linked evidence to actual QA activities will provide 
    most of the evidence needed.",
    br(),
    "Are all documents (as set out in the Scope/ specification / QA plan 
    avaliable for review and up to date (including risk / assumption / decision 
    logs)?"))})

#----DG9 Risk and Issues log----

output$DG9statistics <- renderUI({fluidRow(column(12,
    "Have risks and issues been identified, documented, agreed and reviewed?",
    br(), br(),
    "Have appropriate mitigations been put into place?",
    br(),
    "Is there an appropriate governance process to review risks and issues?"))})

#----Structure and clarity----

#----SC1 Structure of analysis----
output$SC1statistics <- renderUI({fluidRow(column(12,
                                                "Note"))})

#----SC2 Calculation structure----
output$SC2statistics <- renderUI({fluidRow(column(12,
                                                  "Note"))})

#----SC3 Variable names and units----
output$SC3statistics <- renderUI({fluidRow(column(12,
                                                  "Note"))})

#----SC4 Analysis comments----
output$SC4statistics <- renderUI({fluidRow(column(12,
                                                  "Note"))})

#----SC5 Formula clarity and robustness----
output$SC5statistics <- renderUI({fluidRow(column(12,
                                                  "Note"))})

#----SC6 Accessibility----
output$SC6statistics <- renderUI({fluidRow(column(12,
                                                  "This check is not required."))})

#----SC7 Caveats and footnotes----
output$SC7statistics <- renderUI({fluidRow(column(12,
                                                  "Note"))})

#----SC8 Output formatting----
output$SC8statistics <- renderUI({fluidRow(column(12,
                                                  "Note"))})

#----SC9 RAP----
output$SC9statistics <- renderUI({fluidRow(column(12,
                                                  "Note"))})