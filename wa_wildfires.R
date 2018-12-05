library(data.table)
library(ggplot2)

wa_wildfires <- data.table::fread("wa-wildfires.csv")

wa_wildfires %>% 
  filter()