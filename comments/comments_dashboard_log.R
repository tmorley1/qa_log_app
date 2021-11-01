#----Documentation and governance----

#----DG1 Scope and specification----
DG1dashboard <- renderUI({fixedRow(column(12,
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
DG2dashboard <- renderUI({fixedRow(column(12,
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
DG3dashboard <- renderUI({fixedRow(column(12,
    "This check is not required."))})

#----DG4 KIM----
DG4dashboard <- renderUI({fixedRow(column(12,
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
DG5dashboard <- renderUI({fixedRow(column(12,
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
DG6dashboard <- renderUI({fixedRow(column(12,
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
DG7dashboard <- renderUI({fixedRow(column(12,
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
DG8dashboard <- renderUI({fixedRow(column(12,
    "Record of QA",
    br(), br(),
    "Have all the checks and tests been recorded with evidence available to
    review?",
    br(),
    "This log, along with linked evidence to actual QA activities will provide
    most of the evidence needed."))})

#----DG9 Risk and issues log----
DG9dashboard <- renderUI({fixedRow(column(12,
    "This check is not required."))})

#----Structure and clarity----

#----SC1 Structure of data model----
SC1dashboard <- renderUI({fixedRow(column(12,
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
SC2dashboard <- renderUI({fixedRow(column(12,
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
SC3dashboard <- renderUI({fixedRow(column(12,
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
SC4dashboard <- renderUI({fixedRow(column(12,
     "This check is not required."))})

#----SC5 Formula clarity and robustness----
SC5dashboard <- renderUI({fixedRow(column(12,
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
SC6dashboard <- renderUI({fixedRow(column(12,
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
SC7dashboard <- renderUI({fixedRow(column(12,
     "This check is not required."))})

#----SC8 Output formatting----
SC8dashboard <- renderUI({fixedRow(column(12,
      "This check is not required."))})

#----SC9 RAP----
SC9dashboard <- renderUI({fixedRow(column(12,
      "This check is not required."))})

#----Verification----

#----VE1 Formula and code correctness----
VE1dashboard <- renderUI({fixedRow(column(12,
      "Formula and code correctness",
      br(),br(),
      "Have you checked that all the formulae and code used in the dashboard
      and data model to calculate new columns/measures have been implemented
      correctly?",
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
      month/year versus the beginning/end)? Is it consistent throughout the
      model? Are financial year and calendar year data managed correctly? Are
      discount rates (nominal/real) applied correctly?"))})

#----VE2 Usability testing----
VE2dashboard <- renderUI({fixedRow(column(12,
      "Usability testing",
      br(), br(),
      "Can new users easily use the dashboard as intended?",
      br(),
      "Has the dashboard been tested with internal users and customers?",
      br(),
      "Can they access the dashboard and use it as anticipated? ",
      br(),
      "Do users have the correct level of permissions?",
      br(),
      "Is sensitive data being hidden from users that shouldn't have access to
      it?",
      br(),
      "Have you discussed the visuals with users/the customer to confirm the
      visuals are useful and relevant to their needs?",
      br(),
      "Does the dashboard function without any bugs? If bugs have been
      encountered but can not be fixed (such as those inherent to the software
      being used) have they been recorded."))})

#----VE3 Autochecks----
VE3dashboards <- renderUI({fixedRow(column(12,
      "This check is not required."))})

#----VE4 Regression testing----
VE4dashboard <- renderUI({fixedRow(column(12,
      "This check is not required."))})

#----VE5 Use of model outputs----
VE5dashboard <- renderUI({fixedRow(column(12,
      "This check is not required."))})

#----VE6 Visual correctness----
VE6dashboard <- renderUI({fixedRow(column(12,
      "Visual correctness",
      br(),br(),
      "Have you checked that all the visuals are linked to the right fields?
      Are the right filters been applied? Is cross-filtering and
      cross-highlighting being implemented correctly?",
      br(),
      "Visuals include the various formats in which data is displayed to users
      such as charts, maps, tables, cards etc."))})

#----Validation----

#----VA1 Methodology correctness----
VA1dashboard <- renderUI({fixedRow(column(12,
      "Methodology correctness",
      br(), br(),
      "Are the visuals selected the correct visual and fit for purpose?",
      br(),
      "Have you created the right type of dashboard? (Operational vs Strategic
      vs Analytical)",
      br(),
      "Do the included visuals match the business need?",
      br(),
      "Would a different chart or graph be more effective? Have you tried to
      avoid 3-dimensional plots as they can lead to misinterpretation of data?",
      br(),
      "Are the important elements of visuals being emphasised?",
      br(),
      "Are separate pages for different customer types appropriate?"))})

#----VA2 Comparison with historical data/backcasting/alternative models----
VA2dashboard <- renderUI({fixedRow(column(12,
      "Comparison with historical data/backcasting/alternative models",
      br(), br(),
      "Do the visuals produced match historical results when using historical 
      input data, or match an alternative model, to within an agreed tolerance 
      level?",
      br(),
      "Do the visuals in the dashboard present expected results when compared
      with alternative models? (e.g. do the visuals match  those used in the
      data model for sense checks)",
      br(),
      "Do the visuals match expectations when compared with historical data?
      (e.g. do the visuals match those produced using previous data after a
      data refresh)",
      br(),
      "There may be no historical/alternative models, in which case score as
      N/A."))})

#----VA3 Uncertainty testing----
VA3dashboard <- renderUI({fixedRow(column(12,
      "Uncertainty testing",
      br(), br(),
      "Has enough been done to understand the uncertainty inherent in the data,
      assumptions and methodology of the analysis? Is the uncertainty in the
      data communicated in the dashboard?",
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
      "Where applicable, has uncertainty on data points been included on
      visuals shown in the dashboard?",
      br(),
      "If the model just performs standards calculations and there is no
      uncertainty mark the task as N/A"))})

#----VA4 Extreme values testing/model breaking----
VA4dashboard <- renderUI({fixedRow(column(12,
      "This check is not required."))})

#----VA5 Re-performance testing----
VA5dashboard <- renderUI({fixedRow(column(12,
      "This check is not required."))})

#----Data and assumptions----

#----DA1 Data----
DA1dashboard <- renderUI({fixedRow(column(12,
      "Data",
      br(), br(),
      "Does your assumptions log contain details of all data used in the
      analysis?",
      br(),
      "Has key data been identified and prioritised?",
      br(),
      "Has appropriate data been used?",
      br(),
      "Is all the data up-to-date?",
      br(),
      "Is only useful data being imported into the dashboard?",
      br(),
      "Are the quality, characteristics, strengths and limitations of the data
      set fully understood and recorded?",
      br(),
      "Have data quality, impact and risk been assessed?",
      br(),
      "Has the input data or data model been quality assured?",
      br(),
      "Have data inputs and their limitations been agreed with relevant
      stakeholders and signed-off?",
      br(),
      "If Official Statistics are being used/created, have you liaised with the
      statistics team to ensure they are used correctly?",
      br(),
      "Have relevant decisions taken about the data been recorded?",
      br(),
      "Does the data import correctly into the dashboard?",
      br(),
      "Is importing your data or using Direct Query more appropriate?",
      br(),
      "Have timelines been agreed for any future data refreshes? (if applicable)",
      br(),
      "If data is automatically refreshed are there checks in place so that
      errors/data quality issues will be flagged?"))})

#----DA2 Data transformation----
DA2dashboard <- renderUI({fixedRow(column(12,
      "Data transformation",
      br(), br(),
      "Has input data been checked against primary reference for potential
      errors in copying / pasting / transforming?",
      br(),
      "If required, have details on how the data have been imported/transformed
      or processed been recorded in the Assumptions Log?",
      br(),
      "Have sources of data been documented in the Assumptions Log?",
      br(),
      "Is it appropriate to perform data transformation performed in the
      dashboard software? More extensive data transformation can be performed 
      before importing the data to avoid affecting the user experience.",
      br(),
      "Examples of Data Transformation:",
      br(),
      "Renaming variables, changing variable formats, data cleansing,
      adding/removing rows, combining two or more data sources etc."))})

#----DA3 Assumptions----
DA3dashboard <- renderUI({fixedRow(column(12,
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
DA4dashboard <- renderUI({fixedRow(column(12,
      "Decisions",
      br(), br(),
      "Does the specification and your implementation reflect the latest
      decision log?",
      br(),
      "If no distinct log exists, then mark this as N/A but decisions should be 
      covered elsewhere (eg blended with an assumptions log)",
      br(),
      "A separate decision log may exist particularly if the dashboard presents 
      data belonging to a wider set of models. Decision logs may be external 
      (eg. held by policy / delivery colleagues).",
      br(),
      "Where a decision log exists it must be clear how decisions have been 
      implemented in the model and how the decision was approved / scrtinised."))})