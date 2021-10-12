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
         column(6, actionButton("backtohome","Back"), align="right")),
fluidRow(column(2, textInput("projectname", "Project name", value="")),
         column(2, textInput("version", "Version", value="")),
         column(2, textInput("leadanalyst", "Lead Analyst", value="")),
         column(2, textInput("analyticalassurer", "Analytical Assurer", value="")),
         column(2, selectizeInput("BCM", choices=c("Yes", "No"), selected="No", label="Business Critical"))),
#----Colours for DG score----
fluidRow(column(4,
conditionalPanel(
  condition = ("output.scorecolour == 'GREEN'"),
         fluidRow(column(6,
           uiOutput("scoreDGgreen",style="Background-color: #32cd32;")))),
conditionalPanel(
  condition = ("output.scorecolour == 'YELLOW'"),
         fluidRow(column(6,
           uiOutput("scoreDGyellow",style="Background-color: #ffff00;")))),
conditionalPanel(
  condition = ("output.scorecolour == 'ORANGE'"),
  fluidRow(column(6,
                  uiOutput("scoreDGorange",style="Background-color: #ffa500;")))),
conditionalPanel(
  condition = ("output.scorecolour == 'RED'"),
  fluidRow(column(6,
                  uiOutput("scoreDGred",style="Background-color: #ff0000;")))),
)),
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
         UI_check("DG1","Scope and Specification"),
         UI_check("DG2","User guide"),
         conditionalPanel(
         condition="input.QAlogtype == 'Official Statistics' || input.QAlogtype == 'Modelling'",
         UI_check("DG3","Technical guide")
         ),
         UI_check("DG4","KIM"),
         UI_check("DG5", "Version control"),
         UI_check("DG6", "Responsibilities"),
         UI_check("DG7", "QA planning and resourcing"),
         UI_check("DG8", "Record of QA"),
         conditionalPanel(
           condition="input.QAlogtype == 'Official Statistics'",
           UI_check("DG9","Risk and Issues log")
         ),

#----Generate HTML and saving to SQL----
         fluidRow(
           column(2, downloadButton("report", "Generate QA Log")),
           column(2, actionButton("saveSQL", "Save"))
         )
)
