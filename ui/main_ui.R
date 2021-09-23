tabPanel("Edit info", #button in navigation panel
         h1(strong("QA Log"), align="center"),
         fluidRow(column(6,
                         uiOutput("scoreDG",style="Background-color: #d4f7d2;"))),
         fluidRow(
           column(12,
                  h2("Documentation and Governance")
           )
         ),
         fluidRow(
           column(2, h4("Scope and Specification")),
           column(2, uiOutput("scoreSelectorDG1"))
         ),
         fluidRow(
           column(2, h4("User guide")),
           column(2, uiOutput("scoreSelectorDG2"))
         ),
         fluidRow(
           column(2, h4("Technical guide")),
           column(2, uiOutput("scoreSelectorDG3"))
         ),
         fluidRow(
           column(2, h4("KIM")),
           column(2, uiOutput("scoreSelectorDG4"))
         ),
         fluidRow(
           column(2, h4("Version control")),
           column(2, uiOutput("scoreSelectorDG5"))
         ),
         fluidRow(
           column(2, h4("Responsibilities")),
           column(2, uiOutput("scoreSelectorDG6"))
         ),
         fluidRow(
           column(2, h4("QA planning and resourcing")),
           column(2, uiOutput("scoreSelectorDG7"))
         ),
         fluidRow(
           column(2, h4("Record of QA")),
           column(2, uiOutput("scoreSelectorDG8"))
         ),
         fluidRow(
           column(2, downloadButton("report", "Generate QA Log"))
         )
)
