# Use the shiny library
library(shiny)
# Use the markdown library
library(markdown)

# Created the Tabs for each section like Random Variable, Prediction, Hypothesis test, GLM linear regression and About us
  navbarPage("Home",
    # First Tab Random Variable
    tabPanel("Random  Variable",
      # Header of this tab
      headerPanel("Distribution of Random Variables"),
      # Side bar for Random Variable panel
      sidebarLayout(
        sidebarPanel(
          # Radio Button to select the type of probability models
          # Default discrete is selected
          radioButtons("modelType", "Type:",
                       choices = c(
                         "Discrete" = "discrete",
                         "Continuous" = "continuous"
                       ),
                       selected = 'discrete',
                       inline = 'true'
          ),

          # Conditional panel for input for discrete probability models
          conditionalPanel(
            # Checked the condition equal for input_moel type and discrete
            condition = "input.modelType == 'discrete'",

            # List of all the Discrete models
            # Default bernoulli is selected
            selectInput("model", "Select Model",
                        choices = c(
                          "Bernoulli" = "bernoulli",
                          "Binomial" = "binomial",
                          "Poisson" = "poisson",
                          "Geometric" = "geometric",
                          "Hypergeometric" = "hypergeometric"
                        ),
                        selected = "bernoulli"
            ),

            # Slider input for simulated data
            sliderInput("s", "Number of simulated data(s)", min=1, max=1000, value = 10),

            # Conditional panel for inputs of bernoulli
            conditionalPanel(
              condition = "input.model == 'bernoulli'",
              # Slider input for the probability of successful trail
              sliderInput("p", "Probability of successful trail(p)", min=0, max=1, step = 0.01, value = 0.5)
            ),

            # Conditional panel for inputs of binomial
            conditionalPanel(
              condition = "input.model == 'binomial'",
              # Numeric input for the number trail
              numericInput("n", "Number of trails(n)", value = 10),
              # Slider input for the probability of successful trail
              sliderInput("p", "Probability of successful trail(p)", min=0, max=1, step = 0.01, value = 0.5)
            ),

            # Conditional panel for inputs of poission
            conditionalPanel(
              condition = "input.model == 'poisson'",
              # Numeric input for the upper limit
              numericInput("max", "Upper limit for x" , value = 5),
              # Numeric input for the lambda parameter
              numericInput("lam", "Parameter lambda in Poisson", value = 10)
            ),

            # Conditional panel for inputs of geometric
            conditionalPanel(
              condition = "input.model == 'geometric'",
              # Numeric input for the upper limit
              numericInput("max", "Upper limit for x" , value = 5),
              # Slider input for the probability of successful trail
              sliderInput("p", "Probability of successful trail(p)", min=0, max=1, step = 0.01, value = 0.5)
            ),

            # Conditional panel for inputs of hypergeometric
            conditionalPanel(
              condition = "input.model == 'hypergeometric'",
              # Numeric input for the M
              numericInput("m", "M" , value = 10),
              # Numeric input for the N
              numericInput("n", "N" , value = 20),
              # Numeric input for the K
              numericInput("k", "K" , value = 5)
            )

          ),

          # Conditional panel for inputs of continuous probabilities models
          conditionalPanel(
            condition = "input.modelType == 'continuous'",

            # Select input for all the Continuous models
            selectInput("modelCont", "Select Model",
                        choices = c(
                          "Uniform" = "uniform",
                          "Normal" = "normal",
                          "Exponential" = "exponential",
                          "Gamma" = "gamma",
                          "Chi-squared" = "chisquared"
                        ),
                        selected = "uniform"
            ),

            # Slider input for Number of simulated data
            sliderInput("s", "Number of simulated data" ,min=1, max=1000, value = 10),
            # Numeric input for the support
            numericInput("i", "Support" , value = 2),

            # Conditional panel for inputs of uniform
            conditionalPanel(
              condition = "input.modelCont == 'uniform'",
              # Numeric input for the Parameter a
              numericInput("a", "Parameter a in Uniform" , value = -2),
              # Numeric input for the Parameter b
              numericInput("b", "Parameter b in Uniform" , value = 0.8)
            ),

            # Conditional panel for inputs of normal
            conditionalPanel(
              condition = "input.modelCont == 'normal'",
              # Numeric input for the Parameter mu
              numericInput("mu", "Parameter mu in Normal" , value = 0),
              # Numeric input for the Parameter sigma
              numericInput("sigma", "Parameter sigma in Normal" , value = 1)
            ),

            # Conditional panel for inputs of exponential
            conditionalPanel(
              condition = "input.modelCont == 'exponential'",
              # Numeric input for the Parameter lambda
              numericInput("lam", "Parameter lambda in exponential" , value = 1)
            ),

            # Conditional panel for inputs of gamma
            conditionalPanel(
              condition = "input.modelCont == 'gamma'",
              # Numeric input for the Parameter sigma
              numericInput("sigma", "Parameter sigma in Gamma" , value = 1),
              # Numeric input for the Parameter lambda
              numericInput("lam", "Parameter lambda in Gamma" , value = 1)
            ),

            # Conditional panel for inputs of chisquared
            conditionalPanel(
              condition = "input.modelCont == 'chisquared'",
              # Numeric input for the Parameter K
              numericInput("k", "Parameter K in chisquared" , value = 1)
            )
          )
        ),
        # Main panel for Random Variable which shows the output
        mainPanel(
          # Tabs in the main panel
          tabsetPanel(type = "tabs",
                      # Plot tab which displays the graph
                      tabPanel("Plot", plotOutput("plot")),
                      # Tab which displays the summary
                      tabPanel("Summary", verbatimTextOutput("summary")),
                      # Tab which displays the table of simulated data
                      tabPanel("Table", tableOutput("table"))
          )
        )
      )
    ),

    # Tab for Prediction
    tabPanel("Prediction",
      # Header for this tab
      headerPanel("Prediction next value"),
      # Sider bar which take the input
      sidebarLayout(
        sidebarPanel(
          # Select for the probabilities models
          # Default bernoulli  is selected
          selectInput("predmodel", "Select Model",
                      choices = c(
                                  "Bernoulli" = "bernoulli",
                                  "Poisson" = "poisson",
                                  "Uniform" = "uniform",
                                  "Normal" = "normal",
                                  "Exponential" = "exponential"
                                ),
                      selected = "bernoulli"
          ),

          # Dropdown to select the input type.
          # Default is File input
          selectInput("predInputType", "Select Input",
                      choices = c(
                                  "File Input" = "preFile",
                                  "Inbuild Datasets" = "preInbuild",
                                  "URL" = "preUrl",
                                  "Yahoo Finance" = "preYahoo"
                                ),
                      selected = "preFile"
          ),

          # Conditional Panel to take parameter for file input
          conditionalPanel(
            condition = "input.predInputType == 'preFile'",
            # Input: Select a file ----
            fileInput("datafile", "Choose CSV File",
                    multiple = FALSE,
                    accept = c("text/csv",
                               "text/comma-separated-values,text/plain",
                               ".csv"))
          ),

          # Conditional Panel to take parameter for in build dataset input
          conditionalPanel(
            condition = "input.predInputType == 'preInbuild'",
            # Drop down of all the input dataset present in R
            selectInput("preInbuildFile", "Select a Dataset",
                        choices = ls("package:datasets")
            )
          ),

          # Conditional Panel to take parameter for in URL input
          conditionalPanel(
            condition = "input.predInputType == 'preUrl'",
            # Text input to take data url from User
            textInput('preUrl', 'Input URL', value="http://users.stat.ufl.edu/~winner/data/marij1.csv")
          ),

          # Conditional Panel to take parameter for in Yahoo Finance input
          conditionalPanel(
            condition = "input.predInputType == 'preYahoo'",
            # Text input to take Ticket Number from User
            textInput('preYahoo', 'Enter Ticket No', value="CTSH")
          ),

          # Drop down to select column of selected dataset
          selectInput(inputId = "pred_columns", label = "Select a Column", choices = ""),

          # Slider to select the use of Number of simulated data for prediction
          sliderInput("s", "Number of simulated data" ,min=1, max=1000, value = 100)
        ),

        # Mail panel for this tab
        mainPanel(
          # More tabs to display more information
          tabsetPanel(type = "tabs",
                      # Tab that will shoW the data set in Data Table
                      tabPanel("Data", DT::dataTableOutput('extdata')),
                      # Tab that will show the prediction
                      tabPanel("Prediction", verbatimTextOutput("prediction"))
          )
        )
      )
    ),

    tabPanel("Hypothesis Test",
      headerPanel("Hypothesis testing"),
      sidebarLayout(
        sidebarPanel(
          selectInput("hpType", "Select Type",
                      choices = c(
                                  "Test of mean of population(s)" = "meanTest",
                                  "Test of proportion of population(s)" = "proportionTest",
                                  "Test of variance of population(s)" = "varianceTest"
                                ),
                      selected = "meanTest"
          ),

          selectInput("hpInputType", "Select Input",
                      choices = c(
                                  "File Input" = "hpFile",
                                  "Inbuild Datasets" = "hpInbuild",
                                  "URL" = "hpUrl",
                                  "Yahoo Finance" = "hpYahoo"
                                ),
                      selected = "hpFile"
          ),

          conditionalPanel(
            condition = "input.hpInputType == 'hpFile'",
            # Input: Select a file ----
            fileInput("hpDatafile", "Choose CSV File",
                    multiple = FALSE,
                    accept = c("text/csv",
                               "text/comma-separated-values,text/plain",
                               ".csv"))
          ),

          conditionalPanel(
            condition = "input.hpInputType == 'hpInbuild'",
            selectInput("hpInbuildFile", "Select a Dataset",
                        choices = ls("package:datasets")
            )
          ),

          conditionalPanel(
            condition = "input.hpInputType == 'hpUrl'",
            textInput('hpUrl', 'Input URL', value="http://users.stat.ufl.edu/~winner/data/marij1.csv")
          ),

          conditionalPanel(
            condition = "input.hpInputType == 'hpYahoo'",
            textInput('hpYahoo', 'Enter Ticket No', value="CTSH")
          ),

          selectInput(inputId = "hp_columns", label = "Select a Column", choices = ""),

          sliderInput("hpAlpha", "Significance Level" ,min=0, max=1, value = 0.05, step=0.01),

          selectInput("hpalternative", "Select Alternative",
                      choices = c(
                                  "Lower Tail" = "less",
                                  "Upper Tail" = "greater",
                                  "Two Sided" = "two.sided"
                                ),
                      selected = "less"
          ),

          conditionalPanel(
            condition = "input.hpalternative == 'two.sided' && input.hpType == 'meanTest'",
            numericInput("hpMu", "Parameter mu in for Two sided" , value = 0),
          )
        ),

        mainPanel(
          tabsetPanel(type = "tabs",
                      tabPanel("Data", DT::dataTableOutput('hpextdata')),
                      tabPanel("Result", verbatimTextOutput("testResult"))
          )
        )
      )
    ),

    tabPanel("About Us",
      headerPanel("About Us"),

      tabsetPanel(type = "tabs",
                  tabPanel("Mayur", 
                    img(src='mayur_photo.jpg', align = "middle", height = 150, width = 150, style="display: block; margin-left: auto; margin-right: auto; margin-top:50px; margin-bottom:50px;"),
                    HTML('<p>I am Mayur Vaishnav.</p>
                      <p><a target="_blank" href="https://github.com/mayurvaishnav">GitHub</a>
                      &nbsp; &nbsp; &nbsp; <a target="_blank" href="https://www.linkedin.com/in/mayur-vaishnav/">Linked In</a></p>
                      ')
                  ),
                  tabPanel("Manmeet", verbatimTextOutput("manmeet_profile")),
                  tabPanel("Hemlata", verbatimTextOutput("hemlata_profile")),
                  tabPanel("Chirag", verbatimTextOutput("chirag_profile"))
      )
    )
  )
# ))
