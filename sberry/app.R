#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(tidyverse)
library(shiny)
library(readr)
library(knitr)
library(magrittr)
library(kableExtra)
library(gridExtra)



# import sberry data
sberry <- read.csv("C:/Users/49431/Downloads/sberry_cleaned.csv")
berry <- read_csv("C:/Users/49431/Downloads/ag_data.csv")



# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Berries"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
                    conditionalPanel(
                        'input.dataset === "berry"'),
                    conditionalPanel(
                        'input.dataset === "sberry"',
                    )
),
        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(
                id = 'dataset',
                tabPanel("Original Data",
                         fluidRow(
                             column(2,
                                    selectInput("Year",
                                                "Year:",
                                                c("All",
                                                  unique(as.character(berry$Year))))
                             ),
                             column(2,
                                    selectInput("State",
                                                "State:",
                                                c("All",
                                                  unique(as.character(berry$State))))
                             ),        
                             column(2,
                                    selectInput("Commodity",
                                                "Commodity:",
                                                c("All",                                       
                                                  unique(as.character(berry$Commodity))))
                             ),
                             column(2,
                                    selectInput("Domain",
                                                "Domain:",
                                                c("All",
                                                  unique(as.character(berry$Domain))))
                             )                  
                         ),
                         DT::dataTableOutput("table1")),
                tabPanel("Strawberry",
                         fluidRow(
                             column(2,
                                    selectInput("Year",
                                                "Year:",
                                                c("All",
                                                  unique(as.character(sberry$Year))))
                             ),
                             column(2,
                                    selectInput("State",
                                                "State:",
                                                c("All",
                                                  unique(as.character(berry$State))))
                             ),
                             column(2,
                                    selectInput("Type",
                                                "Type:",
                                                c("All",
                                                  unique(as.character(sberry$Type))))
                             ),                    
                             column(2,
                                    selectInput("Measure",
                                                "Measure:",
                                                c("All",
                                                  unique(as.character(sberry$Measure))))
                             ),
                             column(2,
                                    selectInput("Chemical",
                                                "Chemical:",
                                                c("All",
                                                  unique(as.character(sberry$Chemical))))
                             )                 
                         ),    
                         DT::dataTableOutput("table2")))
        )
    )
)


# Define server logic required to draw a histogram
server <- function(input, output) {

    output$table1 <- DT::renderDataTable(DT::datatable({
        data <- berry
        if (input$Year != "All") {
            data <- data[berry$Year == input$Year,]
        }
        if (input$State != "All") {
            data <- data[berry$State == input$State,]
        }
        if (input$Commodity != "All") {
            data <- data[berrys$Commodity == input$Commodity,]
        }
        if (input$Domain != "All") {
            data <- data[berry$Domain == input$Domain,]
        }    
        data
    }))
    
    
    output$table2 <- DT::renderDataTable(DT::datatable({
        data2 <- sberry
        if (input$Year != "All") {
            data2 <- data2[sberry$Year == input$Year,]
        }
        if (input$State != "All") {
            data <- data[berry$State == input$State,]
        }
        if (input$Type != "All") {
            data2 <- data2[sberry$Type == input$Type,]
        }
        if (input$Measure != "All") {
            data2 <- data2[sberry$Measure == input$Measure,]
        }
        if (input$Chemical != "All") {
            data2 <- data2[sberry$Chemical == input$Chemical,]
        }
        data2
    }))
}

# Run the application 
shinyApp(ui = ui, server = server)
