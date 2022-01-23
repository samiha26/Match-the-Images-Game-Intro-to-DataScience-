# square-module.R

square_UI <- function(id){
  
  ns < NS(id)
  tagList(
    image_output(
      outputId = ns("square"),
      click = click_options(id = ns("square_click"), clip = FALSE),
      width = 110,
      height = 130,
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
        
        src = "E:/UNIVERSITY OF MALAYA/WIA1007Assignment/3.JPEG",
        width = 110,
        height = 130,
        contentType = "image/JPEG"
        
      )
    }else{
      
      list(
        
        src = paste0("E:/UNIVERSITY OF MALAYA/WIA1007Assignment/", square_logo),
        width = 110,
        height = 130,
        contentType = "image/JPEG"
        
      )
    }
  }, deleteFile = FALSE)
  return(click_status)
  
}