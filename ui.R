
# shinyOptions(plot.autocolors=TRUE)


ui <- fluidPage(
  theme = shinytheme("united"),
  
  tags$head(
    includeCSS("www/style.css")
  ),
  
  headerPanel_2(
    HTML(
      toUTF8(
        
        '<div id="stats_header">
        
                       <a href="http://www.fao.org/home/en/" target="_blank">
                       <img id="stats_logo" align="right" alt="" src="fao_logo2.png" />
                        
                       </a>
                       </div>'
        , "WINDOWS-1252")), h1, toUTF8("Quality Indicators Explorer", "WINDOWS-1252")
  ),
  
  titlePanel(
    "Quality Indicators Explorer"),
  br(),
  navbarPage("About",
             tabPanel(icon("home"),
                      
                      fluidRow(
                        column(
                          
                          br(),
                          p("This application is meant to be used as a tool to analyse the", strong("Quality Indicators"), " of the several FAO processes.",
                            style="text-align:justify;color:black;background-color:lavender;padding:15px;border-radius:10px"),
                          br(),
                          
                          p("The data used in this application are stored in the production environment of the ", strong("Statistical Working System (SWS)"), 
                            "under the domain", strong("Quality Indicators."), 
                            style="text-align:justify;color:black;background-color:papayawhip;padding:15px;border-radius:10px"),
                          

                          width=12)),
                      
                      br(),
                      br(),
                      br(),
                      
                      hr(),
                      p(em("Developed by"),
                        br("Bruno Caetano Vidigal"),style="text-align:center; font-family: times")),
             
             tabPanel("Create Report",
                      
                      sidebarLayout(
                        sidebarPanel(

                          column(4,
                                 selectInput("dataset", "Dataset", choices = sort(unique(dataset_code_list_qi$dataset)))),
                          column(4,
                                 selectInput("area_name", "Country/Region", choices = NULL, multiple = TRUE)),
                          column(4,
                                 selectInput("element_name", "Element", choices = NULL)),
                          column(4,
                                 selectInput("item_code_name", "Item", choices = NULL)),
                               # selectInput("item_name", "Item", choices = NULL)),
                          column(8,
                                 sliderInput("range", h4("Year Range:"), min = 1961, max = as.numeric(format(Sys.Date(), "%Y")), value = c(2000, 2015),sep = "")),
                          h4(textOutput("SliderText")), width = 12,
                          downloadButton('downloadReport', 'Download PDF',  class = "butt1"),
                          tags$head(tags$style(".butt1{background-color:orange;} .butt1{color: black;}")),
                          column(8,
                                 actionButton("go", "Go!",  class = "butt2")),
                          tags$head(tags$style(".butt2{background-color:green;} .butt1{color: black;}"))
                          ),
                        
                        column(align="center", h4('#Data Values'),
                               withSpinner(plotOutput("plot1"), color = "#E41A1C"),
                               withSpinner(plotOutput("plot2"), color = "#E41A1C"),
                               h4('#Data Points'),
                               withSpinner(plotOutput("plot3"), color = "#E41A1C"),
                               withSpinner(plotOutput("plot4"), color = "#E41A1C"),
                               
                               width=12, style="border:1px solid black"),
                      )
             )
             # ,
             # tabPanel('Stats',
             #          h4("#Data Distribution"),
             #          sidebarLayout(
             #            
             #            sidebarPanel(
             #              
             #              column(4,
             #                     selectInput("dataset_stats", "Dataset", choices = sort(unique(dataset_code_list_qi$dataset)))),
             #              column(4,
             #                     selectInput("element_stats", "Element", choices = NULL)),
             #              column(4,
             #                     selectInput("item_stats", "Item", choices = NULL)),
             #              column(4,
             #                     selectInput("qi_stats", "Quality Indicator", choices = NULL)),
             #              column(8,
             #                     numericInput("year_stats", "Year:", min = 1961, max = 2020, value = 2020)),
             #              # verbatimTextOutput("value"), 
             #              # width = 12,
             #              # column(8,
             #                     actionButton("goStats", "Go!",  class = "butt2"),
             #              width = 12,
             #                     # ),
             #              tags$head(tags$style(".butt2{background-color:green;} .butt1{color: black;}"))
             #            ), 
             #            column(align="center", #h4('#Data Distribution'),
             #                   withSpinner(plotOutput("plotStats1"), color = "#E41A1C"),
             #                   br(),
             #                   br(),
             #                   # withSpinner(leafletOutput("map_stats"), color = "#E41A1C"),
             #                   # br(),
             #                   # br(),
             #                   width=12, style="border:1px solid black")
             #          ))
  ))

