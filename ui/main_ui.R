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
         column(2, textInput("projectname", "Project name", value="")),
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
         fluidRow(
           column(2, h6("Scope and Specification")),
           column(2, rating_options("scoreDG1")),
           column(2, textInput("assessDG1",label=NULL, value="")),
           column(2, textInput("summaryDG1", label=NULL, value="")),
           column(2, textInput("obsDG1", label=NULL, value="")),
           column(2, textInput("outDG1", label=NULL, value=""))
         ),
         fluidRow(
           column(2, h6("User guide")),
           column(2, rating_options("scoreDG2")),
           column(2, textInput("assessDG2",label=NULL, value="")),
           column(2, textInput("summaryDG2", label=NULL, value="")),
           column(2, textInput("obsDG2", label=NULL, value="")),
           column(2, textInput("outDG2", label=NULL, value=""))
         ),
         fluidRow(
           column(2, h6("Technical guide")),
           column(2, rating_options("scoreDG3")),
           column(2, textInput("assessDG3",label=NULL, value="")),
           column(2, textInput("summaryDG3", label=NULL, value="")),
           column(2, textInput("obsDG3", label=NULL, value="")),
           column(2, textInput("outDG3", label=NULL, value=""))
         ),
         fluidRow(
           column(2, h6("KIM")),
           column(2, rating_options("scoreDG4")),
           column(2, textInput("assessDG4",label=NULL, value="")),
           column(2, textInput("summaryDG4", label=NULL, value="")),
           column(2, textInput("obsDG4", label=NULL, value="")),
           column(2, textInput("outDG4", label=NULL, value=""))
         ),
         fluidRow(
           column(2, h6("Version control")),
           column(2, rating_options("scoreDG5")),
           column(2, textInput("assessDG5",label=NULL, value="")),
           column(2, textInput("summaryDG5", label=NULL, value="")),
           column(2, textInput("obsDG5", label=NULL, value="")),
           column(2, textInput("outDG5", label=NULL, value=""))
         ),
         fluidRow(
           column(2, h6("Responsibilities")),
           column(2, rating_options("scoreDG6")),
           column(2, textInput("assessDG6",label=NULL, value="")),
           column(2, textInput("summaryDG6", label=NULL, value="")),
           column(2, textInput("obsDG6", label=NULL, value="")),
           column(2, textInput("outDG6", label=NULL, value=""))
         ),
         fluidRow(
           column(2, h6("QA planning and resourcing")),
           column(2, rating_options("scoreDG7")),
           column(2, textInput("assessDG7",label=NULL, value="")),
           column(2, textInput("summaryDG7", label=NULL, value="")),
           column(2, textInput("obsDG7", label=NULL, value="")),
           column(2, textInput("outDG7", label=NULL, value=""))
         ),
         fluidRow(
           column(2, h6("Record of QA")),
           column(2, rating_options("scoreDG8")),
           column(2, textInput("assessDG8",label=NULL, value="")),
           column(2, textInput("summaryDG8", label=NULL, value="")),
           column(2, textInput("obsDG8", label=NULL, value="")),
           column(2, textInput("outDG8", label=NULL, value=""))
         ),

#----Generate HTML and saving to SQL----
         fluidRow(
           column(2, downloadButton("report", "Generate QA Log")),
           column(2, actionButton("saveSQL", "Save"))
         )
)
