shinyUI(
  # Use a fluid Bootstrap layout
  fluidPage(
    # Give the page a title
    titlePanel("2017 DC Crime Statistics"),
    sidebarPanel(
    # Provide some help text to let user knows the meanings of the results
    helpText("Please choose a crime type."),
    selectInput("select", label = h3("Crime Type"), 
                choices = c(unique(as.character(crime$OFFENSE))), # Create a choice for each type
                selected = 1),
    hr(),
    helpText("WEAPON :"),
    #provide the summary about the weapon, time, district and sum.
    fluidRow(column(12, verbatimTextOutput("method"))),
    helpText("TIME :"),
    fluidRow(column(12, verbatimTextOutput("shift"))),
    helpText("DISTRICT :"),
    fluidRow(column(12, verbatimTextOutput("district"))),
    helpText("SUM :"),
    fluidRow(column(12, verbatimTextOutput("sum")))),
    
    mainPanel(leafletOutput("map"))
  )
)
