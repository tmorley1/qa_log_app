#----Documentation and governance----

#----DG1 Scope and specification----
output$DG1dashboard <- renderUI({fluidRow(column(12,
    "Scope and specification",
    br(), br(),
    "Does a clear and comprehensive project scope and specification (including
    the data model design) exist with evidence of key stakeholder involvement
    and sign off? ",
    br(),
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
    "User guide",
    br(), br(),
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
output$DG3dashboard <- renderUI({fluidRow(column(12,
    "This check is not required."))})

#----DG4 KIM----
output$DG4dashboard <- renderUI({fluidRow(column(12,
    "KIM",
    br(), br(),
    "Has the dashboard been stored and/or published in the right area and do
    the correct users have permission to access it?",
    br(),
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
    "Version Control",
    br(), br(),
    "Does an up to date and informative version control log exist?",
    br(),
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
    "Responsibilities",
    br(), br(),
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
output$DG8dashboard <- renderUI({fluidRow(column(12,
    "Record of QA",
    br(), br(),
    "Have all the checks and tests been recorded with evidence available to
    review?",
    br(),
    "This log, along with linked evidence to actual QA activities will provide
    most of the evidence needed."))})

#----DG9 Risk and issues log----
output$DG9dashboard <- renderUI({fluidRow(column(12,
    "This check is not required."))})

#----Structure and clarity----

#----SC1 Structure of data model----
output$SC1dashboard <- renderUI({fluidRow(column(12,
    "Structure of data model",
    br(), br(),
    "Is the data model underpinning the dashboard set out in a clear way so 
    that other analysts can follow it systematically?",
    br(),
    "This check focuses on the structure of the data model underpinning the 
    dashboard. In some cases a QA log may have already been completed for the 
    data model itself. In these cases please duplicate the rating given for 
    this check in that QA log. If additional alterations have been made to the 
    data model in the dashboard itself, please consider these alterations in 
    the overall rating.",
    br(),
    "Does the main analysis file include a control section at the beginning, 
    listing the version number, lead analyst, date of last edit and other 
    important information?",
    br(),
    "Is the structure of the data model clear with obvious distinctions between 
    inputs, calculations and outputs?",
    br(),
    "Is the analysis structured as simply as it reasonably could be?",
    br(),
    "Do any of the files used to create the data model contain any 
    data/structure/clutter which serves no apparent purpose?",
    br(),
    "Has coding/spreadsheet guidance been adhered to?"))})

#----SC2 Dashboard structure----
output$SC2dashboard <- renderUI({fluidRow(column(12,
    "Dashboard structure",
    br(), br(),
    "Is the dashboard structured in a clear to understand manner? Are the number
    of sheets appropriate? Is the drill down capability clearly defined?",
    br(),
    "Does the structure of the dashboard match how customers want to see the 
    report?",
    br(),
    "Are the main/major areas that people are interested to see in report?",
    br(),
    "If desired, are the most important visuals given up-front as part of a
    summary?",
    br(),
    "Are an apropriate amount of sheets being used? Are there any unused sheets?",
    br(),
    "Do you need to include navigation options on your dashboard to drill down, 
    drill through or filter the information?",
    br(),
    "Have you included search options in filters where possible?",
    br(),
    "Have you included tooltips on visuals to provide more contextual
    information where appropriate?",
    br(),
    "Have the recommedations of the department's dashboard standard and style
    guide been incorporated?"))})

#----SC3 Variable names and units----
output$SC3dashboard <- renderUI({fluidRow(column(12,
     "Variable names and units",
     br(), br(),
     "Are names, labels and units logical, appropriate and accurate?",
     br(),
     "Are user defined measures clearly indicated?",
     br(),
     "Are consistent and sensible naming conventions applied?",
     br(),
     "Is an index of names used avaliable?",
     br(),
     "Are measure units correct? If measure units have been converted, has the 
     conversion been performed correctly?",
     br(),
     "Are there any instances of unnecessary precision? Are the correct amount 
     of significant figures being displayed?",
     br(),
     "Do measure names and labels clearly identify data and assumptions?"))})

#----SC4 Analysis comments----
output$SC4dashboard <- renderUI({fluidRow(column(12,
     "This check is not required."))})

#----SC5 Formula clarity and robustness----
output$SC5dashboard <- renderUI({fluidRow(column(12,
     "Formula clarity and robustness",
     br(), br(),
     "Are the formulae used in the dashboard and data model easy to understand
     and designed to be easy to maintain and develop?",
     br(),
     "Are formulas free from hard coded values?",
     br(),
     "Are parameters uniquely defined?",
     br(),
     "Are complicated formulae broken down into manageable steps?",
     br(),
     "Have comments been used to explain complicated formulas? You can add
     comments in measures in dax code using a // as long as its not followed by
     a blank line.",
     br(),
     "Example: Measure=SUM([Amount])",
     br(),
     "             //This comment will be maintained because the next line is
     not blank",
     br(),
     "0"))})

#----SC6 Accessibility----
output$SC6dashboard <- renderUI({fluidRow(column(12,
     "Accessibility",
     br(), br(),
     "Does the dashboard follow the department's accessibility guidelines?",
     br(),
     "Is the dashboard simple and easy to understand? Consider using multiple
     visuals if they show different facets of the data but simultaneously try
     avoid cluttering pages with too many visuals.",
     br(),
     "Does the dashboard use DfE accepted colours? Is the contrast ratio between
     visuals and background colours sufficient (at least 4.5:1)?",
     br(),
     "Have you used distinct colours and marker shapes when plotting multiple
     data series on the same graph?",
     br(),
     "Do visuals make use of titles and alt text so they are compatible with
     screen readers?",
     br(),
     "Does the dashboard use terminology and a complexity of visuals that on
     par with the customer's knowledge level? Have you tried to avoid using
     acronyms and technical jargon that may be confusing to users?",
     br(),
     "Are titles, axis labels, legend values, and data labels easy to read and 
     understand? Have you avoided using acronyms or jargon in titles and labels?",
     br(),
     "Have you set a tab order in PowerBI so keyboard only users can navigate
     the dashboard?"))})

#----SC7 Caveats and footnotes----
output$SC7dashboard <- renderUI({fluidRow(column(12,
     "This check is not required."))})

#----SC8 Output formatting----
output$SC8dashboard <- renderUI({fluidRow(column(12,
      "This check is not required."))})

#----SC9 RAP----
output$SC9dashboard <- renderUI({fluidRow(column(12,
      "This check is not required."))})