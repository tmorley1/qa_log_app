#---Functions for calling inputs----
test <- reactiveValues(log= "blank")

output$test1 <- renderText(paste(test$log))

scoreinputs <- function(checkid){
  #read in check name
  check_row <- names_df%>%filter(QAcheckslist==checkid)
  checkname <- (check_row%>%select(paste0(types$log,"_names")))[1,1]
  checkname_nobr <- str_replace_all(checkname,"<br> ", "")
  #read in score
  score <- eval(parse(text=paste0("input$score",checkid)))
  #read in comments
  assessor <- eval(parse(text=paste0("input$assess",checkid)))
  obs <- eval(parse(text=paste0("input$obs",checkid)))
  out <- eval(parse(text=paste0("input$out",checkid)))
  
  # #read in links
   linksdf <- as.data.frame(links$log)%>%
     filter(projectID==input$projectID)%>%
     filter(checkID==checkid)%>%
     mutate(Hyperlink=createLink(Link))%>%
     select(-projectID,-checkID,-LinkID,-Link)
   df_length <- nrow(linksdf)
    if (df_length == 0){
      link<-""
    }
    else {
      listlinks <- list(1:df_length)[[1]]
      link_pasted <- paste(unlist(lapply(listlinks,paste_link, linksdf=linksdf)), collapse=" <br />")
      link<-link_pasted
    }
    
   test$log<-link

  #paste all together
  pastescore <- paste0(checkname_nobr,": <br /> Rating: ", score, " <br /> Assessed by: ", assessor, " <br /> Observations: ", obs, " <br /> Outstanding (potential) work: ", out, " <br /> Links: ", link, " <br /> <br />")
  return(pastescore)
}

 #function for pasting in links
 paste_link <- function(rownumber,linksdf){
   link <- linksdf[rownumber,]
   return(paste(link))
 }

#---- Creating HTML report----
output$report <- downloadHandler(
  # For pdf output, change this to "report.pdf"
  filename = "report.html",
  content = function(file) {
    # Copy the report file to a temporary directory before processing it, in
    # case we don't have write permissions to the current working dir (which
    # can happen when deployed).
    tempReport <- file.path(tempdir(), "report.Rmd")
    file.copy(paste(pathway,"\\report.Rmd", sep=""), tempReport, overwrite = TRUE)
    
    # Set up parameters for Documentation and Governance to pass to Rmd document
    params <- list(id = input$projectID,
                   name = input$projectname,
                   version = input$version,
                   leadanalyst = input$leadanalyst,
                   analyticalassurer = input$analyticalassurer,
                   totalscore = totalscore(),
                   DGscore = scoresfunc(justDGchecks()),
                   SCscore = scoresfunc(justSCchecks()),
                   VEscore = scoresfunc(justVEchecks()),
                   VAscore = scoresfunc(justVAchecks()),
                   DAscore = scoresfunc(justDAchecks()),
                   DGchecks=sapply(justDGchecks(),scoreinputs),
                   SCchecks=sapply(justSCchecks(),scoreinputs),
                   VEchecks=sapply(justVEchecks(),scoreinputs),
                   VAchecks=sapply(justVAchecks(),scoreinputs),
                   DAchecks=sapply(justDAchecks(),scoreinputs),
                   BCM = input$BCM)
    
    # Knit the document, passing in the `params` list, and eval it in a
    # child of the global environment (this isolates the code in the document
    # from the code in this app).
    rmarkdown::render(tempReport, output_file = file,
                      params = params,
                      envir = new.env(parent = globalenv())
    )
  }
)
