theme_fao <- function(size=14) {
  
  theme(axis.title = element_text(size = size),
        axis.text = element_text(size = size),
        legend.text = element_text(size = size), 
        strip.text = element_text(size = size),
        plot.title = element_text(size = size),
        legend.title = element_blank())
  
}