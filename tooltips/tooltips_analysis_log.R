#------Documentation and governance-----

#----DG1-----
#For some reason R does not like comments being over multiple lines
DG1tooltipanalysis <- "1) An up to date scope exists, consistent with the information contained in the template. Limitations are well specified. Clear evidence of sign off. <br> <br> 2) Near-complete scope and specification exist. Deatailed requirements and limitations are mostly specified. Evidence of sign off. <br> <br> 3) Scope and specification exist but some elements are now out of date, or lack detail. Sign off incomplete or out of date. <br> <br> 4) Scope and specification exist but was never reviewed and it no longer matches the analysis. Sign off incomplete or out of date. <br> <br> 5) Scope or specification missing."

#----DG2----
DG2tooltipanalysis <- "1) Comprehensive user guide (or equivalent documentation within the spreadsheet/code) enables use of analysis, is easily found and up to date <br> <br> 2) User guide available and enables use of analysis but some information is missing or it is not up to date <br> <br> 3) User guide not available, but running the analysis is easy and intuitive <br> <br> 4) User guide not available but a new user could understand key functionalities of the analysis relatively quickly <br> <br> 5) No documentation available to support the user who cannot understand how to run the analysis in a relatively short time period."

#----DG3----
DG3tooltipanalysis <- "Not required"

#----DG4----
DG4tooltipanalysis <- "1) KIM protocols applied in full, including files stored in appropriate Office365 locations, with appropriate controlled access (only sensitive information not accessible by wider DfE colleagues). <br> <br> 2) KIM protocols applied, including files stored in appropriate Office365 locations, but access restricted more than DfE protocols advise. <br> <br> 3) Some KIM protocols applied, but files may not be stored in the most appropriate locations and/or access not widely granted. <br> <br> 4) No KIM protocols applied but files stored in a way that other analysts coming into the team would easily locate all relevant files. <br> <br> 5) No KIM protocols applied and files may be hard to locate."

#----DG5----
DG5tooltipanalysis <- "1) A version log exists and follows a clear and logical versioning system. Detailed information of the changes performed and their impacts are included. <br> <br> 2) Version log and labelling exist and are largely complete but there are a few gaps or inconsistencies. <br> <br> 3) No version log, but version labelling makes it clear which version is used <br> <br> 4) No version log, but some version labelling, although incomplete <br> <br> 5) No version log and no version labelling"

#----DG6----
DG6tooltipanalysis <- "1) All roles identified and people are fully aware of their role and responsibilities and there is clear documentation of this (this could be an email trail). All are fully undertaking their responsibilities. <br> <br> 2) All roles identified and people are aware of their role and responsibilities and there is some documentation of this. <br> <br> 3) People are undertaking these roles, but have not been explicitly named as such or may not be undertaking all aspects of the role. <br> <br> 4) Some of the roles are being undertaken, but people not fully aware of their responsibilities. <br> <br> 5) Insufficient evidence of allocation of roles and/or the requisite activities taking place."

#----DG7----
DG7tooltipanalysis <- "1) A QA plan exists and is clearly agreed by both analytical assurer and commissioner/ SRO. The plan is embedded within the overall work. Time and resources have been planned to address QA recommendations. <br> <br> 2) Near complete QA plan. Plan signed off by SRO and analytical assurer. Some uncertainty over time and resources. <br> <br> 3) Some evidence of QA plan. Plan not signed off by SRO and Analytical Assurer. Lack of clarity over time and resources. <br> <br> 4) Little evidence of QA plan. <br> <br> 5) No evidence of QA plan."

#----DG8----
DG8tooltipanalysis <- "1) Clear and comprehensive record of all QA activities in the QA plan and any additional activity undertaken. The analytical assurer has scrutinised the activity and signed off. <br> <br> 2) Clear and comprehensive record of all QA activities in the QA plan and any additional activity undertaken. The analytical assurer has not yet signed off. <br> <br> 3) A record exists, but it is not clear that it covers all aspects of QA and has not been scrutinised. <br> <br> 4) Little evidence of QA record. <br> <br> 5) No evidence of QA record."

#----DG9----
DG9tooltipanalysis <- "Not required"

#----Structure and clarity----

#----SC1----
SC1tooltipanalysis <- "1) The structure of the analysis is clear, simple and free of unused data/formulae. It is clear how to use the code/spreadsheet. <br> <br> 2) The analysis mostly has a clear and simple structure, but some aspects may not be completely clear. The code/spreadsheet may include a small amount of unused data/formulae. <br> <br> 3) Some issues with the structure: interactions between different parts of the analysis may not always be easy to follow and no clear distinction between inputs, calculations and outputs. May include some unused data/formulae. <br> <br> 4) Many issues about the structure: interactions between different parts of the analysis may be difficult to follow and no clear distinction between inputs, calculations and outputs. Model could include significant amounts of unused data/formulae. <br> <br> 5) Extremely complicated structure. It is not clear how different parts of the analysis interact. Code/spreadsheet could include substantial amounts of unused data/formulae."

#----SC2----
SC2tooltipanalysis <- "Not required"

#----SC3----
SC3tooltipanalysis <- "1) Units and labels always clearly expressed. No hardcoded values are used in conversions (e.g., conversion tables used). <br> <br> 2) Units and labels always clearly expressed. A few hardcoded values are used in conversions. <br> <br> 3) Units and labels are available in most of the cases. Some hardcoded values are used in conversions. <br> <br> 4) Units or labels sometimes missing. Conversions mostly performed with hardcoded values. <br> <br> 5) Units or labels often missing. Conversions performed with hardcoded values."

#----SC4----
SC4tooltipanalysis <- "1) Comments and explanations are embedded throughout the code/spreadsheet so that it is very easy to understand formulae and methodology. Data sources are clearly identified (and linked if appropriate). <br> <br> 2)The majority of the code/spreadsheet has comments embedded and these are clear but there are some cases where comments would be helpful. Almost all of the data sources are identified (and linked if appropriate). <br> <br> 3) The main parts of the code/spreadsheet are commented, but some further explanations would be helpful. Not all the data sources are identified. <br> <br> 4)There are some comments but these are not clear and some are out of date. It is not possible to fully understand the code/spreadsheet without talking with the analysts. <br> <br> 5) None or very few comments. It is very difficult to understand formulae without talking with the analysts."

#----SC5----
SC5tooltipanalysis <- "1) Formulae are, as far as possible, easily understandable. No potential issues due to lack of formulae robustness (e.g. if changes are introduced, the code/spreadshet will still work as intended). No hardcoded values. <br> <br> 2) A robust approach is used in most of the formulae. Some minor issues, like a few hardcoded values. <br> <br> 3) Some formulae could be made more robust (e.g., by using tables or named ranges or removing the hardcoded values). <br> <br> 4) In many cases the formulae used are not the best/most robust ones. Changes in the code/spreadsheet, such as the introduction of new functionalities or the change of the default setting would likely lead to issues. Hardcoded values are used extensively. <br> <br> 5) Most formulae are not clear or robust, large use of hardcoded values."

#----SC6----
SC6tooltipanalysis <- "Not required."

#----SC7----
C7tooltipanalysis <- "Not required."

#----SC8----
SC8tooltipanalysis <- "Not required."

#----SC9----
SC9tooltipanalysis <- "Not required."

#----Verification----

#----VE1----
VE1tooltipanalysis <- "Scoring guided by spreadsheet or Code QA tab, where number of checks and % of checks passed are considered"

#----VE2----
VE2tooltipanalysis <- "1) The functionalities of the analysis work correctly. If parts of the code/spreadsheet are a work in progress, they are clearly labelled and formatted. When settings or scenarios are changed no issues occur. <br> <br> 2) The analysis is free of bugs and all the functionalities work correctly. A few minor issues which do not have any impact on the outputs have been documented and explained. <br> <br> 3) The main functionalities work correctly. Some issues if the non-default scenarios/settings are selected, but they have been documented. <br> <br> 4) Routine operation works correctly, but even small changes of scenarios/settings leads to errors. A moderate chance of some major errors creeping in <br> <br> 5) There are bugs during routine operation, no protection implemented OR usability has not been checked"

#----VE3----
VE3tooltipanalysis <- "1) Auto-checking functionalities are present and correctly implemented wherever possible. <br> <br> 2)  Auto-checking functionalities correctly implemented for high priority sections, but a few could be added to improve overall quality. <br> <br> 3) There are some autochecks, but more could be introduced to easily spot errors or inconsistencies, OR only some autochecks have been examined. <br> <br> 4)  Very few autochecks implemented OR few autochecks examined. <br> <br> 5) No autochecks, OR these have not been examined. "

#----VE4----
VE4tooltipanalysis <- "Not required."

#----VE5----
VE5tooltipanalysis <- "Not required."

#----VE6----
VE6tooltipanalysis <- "Not required."

#----Validation----

#----VA1----
VA1tooltipanalysis <- "1) The methodology has been agreed with relevant stakeholders and reviewed by experts. The outputs are logical <br> <br> 2) The methodology is correct but only some relevant stakeholders have reviewed it. The outputs are logical <br> <br> 3) Both methodology and outputs are logical, but have not been reviewed by relevant stakeholders, OR only parts of the methodology have been reviewed <br> <br> 4) Some results are counterintuitive and not all the methodology is sensible, OR very few parts of the methodology have been reviewed <br> <br> 5) Not all the outputs are logical or the methodology is not always sensible and fit for purpose, OR the methodology needs review but this has not yet happened."

#----VA2----
VA2tooltipanalysis <- "1) The outputs when historical data are used are sensible and are fairly close to the historical outputs OR the oututs have been compared against alternative data sources, with a clear explanation of any differences <br> <br> 2) Most of the outputs match historical or alternative data with a clear explanation of any differences <br> <br> 3) Historical outputs cannot be always reproduced by the analysis, but this behaviour is documented, OR only some of the feasible comparisons have been carried out. <br> <br> 4) The historical values differ significantly from the outputs and the explanation for this is somewhat insufficient, OR few comparisons with historical data performed <br> <br> 5) The code/spreadsheet cannot replicate the historical outputs and no explanation is available, OR no historical comparisons have been performed. <br> <br> N/A) No historical data available and no alternative data comparison is possible"

#----VA3----
VA3tooltipanalysis <- "1) Appropriate sensitivity testing has been performed on all the relevant data and assumptions. The code/spreadsheet always responds logically to these tests and the potential impacts of a change in data or assumptions have been fully recorded. Scenario testing have been performed and the expected outputs have been obtained <br> <br> 2) Appropriate sensitivity testing performed for all high risk data and assumptions. Results from these tests are logical and have been recorded <br> <br> 3) Only some scenarios considered or testing not properly logged <br> <br> 4) Few testing performed and results not logged and analysed <br> <br> 5) No sensitivity testing performed, or results from testing are illogical and/or not documented. Scenario testing missing or very limited <br> <br> N/A) There is no uncertainty as the model simply performs standard calculations"

#----VA4----
VA4tooltipanalysis <- "Not required."

#----VA5----
VA5tooltipanalysis <- "Not required."

#----Data and assumptions----

#----DA1----
DA1tooltipanalysis <- "1) Data log containing all the relevant information about data available. Data fit for purpose, their quality, impact and risk recorded and fully understood. Data signed-off and up-to-date <br> <br> 2) No data log but all data is recorded and information is present within the code/spreadsheet. <br> <br> 3) No data log but the majority of data is recorded and information is present within the code/spreadsheet. <br> <br> 4) No data log, but some information is available (in the documentation or within the code/spreadsheet). Quality of data not always assessed properly, sign off may be missing <br> <br> 5) No data log and very little information available. No documentation assessing data quality and limitations and no sign off. Not all data is fit for purpose"

#----DA2----
DA2tooltipanalysis <- "1) Complete details available about where the data is taken and how it is transformed. Data matches source following transformation. <br> <br> 2) Details on data transformation are available for all critical data and sources are included <br> <br> 3) Not all the data transformations are clearly documented but no errors due to copying/pasting/transforming data <br> <br> 4) Not clear description of data transformations, some sources are not included <br> <br> 5) A proper description of how data is transformed is missing, sources are often not included. It is difficult to check whether there are errors due to copying/pasting/transforming data <br> <br> N/A) No transformation or copying/pasting performed"

#----DA3----
DA3tooltipanalysis <- "1) Assumptions log containing all the relevant information about all the assumptions Assumptions fit for purpose, their quality, impact and risk recorded and fully understood. Assumptions signed-off and up-to-date <br> <br> 2) No assumptions log but all assumptions are recorded and information is present within the code/spreadsheet <br> <br> 3) No assumptions log fit but the majority of assumptions are recorded and information is present within the code/spreadsheet. <br> <br> 4) No assumptions log, but some information is available (in the documentation or within the code/spreadsheetl). Quality of assumptions not always assessed properly, sign off may be missing <br> <br> 5) No assumptions log and very little information available. No documentation assessing assumptions quality and risk and no sign off. Not all assumptions are fit for purpose"

#----DA4----
DA4tooltipanalysis <- "Not required."