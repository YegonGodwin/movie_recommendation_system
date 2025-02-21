library(shiny)
library(bslib)
library(ggplot2)
library(dplyr)
library(DT)
library(shinythemes)
library(readr) # Make sure readr is loaded for write_csv and write_tsv

# Load data --------------------------------------------------------------------
load("movies.RData")

# Calculate new variable
movies <- movies %>% mutate(score_ratio = audience_score / critics_score)

# Define UI --------------------------------------------------------------------
ui <- fluidPage(
  theme = shinytheme('yeti'),
  titlePanel(strong("Movie Browser")),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "y",
        label = "Y-axis:",
        choices = c(
          "IMDB rating" = "imdb_rating",
          "IMDB number of votes" = "imdb_num_votes",
          "Critics score" = "critics_score",
          "Audience score" = "audience_score",
          "Runtime" = "runtime"
        ),
        selected = "audience_score"
      ),
      selectInput(
        inputId = "x",
        label = "X-axis:",
        choices = c(
          "IMDB rating" = "imdb_rating",
          "IMDB number of votes" = "imdb_num_votes",
          "Critics score" = "critics_score",
          "Audience score" = "audience_score",
          "Runtime" = "runtime"
        ),
        selected = "critics_score"
      ),
      selectInput(
        inputId = "z",
        label = "Color by:",
        choices = c(
          "Title type" = "title_type",
          "Genre" = "genre",
          "MPAA rating" = "mpaa_rating",
          "Critics rating" = "critics_rating",
          "Audience rating" = "audience_rating"
        ),
        selected = "mpaa_rating"
      ),
      checkboxGroupInput(
        "titleType",
        "Choose title movie",
        choices = levels(movies$title_type)
      ),
      radioButtons(
        inputId = "filetype",
        label = "Select filetype:",
        choices = c("csv", "tsv"),
        selected = "csv"
      ),
      checkboxGroupInput( # Correct placement and logic
        inputId = "selected_vars", # Renamed to avoid confusion
        label = "Select variables to download:",
        choices = names(movies),
        selected = c("title")
      )
    ),
    mainPanel(
      card(
        plotOutput(outputId = "scatterplot"),
        tableOutput("title_type"),
        HTML('Select a file to download, then hit "Download hit".'),
        downloadButton("download_data", "Download data", style = "width: 200px; border-radius: 9px; background-color: rgb(100, 100, 200); margin: 5px; color: #fff;")
      )
    )
  )
)

# Define server ----------------------------------------------------------------
server <- function(input, output, session) {
  output$scatterplot <- renderPlot({
    ggplot(data = movies, aes_string(x = input$x, y = input$y, color = input$z)) +
      geom_point()
  })
  
  output$title_type <- renderTable({
    movies %>%
      filter(title_type %in% input$titleType) %>%
      group_by(mpaa_rating) %>%
      summarise(mean_score_ratio = mean(score_ratio), SD = sd(score_ratio), n = n())
  },
  striped = TRUE,
  spacing = "l",
  align = "lccr",
  digits = 4,
  width = "90%",
  caption = "Score ratio (audience / critics' scores) summary statistics by MPAA rating."
  )
  
  output$download_data <- downloadHandler(
    filename = function() {
      paste0("movies.", input$filetype)
    },
    content = function(file) {
      data_to_download <- movies %>% select(input$selected_vars) # Correct selection!
      
      if (input$filetype == "csv") {
        write_csv(data_to_download, file)
      } else if (input$filetype == "tsv") {
        write_tsv(data_to_download, file)
      }
    }
  )
}

# Create a Shiny app object ----------------------------------------------------
shinyApp(ui = ui, server = server)