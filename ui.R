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
                min = 0, max = 100, value = c(1),step= 0.5),
    sliderInput("beta", label = "Beta:",
                min = 0, max = 100, value = c(1),step= 0.5),
    sliderInput("obs", label = "Number of observations:", 
                min = 1,
                max = 10000, 
                value = 5000)
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    plotOutput("distPlot"),
    verbatimTextOutput("summary")
  )
))