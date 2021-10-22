tabPanel(title = "QA Log", value = "panel2", #button in navigation panel
         
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
fluidRow(column(2, uiOutput("projectIDtext")),
         column(2, uiOutput("QAlogtypetext")),
         column(4, uiOutput("savedialogue"), align="right"),
         #making save warning appear in red!
         tags$head(tags$style("#savedialogue{color: red;
                                 font-size: 25px;
                                 font-style: italic;
                                 }")),
         #column(4, dataTableOutput("writingtest")),
         #column(4, dataTableOutput("writingtest2")),
         column(2, actionButton("backtohome","Back"), align="right")),
fluidRow(column(2, textInput("projectname", "Project name", value="")),
         column(2, textInput("version", "Version", value="")),
         column(2, textInput("leadanalyst", "Lead Analyst", value="")),
         column(2, textInput("analyticalassurer", "Analytical Assurer", value="")),
         column(2, selectizeInput("BCM", choices=c("Yes", "No"), selected="No", label="Business Critical"))),
#Scores
fluidRow(column(2,uiOutput("DGscorescolours")),
         column(2,uiOutput("SCscorescolours")),
         column(2,uiOutput("VEscorescolours")),
         column(2,uiOutput("VAscorescolours")),
         column(2,uiOutput("DAscorescolours"))),

#----DG checks----
         fluidRow(
           column(12,
                  h2("Documentation and Governance")
           )
         ),
         fluidRow(
           column(2, h5("QA area")),
           column(2, h5("Rating")),
           column(2, h5("Assessed by")),
           column(2, h5("Summary of/link to QA outcome or evidence")),
           column(2, h5("Observations")),
           column(2, h5("Outstanding (potential) work"))
         ),
        uiOutput("DGuichecks"),
#----SC checks-----
        fluidRow(
          column(12,
                 h2("Structure and Clarity")
          )
        ),
        fluidRow(
          column(2, h5("QA area")),
          column(2, h5("Rating")),
          column(2, h5("Assessed by")),
          column(2, h5("Summary of/link to QA outcome or evidence")),
          column(2, h5("Observations")),
          column(2, h5("Outstanding (potential) work"))
        ),
        uiOutput("SCuichecks"),
#----VE Checks----
        fluidRow(
          column(12,
                 h2("Verification")
          )
        ),
        fluidRow(
          column(2, h5("QA area")),
          column(2, h5("Rating")),
          column(2, h5("Assessed by")),
          column(2, h5("Summary of/link to QA outcome or evidence")),
          column(2, h5("Observations")),
          column(2, h5("Outstanding (potential) work"))
        ),
        uiOutput("VEuichecks"),

#----VA checks-----
        fluidRow(
          column(12,
                 h2("Validation")
          )
        ),
        fluidRow(
          column(2, h5("QA area")),
          column(2, h5("Rating")),
          column(2, h5("Assessed by")),
          column(2, h5("Summary of/link to QA outcome or evidence")),
          column(2, h5("Observations")),
          column(2, h5("Outstanding (potential) work"))
        ),
        uiOutput("VAuichecks"),

#----DA checks----

        fluidRow(
          column(12,
                 h2("Data and assumptions")
          )
        ),
        fluidRow(
          column(2, h5("QA area")),
          column(2, h5("Rating")),
          column(2, h5("Assessed by")),
          column(2, h5("Summary of/link to QA outcome or evidence")),
          column(2, h5("Observations")),
          column(2, h5("Outstanding (potential) work"))
        ),
        uiOutput("DAuichecks"),

#----Tooltips----
uiOutput("tooltips"),
tags$style(HTML(".tooltip {width: 1000px;}")),
HTML("<br><br><br>"),
#----Generate HTML and saving to SQL----
         fluidRow(
           column(2, downloadButton("report", "Generate QA Log")),
           column(2, actionButton("saveSQL", "Save"))
         )
)
