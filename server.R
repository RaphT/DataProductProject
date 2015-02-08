library(shiny)
library(ggplot2)
library(betareg)
# Define server logic required to generate, plot and estimate a beta distribution
shinyServer(function(input, output,session) {
#   Calculate the beta regression every time a slider is changed 
#   (two sliders are "deactivated" depending on the parametrization).
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
    # Beta regression to estimate the values of the distribution parameters
    model = betareg(x~-alpha-beta, link = "logit", link.phi = "log", data = dat)
    # Output both distribution and model for plotting
    list(dat, model)
  })
  # Displays the regression and density functions in the app.
  output$distPlot <- renderPlot({
    dat = as.data.frame(dist()[1])
    model = dist()[2]
    mu.fitted = plogis(coef(model[[1]])[1])
    phi.fitted = exp(coef(model[[1]])[2])
    alpha.fitted = mu.fitted*phi.fitted
    beta.fitted = phi.fitted*(1-mu.fitted)
    # Plot routing based on ggplot2 package
    p = ggplot(dat, aes(x=x)) + 
      geom_histogram(aes(y=..density..),
                     breaks=seq(0,1,by=0.011), 
                     colour="black", 
                     fill="white")+
      scale_x_continuous("")+
      scale_y_continuous("Density")+
      stat_function(fun=dbeta, args=list(shape1=mean(dat$alpha), shape2 = mean(dat$beta)),col = "red")+
      stat_function(fun=dbeta, args=list(shape1=alpha.fitted, shape2 = beta.fitted),col = "green")
    print(p)
  })
  #Shows the summary of the simulated distribution
  output$summary <- renderPrint({
    dat = dist()[[1]]
    summary(dat$x)
  })
  #Displays the estimated values of the parameters
  output$Alpha <- renderPrint({
    model = dist()[2]
    mu.fitted = plogis(coef(model[[1]])[1])
    phi.fitted = exp(coef(model[[1]])[2])
    alpha.fitted = mu.fitted*phi.fitted
    HTML(paste("Alpha = ", round(alpha.fitted,2)))
  })
  output$Beta <- renderPrint({
    model = dist()[2]
    mu.fitted = plogis(coef(model[[1]])[1])
    phi.fitted = exp(coef(model[[1]])[2])
    beta.fitted = phi.fitted*(1-mu.fitted)
    HTML(paste("Beta = ", round(beta.fitted,2)))
  })
  output$Mu <- renderPrint({
    model = dist()[2]
    mu.fitted = plogis(coef(model[[1]])[1])
    HTML(paste("Mu = ", round(mu.fitted,2)))
  })
  output$Phi <- renderPrint({
    model = dist()[2]
    phi.fitted = exp(coef(model[[1]])[2])
    HTML(paste("Phi = ", round(phi.fitted,2)))
  })
  
})
