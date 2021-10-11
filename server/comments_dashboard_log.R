#----Documentation and governance

#----DG1 Scope and specification----
output$DG1dashboard <- renderUI({fluidRow(column(12,
    "Does a clear and comprehensive project scope and specification (including
    the data model design) exist with evidence of key stakeholder involvement
    and sign off? ",
    br(), br(),
    "This may take a number of different forms, e.g., separate scope and
    specification document(s), an exchange of emails or embedded into the
    dashboard itself.",
    br(),
    "See QA Guidance chapter 3.",
    br(),
    "For dashboards, scope and/or specification should cover whether suppression 
    rules will be required (e.g. senstive data will not be displayed to protect 
    individuals from being indentified)"))})

#----DG2 User guide----
output$DG2dashboard <- renderUI({fluidRow(column(12,
    "Is the user documentation sufficiently clear to support independent use of
    the dashboard for a user who needs to view outputs?",
    br(), br(),
    "Is a user guide embedded into the dashboard?",
    br(),
    "Is an introduction to the dashboard and individual reports included? Is
    there a short paragraph explaining the purpose of the dashboard/report?",
    br(),
    "Is a tutorial about how to use the dashboard included?",
    br(),
    "Does the dashboard include information about who to contact for 
    feedback/issues?"))})

#----DG3 Technical guide----
#Not required for this log

#----DG4 KIM----
output$DG4dashboard <- renderUI({fluidRow(column(12,
    "Has the dashboard been stored and/or published in the right area and do
    the correct users have permission to access it?",
    br(), br(),
    "Are files appropriately labelled? Has an appropriate rating been applied?",
    br(),
    "Who can access data files, outputs?",
    br(),
    "If data is being created by the dashboard is it being saved in an
    appropriate location?",
    br(),
    "When will it be archived?",
    br(),
    "Have you followed DfE best practice when publishing the dashboard?"))})

#----DG5 Version Control----
output$DG5dashboard <- renderUI({fluidRow(column(12,
    "Does an up to date and informative version control log exist?",
    br(), br(),
    "Version control log can be a separate document though it is recommended
    that it is embedded into the dashboard.",
    br(),
    "Use the version control standards for each major change. Use a naming
    convention that allows files to be sorted in chronological order and always
    include the version number in the filename.",
    br(),
    "v.0.1 for 1st draft copy, then 0.1 increments for reviewed amendments.",
    br(),
    "v1.0 for the signed-off copy (and 0.1 increments for minor change
    requests)."))})

#----DG6 Responsibilities----
output$DG6dashboard <- renderUI({fluidRow(column(12,
    "Have responsibilities and accountabilities laid out in the DfE guidance
    been assigned with sign-off process completed?",
    br(), br(),
    "Have the following roles been allocated:",
    br(),
    "- a lead data engineer",
    br(),
    "- a lead analyst",
    br(),
    "- an assurer",
    br(),
    "- a comissioner",
    br(),
    "- SRO",
    br(), br(),
    "If the dashboard requires regular maintance, such as data updates, has
    the role of update lead been assigned?"))})

#----DG7 QA Planning and Resourcing----
output$DG7dashboard <- renderUI({fluidRow(column(12,
    "Has an appropriate QA plan been agreed with adequate consideration of
    resource quantity and skills required?",
    br(), br(),
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
output$DG8dashboard <- renderUI({fluidRow(column(12,
    "Have all the checks and tests been recorded with evidence available to
    review?",
    br(), br(),
    "This log, along with linked evidence to actual QA activities will provide
    most of the evidence needed."))})