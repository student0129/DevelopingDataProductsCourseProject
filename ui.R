library(shiny)
library(shinythemes)
shinyUI(navbarPage("Course Project",
                   tabPanel("Information",
                            h2("Course Project for Developing Data Products"),
                            h4("In this model, the MPG is predicted based on two models:"),
                            tags$ol(
                                    tags$li("One model uses a linear regression with horsepower as the predictor variable."), 
                                    tags$li("The second model uses a quadatic regression with horsepower as the predictor variable.")
                            ),
                            h4("The user can also do the following:"),
                            tags$ol(
                                    tags$li("Select a subset of data based on the number of cylinders."),
                                    tags$li("Add confidence bounds to each model.")
                            ),
                            h4("Finaly, MPG for a hypothetical car with a chosen horsepower will be deisplayed based on selected model(s)."),
                            h4("Source code:", a("http://", href="http://", target = "_blank")),
                            h4("Presentation:", a("http://", href="http://", target = "_blank"))
                   ),
                   tabPanel("Application",
                           fluidPage(
                                   theme = shinytheme("superhero"),
                                   titlePanel("Predicting MPG from Horsepower"),
                                   sidebarLayout(
                                           sidebarPanel(
                                                   sliderInput("sliderHP", "What is the HP of the car?", 50, 350, value = 150),
                                                   checkboxGroupInput("ncyl", "n-Cylinder Cars To Include:",
                                                                      c("4" = "4",
                                                                        "6" = "6",
                                                                        "8" = "8"), 
                                                                      selected = c("4","6","8")),
                                                   checkboxInput("showModel1", "Show/Hide Linear Model", value = TRUE),
                                                   checkboxInput("showModel2", "Show/Hide Quadratic Model", value = TRUE),
                                                   checkboxInput("showSE", "Show/Hide Confidence Interval", value = FALSE),
                                                   submitButton("Submit")
                                                   ),
                                           mainPanel(
                                                   plotOutput("plot1"),
                                                   h3("Predicted MPG from Linear Model:"),
                                                   textOutput("pred1"),
                                                   h3("Predicted MPG from Quadratic Model:"),
                                                   textOutput("pred2")
                                                   )
                                           )
                                   )
                   )
))
