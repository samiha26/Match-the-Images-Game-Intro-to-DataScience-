# welcome-module.R

welcomeModule_UI <- function(id) {
  ns <- NS(id)
  modalDialog(
    title = tags$h1(
      style = "text-align: center;",
      "Welcome To Visual Recall Game !"
    ),
    
    tags$div(
      style = "text-align: center;",
      tags$p("Find All Matching Images As Soon As Possible !"),
      tags$p("Click On A Square To Return It."),
      tags$p("You Can Only See Two Images Together."),
      tags$p("Are You Ready? Click The Button Below To Play !")
    ),
    
    footer = actionButton(
      inputId = ns("play"),
      label = "Play Now !",
      icon = icon("play"),
      style = "width: 100%"
    )
  )
}

welcome <- function(input, output, session) {
  id <- gsub("-$", "", session$ns(""))
  showModal(ui = welcomeModule_UI(id))
  
  observeEvent(input$play, {
    removeModal()
  })
  return(reactive(input$play))
}

