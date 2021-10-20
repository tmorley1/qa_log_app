#------Documentation and governance-----

#----DG1-----
#For some reason R does not like comments being over multiple lines
DG1tooltipmodelling <- "1) An up to date scope exists, consistent with the information contained in the template. Model boundaries and limitations are well specified. An up to date specification exists detailing all requirements of the model. A process exists to formalise changes to requirements. Clear evidence of sign off.(Note - the scope and specification can be standalone document(s) or covered within other documentation) <br> <br> 2) Near-complete scope and specification exist. Detailed requirements, model boundaries and limitations are mostly specified. Evidence of sign off. <br> <br> 3) Scope and specification exist but some elements are now out of date, or detailed requirements, model boundaries and limitations are partially specified. Sign off incomplete or out of date. <br> <br> 4) Scope and specification exist but was never reviewed and it no longer matches the model, or detailed requirements, model boundaries and limitations are not well specified. Sign off incomplete or out of date. <br> <br> 5) Scope or specification missing."
DG1tooltipanalysis <- "1) An up to date scope exists, consistent with the information contained in the template. Limitations are well specified. Clear evidence of sign off. <br> <br> 2) Near-complete scope and specification exist. Deatailed requirements and limitations are mostly specified. Evidence of sign off. <br> <br> 3) Scope and specification exist but some elements are now out of date, or lack detail. Sign off incomplete or out of date. <br> <br> 4) Scope and specification exist but was never reviewed and it no longer matches the analysis. Sign off incomplete or out of date. <br> <br> 5) Scope or specification missing."
DG1tooltipdashboard <- "1) An up to date scope exists, consistent with the information contained in the template. Limitations are well specified. Clear evidence of sign off. <br> <br> 2) Near-complete scope and specification exist. Detailed requirements and limitations are mostly specified. Evidence of sign off. <br> <br> 3) Scope and specification exist but some elements are now out of date, or lack detail. Sign off incomplete or out of date. <br> <br> 4) Scope and specification exist but was never reviewed and it no longer matches the analysis. Sign off incomplete or out of date. <br> <br> 5) Scope or specification missing."
DG1tooltipstatistics <- "Specific note for statistics"

#----DG2----
DG2tooltipmodelling <- "1) Comprehensive user guide (or equivalent documentation within the model) enables model use, is easily found and up to date <br> <br> 2) User guide available and enables model use but some information is missing or it is not up to date <br> <br> 3) User guide not available, but running the model is easy and intuitive <br> <br> 4) User guide not available but a new user could understand key model functionalities relatively quickly <br> <br> 5) No documentation available to support the user who cannot understand how to run the model in a relatively short time period."
DG2tooltipanalysis <- "1) Comprehensive user guide (or equivalent documentation within the spreadsheet/code) enables use of analysis, is easily found and up to date <br> <br> 2) User guide available and enables use of analysis but some information is missing or it is not up to date <br> <br> 3) User guide not available, but running the analysis is easy and intuitive <br> <br> 4) User guide not available but a new user could understand key functionalities of the analysis relatively quickly <br> <br> 5) No documentation available to support the user who cannot understand how to run the analysis in a relatively short time period."
DG2tooltipdashboard <- "1) Comprehensive user guide (or equivalent embedded documentation) enables use of the dashboard, is easily found and up to date <br> <br> 2) User guide available and enables use of the dashboard but some information is missing or it is not up to date <br> <br> 3) User guide not available, but using the dashboard is easy and intuitive <br> <br> 4) User guide not available but a new user could understand key functionalities of the dashboard relatively quickly <br> <br> 5) No documentation available to support the user who cannot understand how to use the dashboard in a relatively short time period."
DG2tooltipstatistics <- "1) Comprehensive user guide (or equivalent documentation within the analysis) enables analysis use, is easily found and up to date <br> <br> 2) User guide available and enables analysis use but some information is missing or it is not up to date <br> <br> 3) User guide not available, but running the analysis is easy and intuitive <br> <br> 4) User guide not available but a new user could understand key analysis functionalities relatively quickly <br> <br> 5) No documentation available to support the user who cannot understand how to run the analysis in a relatively short time period."

#----DG3----
DG3tooltipmodelling <- "1) Comprehensive and informative technical guide available and up to date <br> <br> 2) Technical guide available but some information is missing or it is not up to date. <br> <br> 3) Technical guide available but most information is missing or it is not up to date. <br> <br> 4) Technical guide not available, but some technical info can be found within the model <br> <br> 5) No technical documentation either in external document or within the model available to help users with future model adaptations."
DG3tooltipanalysis <- "Not required"
DG3tooltipdashboard <- "Not required"
DG3tooltipstatistics <- "1) Comprehensive and informative technical guide available and up to date <br> <br> 2) Technical guide available but some information is missing or it is not up to date. <br> <br> 3) Technical guide available but most information is missing or it is not up to date. <br> <br> 4) Technical guide not available, but some technical info can be found within the analysis <br> <br> 5) No technical documentation either in external document or within the analysis available to help users with future analysis adaptations."

#----DG4----
DG4tooltipmodelling <- "1) KIM protocols applied in full, including files stored in appropriate Office365 locations, with appropriate controlled access (only sensitive information not accessible by wider DfE colleagues). <br> <br> 2) KIM protocols applied, including files stored in appropriate Office365 locations, but access restricted more than DfE protocols advise. <br> <br> 3) Some KIM protocols applied, but files may not be stored in the most appropriate locations and/or access not widely granted. <br> <br> 4) No KIM protocols applied but files stored in a way that other analysts coming into the team would easily locate all relevant files. <br> <br> 5) No KIM protocols applied and files may be hard to locate."
DG4tooltipanalysis <- "1) KIM protocols applied in full, including files stored in appropriate Office365 locations, with appropriate controlled access (only sensitive information not accessible by wider DfE colleagues). <br> <br> 2) KIM protocols applied, including files stored in appropriate Office365 locations, but access restricted more than DfE protocols advise. <br> <br> 3) Some KIM protocols applied, but files may not be stored in the most appropriate locations and/or access not widely granted. <br> <br> 4) No KIM protocols applied but files stored in a way that other analysts coming into the team would easily locate all relevant files. <br> <br> 5) No KIM protocols applied and files may be hard to locate."
DG4tooltipdashboard <- "1) KIM protocols applied in full, including files stored in appropriate Office365 locations, with appropriate controlled access (only sensitive information not accessible by wider DfE colleagues). <br> <br> 2) KIM protocols applied, including files stored in appropriate Office365 locations, but access restricted more than DfE protocols advise. <br> <br> 3) Some KIM protocols applied, but files may not be stored in the most appropriate locations and/or access not widely granted. <br> <br> 4) No KIM protocols applied but files stored in a way that other analysts coming into the team would easily locate all relevant files. <br> <br> 5) No KIM protocols applied and files may be hard to locate."
DG4tooltipstatistics <- "1) KIM protocols applied in full, including files stored in appropriate Office365 locations, with appropriate controlled access (only sensitive information not accessible by wider DfE colleagues). <br> <br> 2) KIM protocols applied, including files stored in appropriate Office365 locations, but access restricted more than DfE protocols advise. <br> <br> 3) Some KIM protocols applied, but files may not be stored in the most appropriate locations and/or access not widely granted. <br> <br> 4) No KIM protocols applied but files stored in a way that other analysts coming into the team would easily locate all relevant files. <br> <br> 5) No KIM protocols applied and files may be hard to locate."

#----DG5----
DG5tooltipmodelling <- "1) A version log exists and follows a clear and logical versioning system. Detailed information of the changes performed and their impacts are included. <br> <br> 2) Version log and labelling exist and are largely complete but there are a few gaps or inconsistencies. <br> <br> 3) A version log and labelling system exists but not all the versions were logged or the descriptions of the changes performed are limited <br> <br> 4) No version log, but a version labelling makes it clear which model version is used <br> <br> 5) No version log and no version labelling"
DG5tooltipanalysis <- "1) A version log exists and follows a clear and logical versioning system. Detailed information of the changes performed and their impacts are included. <br> <br> 2) Version log and labelling exist and are largely complete but there are a few gaps or inconsistencies. <br> <br> 3) No version log, but version labelling makes it clear which version is used <br> <br> 4) No version log, but some version labelling, although incomplete <br> <br> 5) No version log and no version labelling"
DG5tooltipdashboard <- "1) A version log exists and follows a clear and logical versioning system. Detailed information of the changes performed and their impacts are included. <br> <br> 2) Version log and labelling exist and are largely complete but there are a few gaps or inconsistencies. <br> <br> 3) No version log, but version labelling makes it clear which version is used <br> <br> 4) No version log, but some version labelling, although incomplete <br> <br> 5) No version log and no version labelling"
DG5tooltipstatistics <- "1) A version log exists and follows a clear and logical versioning system. Detailed information of the changes performed and their impacts are included. <br> <br> 2) Version log and labelling exist and are largely complete but there are a few gaps or inconsistencies. <br> <br> 3) A version log and labelling system exists but not all the versions were logged or the descriptions of the changes performed are limited <br> <br> 4) No version log, but a version labelling makes it clear which analysis version is used <br> <br> 5) No version log and no version labelling"

#----DG6----
DG6tooltipmodelling <- "1) All roles identified and people are fully aware of their role and responsibilities and there is clear documentation of this. All are fully undertaking their responsibilities. <br> <br> 2) All roles identified and people are fully aware of their role and responsibilities and there is near complete documentation of this. All are fully undertaking their responsibilities. <br> <br> 3) People are undertaking these roles, but have not been explicitly named as such or may not be undertaking all aspects of the role. <br> <br> 4) Some of the roles are being undertaken, but people not fully aware of their responsibilities. <br> <br> 5) Insufficient evidence of allocation of roles and/or the requisite activities taking place."
DG6tooltipanalysis <- "1) All roles identified and people are fully aware of their role and responsibilities and there is clear documentation of this (this could be an email trail). All are fully undertaking their responsibilities. <br> <br> 2) All roles identified and people are aware of their role and responsibilities and there is some documentation of this. <br> <br> 3) People are undertaking these roles, but have not been explicitly named as such or may not be undertaking all aspects of the role. <br> <br> 4) Some of the roles are being undertaken, but people not fully aware of their responsibilities. <br> <br> 5) Insufficient evidence of allocation of roles and/or the requisite activities taking place."
DG6tooltipdashboard <- "1) All roles identified and people are fully aware of their role and responsibilities and there is clear documentation of this (this could be an email trail). All are fully undertaking their responsibilities. <br> <br> 2) All roles identified and people are aware of their role and responsibilities and there is some documentation of this. <br> <br> 3) People are undertaking these roles, but have not been explicitly named as such or may not be undertaking all aspects of the role. <br> <br> 4) Some of the roles are being undertaken, but people not fully aware of their responsibilities. <br> <br> 5) Insufficient evidence of allocation of roles and/or the requisite activities taking place."
DG6tooltipstatistics <- "1) All roles identified and people are fully aware of their role and responsibilities and there is clear documentation of this. All are fully undertaking their responsibilities. <br> <br> 2) All roles identified and people are fully aware of their role and responsibilities and there is near complete documentation of this. All are fully undertaking their responsibilities. <br> <br> 3) People are undertaking these roles, but have not been explicitly named as such or may not be undertaking all aspects of the role. <br> <br> 4) Some of the roles are being undertaken, but people not fully aware of their responsibilities. <br> <br> 5) Insufficient evidence of allocation of roles and/or the requisite activities taking place."

#----DG7----
DG7tooltipmodelling <- "1) A QA plan exists and is clearly agreed by both analytical assurer and commissioner/model SRO. The plan is embedded within the overall work. Time and resources have been planned to address QA recommendations. <br> <br> 2) Near complete QA plan. Plan signed off by SRO and analytical assurer. Some uncertainty over time and resources. <br> <br> 3) Some evidence of QA plan. Plan not signed off by SRO and Analytical Assurer. Lack of clarity over time and resources. <br> <br> 4) Little evidence of QA plan. <br> <br> 5) No evidence of QA plan."
DG7tooltipanalysis <- "1) A QA plan exists and is clearly agreed by both analytical assurer and commissioner/ SRO. The plan is embedded within the overall work. Time and resources have been planned to address QA recommendations. <br> <br> 2) Near complete QA plan. Plan signed off by SRO and analytical assurer. Some uncertainty over time and resources. <br> <br> 3) Some evidence of QA plan. Plan not signed off by SRO and Analytical Assurer. Lack of clarity over time and resources. <br> <br> 4) Little evidence of QA plan. <br> <br> 5) No evidence of QA plan."
DG7tooltipdashboard <- "1) A QA plan exists and is clearly agreed by both analytical assurer and commissioner/SRO. The plan is embedded within the overall work. Time and resources have been planned to address QA recommendations. <br> <br> 2) Near complete QA plan. Plan signed off by SRO and analytical assurer. Some uncertainty over time and resources. <br> <br> 3) Some evidence of QA plan. Plan not signed off by SRO and Analytical Assurer. Lack of clarity over time and resources. <br> <br> 4) Little evidence of QA plan. <br> <br> 5) No evidence of QA plan."
DG7tooltipstatistics <- "1) A QA plan exists and is clearly agreed by both analytical assurer and commissioner/analysis SRO. The plan is embedded within the overall work. Time and resources have been planned to address QA recommendations. <br> <br> 2) Near complete QA plan. Plan signed off by SRO and analytical assurer. Some uncertainty over time and resources. <br> <br> 3) Some evidence of QA plan. Plan not signed off by SRO and Analytical Assurer. Lack of clarity over time and resources. <br> <br> 4) Little evidence of QA plan. <br> <br> 5) No evidence of QA plan."

#----DG8----
DG8tooltipmodelling <- "1) Clear and comprehensive record of all QA activities in the QA plan and any additional activity undertaken. The analytical assurer has scrutinised the activity and signed off. <br> <br> 2) Clear and comprehensive record of all QA activities in the QA plan and any additional activity undertaken. The analytical assurer has not yet signed off. <br> <br> 3) A record exists, but it is not clear that it covers all aspects of QA and has not been scrutinised. <br> <br> 4) Little evidence of QA record. <br> <br> 5) No evidence of QA record."
DG8tooltipanalysis <- "1) Clear and comprehensive record of all QA activities in the QA plan and any additional activity undertaken. The analytical assurer has scrutinised the activity and signed off. <br> <br> 2) Clear and comprehensive record of all QA activities in the QA plan and any additional activity undertaken. The analytical assurer has not yet signed off. <br> <br> 3) A record exists, but it is not clear that it covers all aspects of QA and has not been scrutinised. <br> <br> 4) Little evidence of QA record. <br> <br> 5) No evidence of QA record."
DG8tooltipdashboard <- "1) Clear and comprehensive record of all QA activities in the QA plan and any additional activity undertaken. The analytical assurer has scrutinised the activity and signed off. <br> <br> 2) Clear and comprehensive record of all QA activities in the QA plan and any additional activity undertaken. The analytical assurer has not yet signed off. <br> <br> 3) A record exists, but it is not clear that it covers all aspects of QA and has not been scrutinised. <br> <br> 4) Little evidence of QA record. <br> <br> 5) No evidence of QA record."
DG8tooltipstatistics <- "1) Clear and comprehensive record of all QA activities in the QA plan and any additional activity undertaken. The analytical assurer has scrutinised the activity and signed off. <br> <br> 2) Clear and comprehensive record of all QA activities in the QA plan and any additional activity undertaken. The analytical assurer has not yet signed off. <br> <br> 3) A record exists, but it is not clear that it covers all aspects of QA and has not been scrutinised. <br> <br> 4) Little evidence of QA record. <br> <br> 5) No evidence of QA record."

#----DG9----
DG9tooltipmodelling <- "Not required"
DG9tooltipanalysis <- "Not required"
DG9tooltipdashboard <- "Not required"
DG9tooltipstatistics <- "1) Clear and comprehensive record of all risks and issues, including mitigations and details of action undertaken.  Relevant stakeholders have scrutinised the log and signed off. <br> <br> 2) Clear and comprehensive record of all risks and issues, including miitigations and details of action undertaken. Not yet signed off. <br> <br> 3) A log exists, but it is not clear that it covers all risks and/or issues and has not been scrutinised. <br> <br> 4) Little evidence of a risks and issues log. <br> <br> 5) No evidence of a risks and issues log."

#----Structure and clarity----

#----SC1----
SC1tooltipmodelling <- "Note"
SC1tooltipanalysis <- "Note"
SC1tooltipdashboard <- "Note"
SC1tooltipstatistics <- "Note"

#----SC2----
SC2tooltipmodelling <- "Note"
SC2tooltipanalysis <- "Note"
SC2tooltipdashboard <- "Note"
SC2tooltipstatistics <- "Note"

#----SC3----
SC3tooltipmodelling <- "Note"
SC3tooltipanalysis <- "Note"
SC3tooltipdashboard <- "Note"
SC3tooltipstatistics <- "Note"

#----SC4----
SC4tooltipmodelling <- "Note"
SC4tooltipanalysis <- "Note"
SC4tooltipdashboard <- "Note"
SC4tooltipstatistics <- "Note"

#----SC5----
SC5tooltipmodelling <- "Note"
SC5tooltipanalysis <- "Note"
SC5tooltipdashboard <- "Note"
SC5tooltipstatistics <- "Note"

#----SC6----
SC6tooltipmodelling <- "Note"
SC6tooltipanalysis <- "Note"
SC6tooltipdashboard <- "Note"
SC6tooltipstatistics <- "Note"

#----SC7----
SC7tooltipmodelling <- "Note"
SC7tooltipanalysis <- "Note"
SC7tooltipdashboard <- "Note"
SC7tooltipstatistics <- "Note"

#----SC8----
SC8tooltipmodelling <- "Note"
SC8tooltipanalysis <- "Note"
SC8tooltipdashboard <- "Note"
SC8tooltipstatistics <- "Note"

#----SC9----
SC9tooltipmodelling <- "Note"
SC9tooltipanalysis <- "Note"
SC9tooltipdashboard <- "Note"
SC9tooltipstatistics <- "Note"