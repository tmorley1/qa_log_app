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
  uicheck <- fluidRow(
      column(2, actionButton(paste(checkID,"info",sep=""), checkname)),
      column(2, rating_options(paste("score",checkID,sep=""))),
      column(2, textInput(paste("assess",checkID,sep=""),label=NULL, value="")),
      column(2, textInput(paste("summary",checkID,sep=""), label=NULL, value="")),
      column(2, textInput(paste("obs",checkID,sep=""), label=NULL, value="")),
      column(2, textInput(paste("out",checkID,sep=""), label=NULL, value=""))
    )
  return(uicheck)
}

scorecolour<-function(scores,colours){
  uiOutput(scores,style=colours)
}