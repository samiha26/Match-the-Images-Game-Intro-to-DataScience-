# square-module.R

square_UI <- function(id){
  
  ns < NS(id)
  tagList(
    image_output(
      outputId = ns("square"),
      click = clickOpts(id = ns("square_click"), clip = FALSE),
      width = 120,
      height = 139,
      inline = TRUE
      
    )
  )
}


square <- function(input, output, session, square_logo, 
                   reset = reactiveValues(x = NULL), block = reactiveValues(x = NULL)){
  
  click_status <- reactiveValues(show = FALSE, square = square_logo, timeSystem = Sys.time(), found = FALSE)
  
  observeEvent(input$square_click, {
    
    if(!click_status$found){
      click_status$show <- !click_status$show
      click_status$timeSystem <- Sys.time()
      
    }
  })
  
  
  observeEvent(block$x, {
    
    if(square_logo %in% block$x){
      click_status$found <- TRUE
      
    }
  })
  
  
  observeEvent(reset$x, {
    
    if(square_logo %in% reset$x & !click_status$found){
      click_status$show <- FALSE
      
    }
  })
  
  
  output$square <- renderImage({
    
    if(!click_status$show){
      
      list(
        
        src = "file/3.jpeg",
        width = 120,
        height = 139,
        contentType = "image/jpeg"
        
      )
    }else{
      
      list(
        
        src = paste0("file/square images/", square_logo),
        width = 120,
        height = 139,
        contentType = "image/jpeg"
        
      )
    }
  }, deleteFile = FALSE)
  return(click_status)
  
}