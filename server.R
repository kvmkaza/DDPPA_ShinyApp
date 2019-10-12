library(shiny)

shinyServer(function(input, output) {

    data("airquality")
    
    airquality$Date <- as.Date(paste("1973",airquality$Month, airquality$Day, sep="-"), 
                                             format="%Y-%m-%d")
    airquality$Month <- factor(airquality$Month, levels=c(5,6,7,8,9),
                               labels = c("May","June","July","Aug","Sep"))
    
    dateSt <- reactive({ format(input$selDateRange[1],format="%Y-%m-%d")})
    dateEnd <- reactive({ format(input$selDateRange[2],format="%Y-%m-%d")})
    
    dataOP <- eventReactive(input$shData, {
            airquality[(airquality$Date >= dateSt() & airquality$Date <= dateEnd()),]
                 })
    
    output$opCnt <- renderText({paste("Number of Rows: ",nrow(dataOP()))})
    output$data <- renderTable({head(dataOP()[,input$dataVar, drop=FALSE],input$numrows)})
    output$sdVar <- renderPrint({
      as.data.frame(sapply(dataOP()[input$dataVar], function(x) c(sd(x, na.rm=TRUE),var(x, na.rm = TRUE))), 
                    row.names = c("Std. Deviation","Variance"))
      })
    output$summ <- renderPrint({ 
      summary(dataOP()[input$dataVar])})
    
    output$plot <-  renderPlot({
      boxplot(get(input$plotVar) ~ airquality$Month, airquality, xlab = "Month", ylab = input$plotVar, 
              col=c("blue","green","bisque","red","orange"), main=c("Seasonal Variation of ",input$plotVar))
          })
})
