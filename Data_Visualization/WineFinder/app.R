#Welcome to World of Wine
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#

library(shiny)
library(dplyr)
library(ggplot2)
library(DT)
#loading data 
data<-read.csv('data/winedata.csv')
data<-as.data.frame(data)

#create lists to use for input selection
listofcountry<-levels(data$country)
listofvariety<-levels(data$variety)

# Define UI for application 
ui <- fluidPage(
   
   # Application title
   titlePanel("Wine Explorer:\n Discovering wine trends from different countries around the globe"),
   
   # Input
   sidebarLayout(
     sidebarPanel(
       selectizeInput('country', 'Select Countries', choices = listofcountry, multiple = TRUE),
       selectizeInput('variety','Select Varieties', choices=listofvariety,multiple=TRUE),
       sliderInput('price','Select Price Range',min=4,max = 3300,step = 100,value = c(4,3300)),
       sliderInput('points','Select Rating Range',min = 80,max = 100,step = 1,value = c(80,100)),
       actionButton('button','Start Analysis'),
       p("Click the button to start analysis")
     ),
      
# Show a plot of the generated distribution
      mainPanel(
         h4(textOutput('text')),
         plotOutput('boxplot'),
         br(),
         plotOutput('distplot'),
         br(),
         plotOutput('scorehis'),
         br(),br(),
         DT::dataTableOutput('result')
      )
   )
)

# Define server 
server <- function(input, output,session) {
  
  filtered<-eventReactive(input$button,{
    filtered<-data
    if((is.null(input$country)==FALSE)&(is.null(input$variety))){
     filtered<-filter(filtered,country %in% input$country,price>=input$price[1],
                      price<=input$price[2],points>=input$points[1],points<=input$points[2])
    }
    if((is.null(input$variety)==FALSE)&(is.null(input$country))){
      filtered<-filter(filtered,variety %in% input$variety,price>=input$price[1],
                       price<=input$price[2],points>=input$points[1],points<=input$points[2])
    }
    if((is.null(input$variety)==FALSE)&(is.null(input$country)==FALSE)){
      filtered<-filter(filtered,country %in% input$country,variety %in% input$variety,price>=input$price[1],
                       price<=input$price[2],points>=input$points[1],points<=input$points[2])
    }
    if((is.null(input$variety))&(is.null(input$country))){
      filtered<-filter(filtered,price>=input$price[1],
                    price<=input$price[2],points>=input$points[1],points<=input$points[2])
     }
      
    if(nrow(filtered)==0){
     return(NULL)
    }
    filtered
  })
  output$text<-renderText({
    rows<-nrow(filtered())
    if(is.null(rows)){
      rows<-0
    }
    paste0("There are ",rows," options")
  })
  #price boxplot
  output$boxplot<-renderPlot({
    if(is.null(filtered())){
      return(NULL)
    }
    ggplot(filtered(),aes(country,price))+
      geom_boxplot(aes(color=country))+
      labs(title='Price Summary with selected options')+
      theme(axis.text.x = element_text(angle=90,hjust=1))
  })
  output$distplot<-renderPlot({
    if(is.null(filtered())){
      return(NULL)
    }
    ggplot(filtered(),aes(price,fill=country))+
      geom_histogram(colour='black')+
      labs(title='Price Distribution with selected options')
  })
  output$scorehis<-renderPlot({
    if(is.null(filtered())){
      return(NULL)
    }
    ggplot(filtered(),aes(points,fill=country))+
      geom_histogram(colour='black')+
      labs(title='Rating Distribution with selected options')
  })
  output$result<-DT::renderDataTable({
    if(is.null(filtered())){
      return(NULL)
    }
    selected<-select(filtered(),country,description,variety,title,price,points)
    selected
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

