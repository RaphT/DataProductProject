library(shiny)
library(ggplot2)
library(betareg)
# Define server logic required to generate and plot a beta distribution
shinyServer(function(input, output,session) {
  alpha.fitted = numeric()
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
    dat = data.frame(x = rbeta(input$obs, alpha, beta), alpha = alpha, beta = beta)
    model = betareg(x~-alpha-beta, link = "logit", link.phi = "log", data = dat)
    list(dat, model)
#     print(alpha.fitted)
#     print(beta.fitted)
  })

  output$distPlot <- renderPlot({
    dat = as.data.frame(dist()[1])
    model = dist()[2]
#     print(coef(model[[1]]))
    
#     print(summary(model))
    p = ggplot(dat, aes(x=x)) + 
       geom_histogram( aes(y=..density..),
                       breaks=seq(0,1,by=0.011), 
                       colour="red", 
                       fill="white")+
       stat_function(fun=dbeta, args=list(shape1=mean(dat$alpha), shape2 = mean(dat$beta)))
     print(p)
  })
  output$summary <- renderPrint({
      summary(dist()[1])
  })
  output$Alpha <- renderPrint({
    model = dist()[2]
    mu.fitted = plogis(coef(model[[1]])[1])
    phi.fitted = exp(coef(model[[1]])[2])
    alpha.fitted = mu.fitted*phi.fitted
    beta.fitted = phi.fitted*(1-mu.fitted)
    print(paste("Alpha = ", round(alpha.fitted,2),"\n"))
    print(paste("Beta = ", round(beta.fitted,2),"\n"))
    print(paste("Mu = ", round(mu.fitted,2),"\n"))
    print(paste("Phi = ", round(phi.fitted,2),"\n"))
    
  })
  
})
