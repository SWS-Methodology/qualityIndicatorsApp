
# shinyServer(function(input, output) {
server <- function(input, output, session) {
  
  dataset <- reactive({
    req(input$dataset)
    filter(dataset_code_list_qi, dataset == input$dataset)
    
  })
  
  country <- reactive({
    req(input$area_name)
    filter(dataset(), area_name %in% input$area_name)
  })
  
  element <- reactive({
    req(input$element_name)
    filter(dataset(), element_name == input$element_name)
  })
  
  item <- reactive({
    req(input$item_code_name)
    # filter(dataset(), item_name == input$item_name)
    filter(dataset(), item_code_name == input$item_code_name)
  })
  
  year_range <- reactive({
    cbind(input$range[1],input$range[2])
  })
  output$SliderText <- renderText({year_range()})
  
  
  # observeEvent ------------------------------------------------------------
  
  observeEvent(dataset(), {
    
    updateSelectInput(session, "area_name", choices = sort(unique(dataset()$area_name)),
                      selected = 'World')
  })
  
  observeEvent(country(), {
    
    updateSelectInput(session, "element_name", choices = sort(unique(dataset()$element_name)),
                      selected = 'Production [t]')
  })
  
  observeEvent(element(), {
    
    updateSelectInput(session, "item_code_name", choices = sort(unique(dataset()$item_code_name)),
                      # updateSelectInput(session, "item_name", choices = sort(unique(dataset()$item_name)),
                      selected = 'Cereals,Total')
  })
  
  
  
  # Get data for report -----------------------------------------------------
  
  
  sws_query <- reactive({
    
    req(input$go)
    
    
    if (input$go == 0){
      
      return()
      
    }
    input$go
    key <-  isolate(DatasetKey(
      domain = 'quality_indicators',
      dataset = mapping_datasets[dataset_name == unique(dataset()$dataset), dataset_id_qi],
      dimensions = list(
        Dimension(name = qi_dimensions[dataset_name == unique(dataset()$dataset), area],
                  keys = GetCodeList('quality_indicators', mapping_datasets[dataset_name == unique(dataset()$dataset), dataset_id_qi], qi_dimensions[dataset_name == unique(dataset()$dataset), area])[description %in% unique(country()$area_name), code]),
        Dimension(name = qi_dimensions[dataset_name == unique(dataset()$dataset), element],
                  keys = GetCodeList('quality_indicators', mapping_datasets[dataset_name == unique(dataset()$dataset), dataset_id_qi], qi_dimensions[dataset_name == unique(dataset()$dataset), element])[description %in% unique(element()$element_name), code]),
        Dimension(name = qi_dimensions[dataset_name == unique(dataset()$dataset), item],
                  #keys = GetCodeList('quality_indicators', mapping_datasets[dataset_name == unique(dataset()$dataset), dataset_id_qi], qi_dimensions[dataset_name == unique(dataset()$dataset), item])[description %in% unique(item()$item_code_name), code]),
                  # keys = GetCodeList('quality_indicators', mapping_datasets[dataset_name == unique(dataset()$dataset), dataset_id_qi], qi_dimensions[dataset_name == unique(dataset()$dataset), item])[description %in% str_trim(gsub(".*-", "", unique(item()$item_code_name))), code]),
                  keys = GetCodeList('quality_indicators', mapping_datasets[dataset_name == unique(dataset()$dataset), dataset_id_qi], qi_dimensions[dataset_name == unique(dataset()$dataset), item])[description %in% sub(".*? ", "", sub(".*? ", "", unique(item()$item_code_name))), code]),
        Dimension(name = 'qualityIndicators',
                  keys = GetCodeList('quality_indicators',
                                     mapping_datasets[dataset_name == unique(dataset()$dataset), dataset_id_qi],
                                     'qualityIndicators')[code %in% c('9270', '9280', '9260', '9295', '9240', 
                                                                      '9235', '9250', '9290'), code]),
        Dimension(name = qi_dimensions[dataset_name == unique(dataset()$dataset), year],
                  keys = as.character(input$range[1]:input$range[2])))))
    
    data_qi <- isolate(GetData(key))
    data_qi <- isolate(nameData('quality_indicators', mapping_datasets[dataset_name == unique(dataset()$dataset), dataset_id_qi], data_qi))
    
  })
  
  
  
  # Not show the plot when opening the app ----------------------------------
  
  
  output$plot1 <- renderPlot(NULL)
  output$plot2 <- renderPlot(NULL)
  output$plot3 <- renderPlot(NULL)
  output$plot4 <- renderPlot(NULL)
  
  
  vals <- reactiveValues()
  
  output$plot1 <- renderPlot({ 
    
    # Take a dependency on input$goButton
    input$go
    
    p1_0 <- ggplot(sws_query()[qualityIndicators %in% c('9270', '9280')], 
                   aes(x = as.integer(timePointYears), 
                       y = Value, 
                       group = geographicAreaM49_description,
                       colour = geographicAreaM49_description)) +
      geom_line(size = 1.5) +
      geom_point(size = 3, alpha = .4) +
      facet_wrap(~qualityIndicators_description, scales = 'free', ncol = 2) + 
      labs(x = '', y = '') +
      scale_x_continuous(breaks = integerBreaks()) +
      scale_colour_brewer(palette = "Paired") +
      theme_bw() +
      ggtitle(paste0(isolate(element()$element_name), ' - ', isolate(item()$item_name)))
    
    p1_1 <- p1_0 + theme_fao(size = 18)
    
    p1_2 <- p1_0 + theme_fao(size = 12)
    vals$p1_2 <- p1_2
    
    print(p1_1)
    
    dataset_ <- isolate(mapping_datasets[dataset_name == unique(dataset()$dataset), dataset_id_qi])
    vals$dataset_ <- dataset_
    
    area_ <- isolate(country()$area_name)
    vals$area_ <- area_
    
    element_ <- isolate(element()$element_name)
    vals$element_ <- element_
    
    item_ <- isolate(item()$item_name)
    vals$item_ <- item_
    
    year1_ <- isolate(input$range[1])
    vals$year1_ <- year1_
    
    year2_ <- isolate(input$range[2])
    vals$year2_ <- year2_
    
    
  })
  
  output$plot2 <- renderPlot({
    
    # Take a dependency on input$goButton
    input$go
    
    p2_0 <- ggplot(sws_query()[qualityIndicators %in% c('9260', '9295')], 
                   aes(x = as.integer(timePointYears), 
                       y = Value, 
                       group = geographicAreaM49_description,
                       colour = geographicAreaM49_description)) +
      geom_line(size = 1.5) +
      geom_point(size = 3, alpha = .4) +
      facet_wrap(~qualityIndicators_description, scales = 'free', ncol = 2) + 
      labs(x = '', y = '') +
      scale_x_continuous(breaks = integerBreaks()) +
      scale_colour_brewer(palette = "Paired") +
      theme_bw() +
      ggtitle(paste0(isolate(element()$element_name), ' - ', isolate(item()$item_name)))
    
    p2_1 <- p2_0 + theme_fao(size = 18)
    
    p2_2 <- p2_0 + theme_fao(size = 12)
    vals$p2_2 <- p2_2
    
    print(p2_1)
    
  })
  
  
  output$plot3 <- renderPlot({
    
    # Take a dependency on input$goButton
    input$go
    
    p3_0 <- ggplot(sws_query()[qualityIndicators %in% c('9240','9235')], 
                   aes(x = as.integer(timePointYears), 
                       y = Value, 
                       group = geographicAreaM49_description,
                       colour = geographicAreaM49_description)) +
      geom_line(size = 1.5) +
      geom_point(size = 3, alpha = .4) +
      facet_wrap(~qualityIndicators_description, scales = 'free', ncol = 2) + 
      labs(x = '', y = '') +
      scale_x_continuous(breaks = integerBreaks()) +
      scale_colour_brewer(palette = "Paired") +
      theme_bw() +
      ggtitle(paste0(isolate(element()$element_name), ' - ', isolate(item()$item_name))) 
    
    
    p3_1 <- p3_0 + theme_fao(size = 18)
    
    p3_2 <- p3_0 + theme_fao(size = 12)
    vals$p3_2 <- p3_2
    
    print(p3_1)
  })
  
  
  output$plot4 <- renderPlot({ 
    
    # Take a dependency on input$goButton
    input$go
    
    p4_0 <- ggplot(sws_query()[qualityIndicators %in% c('9250', '9290')], 
                   aes(x = as.integer(timePointYears), 
                       y = Value, 
                       group = geographicAreaM49_description,
                       colour = geographicAreaM49_description)) +
      geom_line(size = 1.5) +
      geom_point(size = 3, alpha = .4) +
      facet_wrap(~qualityIndicators_description, scales = 'free', ncol = 2) + 
      labs(x = '', y = '') +
      scale_x_continuous(breaks = integerBreaks()) +
      scale_colour_brewer(palette = "Paired") +
      theme_bw() +
      ggtitle(paste0(isolate(element()$element_name), ' - ', isolate(item()$item_name)))
    
    
    # To be printed in the app ------------------------------------------------
    
    p4_1 <- p4_0 + theme_fao(size = 18)
    
    vals$p4_1 <- p4_1
    
    print(p4_1)
    
    # To be shown in the pdf --------------------------------------------------
    
    p4_2 <- p4_0 + theme_fao(size = 12)
    vals$p4_2 <- p4_2
    
    
  })
  
  # Generate PDF Report -----------------------------------------------------
  
  
  output$downloadReport = downloadHandler(
    filename = function() 
    {paste0(unique(dataset()$dataset), '_', paste(country()$area_name, sep = "_", collapse = '_'),  '_', unique(element()$element_name), '_', 
            unique(item()$item_code_name), '_', input$range[1], '_to_', input$range[2], '_', Sys.Date(), ".pdf", sep="")},
    # {paste("report-", Sys.Date(), ".pdf", sep="")},
    content = function(file) {
      pdf(file, width = 10, height = 20)
      getInfographic(
        plot1 = vals$p1_2, 
        plot2 = vals$p2_2,
        plot3 = vals$p3_2,
        plot4 = vals$p4_2,
        dataset_name = isolate(dataset()$dataset),
        area_name = c(vals$area_), 
        item_name = vals$item_,
        element_name = vals$element_,
        min_year = vals$year1_, 
        max_year = vals$year2_
      )
      dev.off()
    }
  )
  
  
#   # Tab Stats ---------------------------------------------------------------
#   
#   
#   # Menu --------------------------------------------------------------------
#   
#   dataset_tab_stats <- reactive({
#     req(input$dataset_stats)
#     filter(dataset_code_list_qi, dataset == input$dataset_stats)
#     
#   })
#   
#   element_tab_stats <- reactive({
#     req(input$element_stats)
#     filter(dataset_tab_stats(), element_name == input$element_stats)
#   })
#   
#   item_tab_stats <- reactive({
#     req(input$item_stats)
#     filter(dataset_tab_stats(), item_name == input$item_stats)
#   })
#   
#   
#   qi_tab_stats <- reactive({
#     req(input$qi_stats)
#     filter(dataset_tab_stats(), 
#            quality_indicators_name == input$qi_stats)
#   })
#   
#   
#   output$year_stats <- renderText({ input$year_stats })
#   
#   # observeEvent ------------------------------------------------------------
#   
#   observeEvent(dataset_tab_stats(), {
#     
#     updateSelectInput(session, "element_stats", choices = unique(dataset_tab_stats()$element_name),
#                       selected = 'Production [t]')
#   })
#   
#   observeEvent(element_tab_stats(), {
#     
#     updateSelectInput(session, "item_stats", choices = unique(dataset_tab_stats()$item_name),
#                       selected = 'Pulses,Total')
#   })
#   
#   observeEvent(item_tab_stats(), {
#     
#     updateSelectInput(session, "qi_stats", 
#                       choices = c("Contribution Imputed Values to Totals [%]", "Contribution Official Values to Totals [%]", 
#                                   "Contribution Questionnaire Values to Totals [%]", "Contribution Semi-Official Values to Totals [%]", 
#                                   "Imputation Rate [%]", "Percentage Official Data Points [%]", 
#                                   "Percentage Questionnaire Data Points [%]", "Percentage Semi-Official Data Points [%]"),
#                       selected = 'Contribution Imputed Values to Totals [%]'
#     )
#   })
#   
# 
# # Get data for Stats tab --------------------------------------------------
#   
#   stats_query <- reactive({
#     
#     req(input$goStats)
#     
#     
#     if (input$goStats == 0){
#       
#       return()
#       
#     }
#     input$goStats
# 
#     key_stats <- key <-  isolate(DatasetKey(
#       domain = 'quality_indicators',
#       dataset = mapping_datasets[dataset_name == unique(dataset_tab_stats()$dataset), dataset_id_qi],
#       dimensions = list(
#         Dimension(name = qi_dimensions[dataset_name == unique(dataset_tab_stats()$dataset), area],
#                   keys = GetCodeList('quality_indicators', mapping_datasets[dataset_name == unique(dataset_tab_stats()$dataset), dataset_id_qi], qi_dimensions[dataset_name == unique(dataset_tab_stats()$dataset), area])[, code]),
#         Dimension(name = qi_dimensions[dataset_name == unique(dataset_tab_stats()$dataset), element],
#                   keys = GetCodeList('quality_indicators', mapping_datasets[dataset_name == unique(dataset_tab_stats()$dataset), dataset_id_qi], qi_dimensions[dataset_name == unique(dataset_tab_stats()$dataset), element])[description %in% unique(element_tab_stats()$element_name), code]),
#         Dimension(name = qi_dimensions[dataset_name == unique(dataset_tab_stats()$dataset), item],
#                   keys = GetCodeList('quality_indicators', mapping_datasets[dataset_name == unique(dataset_tab_stats()$dataset), dataset_id_qi], qi_dimensions[dataset_name == unique(dataset_tab_stats()$dataset), item])[description %in% unique(item_tab_stats()$item_name), code]),
#         Dimension(name = 'qualityIndicators',
#                   keys = GetCodeList('quality_indicators',
#                                      mapping_datasets[dataset_name == unique(dataset_tab_stats()$dataset), dataset_id_qi],
#                                      'qualityIndicators')[description %in% unique(qi_tab_stats()$quality_indicators_name), code]),
#         Dimension(name = qi_dimensions[dataset_name == unique(dataset_tab_stats()$dataset), year],
#                   keys = as.character(input$year_stats)))))
#     
#     
#     data_qi_stats <- isolate(GetData(key_stats))
#     data_qi_stats <- isolate(nameData('quality_indicators', 
#                                       mapping_datasets[dataset_name == unique(dataset_tab_stats()$dataset), dataset_id_qi], data_qi_stats))
#     
#     
#   })
#   
#   # Not show the plot when opening the app ----------------------------------
#   
#   
#   output$plotStats1 <- renderPlot(NULL)
#   
#   output$plotStats1 <- renderPlot({
#     
#     # Take a dependency on input$goButton
#     input$goStats
#     
#     element_ = grep('Element_description', names(stats_query()),
#          value = T, ignore.case = T)
# 
#     item_ = grep('Item_description', names(stats_query()),
#                     value = T, ignore.case = T)
#     
#     p1_Stats <- ggplot(
#       stats_query(),
#            aes(Value)) +
#       geom_histogram(boundary = 0, binwidth = 5, position="identity", alpha=0.5, fill = '#128c25') +
#       ylab('# Number of Countries') + xlab(paste0(unique(stats_query()[, qualityIndicators_description]))) +
#       theme_bw() + theme_fao(size = 18) +
#       ggtitle(paste0(isolate(element_tab_stats()$element_name), ' - ', isolate(item_tab_stats()$item_name)))
#     
#     
#     
#     
#     vals$p1_Stats <- p1_Stats
#     
#     print(p1_Stats)
#   })
#   

  
}