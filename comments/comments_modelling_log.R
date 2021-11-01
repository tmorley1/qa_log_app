#----Documentation and governance----

#----DG1 Scope and specification----
DG1modelling <- renderUI({fixedRow(column(12,
    span("Mandatory check", style="color:red"),
    br(),
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
DG2modelling <- renderUI({fixedRow(column(12,
    "User guide",
    br(), br(),
    "Is the user documentation sufficiently clear to support independent use of
    the model for a new model user who needs to run/operate the model and view
    outputs?",
    br(),
    "User guide could be a separate document or intstructions within the
    model."))})

#----DG3 Technical guide----
DG3modelling <- renderUI({fixedRow(column(12,
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
DG4modelling <- renderUI({fixedRow(column(12,
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
DG5modelling <- renderUI({fixedRow(column(12,
    span("Mandatory check", style="color:red"),
    br(),
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
DG6modelling <- renderUI({fixedRow(column(12,
    span("Mandatory check", style="color:red"),
    br(),
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
DG7modelling <- renderUI({fixedRow(column(12,
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
DG8modelling <- renderUI({fixedRow(column(12,
    span("Mandatory check", style="color:red"),
    br(),
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
DG9modelling <- renderUI({fixedRow(column(12,
    "This check is not required."))})

#----Structure and clarity----

#----SC1 Structure of model----
SC1modelling <- renderUI({fixedRow(column(12,
    span("Mandatory check", style="color:red"),
    br(),
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
SC2modelling <- renderUI({fixedRow(column(12,
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
SC3modelling <- renderUI({fixedRow(column(12,
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
SC4modelling <- renderUI({fixedRow(column(12,
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
SC5modelling <- renderUI({fixedRow(column(12,
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
SC6modelling <- renderUI({fixedRow(column(12,
    "This check is not required."))})

#----SC7 Caveats and footnotes----
SC7modelling <- renderUI({fixedRow(column(12,
    "This check is not required."))})

#----SC8 Output formatting----
SC8modelling <- renderUI({fixedRow(column(12,
    "This check is not required."))})

#----SC9 RAP----
SC9modelling <- renderUI({fixedRow(column(12,
    "This check is not required."))})
#----Verification----

#----VE1 Formula and code correctness----
VE1modelling <- renderUI({fixedRow(column(12,
    span("Mandatory check", style="color:red"),
    br(),
    "Formula and code correctness",
    br(),br(),
    "Have you checked that all the formulae and code have been implemented correctly?",
    br(),
    "Do all formulae refer to the right inputs/variables/parameters?",
    br(),
    "Have you identified riskiest sections of the calculations and applied
    particular scrutiny?",
    br(),
    "Can an independent modeller track back and reproduce parts of the
    calculations off model?",
    br(),
    "Is the data being pulled into the calculation modules correctly?",
    br(),
    "Do numbers apply to the correct time period (e.g. the middle of the
    month/year versus the beginning/end)? Is it consistent throughout the model?
    Are financial year and calendar year data managed correctly? Are discount
    rates (nominal/real) applied correctly?",
    br(),
    "Consider use of Adam Slim tool for spreadsheets."))})

#----VE2 Usability testing----
VE2modelling <- renderUI({fixedRow(column(12,
    "Usability testing",
    br(),br(),
    "Can a new user easily operate the model and view outputs?",
    br(),
    "Is routine operation of the model smooth and free of bugs? If relevant, is 
    there an appropriate user interface? Does it work correctly?",
    br(),
    "Does the model open in an acceptable amount of time? Is the runtime of the
    model appropriate for the demand placed on the model and the complexity of
    what is being modelled?",
    br(),
    "Is there a smooth and secure procedure to allow access to the software to
    the users or the people who need to QA the model? Is the time needed to 
    provide the access to a new user appropriate?",
    br(),
    "Have the appropriate control been put in place to avoid invalid
    data/entries (e.g. not sensible inputs)?",
    br(),
    "Is the system able to provide and maintain an acceptable level of service
    in the face of faults and challenges to normal operation? What is the 
    impact of faults and challenges to normal operations?"))})

#----VE3 Autochecks----
VE3modelling <- renderUI({fixedRow(column(12,
    "Autochecks",
    br(), br(),
    "Are autochecks used to highlight correct functionality (e.g. some lines of
    code checking that the inputs are sensible), and are they implemented
    correctly?"))})

#----VE4 Regression testing----
VE4modelling <- renderUI({fixedRow(column(12,
    "Regression testing",
    br(), br(),
    "Does the model make use of a reference set of input data / output data to
    test the model for unexpected outcomes after every significant
    development?",
    br(),
    "Are there a number of quantitative scenarios that cover a wide range of
    the possible inputs which can be run on old and new versions of the
    model?"))})

#----VE5 Use of model outputs----
VE5modelling <- renderUI({fixedRow(column(12,
    "Use of model outputs",
    br(), br(),
    "Are model outputs being correctly fed into dependent documents?",
    br(),
    "Have you compared outputs to previous model versions? Can you explain
    changes? Check outputs are correctly copied/transcribed into any dependent
    documents."))})

#----VE6 Visual correctness----
VE6modelling <- renderUI({fixedRow(column(12,
    "This check is not required."))})

#----Validation----

#----VA1 Methodology correctness----
VA1modelling <- renderUI({fixedRow(column(12,
      span("Mandatory check", style="color:red"),
      br(),
      "Methodology correctness",
      br(), br(),
      "Is the methodology used sensible and fit for purpose? (with \"purpose\"
      defined in the model specification)",
      br(),
      "Was the model methodology reviewed and agreed with relevant stakeholders?",
      br(),
      "Has the selected methodology been tested with other experts (eg other
      DfE analysts or external experts if appropriate?)",
      br(),
      "Does the model produce logical outputs?",
      br(),
      "- are outputs changes of the right direction and magnitude for relevant
      input changes?",
      br(),
      "- consider testing sparklines / trends for time series",
      br(),
      "- can changes from previous versions be explained?",
      br(),
      "Have model outputs been sense / reality checked and agreed with relevant 
      stakeholders?",
      br(),
      "Have appropraiate model walk-throughs been carried out?"))})

#----VA2 Comparison with historical data/backcasting/alternative models----
VA2modelling <- renderUI({fixedRow(column(12,
      "Comparison with historical data/backcasting/alternative models",
      br(), br(),
      "Does the model match historical results when using historical input data, 
      or match an alternative model, to within an agreed tolerance level?",
      br(),
      "There may be no historical/alternative models, in which case score as
      N/A."))})

#----VA3 Uncertainty testing----
VA3modelling <- renderUI({fixedRow(column(12,
      "Uncertainty testing",
      br(), br(),
      "Has enough been done to understand the uncertainty inherent in the data, 
      assumptions and methodology of the analysis?",
      br(),
      "Has data (especially poor quality data) been addressed via sensitivity
      testing and/or Monte Carlo analysis, and the results documented? Has
      uncertainty about the structure of the analysis (e.g. equations or logic
      used to combine the analysis inputs) been quantified through uncertainty
      analysis?",
      br(),
      "Has sensitivity analysis been used to find out the most significant
      inputs and assumptions?",
      br(),
      "Where random sampling is used, is it as consistent as possible with
      real-world distributions?",
      br(),
      "Are poor quality assumptions managed via sensitivity testing to
      determine the potential impact of an incorrect assumption?",
      br(),
      "Have scenario combinations been determined and performed to check
      whether expected outputs are produced?",
      br(),
      "If the model just perform standards calculations and there is no
      uncertainty mark the task as N/A."))})

#----VA4 Extreme values testing/model breaking----
VA4modelling <- renderUI({fixedRow(column(12,
      "Extreme values testing/model breaking",
      br(), br(),
      "Does the model respond as expected to extreme values, zeroes, negative
      values, critical limits?",
      br(),
      "Is it possible to 'break' the model or get implausible outcomes (e.g.
      percentages adding to more than 100%, people adding up to more than the
      population...)?",
      br(),
      "Use sparklines / trends to explore time series.",
      br(),
      "Test direction and magnitude for outputs in response to input change."))})

#----VA5 Re-performance testing----
VA5modelling <- renderUI({fixedRow(column(12,
      "Re-performance testing",
      br(), br(),
      "Can you replicate model output by independently (e.g. offline)
      re-performing key calculations on sections of the model?"))})

#----Data and assumptions----

#----DA1 Data----
DA1modelling <- renderUI({fixedRow(column(12,
      span("Mandatory check", style="color:red"),
      br(),
      "Data",
      br(), br(),
      "Does your data log contain details of all model data?",
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
DA2modelling <- renderUI({fixedRow(column(12,
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
DA3modelling <- renderUI({fixedRow(column(12,
      "Assumptions",
      br(), br(),
      "Does your assumptions log contain details of all model assumptions?",
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
 DA4modelling <- renderUI({fixedRow(column(12,
      "Decisions",
      br(), br(),
      "Does the specification and your implementation reflect the latest
      decision log?",
      br(),
      "If no distinct log exists, then mark this as N/A but decisions should be
      covered elsewhere (eg blended with an assumptions log)",
      br(),
      "Models may have a separate decision log particularly if they belong to a
      wider set of models. Decision logs may be external (eg held by policy / 
      delivery colleagues).",
      br(),
      "Where a decision log exists it must be clear how decisions have been
      implemented in the model and how the decision was approved / scrutinised."))})