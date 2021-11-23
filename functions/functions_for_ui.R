#These functions must be called before UI is read in
#So they cannot be included in server scripts

#Different rating options
rating_options <- function(score_index){selectizeInput(score_index, 
                                                       choices=c("1) Excellent",
                                                                 "2) Good",
                                                                 "3) Some issues",
                                                                 "4) Needs improvement",
                                                                 "5) Significant issues",
                                                                 "N/A",
                                                                 "TO BE CHECKED"
                                                       ),
                                                       selected="TO BE CHECKED", label=NULL)}


#Generating UI for different checks
UI_check <- function(checkID,types,names_df){
  check_row <- names_df%>%filter(QAcheckslist==checkID)
  checkname <- (check_row%>%select(paste0(types$log,"_names")))[1,1]
  mandatory <- (check_row%>%select(paste0(types$log,"_mandatory")))[1,1]
  style_mandatory <- if(mandatory == 1){"color: #fff; background-color: #ce2029; border-color: #a9203e"} else {""}
  uicheck <- fixedRow(fixedRow(
      column(2, actionButton(paste(checkID,"info",sep=""), HTML(checkname), style=style_mandatory)),
      column(2, fixedRow(rating_options(paste("score",checkID,sep=""))),
             fixedRow(withTags(div(textarea(id = paste("assess",checkID,sep=""),placeholder="Assessed by"))))),
      column(3, withTags(div(textarea(id = paste("summary",checkID,sep=""),placeholder="Summary of evidence")))),
      column(1, actionButton(paste(checkID,"link",sep=""), "Links"), align="center"),
      column(4, fixedRow(withTags(div(textarea(id = paste("obs",checkID,sep=""),placeholder="Observations")))),br(),
                fixedRow(withTags(div(textarea(id = paste("out",checkID,sep=""),placeholder="Outstanding (potential) work")))))
      ),
      hr(), br())
  return(uicheck)
}

scorecolour<-function(scores,colours){
  uiOutput(scores,style=colours)
}

#generating some html code for text boxes
paste_summary <- function(checkid){
  paste0("#summary",checkid, " {height:110px; width:100%}")
}

paste_obs <- function(checkid){
  paste0("#obs",checkid, " {width:100%}")
}

paste_out <- function(checkid){
  paste0("#out",checkid, " {width:100%}")
}

paste_assess <- function(checkid){
  paste0("#assess",checkid, " {width:100%}")
}

paste_info <- function(checkid){
  paste0("#",checkid,"info {height:110px; width:100%}")
}