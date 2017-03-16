library(shiny)
library(ggplot2)
library(ggthemes)
shinyServer(function(input, output) {
        mydata <- reactive({
                mtcars[mtcars$cyl %in% input$ncyl,]
        })
        
        model1 <- reactive({
                lm(mpg ~ hp, data = mydata())
        })
        
        model2 <- reactive({
                lm(mpg ~ poly(hp,2), data = mydata())
        })
        
        model1pred <- reactive({
                hpInput <- input$sliderHP
                predict(model1(), newdata = data.frame(hp = hpInput))
        })
        
        model2pred <- reactive({
                hpInput <- input$sliderHP
                predict(model2(), newdata = 
                                data.frame(hp = hpInput))
        })
        
        output$plot1 <- renderPlot({
                validate(need(length(input$ncyl) > 0, "No data selected!"))
                hpInput <- input$sliderHP
                
                p <- ggplot(mydata(), aes(hp, mpg)) + 
                        geom_point(aes(colour=factor(cyl), size = qsec)) +
                        xlab("Horespower") + ylab("Miles Per Gallon") + 
                        labs(colour = "Cylinder", size = "1/4 Mile Time") +
                        theme_economist() + scale_color_economist()
                
                if(input$showModel1){
                        p <- p + geom_smooth(method='lm', colour = "firebrick3",
                                             se = input$showSE, fullrange=TRUE,
                                             fill = "rosybrown1") +
                                geom_point(aes(hpInput, model1pred()), color="firebrick3", size = 4)
                }
                if(input$showModel2){
                        p <- p + geom_smooth(method='lm', formula = y ~ poly(x,2),
                                             data = mydata(), colour = "dodgerblue4",
                                             se = input$showSE, fullrange=TRUE,
                                             fill = "skyblue1") +
                                geom_point(aes(hpInput, model2pred()), color = "dodgerblue4", size = 4)
                }
                show(p)
        })
        
        output$pred1 <- renderText({
                validate(need(length(input$ncyl) > 0, "No data selected!"))
                if(input$showModel1){
                        model1pred()
                }
                else 
                        "Select The Llinear Model To See Results!"
        })
        
        output$pred2 <- renderText({
                validate(need(length(input$ncyl) > 0, "No data selected!"))
                if(input$showModel2){
                        model2pred()
                }
                else
                        "Select The Quadratic Model To See Results!"
        })
})
