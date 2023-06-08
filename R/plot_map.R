plot_map <- function(data) {
  
  data[, iso3c := countrycode(geographicAreaM49_description, 'country.name', 'iso3c')]
  
  countries_sf <- merge(countries_sf, data,
                        by.x = 'ISO3CD', by.y = 'iso3c', all.x = TRUE)
  
  countries_sf <- countries_sf %>%
    mutate(`perc` = Value/100)
  
  
  
  countries_sf <- countries_sf %>%
    mutate(pop_up_qi = paste0(unique(countries_sf$qualityIndicators_description),
                              ": ",
                              MAPLAB, 
                              " - ",
                              scales::percent(`perc`)))

  countries_sf <- countries_sf %>%
    mutate(pop_up_qi = ifelse(is.na(`Value`), 
                              sprintf("<b>%s</b><br/><br/>Value: %s", 
                                      MAPLAB, "-", "-", "-"), pop_up_qi))
  
  bins <- seq(0, 1, length.out = 6)
  qi_pal <- colorBin("YlOrRd", domain = countries_sf$perc, bins = bins)
  
  countries_sf <- countries_sf %>%
    mutate(MAPLAB_1 = paste0(MAPLAB, "_1"),
           MAPLAB_2 = paste0(MAPLAB, "_2"),
           MAPLAB_3 = paste0(MAPLAB, "_3"))

  stats_map <- leaflet() %>% 
    addLayersControl(
      position = "bottomright",
      overlayGroups = c("Value"),
      options = layersControlOptions(collapsed = FALSE)) %>% 
    setView(lng = 4.327251, lat = 22.521082, zoom = 2) %>%
    addPolygons(data = countries_sf, 
                layerId = ~MAPLAB_1,
                label = ~MAPLAB,
                fillColor = ~qi_pal(`perc`), 
                color = "#666666", 
                popup = countries_sf$pop_up_qi,
                weight = .5) %>%
    addLegend("bottomright",
              pal = qi_pal,
              na.label = "No value",
              labFormat = labelFormat(suffix = "%", transform = function(x) 100*x),
              labels = scales::percent(bins),
              values = countries_sf$perc,
              title = "<small>Quality Indicator</small>") 
  stats_map
  
  
  
  
}