#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(rsconnect)
library(shiny)
library(ggplot2)
powerlifting <- read.csv("ShinyAppData/powerlifting.csv")
# Define UI for application that draws a histogram
# Define UI for random distribution app ----
ui <- fluidPage(
    
    # App title ----
    titlePanel("National Powerlifting 2018 Dataset"),
    
    # Sidebar layout with input and output definitions ----
    sidebarLayout(
        
        # Sidebar panel for inputs ----
        sidebarPanel(
            
            # Input: Select the random distribution type ----
            radioButtons("var", "X Variables to Analyze",
                         c("Age" = "age",
                           "Bodyweight" = "bw",
                           "Squat" = "squat",
                           "Bench Press" = "bench",
                           "Deadlift" = "deadlift",
                           "Total" = "total",
                           "Wilks" = "wilks"),selected = NULL),
            
            # br() element to introduce extra vertical spacing ----
            br(),
            
            # Input: Slider for the number of observations to generate ----
            radioButtons("gender", "Filter by Gender",
                         c("Men" = "men",
                           "Women" = "women",
                           "All" = "all"),selected = NULL)
            
        ),
        
        # Main panel for displaying outputs ----
        mainPanel(
            
            # Output: Tabset w/ plot, summary, and table ----
            tabsetPanel(type = "tabs",
                        tabPanel("Descriptive Statistics",titlePanel("Descriptive variable statistics"), verbatimTextOutput("summary")),
                        tabPanel("Visualization",radioButtons("var2", "Y Axis Variable to anaylze",
                                                              c("Age" = "age2",
                                                                "Bodyweight" = "bw2",
                                                                "Squat" = "squat2",
                                                                "Bench Press" = "bench2",
                                                                "Deadlift" = "deadlift2",
                                                                "Total" = "total2",
                                                                "Wilks" = "wilks2"),selected = NULL), plotOutput("plot")),
                        tabPanel("Statistical Analysis",radioButtons("var3", "Y Axis Variable to Analyze (Left hand side radio options to control X)",
                                                                     c("Age" = "age3",
                                                                       "Bodyweight" = "bw3",
                                                                       "Squat" = "squat3",
                                                                       "Bench Press" = "bench3",
                                                                       "Deadlift" = "deadlift3",
                                                                       "Total" = "total3",
                                                                       "Wilks" = "wilks3"),selected = NULL), verbatimTextOutput("regression"))
            )
            
        )
    )
)
# Define server logic required to draw a histogram
# Define server logic for random distribution app ----
server <- function(input, output) {
    
    # Reactive expression to generate the requested distribution ----
    # This is called whenever the inputs change. The output functions
    # defined below then use the value computed from this expression
    #Categorical Subsets
    male <- powerlifting[powerlifting$Sex == "M",]
    female <- powerlifting[powerlifting$Sex == "F",]


    
    d <- reactive({
    
        gender <- switch(input$gender,
                         men = male,
                         women = female,
                         all = powerlifting)
        powerlifting <- gender
        Age <- as.numeric(unlist(powerlifting['Age']))
        BodyweightKg <- as.numeric(unlist(powerlifting['BodyweightKg']))
        Squat <- as.numeric(unlist(powerlifting['Best3SquatKg']))
        Bench <- as.numeric(unlist(powerlifting['Best3BenchKg']))
        Deadlift <- as.numeric(unlist(powerlifting['Best3DeadliftKg']))
        Total <- as.numeric(unlist(powerlifting['TotalKg']))
        Wilks <- as.numeric(unlist(powerlifting['Wilks']))
        Place <- as.numeric(unlist(powerlifting['Place']))
        dist <- switch(input$var,
                              age = Age,
                              bw = BodyweightKg,
                              squat = Squat,
                              bench = Bench,
                              deadlift = Deadlift,
                              wilks = Wilks,
                              total = Total)
    })
  boxplotvar2 <- reactive({
    
    gender2 <- switch(input$gender,
                     men = male,
                     women = female,
                     all = powerlifting)
    
    powerlifting2 <- gender2
    Age2 <- as.numeric(unlist(powerlifting2['Age']))
    BodyweightKg2 <- as.numeric(unlist(powerlifting2['BodyweightKg']))
    Squat2 <- as.numeric(unlist(powerlifting2['Best3SquatKg']))
    Bench2 <- as.numeric(unlist(powerlifting2['Best3BenchKg']))
    Deadlift2 <- as.numeric(unlist(powerlifting2['Best3DeadliftKg']))
    Total2 <- as.numeric(unlist(powerlifting2['TotalKg']))
    Wilks2 <- as.numeric(unlist(powerlifting2['Wilks']))
    Place2 <- as.numeric(unlist(powerlifting2['Place']))
    
    dist2 <- switch(input$var2,
                   age2 = Age2,
                   bw2 = BodyweightKg2,
                   squat2 = Squat2,
                   bench2 = Bench2,
                   deadlift2 = Deadlift2,
                   wilks2 = Wilks2,
                   total2 = Total2)
    
    
    
  })
  
  regressionAnalysisVar <- reactive({
    
    gender3 <- switch(input$gender,
                      men = male,
                      women = female,
                      all = powerlifting)
    
    powerlifting3 <- gender3
    Age3 <- as.numeric(unlist(powerlifting3['Age']))
    BodyweightKg3 <- as.numeric(unlist(powerlifting3['BodyweightKg']))
    Squat3 <- as.numeric(unlist(powerlifting3['Best3SquatKg']))
    Bench3 <- as.numeric(unlist(powerlifting3['Best3BenchKg']))
    Deadlift3 <- as.numeric(unlist(powerlifting3['Best3DeadliftKg']))
    Total3 <- as.numeric(unlist(powerlifting3['TotalKg']))
    Wilks3 <- as.numeric(unlist(powerlifting3['Wilks']))
    Place3 <- as.numeric(unlist(powerlifting3['Place']))
    
    dist3 <- switch(input$var3,
                    age3 = Age3,
                    bw3 = BodyweightKg3,
                    squat3 = Squat3,
                    bench3 = Bench3,
                    deadlift3 = Deadlift3,
                    wilks3 = Wilks3,
                    total3 = Total3)
    
    
    
  })
  
    # Generate a plot of the data ----
    # Also uses the inputs to build the plot label. Note that the
    # dependencies on the inputs and the data reactive expression are
    # both tracked, and all expressions are called in the sequence
    # implied by the dependency graph.
    output$plot <- renderPlot({
        x <- input$var
        y <- input$var2
        boxplot(d() ~ boxplotvar2(),
                main="Different boxplots for each month",
                xlab= x,
                ylab= y,
                col="orange",
                border="brown"
        )
       
    })
    
    # Generate a summary of the data ----
    output$summary <- renderPrint({
        summary(d())
    })
    
    # Generate an HTML table view of the data ----
    output$regression <- renderPrint({
      model <- lm(d() ~ regressionAnalysisVar())
        summary(model)
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
