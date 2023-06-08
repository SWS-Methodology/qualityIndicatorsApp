# R Packages --------------------------------------------------------------



# frano
# .libPaths( c(#"/srv/shiny-server/shinyFisheriesTrade_prod/lib",
#   "/work/SWS_R_Share/shiny/Rlib/3.1",
#   "/srv/shiny-server/FisheriesTrade/lib",
#   "/usr/local/lib64/R-3.1.2/library",
#   "/home/shiny/R/x86_64-pc-linux-gnu-library/3.2",
#   .libPaths()))

#fi  .libPaths( c(#"/srv/shiny-server/shinyFisheriesTrade_prod/lib",
#fi   "/home/shiny/R/x86_64-pc-linux-gnu-library/3.2",
#fi   "/usr/local/lib64/R-3.1.2/library",
#fi   "/srv/shiny-server/FisheriesTrade/lib",
#fi   "/work/SWS_R_Share/shiny/Rlib/3.1",
#fi   .libPaths())) 

#.libPaths("../_qualityIndicatorsApp_support_lib/3.3/")
.libPaths("/newhome/ilicicf/Shiny-FAO-Legacy-app-port/_qualityIndicatorsApp_support_lib/3.3.latest")

rm(list = ls())

suppressMessages({
  
  library(shiny)
  library(dplyr)
  #library(data.table)
  #library(data.table, lib.loc = '/usr/local/lib64/R-3.1.2/library')
  library(data.table)
  library(htmltools)
  library(shinyWidgets)
  library(faosws)
  library(faoswsUtil)
  library(faoswsFlag)
  library(plyr)
  library(stringr)
  library(ggplot2)
  library(scales)
  library(shinythemes)#, lib.loc = '/srv/shiny-server/qualityIndicatorsApp/lib')
  #library(shinythemes)
  library(gridExtra)#, lib.loc = '/srv/shiny-server/qualityIndicatorsApp/lib')
  #library(gridExtra)
  library(png)
  library(grid)
  library(DT)
  library(shinycssloaders)
  # library(leaflet)
  # library(leaflet, lib.loc ="/srv/shiny-server/leaflet-lib/lib/")
  
})

message("data.table: ", packageVersion("data.table")) 
message("curl: ", packageVersion("curl"))
message("faosws: ", packageVersion("faosws"))
message("faoswsUtil: ", packageVersion("faoswsUtil"))
message("faoswsFlag: ", packageVersion("faoswsFlag"))



# Setting the environment -------------------------------------------------

is_run_local <- ifelse(Sys.info()[["user"]] == "Bruno", T, F)

if(is_run_local){
  
  
  if(CheckDebug()){
    
    library(faoswsModules)
    # SETT <- ReadSettings("../modules/sws.yml")
    SETT <- ReadSettings("../modules/sws.yml")
    SetClientFiles(SETT[["certdir"]])
    GetTestEnvironment(baseUrl = SETT[["server"]], token = SETT[["token"]])
    Sys.setenv(R_SWS_SHARE_PATH = SETT[["share"]])
    GetTestEnvironment(baseUrl = SETT[["server"]], token = SETT[["token"]])
    
  } 
} else {
  
  if(CheckDebug()){
    message("After checkdebug")
    library(faoswsModules)
    R_SWS_SHARE_PATH = "Z:"
    # SetClientFiles("/srv/shiny-server/.R/QA/")
    SetClientFiles("./sws/qa")
    GetTestEnvironment(baseUrl = "https://sws.aws.fao.org:8181",
      # baseUrl = "https://hqlqasws1.hq.un.fao.org:8181/sws",
                       # token = '7ce801e7-cdf4-412a-b53d-ced366f91d41'
                       #token = '150ab136-1f98-4843-8e09-482248d667ce'
      # token = '02dedeb6-0bc5-485b-9ccd-d27cf9139999'
      token = '90474a98-842f-480e-84bf-6399f41d4010'
    )
  }
}


message("Right after connecting to SWS")

message(swsContext.baseRestUrl)

# Functions ---------------------------------------------------------------

# source('../R/getDataCompleteness.R')
# source('../R/save_plot.R')
# source('../R/theme_fao.R')
source('R/getInfographic.R')
source('R/toUTF8.R')
source('R/theme_fao.R')
# source('R/plot_map.R')
# source('R/vplayout.R')
# source('R/ReadPNG.R')
# source('R/read.c')
# Rcpp::sourceCpp("R/read_png.cpp")
# source('../R/getInfographicGroups.R')
source('R/integerBreaks.R')

message("Right after loading functions")

# Loading data ------------------------------------------------------------

mapping_datasets <- ReadDatatable('mapping_datasets_qi')

message("Right after reading datatable")

dataset_code_list_qi <- ReadDatatable("dataset_code_list_qi")

qi_dimensions <- ReadDatatable("qi_dimensions")

message(head(dataset_code_list_qi))
# countries_sf <- readRDS("data/geo_un_simple_boundaries.rds")

# dataset_code_list_qi <- ReadDatatable(
#   "dataset_code_list_qi",
#   where = "dataset = 'Crops' AND
#   area_name IN ('World', 'Italy', 'France', 'Africa', 'Europe', 'Asia', 'Mozambique', 'United States of America', 'Oceania') ")


# Header ------------------------------------------------------------------

headerPanel_2 <- function(title, h, windowTitle=title) {    
  tagList(
    tags$head(tags$title(windowTitle)),
    h(title)
  )
}
