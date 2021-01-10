####################################
# Data Professor                   #
# http://youtube.com/dataprofessor #
# http://github.com/dataprofessor  #
####################################

# Modified from Winston Chang, 
# https://shiny.rstudio.com/gallery/shiny-theme-selector.html

# Concepts about Reactive programming used by Shiny, 
# https://shiny.rstudio.com/articles/reactivity-overview.html

# Load R packages
library(shiny)
library(shinythemes)


  # Define UI
  ui <- fluidPage(theme = shinytheme("superhero"),
    navbarPage(
      # theme = "cerulean",  # <--- To use a theme, uncomment this
      "My first app",
      tabPanel("Navbar 1",
               sidebarPanel(
                 tags$h3("Please Enter:"),
                 textInput("txt1", "Given Name", ""),
                 textInput("txt2", "Surname", ""),
                 
               ), # sidebarPanel
               mainPanel(
                            h1("Name Printer"),
                            
                            h4("Full Name"),
                            verbatimTextOutput("txtout"),

               ) # mainPanel
               
      ), # Navbar 1, tabPanel
      tabPanel("Navbar 2", 
               sidebarPanel(
                 tags$h3("Please Enter:"),
                 numericInput("no1", "first number (0~1000)", 0, min=0, max=1000),
                 numericInput("no2", "second number (0~1000)", 0, min=0, max=1000),
                 htmlOutput("note")
                 
               ),
               mainPanel(
                 h1("Multiply!"),
                 
                 h4("return"),
                 verbatimTextOutput("numOut"),
                 
               )
      ),
      tabPanel("Navbar 3", "This panel is intentionally left blank")
  
    ) # navbarPage
  ) # fluidPage

  
  # Define server function  
  server <- function(input, output) {
    
    input_received <- reactive({
      if(input$no1>1000){
        max
      }
      else{
        input$no1
      }
    })
    
    input_received2 <- reactive({
      if(input$no2>1000){
        input$no2 = 1000
        return(input$no2)
      }
      else{
        input$no2
      }
    })
    
    textnote <- reactive({
      if((input$no1 <=1000 & input$no2 <=1000) & (input$no1 >=0 &input$no2 >=0)){
        
      }
      else{
        paste0("<font color=\"#e05959\"><b>", "Note: your input(s) out of acceptable range, please try again. ", "</b></font>")
      }
    })
    output$note <- renderText({
      HTML(textnote())
    })
    
    output$txtout <- renderText({
      paste( input$txt1, input$txt2, sep = " " )
    })
    
    output$numOut <- renderText({
      if(input$no1 >1000 | input$no2 >1000 |input$no1 <0 |input$no2 <0){
        paste("ERROR")
      }
      else{
      input$no1*input$no2}
    })
  } # server
  

  # Create Shiny object
  shinyApp(ui = ui, server = server)
