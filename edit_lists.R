#To add in a new log, you must edit below, and then check the following:
#names_of_checks: where checks are specific to the type of log, you may have to
  #put the name of the new log down
#conditions: check that the new log is included for the relevant checks
#You will also need to edit tooltips.R
#And add a new file "comments_logname_log.R", with logname replaced with the
  #name of the new log

#To make things simpler, refer to the log by one word only in code
logslist <- c("modelling","analysis","dashboard","statistics")

#This is the actual name of the log, can be as many words as you like!
logname <- function(name){
  if(name=="modelling"){"Modelling"}
  else if (name=="analysis"){"Data Analysis"}
  else if (name=="dashboard"){"Dashboard"}
  else if (name=="statistics"){"Official Statistics"}
}

#To add in a new check, you must edit the lists below:

#List of checks
#Add the check ID of a new check
QAcheckslist <- c("DG1", "DG2", "DG3", "DG4", "DG5", "DG6", "DG7", "DG8", "DG9",
                  "SC1", "SC2", "SC3", "SC4", "SC5", "SC6", "SC7", "SC8", "SC9",
                  "VE1", "VE2", "VE3", "VE4", "VE5", "VE6",
                  "VA1", "VA2", "VA3", "VA4", "VA5",
                  "DA1", "DA2", "DA3", "DA4")

#The following are the names of checks - if there is a 0, that means the check
#is not relevant for that log

modelling_names <- c("Scope and Specification", "User guide", "Technical guide", "KIM",
               "Version control", "Responsibilities","QA planning and resourcing",
               "Record of QA", 0,
               "Structure of model", "Calculation structure", "Variable names and units",
               "Model comments", "Formula clarity and robustness", 0, 0, 0, 0,
               "Formula and code correctness","Usability testing","Autochecks",
               "Regression testing", "Use of model outputs", 0,
               "Methodology correctness", "Comparisons", "Uncertainty testing",
               "Extreme values testing", "Re-performance testing",
               "Data", "Data transformation", "Assumptions", "Decisions")

analysis_names <- c("Scope and Specification", "User guide", 0, "KIM",
              "Version control", "Responsibilities","QA planning and resourcing",
              "Record of QA", 0,
              "Structure of analysis", "Calculation structure", "Variable names and units",
              "Analysis comments", "Formula clarity and robustness", 0, 0, 0, 0,
              "Formula and code correctness","Usability testing",0,
              0, 0, 0,
              "Methodology correctness", "Comparisons", "Uncertainty testing",
              0,0,
              "Data", "Data transformation", "Assumptions", 0)

dashboard_names <- c("Scope and Specification", "User guide", 0, "KIM",
               "Version control", "Responsibilities","QA planning and resourcing",
               "Record of QA", 0,
               "Structure of data model", "Dashboard structure", "Variable names and units",
               0, "Formula clarity and robustness", "Accessibility", 0, 0, 0,
               "Formula and code correctness","Usability testing","Autochecks",
               0, 0, "Visual correctness",
               "Methodology correctness", "Comparisons", "Uncertainty testing",
               0,0,
               "Data", "Data transformation", "Assumptions", "Decisions")

statistics_names <- c("Scope and Specification", "User guide", "Technical guide", "KIM",
                     "Version control", "Responsibilities","QA planning and resourcing",
                     "Record of QA", "Risk and issues log",
                     "Structure of analysis", "Calculation structure", "Variable names and units",
                     "Analysis comments", "Formula clarity and robustness", 0, 
                     "Caveats and footnotes", "Output formatting", "RAP",
                     "Formula and code correctness","Usability testing","Autochecks",
                     0, "Use of analytical outputs", "Visual correctness",
                     "Methodology correctness", "Comparisons", 0,
                     "Extreme values testing", "Re-performance testing",
                     "Data", "Data transformation", "Assumptions", 0)

names_df <- (data.frame(QAcheckslist, modelling_names, analysis_names, dashboard_names, 
                       statistics_names))%>%mutate(blank_names=0,new_names=0,update_names=0)