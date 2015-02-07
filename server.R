library(shiny)

# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output,session) {
  
 
dist <- reactive({
  val <- input$param
  if(val == "Alternative"){
    alpha = input$mu*input$phi
    beta = input$phi * (1- input$mu)
    updateSliderInput(session, "alpha", label = "alpha", value = alpha)
    updateSliderInput(session, "beta", label = "beta", value= beta)
  } else {
    alpha = input$alpha
    beta = input$beta
    mu = alpha/(alpha+beta)
    phi = alpha + beta
    updateSliderInput(session, "mu", label = "mu", value = mu)
    updateSliderInput(session, "phi", label = "phi", value = phi)  
  }
#   print(alpha)
#   print(beta)
  rbeta(input$obs, alpha, beta)
})

  output$distPlot <- renderPlot({
     hist(dist(), breaks = input$obs/100)
  })
  output$summary <- renderPrint({
      summary(dist())
  })
  
})
