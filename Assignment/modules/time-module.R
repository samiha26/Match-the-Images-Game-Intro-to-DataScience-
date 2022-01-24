#TIME

time_UI <- function(id){
  ns <- NS(id)
  tags$div(
    style = "width: 150%; text-align: center;",
    "Time elapsed:",
    uiOutput(outputId = ns("timer_ui"), style = "font-size: 200%; font-weight: bold;", inline = TRUE)
  )
  
}

time <- function(input, output, session, start = reactive(0)){
  
  time_reactive <- reactiveVal(value = 10)
  started <- reactiveVal(value = FALSE)
  
  observeEvent(start(),{
    
    time_reactive(0)
    started(TRUE)
  },ignoreInit = TRUE)
  
  observe({
    if(started()){
      invalidateLater(1000,session)
      isolate({
        new_Time <- time_reactive()+1
        time_reactive(new_Time)
      })
    }
    
  })
  
  output$timer_ui <- renderUI({
    
    as.character(time_reactive())
    
  })
  
  return(time_reactive)
}