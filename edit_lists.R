
#List of checks
QAcheckslist <- c("DG1", "DG2", "DG3", "DG4", "DG5", "DG6", "DG7", "DG8", "DG9",
                  "SC1", "SC2", "SC3", "SC4", "SC5", "SC6", "SC7", "SC8", "SC9",
                  "VE1", "VE2", "VE3", "VE4", "VE5", "VE6",
                  "VA1", "VA2", "VA3", "VA4", "VA5",
                  "DA1", "DA2", "DA3", "DA4")

#These are the names of each check
#Sometimes names differ slightly depending on type of log
names_of_checks <- function(checkID,types){
  if(checkID=="DG1"){"Scope and Specification"}
  else if (checkID=="DG2"){"User guide"}
  else if (checkID=="DG3"){"Technical guide"}
  else if (checkID=="DG4"){"KIM"}
  else if (checkID=="DG5"){"Version control"}
  else if (checkID=="DG6"){"Responsibilities"}
  else if (checkID=="DG7"){"QA planning and resourcing"}
  else if (checkID=="DG8"){"Record of QA"}
  else if (checkID=="DG9"){"Risk and issues log"}
  else if (checkID=="SC1"){if(types$log=="modelling"){"Structure of model"}
    else if(types$log=="analysis"){"Structure of analysis"}
    else if(types$log=="dashboard"){"Structure of data model"}
    else if(types$log=="statistics"){"Structure of analysis"}}
  else if (checkID=="SC2"){if(types$log=="dashboard"){"Dashboard structure"}
    else {"Calculation structure"}}
  else if (checkID=="SC3"){"Variable names and units"}
  else if (checkID=="SC4"){if(types$log=="modelling"){"Model comments"}
    else {"Analysis comments"}}
  else if (checkID=="SC5"){"Formula clarity and robustness"}
  else if (checkID=="SC6"){"Accessibility"}
  else if (checkID=="SC7"){"Caveats and footnotes"}
  else if (checkID=="SC8"){"Output formatting"}
  else if (checkID=="SC9"){"RAP"}
  else if (checkID=="VE1"){"Formula and code correctness"}
  else if (checkID=="VE2"){"Usability testing"}
  else if (checkID=="VE3"){"Autochecks"}
  else if (checkID=="VE4"){"Regression testing"}
  else if (checkID=="VE5"){if(types$log=="modelling"){"Use of model outputs"}
    else{"Use of analytical outputs"}}
  else if (checkID=="VE6"){"Visual correctness"}
  else if (checkID=="VA1"){"Methodology correctness"}
  else if (checkID=="VA2"){"Comparisons"}
  else if (checkID=="VA3"){"Uncertainty testing"}
  else if (checkID=="VA4"){"Extreme values testing"}
  else if (checkID=="VA5"){"Re-performance testing"}
  else if (checkID=="DA1"){"Data"}
  else if (checkID=="DA2"){"Data transformation"}
  else if (checkID=="DA3"){"Assumptions"}
  else if (checkID=="DA4"){"Decisions"}
}

#These are conditions since some checks are not required for all logs
conditions <- function(checkID,QAlogtype){
  if(checkID=="DG3"){"input.QAlogtype == 'Official Statistics' || input.QAlogtype == 'Modelling'"}
  else if(checkID=="DG9"){"input.QAlogtype == 'Official Statistics'"}
  else if(checkID=="SC2"){"input.QAlogtype == 'Official Statistics' || input.QAlogtype == 'Modelling' || input.QAlogtype == 'Dashboard'"}
  else if(checkID=="SC4"){"input.QAlogtype == 'Official Statistics' || input.QAlogtype == 'Modelling' || input.QAlogtype == 'Data Analysis'"}
  else if(checkID=="SC6"){"input.QAlogtype == 'Dashboard'"}
  else if(checkID=="SC7"){"input.QAlogtype == 'Official Statistics'"}
  else if(checkID=="SC8"){"input.QAlogtype == 'Official Statistics'"}
  else if(checkID=="SC9"){"input.QAlogtype == 'Official Statistics'"}
  else if(checkID=="VE3"){"input.QAlogtype == 'Official Statistics' || input.QAlogtype == 'Modelling' || input.QAlogtype == 'Data Analysis'"}
  else if(checkID=="VE4"){"input.QAlogtype == 'Modelling'"}
  else if(checkID=="VE5"){"input.QAlogtype == 'Official Statistics' || input.QAlogtype == 'Modelling'"}
  else if(checkID=="VE6"){"input.QAlogtype == 'Official Statistics' || input.QAlogtype == 'Dashboard'"}
  else if(checkID=="VA3"){"input.QAlogtype == 'Dashboard' || input.QAlogtype == 'Modelling' || input.QAlogtype == 'Data Analysis'"}
  else if(checkID=="VA4"){"input.QAlogtype == 'Official Statistics' || input.QAlogtype == 'Modelling'"}
  else if(checkID=="VA5"){"input.QAlogtype == 'Official Statistics' || input.QAlogtype == 'Modelling'"}
  else if(checkID=="DA4"){"input.QAlogtype == 'Dashboard' || input.QAlogtype == 'Modelling'"}
  else {"No condition"}
}