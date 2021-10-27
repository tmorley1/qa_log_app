#----Documentation and governance

#----DG1 Scope and specification----
DG1dataanalysis <- renderUI({fluidRow(column(12,
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
DG2dataanalysis <- renderUI({fluidRow(column(12,
      "User guide",
      br(), br(),
      "Is the user documentation sufficiently clear to support independent use 
      of the analysis for a new user who needs to run/operate the analysis and 
      view outputs?"))})

#----DG3 Technical guide----
DG3dataanalysis <- renderUI({fluidRow(column(12,
      "This check is not required."))})

#----DG4 KIM----
DG4dataanalysis <- renderUI({fluidRow(column(12,
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
DG5dataanalysis <- renderUI({fluidRow(column(12,
      "Version Control",
      br(), br(),
      "Does an up to date and informative version control log exist?",
      br(),
      "Version control log can be a separate document or embedded in the
      code/spreadsheet."))})

#----DG6 Responsibilities----
DG6dataanalysis <- renderUI({fluidRow(column(12,
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
DG7dataanalysis <- renderUI({fluidRow(column(12,
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
DG8dataanalysis <- renderUI({fluidRow(column(12,
      "Record of QA",
      br(), br(),
      "Have all the checks and tests been recorded with evidence available to 
      review?",
      br(),
      "This log, along with linked evidence to actual QA activities, will 
      provide most of the evidence needed."))})

#----DG9 Risk and issues log
DG9dataanalysis <- renderUI({fluidRow(column(12,
      "This check is not required."))})

#----Structure and Clarity-----

#----SC1 Structure of model----
SC1analysis <- renderUI({fluidRow(column(12,
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
SC2analysis <- renderUI({fluidRow(column(12,
      "This check is not required"))})

#----SC3 Variable names and units----
SC3analysis <- renderUI({fluidRow(column(12,
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
SC4analysis <- renderUI({fluidRow(column(12,
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
SC5analysis <- renderUI({fluidRow(column(12,
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
SC6analysis <- renderUI({fluidRow(column(12,
      "This check is not required"))})

#----SC7 Caveats and footnotes----
SC7analysis <- renderUI({fluidRow(column(12,
      "This check is not required"))})

#----SC8 Output formatting----
SC8analysis <- renderUI({fluidRow(column(12,
      "This check is not required"))})

#----SC9 RAP----
SC9analysis <- renderUI({fluidRow(column(12,
      "This check is not required"))})

#----Verification----

#----VE1 Formula and code correctness----
VE1analysis <- renderUI({fluidRow(column(12,
      "Formula and code correctness",
      br(), br(),
      "Have you checked that all the formulae and code have been implemented
      correctly? Use spreadsheet/code QA tab for detailed checks"))})

#----VE2 Usability testing----
VE2analysis <- renderUI({fluidRow(column(12,
      "Usability testing",
      br(), br(),
      "Can a new user easily re-run the analysis and view outputs?"))})

#----VE3 Autochecks----
VE3analysis <- renderUI({fluidRow(column(12,
      "Autochecks",
      br(), br(),
      "Are autochecks used to highlight correct functionality (e.g. some lines
      of codes checking that the inputs are sensible), and are they implemented
      correctly?"))})

#----VE4 Regression testing----
VE4analysis <- renderUI({fluidRow(column(12,
      "This check is not required."))})

#----VE5 Use of model outputs----
VE5analysis <- renderUI({fluidRow(column(12,
      "This check is not required."))})

#----VE6 Visual correctness----
VE6analysis <- renderUI({fluidRow(column(12,
      "This check is not required."))})

#----Validation----

#----VA1 Methodology correctness----
VA1analysis <- renderUI({fluidRow(column(12,
      "Methodology correctness",
      br(), br(),
      "Is the methodology used sensible and fit for purpose?",
      br(),
      "Was the methodology reviewed and agreed with relevant stakeholders?",
      br(),
      "Has the selected methodology been tested with other experts (eg other
      DfE analysts or external experts if appropriate?)",
      br(),
      "Have model outputs been sense / reality checked and agreed with relevant
      stakeholders?"))})

#----VA2 Comparison with historical data/backcasting----
VA2analysis <- renderUI({fluidRow(column(12,
      "Comparison with historical data/backcasting",
      br(), br(),
      "Do the outputs match historical results when using historical input data,
      or match alternative analysis, to within an agreed tolerance level?",
      br(),
      "There may be no historical/alternative models, in which case score as
      N/A."))})

#----VA3 Uncertainty testing----
VA3analysis <- renderUI({fluidRow(column(12,
      "Uncertainty testing",
      br(), br(),
      "Has enough been done to understand the uncertainty inherent in the data,
      assumptions and methodology of the analysis?",
      br(),
      "Has data (especially poor quality data) been addressed via sensitivity
      testing and/or Monte Carlo analysis, and the results documented?",
      br(),
      "Has sensitivity analysis been used to find out the most significant
      inputs and assumptions?",
      br(),
      "If the analysis just perform standards calculations and there is no
      uncertainty mark the task as N/A"))})

#----VA4 Extreme values testing/model breaking----
VA4analysis <- renderUI({fluidRow(column(12,
      "This check is not required."))})

#----VA5 Re-performance testing----
VA5analysis <- renderUI({fluidRow(column(12,
      "This check is not required."))})

#----Data and assumptions----

#----DA1 Data----
DA1analysis <- renderUI({fluidRow(column(12,
      "Data",
      br(), br(),
      "Does your data log contain details of all data used in the analysis?"))})

#----DA2 Data transformation----
DA2analysis <- renderUI({fluidRow(column(12,
      "Data transformation",
      br(), br(),
      "Has input data been checked against primary reference for potential
      errors in copying / pasting / transforming?"))})

#----DA3 Assumptions----
DA3analysis <- renderUI({fluidRow(column(12,
      "Assumptions",
      br(), br(),
      "Does your assumptions log contain details of all analytical assumptions?"))})

#----DA4 Decisions----
DA4analysis <- renderUI({fluidRow(column(12,
      "This check is not required."))})