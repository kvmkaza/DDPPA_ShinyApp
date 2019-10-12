library(shiny)

data("airquality")

shinyUI(fluidPage(
    
    titlePanel("New York Air Quality Measurements"),

    fluidRow(
        column(3,    
            
            dateRangeInput("selDateRange", "Select Dates:", start = "1973-05-01", end="1973-05-31",
                           min = "1973-05-01", max = "1973-09-30", format = "mm/dd/yyyy"),
            
            actionButton("shData", "Retrieve Data"),
            hr(),
            checkboxGroupInput("dataVar","Data to Show:",
                               c("Ozone"="Ozone",
                                 "Solar Radiation"="Solar.R",
                                 "Wind"="Wind",
                                 "Temperature"="Temp"), 
                               selected = c("Ozone")),
            
            sliderInput("numrows", "Number of Rows to Display:",
                        min = 1, max = nrow(airquality), value = 1),
            hr(),
            h5(strong("Seasonal Variation Plot:")),
            fluidRow(
                column(6,
                       radioButtons("plotDate","",c("Date"="Date"))          
                       ),
                column(6,
                       radioButtons("plotVar", "Select:",
                                    c("Ozone"="Ozone",
                                      "Solar Radiation"="Solar.R",
                                      "Wind"="Wind",
                                      "Temperature"="Temp"), 
                                    selected = c("Ozone"))
                       )
            )
        ),
          column(9,
            tabsetPanel(type="tabs",
                        tabPanel("Data", textOutput("opCnt"), br(), tableOutput("data")),
                        tabPanel("Summary", verbatimTextOutput("sdVar"), br(), verbatimTextOutput("summ")),
                        tabPanel("Plot", textOutput("plotV"), br(), plotOutput("plot")),
                        tabPanel("Documentation", 
                                h3("Shiny Application Usage Guidelines:", hr()),
                                h5(strong("Step1: "), em("Select desired Date Range from calendar controls and click on "),
                                                           strong("Retrieve Data"),em("button")),
                                h5(strong("Step2: "), em("Data to Show: Choose Variables to display (with checkboxes)")),
                                h5(strong("Step3: "), em("Use Slidebar to change number of rows to display")),
                                h6(em("(The number of available records for the selected date range is shown at the header)")),
                                h5(strong("Step4: "), em("Change to "),strong("Summary "),
                                   em("tab to view the data summary for the selected variables \n like Standard Deviation, Variance and other summary info")),
                                h5(strong("Step5: "), em("Change to "),strong("Plot "), em("tab to view the Seasonal variation plots")),
                                h5(strong("Step6: "), em("Seasonal Variations Plot: Choose Variables to Plot against Date (with radiobuttons)"))
                                )
            )
        )
    )
))

