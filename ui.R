library(shiny)
require(markdown)

shinyUI(fluidPage(
  title = "Beta distribution Explorer",
  #Setup Introduction and Plot tabs
  tabsetPanel(
    tabPanel("Introduction",includeMarkdown("README.md")),
    tabPanel("Plot",plotOutput('distPlot'))
  ),
  #Setup control parameters row
  fluidRow(
    column(3,
           h4("Control parameters"),
           sliderInput("alpha", label = "Alpha:",
                       min = 0.5, max = 20, value = c(1),step= 0.05),
           sliderInput("beta", label = "Beta:",
                       min = 0.5, max = 20, value = c(1),step= 0.05),
           sliderInput("obs", label = "Number of observations:", 
                       min = 1,
                       max = 1000, 
                       value = 500)
    ),
    column(3,
           h4(""),
           selectInput("param", 
                         label = "Choose a parametrization of distribution",
                         choices = c("Standard", "Alternative"),
                         selected = "Standard"),
           sliderInput("mu", label = "Mu:",
                       min = 0.01, max = 0.99, value = c(0.5),step= 0.05),
           sliderInput("phi", label = "Phi:",
                       min = 0, max = 40, value = c(2),step= 0.05)),
    column(6,
           h4("Distribution summary"),
           verbatimTextOutput("summary"),
           h4("Regression coefficients"),
           textOutput("Alpha"),
           textOutput("Beta"),
           textOutput("Mu"),
           textOutput("Phi"))
  )
))