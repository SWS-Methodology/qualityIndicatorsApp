## PDF format

getInfographic <- function(plot1, plot2, plot3, plot4,
                           dataset_name, area_name, item_name, element_name, min_year, max_year) {
  
  # pdf("Infographics1.pdf", width = 10, height = 20)
  # source('R/vplayout.R')
  
  vplayout <- function (x, y) {
    grid::viewport(layout.pos.row = x, layout.pos.col = y)
  }
  
  grid.newpage() 
  pushViewport(viewport(layout = grid.layout(4, 2)))
  grid.rect(gp = gpar(fill = "white", col = "#E2E2E3"))
  grid.text("Quality Indicators", y = unit(0.94, "npc"), gp = gpar(fontfamily = "Helvetica", col = "#3b556e", cex = 6.4))
  grid.text("by Methodological Innovation Team - ESS", vjust = 4.5, y = unit(0.92, "npc"), gp = gpar(fontfamily = "Helvetica", 
                                                                                                     col = "#552683", cex = 0.8))
  
  # print(top15prod_crops_2018_item,  vp = vplayout(4, 1))
  # print(top15area_crops_2018_item,  vp = vplayout(4, 2))# print(top15, vp = vplayout(3, 1:3))
  # 
  # print(top15prod_crops_2018,  vp = vplayout(3, 1))
  # print(top15area_crops_2018,  vp = vplayout(3, 2))
  # 
  # print(perc_official_data_points_crops_livestock, vp = vplayout(2, 1:2))
  
  print(plot1, vp = vplayout(2, 1:2))
  print(plot2, vp = vplayout(3, 1:2))
  print(plot3, vp = vplayout(4, 1:2))

  
  fao_logo <- png::readPNG("www/fao_logo2.png")# readPNG('www/fao_logo2.png')
  grid::grid.raster(fao_logo, x = 0.07, y = 1, just = c('left', 'top'), width = unit(2, 'inches'))
  
  grid.rect(gp = gpar(fill = "#E7A922", col = "#E7A922"), x = unit(0.5, "npc"), y = unit(0.82, "npc"), width = unit(1, "npc"), 
            height = unit(0.11, "npc"))
  grid.text("Quality Indicators - SWS", y = unit(0.82, "npc"), x = unit(0.5, "npc"), vjust = .5, 
            hjust = .5, gp = gpar(fontfamily = "Helvetica", col = "#CA8B01", cex = 4.5, alpha = 0.3))
  
  # grid.text("#Crops: % Official Data Points - Top 15 countries in 2018", vjust = 0, hjust = 0, x = unit(0.01, "npc"), 
  #           y = unit(0.505, "npc"), gp = gpar(fontfamily = "Helvetica", col = "#552683", cex = 1.2))
  
  # grid.text("#Crops: % Official Data Points - Top 15 items in 2018", vjust = 0, hjust = 0, x = unit(0.01, "npc"), 
  #           y = unit(0.25, "npc"), gp = gpar(fontfamily = "Helvetica", col = "#552683", cex = 1.2))
  
  grid.text("#DataInfo", vjust = 0, hjust = 0, x = unit(0.01, "npc"), y = unit(0.88, "npc"), gp = gpar(fontfamily = "Helvetica", col = "#552683", cex = 1.2))
  grid.text(paste(
    "Dataset",
    "Area",
    "Item",
    "Element",
    "Source",
   # "Frequency of Update",
    "Period", sep = "\n"), vjust = 0, hjust = 0, x = unit(0.01, "npc"), y = unit(0.79, "npc"), gp = gpar(fontfamily = "Helvetica", col = "#552683", cex = 0.8))
  grid.text(paste(
    # "Dataset: Crops and Livestock Primary",
    dataset_name,
    # "Top 15 countries - % Official Data points",
    # area_name,
    paste0(unique(c(area_name)), collapse = ', '),
    item_name,
    #"Top 15 items - % Official Data points",
    element_name,
    "Statistical Working System",
    #"Annually",
    # "1961-2018", 
    paste0(min_year, ' - ', max_year),
    sep = "\n"), vjust = 0, hjust = 0, x = unit(0.15, "npc"), y = unit(0.79, "npc"), gp = gpar(fontfamily = "Helvetica", col = "#552683", cex = 0.8))
  
  grid.newpage()
  pushViewport(viewport(layout = grid.layout(4, 2)))
  print(plot4,  vp = vplayout(1, 1:2))
  
  # dev.off()

}
