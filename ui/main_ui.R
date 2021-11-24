tabPanel(title = "QA Log", value = "panel2", #button in navigation panel

#--------changing height of text boxes with text------         
         tags$head(
           tags$style(lapply(QAcheckslist,paste_summary)
           )
         ),

          tags$head(
            tags$style(lapply(QAcheckslist,paste_obs)
            )
          ),

          tags$head(
            tags$style(lapply(QAcheckslist,paste_out)
            )
          ),

          tags$head(
            tags$style(lapply(QAcheckslist,paste_assess)
            )
          ),

          tags$head(
            tags$style(lapply(QAcheckslist,paste_info)
            )
          ),
         
#-------colours in drop down menu----
         tags$head(
           tags$style(HTML("
        .option[data-value='1) Excellent'], .item[data-value='1) Excellent']{
          background: #32cd32 !important;
          color: black !important;
        }
        .option[data-value='2) Good'], .item[data-value='2) Good']{
          background: #a4c639 !important;
          color: black !important;
        }
        .option[data-value='3) Some issues'], .item[data-value='3) Some issues']{
          background: #ffff00 !important;
          color: black !important;
        }
        .option[data-value='4) Needs improvement'], .item[data-value='4) Needs improvement']{
          background: #ffa500 !important;
          color: black !important;
        }
        .option[data-value='5) Significant issues'], .item[data-value='5) Significant issues']{
          background: #ff0000 !important;
          color: black !important;
        }
        .option[data-value='N/A'], .item[data-value='N/A']{
          background: #d3d3d3 !important;
          color: black !important;
        }
        .option[data-value='TO BE CHECKED'], .item[data-value='TO BE CHECKED']{
          background: #00bfff !important;
          color: black !important;
        }
  "))),
#----UI----         
         h1(strong("QA Log"), align="center"),
#----Displaying project name, version, lead analyst, analytical assurer, BCM----
fixedRow(column(2, uiOutput("projectIDtext")),
         column(2, uiOutput("QAlogtypetext")),
         column(4, uiOutput("savedialogue"), align="right"),
         #making save warning appear in red!
         tags$head(tags$style("#savedialogue{color: red;
                                 font-size: 25px;
                                 font-style: italic;
                                 }")),
         tags$head(tags$style("#weights{color: red;
                                 font-size: 25px;
                                 font-style: italic;
                                 }")),
         column(4,textOutput("test1")),
#         column(4, dataTableOutput("writingtest")),
#         column(4, dataTableOutput("writingtest2")),
         column(2, actionButton("saveSQL", "Save"), align="center"),
         column(2, actionButton("backtohome","Back"), align="center")),
fixedRow(column(2, textInput("projectname", "Project name", value="")),
         column(2, textInput("version", "Version", value="")),
         column(2, textInput("leadanalyst", "Lead Analyst", value="")),
         column(2, textInput("analyticalassurer", "Analytical Assurer", value="")),
         column(2, selectizeInput("BCM", choices=c("Yes", "No"), selected="No", label="Business Critical")),
         column(2, downloadButton("report", "Generate QA Log"), align="center")),
#Edit pillar weighting, display overall score, display error messages
fixedRow(column(2, uiOutput("totalscorescolours")),
         column(2, br(), br(), actionButton("weighting","Edit pillar weighting")),
         column(8, uiOutput("mandatory_dialogue"),
                tags$head(tags$style("#mandatory_dialogue{
                                 font-style: italic;
                                 background-color: #00bfff
                                 }")),
                uiOutput("mandatory_dialogueNA"),
                tags$head(tags$style("#mandatory_dialogueNA{
                                 font-style: italic;
                                 background-color: #d3d3d3
                                 }")),
                uiOutput("significant_dialogue"),
                tags$head(tags$style("#significant_dialogue{
                                 font-style: italic;
                                 background-color: #ff0000
                                 }")))),
#----Scores------
fixedRow(column(2,uiOutput("DGscorescolours")),
         column(2,uiOutput("SCscorescolours")),
         column(2,uiOutput("VEscorescolours")),
         column(2,uiOutput("VAscorescolours")),
         column(2,uiOutput("DAscorescolours")),
         column(2, actionButton("previous","Previous versions"))),

br(),

#----DG checks----
fixedRow(
   tabBox(width=12,
        tabPanel("Documentation and Governance",
              h4("Documentation and Governance"),
              hr(),
              uiOutput("DGuichecks")
              ),
#----SC checks-----
       tabPanel("Structure and Clarity",
                h4("Structure and Clarity"),
                hr(),
                uiOutput("SCuichecks")
       ),      
#----VE Checks----
       tabPanel("Verification",
                h4("Verification"),
                hr(),
                uiOutput("VEuichecks")
       ),

#----VA checks-----
       tabPanel("Validation",
                h4("Validation"),
                hr(),
                uiOutput("VAuichecks")
       ),

#----DA checks----
       tabPanel("Data and Assumptions",
                h4("Data and Assumptions"),
                hr(),
                uiOutput("DAuichecks")
       )
)
),

#----Tooltips----
uiOutput("tooltips"),
tags$style(HTML(".tooltip {width: 1000px;}")),
HTML("<br><br><br>"),

)
