#----Documentation and governance----

#----DG1 Scope and specification----
output$DG1modelling <- renderUI({fluidRow(column(12,
    "Scope and specification",
    br(), br(),
    "Does a clear and comprehensive project scope and specification exist with
    evidence of key stakeholder involvement and sign off?",
    br(),
    "Has the information in the scope template been identified?",
    br(),
    "Have all relevant stakeholders been identified and their requirements
    collected?",
    br(),
    "Has the methodology selection been documented and subject to appropriate
    scrutiny?",
    br(),
    "This may take a number of different forms, eg separate scope and
    specification document(s), an exchange of emails or embedded into the model
    itself.",
    br(),br(),
    "See QA Guidance chapter 3."))})

#----DG2 User guide----
output$DG2modelling <- renderUI({fluidRow(column(12,
    "User guide",
    br(), br(),
    "Is the user documentation sufficiently clear to support independent use of
    the model for a new model user who needs to run/operate the model and view
    outputs?",
    br(),
    "User guide could be a separate document or intstructions within the
    model."))})

#----DG3 Technical guide----
output$DG3modelling <- renderUI({fluidRow(column(12,
    "Technical guide",
    br(), br(),
    "Is the technical documentation sufficiently clear to support independent
    maintenance and any future development of the model?",
    br(),
    "Any decisions taken on methodology and implementation should be recorded
    in the technical guide.",
    br(),
    "Technical guide could be a separate document or recorded within the
    model."))})

#----DG4 KIM----
output$DG4modelling <- renderUI({fluidRow(column(12,
    "KIM",
    br(), br(),
    "Is the model and documentation stored according to DfE and local
    protocols?",
    br(),
    "Are files appropriately labelled? Has an appropriate rating been applied?",
    br(),
    "Who can access data files, models, outputs?",
    br(),
    "When will the model be archived?",
    br(),
    "If BCM, has entry on register been updated?"))})

#----DG5 Version Control----
output$DG5modelling <- renderUI({fluidRow(column(12,
    "Version Control",
    br(), br(),
    "Does an up to date and information version control log exist?",
    br(),
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
    model."))})

#----DG6 Responsibilities----
output$DG6modelling <- renderUI({fluidRow(column(12,
    "Responsibilities",
    br(), br(),
    "Have responsibilities and accountabilities laid out in the DfE guidance 
    been assigned with sign-off process completed?",
    br(),
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
    "- Finance Business Partner"))})

#----DG7 QA Planning and Resourcing----
output$DG7modelling <- renderUI({fluidRow(column(12,
    "QA Planning and Resourcing",
    br(), br(),
    "Has an appropriate QA plan been agreed with adequate consideration of
    resource quantity and skills required?",
    br(),
    "Has this been agreed between analyst, analytical assurer and
    commissioner/model SRO?",
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
output$DG8modelling <- renderUI({fluidRow(column(12,
    "Record of QA",
    br(), br(),
    "Have all the checks and tests been recorded with evidence available to
    review?",
    br(), br(),
    "This log, along with linked evidence to actual QA activities, will provide 
    most of the evidence needed.",
    br(),
    "Are all documents (as set out in the Scope/ specification / QA plan 
    avaliable for review and up to date (including risk / assumption / decision 
    logs)?"))})

#----DG9 Risk and issues log-----
output$DG9modelling <- renderUI({fluidRow(column(12,
    "This check is not required."))})

#----Structure and clarity----

#----SC1 Structure of model----
output$SC1modelling <- renderUI({fluidRow(column(12,
    "Structure of model",
    br(), br(),
    "Is the model set out in a clear way so that other analysts can follow it
    systematically? ",
    br(),
    "Is a map of the model available?",
    br(),
    "Is the model contained within a single file?",
    br(),
    "Does the model include a control section at the beginning, listing the
    version number, model builder, date of last edit and other important
    information?",
    br(),
    "Is it possible to read the Model systematically? (code top to bottom? 
    excel along tabs, sheets left to right?)",
    br(),
    "Is the structure clear with clear distinctions between inputs, 
    calculations and outputs?",
    br(),
    "Does the model produce enough intermediate outputs to allow policy
    scrutiny?",
    br(),
    "Is the model as simple as it reasonably could be?",
    br(),
    "Is the structure and layout consistent throughout?",
    br(),
    "Are the parts of the models currently not used or under development easily
    recognisable?",
    br(),
    "Does the model contain any data/structure/clutter which serves no apparent 
    purpose?",
    br(),
    "Does the model adhere to relevant guidance?"))})

#----SC2 Calculation structure----
output$SC2modelling <- renderUI({fluidRow(column(12,
    "Calculation structure",
    br(), br(),
    "Are the calculations flows in the model set out logically and easy to
    follow?",
    br(),
    "Is the model layout clear (eg does it make use of white space, indenting
    etc)?",
    br(),
    "Is there a clear distinction between importing data, carrying out 
    calculations and producing outputs?",
    br(),
    "Does each calculation step have a single purpose?",
    br(),
    "Are the steps carried out in a logical sequential order?",
    br(),
    "Are the formulae adaptable to structural change in the model?",
    br(),
    "Is the model free from anomalous calculations?",
    br(),
    "Are parameters clearly defined and hard coding avoided?",
    br(),
    "Where the model relies on code:",
    br(),
    "- is a consistent coding convention used?",
    br(),
    "- are variables uniquely defined?",
    br(),
    "- is appropriate error handling built in?",))})

#----SC3 Variable names and units----
output$SC3modelling <- renderUI({fluidRow(column(12,
    "Variable names and units",
    br(), br(),
    "Are names, labels and units logical, appropriate and accurate?",
    br(),
    "Consider how rounding is applied. Are rounded and unrounded numbers used
    in appropriate places? In particular, avoid using rounded numbers in 
    intermediate calculations unless specifically required.",
    br(),
    "Are user defined variables clearly indicated?",
    br(),
    "Are consistent naming conventions applied?",
    br(),
    "Is an index of names used avaliable?"))})

#----SC4 Model comments----
output$SC4modelling <- renderUI({fluidRow(column(12,
    "Model comments",
    br(), br(),
    "Is the model sufficiently and appropriately commented to follow the 
    technical intention?",
    br(),
    "Are complex formulae sufficiently explained?",
    br(),
    "Are all the data sources explicitly documented in the model?",
    br(),
    "Are there short descriptions of the content and logic of every step?",
    br(),
    "Spreadsheet models only - if formulae are removed to preserve processing 
    time, is this made clear? Can they be reinstated without introducing 
    error."))})

#----SC5 Formula clarity and robustness----
output$SC5modelling <- renderUI({fluidRow(column(12,
    "Formula clarity and robustness",
    br(), br(),
    "Are the formulae easy to understand and designed to be easy to maintain
    and develop?",
    br(),
    "Is the model free from hard coded values?",
    br(),
    "Are parameters uniquely defined?",
    br(),
    "Are complicated formuale broken down into maangeable steps?",
    br(),
    "Do variable names and labels clearly identify data and assumptions?"))})

#----SC6 Accessibility----
output$SC6modelling <- renderUI({fluidRow(column(12,
    "This check is not required."))})

#----SC7 Caveats and footnotes----
output$SC7modelling <- renderUI({fluidRow(column(12,
    "This check is not required."))})

#----SC8 Output formatting----
output$SC8modelling <- renderUI({fluidRow(column(12,
    "This check is not required."))})

#----SC9 RAP----
output$SC9modelling <- renderUI({fluidRow(column(12,
    "This check is not required."))})