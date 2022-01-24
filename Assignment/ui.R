#    http://shiny.rstudio.com/

library(shiny)
library(shinythemes)

fluidPage(
  theme = shinytheme("slate"),
  tags$head(
    tags$link(href="styles.css",rel="stylesheet",type="text/css"),
    tags$script(src = "http://platform.twitter.com/widgets.js"),
    includeHTML(path = "file/google-analytics.html")
  ),
  
  tags$div(
    
    

    class = "title-app",
    style = "text-align: center;",
    
    
    tags$h1("Visual Recall Game"),
    tags$h4("Match all the pictures and words!!")
  ),
  tags$br(),

  
  tags$div(
    
    
    style = "width: 650px; margin: auto;text-align: center;",
    
    
    time_UI("timer"),
    tags$br(),
    lapply(
      X = seq_len(n_square * 2),
      FUN = function(x){
        square_UI(id = paste0("module", x))
      }
    ),
  )
  
)
