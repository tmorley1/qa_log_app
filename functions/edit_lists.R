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

modelling_names <- c("Scope <br> and <br> Specification", "User guide", "Technical guide", "KIM",
               "Version control", "Responsibilities","QA planning <br> and <br> resourcing",
               "Record of QA", 0,
               "Structure <br> of <br> model", "Calculation <br> structure", "Variable <br> names <br> and <br> units",
               "Model comments", "Formula <br> clarity <br> and <br> robustness", 0, 0, 0, 0,
               "Formula <br> and <br> code <br> correctness","Usability <br> testing","Autochecks",
               "Regression <br> testing", "Use of <br> model <br> outputs", 0,
               "Methodology <br> correctness", "Comparisons", "Uncertainty <br> testing",
               "Extreme <br> values <br> testing", "Re-performance <br> testing",
               "Data", "Data <br> transformation", "Assumptions", "Decisions")

analysis_names <- c("Scope <br> and <br> Specification", "User guide", 0, "KIM",
              "Version control", "Responsibilities","QA planning <br> and <br> resourcing",
              "Record of QA", 0,
              "Structure <br> of <br> analysis", "Calculation <br> structure", "Variable <br> names <br> and <br> units",
              "Analysis comments", "Formula <br> clarity <br> and <br> robustness", 0, 0, 0, 0,
              "Formula <br> and <br> code <br> correctness","Usability <br> testing","Autochecks",
              0, 0, 0,
              "Methodology <br> correctness", "Comparisons", "Uncertainty <br> testing",
              0,0,
              "Data", "Data <br> transformation", "Assumptions", 0)

dashboard_names <- c("Scope <br> and <br> Specification", "User guide", 0, "KIM",
               "Version control", "Responsibilities","QA planning <br> and <br> resourcing",
               "Record of QA", 0,
               "Structure <br> of <br> data model", "Dashboard <br> structure", "Variable <br> names <br> and <br> units",
               0, "Formula <br> clarity <br> and <br> robustness", "Accessibility", 0, 0, 0,
               "Formula <br> and <br> code <br> correctness","Usability <br> testing","Autochecks",
               0, 0, "Visual <br> correctness",
               "Methodology <br> correctness", "Comparisons", "Uncertainty <br> testing",
               0,0,
               "Data", "Data <br> transformation", "Assumptions", "Decisions")

statistics_names <- c("Scope <br> and <br> Specification", "User guide", "Technical guide", "KIM",
                     "Version control", "Responsibilities","QA planning <br> and <br> resourcing",
                     "Record of QA", "Risk and <br> issues log",
                     "Structure <br> of <br> analysis", "Calculation <br> structure", "Variable <br> names <br> and <br> units",
                     "Analysis <br> comments", "Formula <br> clarity <br> and <br> robustness", 0, 
                     "Caveats <br> and <br> footnotes", "Output <br> formatting", "RAP",
                     "Formula <br> and <br> code <br> correctness","Usability <br> testing","Autochecks",
                     0, "Use of <br> analytical <br> outputs", "Visual <br> correctness",
                     "Methodology <br> correctness", "Comparisons", 0,
                     "Extreme <br> values <br> testing", "Re-performance <br> testing",
                     "Data", "Data <br> transformation", "Assumptions", 0)

#Are checks mandatory? If check is mandatory = "M", if not mandatory = ""
modelling_mandatory <- c(1,0,0,0,1,1,0,1,0, #DG checks
                         1,0,0,0,0,0,0,0,0, #SC checks
                         1,0,0,0,0,0, #VE checks
                         1,0,0,0,0, #VA checks
                         1,0,0,0) #DA checks

analysis_mandatory <-  c(1,0,0,0,1,1,0,1,0, #DG checks
                         1,0,0,0,0,0,0,0,0, #SC checks
                         1,0,0,0,0,0, #VE checks
                         0,0,0,0,0, #VA checks
                         1,0,0,0) #DA checks

dashboard_mandatory <- c(1,1,1,1,1,1,1,1,0, #DG checks
                         1,1,0,0,0,1,0,0,0, #SC checks
                         0,1,0,0,0,1, #VE checks
                         1,0,0,0,0, #VA checks
                         1,0,0,0) #DA checks

statistics_mandatory <-c(0,0,0,0,0,0,0,0,0, #DG checks
                         0,0,0,0,0,0,0,0,0, #SC checks
                         0,0,0,0,0,0, #VE checks
                         0,0,0,0,0, #VA checks
                         0,0,0,0) #DA checks

names_df <- (data.frame(QAcheckslist, modelling_names, analysis_names, dashboard_names, 
                        statistics_names, modelling_mandatory, analysis_mandatory,
                        dashboard_mandatory, statistics_mandatory))%>%mutate(blank_names=0,
                        new_names=0,update_names=0, blank_mandatory=0, new_mandatory=0,update_mandatory=0)