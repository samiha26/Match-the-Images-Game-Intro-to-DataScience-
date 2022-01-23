#    http://shiny.rstudio.com/

library(shiny)

function(input, output, session) {
  
  start <- callModule(module = welcome, id = "Welcome")
  timer <- callModule(module = time, id="timer", start = start)
  
  square_jpeg <- sample(list.files(path = "file/square images/", pattern = "jpeg$"), n_square)
  square_jpeg <- sample(rep(square_jpeg, 2))
  
  output_mods <- reactiveValues()
  output_mods_parse <- reactiveValues(all = NULL, show1 = NULL, show2 = NULL, show3 = NULL)
  reset <- reactiveValues(x = NULL)
  block <- reactiveValues(x = NULL)
  
  lapply(
    X = seq_len(n_square * 2),
    FUN = function(x) {
      output_mods[[paste0("module", x)]] <- callModule(
        module = square,
        id = paste0("module", x),
        square_logo = square_jpeg[x],
        reset = reset,
        block = block
      )
    }
  )
  
  observe({
   op_mod <- lapply(
     X = reactiveValuesToList(output_mods),
     FUN = reactiveValuesToList
   )
   output_mods_parse$all <- op_mod
   output_mods_parse$show1 <- which_show(op_mod, 1)
   output_mods_parse$show2 <- which_show(op_mod, 2)
   output_mods_parse$show3 <- which_show(op_mod, 3)
    }
  )
  
  observeEvent(output_mods_parse$show2, {
    square1 <- which_square(output_mods_parse$all, output_mods_parse$show1)
    square2 <- which_square(output_mods_parse$all, output_mods_parse$show2)
    if(identical(square1, square2)){
      block$x <- square1
      showNotification(
        ui = tags$div(
          style = "font-size: 160%; font-weight: bold;",
          sample(
            x = c("That's A Match!", "Hooray!", "Good Job!", "Well Done!",
                  "Bravo!", "Great!", "Amazing!"),
            size = 1
          )
        ), type = "message"
      )
    }
  })
  
  observeEvent(output_mods_parse$show3, {
    reset$x <- which_square(
      output_mods_parse$all,
      c(output_mods_parse$show1, output_mods_parse$show2)
    )
    output_mods_parse$show1 <- NULL
    output_mods_parse$show2 <- NULL
    output_mods_parse$show1 <- output_mods_parse$show3
    output_mods_parse$show3 <- NULL
  })
  
  observe({
    allfound <- all_found(output_mods_parse$all)
    if(isTRUE(allfound)){
      showModal(modalDialog(
        tags$div(
          style = "text-align: center;",
          tags$h2(
            tags$span(icon("trophy"), style = "color: #9BE8E7"),
            "That's A Match!",
            tags$span(icon("trophy"), style = "color: #9BE8E7")
          ),
          tags$h4("You've found all matching squares in"),
          tags$h1(isolate(timer()), "Seconds!"),
          tags$br(), tags$br(),
          
          
          actionButton(
            inputId = "reload",
            label = "Play Again!",
            style = "width: 100%;"
          )
        ),
        footer = NULL,
        easyClose = FALSE
      ))
    }
  })
  
  observeEvent(input$reload, {
    session$reload()
  }, ignoreInit = TRUE)
  
}
