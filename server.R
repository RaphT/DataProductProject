library(shiny)

# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output,session) {
  
  # Expression that generates a plot of the distribution. The expression
  # is wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should be automatically 
  #     re-executed when inputs change
  #  2) Its output type is a plot 
  #
  dist <- reactive({
    val <- input$param
    if(val == "Alternative"){
      alpha = input$alpha*input$beta
      beta = input$beta * (1- input$alpha)
      rbeta(input$obs, alpha, beta)
    } else {
      rbeta(input$obs, input$alpha, input$beta)
    }
  })
  
  observe({
    val <- input$param
    if(val == "Alternative"){
      updateSliderInput(session, "alpha", label = "mu",min = 0, max = 1)
      updateSliderInput(session, "beta", label = "phi", min = 1, max = 100)
    } else {
      updateSliderInput(session, "alpha", label = "alpha", min = 0, max = 100)
      updateSliderInput(session, "beta", label = "beta", min = 0, max = 100)
    }
  })

  output$distPlot <- renderPlot({
    hist(dist(), breaks = input$obs/100)
  })
  output$summary <- renderPrint({
      summary(dist())
  })
  
})
