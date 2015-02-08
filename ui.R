library(shiny)

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Hello Shiny!"),
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    selectInput("param", 
                label = "Choose a parametrization of distribution",
                choices = c("Standard", "Alternative"),
                selected = "Standard"),
    sliderInput("alpha", label = "Alpha:",
                min = 0.5, max = 100, value = c(1),step= 0.05),
    sliderInput("beta", label = "Beta:",
                min = 0.5, max = 100, value = c(1),step= 0.05),
    sliderInput("mu", label = "Mu:",
                min = 0, max = 1, value = c(0.5),step= 0.05),
    sliderInput("phi", label = "Phi:",
                min = 0, max = 200, value = c(2),step= 0.05),
    sliderInput("obs", label = "Number of observations:", 
                min = 1,
                max = 1000, 
                value = 500)
  ),
  
  
  # Show a plot of the generated distribution
  mainPanel(
    plotOutput("distPlot"),
    verbatimTextOutput("summary"),
    textOutput("Alpha"),
    textOutput(""),
    textOutput(""),
    textOutput(""))
))