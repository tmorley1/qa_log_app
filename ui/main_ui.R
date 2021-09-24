tabPanel("Edit info", #button in navigation panel
         
         #colours in drop down menu
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
         
         h1(strong("QA Log"), align="center"),
         fluidRow(column(6,
           uiOutput("scoreDG",style="Background-color: #d4f7d2;"))),
         fluidRow(
           column(12,
                  h2("Documentation and Governance")
           )
         ),
         fluidRow(
           column(2, h6("Scope and Specification")),
           column(2, uiOutput("scoreSelectorDG1"))
         ),
         fluidRow(
           column(2, h6("User guide")),
           column(2, uiOutput("scoreSelectorDG2"))
         ),
         fluidRow(
           column(2, h6("Technical guide")),
           column(2, uiOutput("scoreSelectorDG3"))
         ),
         fluidRow(
           column(2, h6("KIM")),
           column(2, uiOutput("scoreSelectorDG4"))
         ),
         fluidRow(
           column(2, h6("Version control")),
           column(2, uiOutput("scoreSelectorDG5"))
         ),
         fluidRow(
           column(2, h6("Responsibilities")),
           column(2, uiOutput("scoreSelectorDG6"))
         ),
         fluidRow(
           column(2, h6("QA planning and resourcing")),
           column(2, uiOutput("scoreSelectorDG7"))
         ),
         fluidRow(
           column(2, h6("Record of QA")),
           column(2, uiOutput("scoreSelectorDG8"))
         ),
         fluidRow(
           column(2, downloadButton("report", "Generate QA Log"))
         )
)
