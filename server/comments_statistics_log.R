#----Documentation and governance----

#----DG1 Scope and specification----
output$DG1statistics <- renderUI({fluidRow(column(12,
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
    specification document(s), an exchange of emails or embedded into the
    analysis itself.",
    br(), br(),
    "See QA Guidance chapter 3"))})

#----DG2 User guide----

output$DG2statistics <- renderUI({fluidRow(column(12,
    "User guide",
    br(), br(),
    "Is the user documentation sufficiently clear to support independent use
    of the analysis for a new user who needs to run/operate the analysis and
    view outputs?",
    br(),
    "User guide could be a separate document or instructions within the
    analysis."))})

#----DG3 Technical guide----

output$DG3statistics <- renderUI({fluidRow(column(12,
    "Technical guide",
    br(), br(),
    "Is the technical documentation sufficiently clear to support independent
    maintenance and any future development of the analysis?",
    br(),
    "Any decisions taken on methodology and implementation should be recorded
    in the technical guide.",
    br(),
    "Technical guide could be a separate document or recorded within the
    analysis."))})

#----DG4 KIM----

output$DG4statistics <- renderUI({fluidRow(column(12,
    "KIM",
    br(), br(),
    "Is the analysis and documentation stored according to DfE and local
    protocols?",
    br(),
    "Are files appropriately labelled? Has an appropriate rating been applied?",
    br(),
    "Who can access data files, analysis, outputs?",
    br(),
    "When will the analysis be archived?",
    br(),
    "If BCM, has entry on register been updated?"))})

#----DG5 Version Control----

output$DG5statistics <- renderUI({fluidRow(column(12,
    "Version Control",
    br(), br(),
    "Does an up to date and informative version control log exist?",
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
    analysis."))})

#----DG6 Responsibilities----

output$DG6statistics <- renderUI({fluidRow(column(12,
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
    " - Finance Business Partner"))})

#----DG7 QA Planning and Resourcing----

output$DG7statistics <- renderUI({fluidRow(column(12,
    "QA Planning and Resourcing",
    br(), br(),
    "Has an appropriate QA plan been agreed with adequate consideration of
    resource quantity and skills required?",
    br(),
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
    "Record of QA",
    br(), br(),
    "Have all the checks and tests been recorded with evidence available to 
    review?",
    br(),
    "This log, along with linked evidence to actual QA activities will provide 
    most of the evidence needed.",
    br(),
    "Are all documents (as set out in the Scope/ specification / QA plan 
    avaliable for review and up to date (including risk / assumption / decision 
    logs)?"))})

#----DG9 Risk and Issues log----

output$DG9statistics <- renderUI({fluidRow(column(12,
    "Risk and Issues log",
    br(), br(),
    "Have risks and issues been identified, documented, agreed and reviewed?",
    br(),
    "Have appropriate mitigations been put into place?",
    br(),
    "Is there an appropriate governance process to review risks and issues?"))})

#----Structure and clarity----

#----SC1 Structure of analysis----
output$SC1statistics <- renderUI({fluidRow(column(12,
     "Structure of analysis",
     br(), br(),
     "Is the analysis set out in a clear way so that other analysts can follow
     it systematically?",
     br(),
     "Is a map of the analysis available?",
     br(),
     "Is the analysis contained within a single file?",
     br(),
     "Does the analysis include a control section at the beginning, listing the
     version number, analyst, date of last edit and other important information?",
     br(),
     "Is it possible to read the analysis systematically? (code top to bottom?
     excel along tabs, sheets left to right?)",
     br(),
     "Is the structure clear with clear distinctions between inputs, calculations
     and outputs?",
     br(),
     "Does the analysis produce enough intermediate outputs to allow policy
     scrutiny?",
     br(),
     "Is the analysis as simple as it reasonably could be?",
     br(),
     "Is the structure and layout consistent throughout?",
     br(),
     "Are the parts of the analysis currently not used or under development
     easily recognisable?",
     br(),
     "Does the analysis contain any data/structure/clutter which serves no
     apparent purpose?",
     br(),
     "Does the analysis adhere to relevant guidance?"))})

#----SC2 Calculation structure----
output$SC2statistics <- renderUI({fluidRow(column(12,
     "Calculation structure",
     br(),br(),
     "Are the calculations flows in the analysis set out logically and easy to
     follow?",
     br(),
     "Is the analysis layout clear (eg does it make use of white space, 
     indenting etc)?",
     br(),
     "Is there a clear distinction between importing data, carrying out 
     calculations and producing outputs?",
     br(),
     "Does each calculation step have a single purpose?",
     br(),
     "Are the steps carried out in a logical sequential order?",
     br(),
     "Are the formulae adaptable to structural change in the analysis?",
     br(),
     "Is the analysis free from anomalous calculations?",
     br(),
     "Are parameters clearly defined and hard coding avoided?",
     br(),
     "Where the analysis relies on code:",
     br(),
     "- is a consistent coding convention used?",
     br(),
     "- are variables uniquely defined?",
     br(),
     "- is appropriate error handling built in?"))})

#----SC3 Variable names and units----
output$SC3statistics <- renderUI({fluidRow(column(12,
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

#----SC4 Analysis comments----
output$SC4statistics <- renderUI({fluidRow(column(12,
     "Analysis comments",
     br(),br(),
     " Is the analysis sufficiently and appropriately commented to follow the
     technical intention?",
     br(),
     "Are complex formulae sufficiently explained?",
     br(),
     "Are all the data sources explicitly documented in the analysis?",
     br(),
     "Are there short descriptions of the content and logic of every step?",
     br(),
     "Spreadsheet analysis only - if formulae are removed to preserve
     processing time, is this made clear? Can they be reinstated without 
     introducing error."))})

#----SC5 Formula clarity and robustness----
output$SC5statistics <- renderUI({fluidRow(column(12,
     "Formula clarity and robustness",
     br(), br(),
     "Are the formulae easy to understand and designed to be easy to maintain
     and develop?",
     br(),
     "Is the analysis free from hard coded values?",
     br(),
     "Are parameters uniquely defined?",
     br(),
     "Are complicated formuale broken down into manageable steps?",
     br(),
     "Do variable names and labels clearly identify data and assumptions?"))})

#----SC6 Accessibility----
output$SC6statistics <- renderUI({fluidRow(column(12,
     "This check is not required."))})

#----SC7 Caveats and footnotes----
output$SC7statistics <- renderUI({fluidRow(column(12,
     "Caveats and footnotes",
     br(), br(),
     "Have all relevant details been checked?",
     br(),
     "Are breaks in time series clearly identified and explained?",
     br(),
     "Have the footnotes have been used appropriately including numbering,
     links and references to methodology document?",
     br(),
     "Are the titles and headers are clearly explained?",
     br(),
     "Has the data been correctly sourced?"))})

#----SC8 Output formatting----
output$SC8statistics <- renderUI({fluidRow(column(12,
     "Output formatting",
     br(), br(),
     "Have relevant links, dates and formatting been checked? 
     Has the text been reviewed for grammar and spelling?"))})

#----SC9 RAP----
output$SC9statistics <- renderUI({fluidRow(column(12,
     "RAP",
     br(), br(),
     "Could R Markdown be used at this stage? Could further RAP or automated
     processes be implemented?"))})

#----Verification----

#----VE1 Formula and code correctness----
output$VE1statistics <- renderUI({fluidRow(column(12,
      "Formula and code correctness",
      br(), br(),
      "Have you checked that all the formulae and code have been implemented
      correctly?",
      br(),
      "Do all formulae refer to the right inputs/variables/parameters?",
      br(),
      "Have you identified riskiest sections of the calculations and applied
      particular scrutiny?",
      br(),
      "Can an independent analyst track back and reproduce parts of the
      calculations off analysis?",
      br(),
      "Is the data being pulled into the calculation modules correctly?",
      br(),
      "Do numbers apply to the correct time period (e.g. the middle of the
      month/year versus the beginning/end)? Is it consistent throughout the
      analysis? Are financial year and calendar year data managed correctly?
      Are discount rates (nominal/real) applied correctly?",
      br(),
      "Consider use of Adam Slim tool for spreadsheets."))})

#----VE2 Usability testing----
output$VE2statistics <- renderUI({fluidRow(column(12,
      "Usability testing",
      br(), br(),
      "Can a new user easily operate the analysis and view outputs?",
      br(),
      "Is routine operation of the analysis smooth and free of bugs? If
      relevant, is there an appropriate user interface? Does it work correctly?",
      br(),
      "Does the analysis open in an acceptable amount of time? Is the runtime
      of the analysis appropriate for the demand placed on the analysis and the
      complexity of what is being analysed?",
      br(),
      "Is there a smooth and secure procedure to allow access to the software
      to the users or the people who need to QA the analysis? Is the time
      needed to provide the access to a new user appropriate?",
      br(),
      "Have the appropriate control been put in place to avoid invalid
      data/entries (e.g. not sensible inputs)?",
      br(),
      "Is the system able to provide and maintain an acceptable level of
      service in the face of faults and challenges to normal operation? What is
      the impact of faults and challenges to normal operations?"))})

#----VE3 Autochecks----
output$VE3statistics <- renderUI({fluidRow(column(12,
      "Autochecks",
      br(), br(),
      "Are autochecks used to highlight correct functionality (e.g. some lines
      of codes checking that the inputs are sensible), and are they implemented
      correctly?"))})

#----VE4 Regression testing----
output$VE4statistics <- renderUI({fluidRow(column(12,
      "This check is not required."))})

#----VE5 Use of analytical outputs----
output$VE5statistics <- renderUI({fluidRow(column(12,
      "Use of analytical outputs",
      br(), br(),
      "Are analytical outputs being correctly fed into dependent documents?",
      br(),
      "Have you compared outputs to previous versions? Can you explain changes?
      Check outputs are correctly copied/transcribed into any dependent
      documents."))})

#----VE6 Visual correctness----
output$VE6statistics <- renderUI({fluidRow(column(12,
      "Visual correctness",
      br(), br(),
      "Do figures in the text and charts correspond to figures in the tables
      and do charts have appropriate headings, footnotes and labels?"))})

#----Validation----

#----VA1 Methodology correctness----
output$VA1statistics <- renderUI({fluidRow(column(12,
      "Methodology correctness",
      br(), br(),
      "Is the methodology used sensible and fit for purpose? (with \"purpose\" 
      defined in the analysis specification)",
      br(),
      "Was the analysis methodology reviewed and agreed with relevant
      stakeholders?",
      br(),
      "Has the selected methodology been tested with other experts (eg other
      DfE analysts or external experts if appropriate?)",
      br(),
      "Does the analysis produce logical outputs?",
      br(),
      "- are outputs changes of the right direction and magnitude for relevant 
      input changes?",
      br(),
      "- consider testing sparklines / trends for time series",
      br(),
      "- can changes from previous versions be explained?",
      br(),
      "Have analysis outputs been sense / reality checked and agreed with
      relevant stakeholders?",
      br(),
      "Have appropriate analysis walk-throughs been carried out?"))})

#----VA2 Comparison with historical data/backcasting/alternative models----
output$VA2statistics <- renderUI({fluidRow(column(12,
      "Comparison with historical data/backcasting/alternative models",
      br(), br(),
      "Does the analysis match historical results when using historical input
      data, or match an alternative analysis, to within an agreed tolerance 
      level?",
      br(),
      "There may be no historical/alternative analysiss, in which case score 
      as N/A."))})

#----VA3 Uncertainty testing----
output$VA3statistics <- renderUI({fluidRow(column(12,
      "This check is not required."))})

#----VA4 Extreme values testing/analysis breaking----
output$VA4statistics <- renderUI({fluidRow(column(12,
      "Extreme values testing/analysis breaking",
      br(), br(),
      "Does the analysis respond as expected to extreme values, zeroes,
      negative values, critical limits?",
      br(),
      "Is it possible to 'break' the analysis or get implausible outcomes (e.g.
      percentages adding to more than 100%, people adding up to more than the
      population...)?",
      br(),
      "Use sparklines / trends to explore time series.",
      br(),
      "Test direction and magnitude for outputs in response to input change."))})

#----VA5 Re-performance testing----
output$VA5statistics <- renderUI({fluidRow(column(12,
      "Re-performance testing",
      br(), br(),
      "Can you replicate analytical output by independently (e.g. offline)
      re-performing key calculations on sections of the analysis?"))})

#----Data and assumptions----

#----DA1 Data----
output$DA1statistics <- renderUI({fluidRow(column(12,
      "Data",
      br(), br(),
      "Does your assumptions log contain details of all analysis data?",
      br(),
      "Has key data been identified and prioritised?",
      br(),
      "Has appropriate data been used?",
      br(),
      "Are the quality, characteristics, strengths and limitations of the data 
      set fully understood and recorded?",
      br(),
      "Have data quality, impact and risk been assessed?",
      br(),
      "Have data inputs been agreed with relevant stakeholders and signed-off?
      Are all data up-to-date?",
      br(),
      "Have relevant decisions taken about the data been recorded?"))})

#----DA2 Data transformation----
output$DA2statistics <- renderUI({fluidRow(column(12,
      "Data transformation",
      br(), br(),
      "Has input data been checked against primary reference for potential
      errors in copying / pasting / transforming?",
      br(),
      "If required, have details on how the data have been imported/transformed
      or processed been recorded in the Assumptions Log?",
      br(),
      "Have sources of data been documented in the Assumptions Log?"))})

#----DA3 Assumptions----
output$DA3statistics <- renderUI({fluidRow(column(12,
      "Assumptions",
      br(), br(),
      "Does your assumptions log contain details of all analysis assumptions?",
      br(),
      "Have key assumptions been identified and prioritised?",
      br(),
      "Are assumptions appropriate, applicable and logically coherent?",
      br(),
      "Are any limitations/caveats adequately described in the Assumptions log?",
      br(),
      "Have data quality, impact and risk been assessed?",
      br(),
      "Have assumptions been agreed with relevant stakeholders and signed-off?
      Are assumptions up-to-date?",
      br(),
      "Have relevant decisions taken about the assumptions been recorded?"))})

#----DA4 Decisions----
output$DA4statistics <- renderUI({fluidRow(column(12,
      "This check is not required."))})