#    http://shiny.rstudio.com/

library(shiny)

shinyUI(fluidPage(
  
  tags$head(
    tags$link(href="styles.css",rel="stylesheet",type="text/css")
  ),
  
  tags$div(
    
    class = "title-app",
    tags$h1("Visual Recall Game"),
    tags$h4("Match all the pictures and words!!")
  ),
  tags$br(),
  
  #Text output
  
  tags$div(
    
    style = "width: 650px; margin: auto;",
    n_square <- 10,
    
    time_UI("timer"),
    tags$br(),
    lapply(
      X = seq_len(n_square * 2),
      FUN = function(x){
        square_UI(id = paste0("module", x))
      }
    ),
  )
  
))
