library(shiny)
library(ggplot2)
state <- rep("h",10000)
x <- rep(1:100,100)
y <- rep(1:100,each=100)


ui <- fluidPage(
    titlePanel("disease screening"),
    
    sidebarLayout(
        sidebarPanel(width = 3,
            #choosing the disease prevalance
            sliderInput(inputId = "prev",
                        label = "disease prevalence (percent):",
                        min = 1,
                        max = 50,
                        value = 10),
            
            #choosing the test sensitivity
            sliderInput(inputId = "sens",
                        label = "test sensitivity (percent):",
                        min = 50,
                        max = 100,
                        value = 80),
            
            #choosing the test specificity
            sliderInput(inputId = "spec",
                        label = "test specificity (percent):",
                        min = 50,
                        max = 100,
                        value = 70)
            
        ),
        mainPanel(
            plotOutput(outputId = "population")
        )
    )
)

server <- function(input,output)
{
#    output$disease <- table(state)
    
    output$population <- renderPlot({
        n_total <- 10000
        
        n_dis_neg <- round(n_total* (input$prev/100) * (100-input$sens)/100)
        n_dis_pos <- round(n_total* (input$prev/100) * (input$sens/100))
        n_healthy_pos <- round(n_total*(100-input$prev)/100 * (100-input$spec)/100)
        n_healthy_neg <- n_total - (n_dis_pos + n_dis_neg + n_healthy_pos)
        
        state <- character(length = n_total)
        
        state[1:n_dis_neg] <- "disease, neg test result"
        state[(n_dis_neg+1):(n_dis_neg+n_dis_pos)] <- "disease, pos test result"
        state[(n_dis_neg+n_dis_pos+1):(n_dis_neg+n_dis_pos+n_healthy_pos)] <- "healthy, pos test result"
        state[(n_total-n_healthy_neg+1):n_total] <- "healthy, negative test result"
        
        x <- rep(1:100,100)
        y <- rep(1:100,each = 100)
        
        pop <- data.frame(state = state, x=x, y=y)
        
        ggplot(pop,aes(x = x, y = y, color = state)) + geom_point() + theme_bw()
    })
}

shinyApp(ui = ui, server=server)