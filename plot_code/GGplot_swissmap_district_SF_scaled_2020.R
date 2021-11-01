library(raster)
library(sf)
library(ggspatial)
library(sp)
library(ggplot2)
library(ggrepel)
library(rgeos)

# load datasets 
#sf dataset
Sw_gemeinde       <- readRDS("Rdata/gadm36_CHE_2_sp.rds")%>%st_as_sf()
#aggregate dataset
load("Rdata/data_aggregate.rda")


#sf object Gemeinden 

Zuerich_gemeinde    =  subset(Sw_gemeinde, NAME_1 == "Zürich")[-10,]  #remove schaffhausen



#take population from data aggregate and add it to sf object !! must check if order is identical
popvec=(data_agg %>%filter(year=="2020-01-01"))$population 
Zuerich_gemeinde$Population=popvec




#legendtitle
legend_title ="Population/\nKm Square"

#color scale for plot
#first is the lower color


#green as in foreigner plot
color_continuous = c("#58FA58","#0B6121") #color for scaling

#grey as swissmap
color_continuous = c("#A9A9A9","#696969") #color for scaling

#yellow blue
color_continuous = c("#F5DF4D","#0072B5") #color for scaling

#D2386C
#yellow rose
color_continuous = c("#F5DF4D","#D2386C")



color_continuous = c("#F5DF4D","#FF0000")

color_na = "gray90"




Map=ggplot()+
  geom_sf(data = Zuerich_gemeinde, color="black",aes(fill=Population))+ #districts
  geom_sf_text(data = st_as_sf(Zuerich_gemeinde ), aes(label =  Population), size = 2.9,family="serif")+ #districtnames
  # annotate swissma
  ggplot2::scale_fill_gradient(low = color_continuous[1],#
                               high = color_continuous[2],
                               na.value = color_na,
                               limits=c(0,5014.6),
                               name = legend_title, #title of the scaling legend
                               guide = ggplot2::guide_colorbar(direction = "vertical",
                                                               barheight = ggplot2::unit(50, units = "mm"),
                                                               barwidth = ggplot2::unit(2, units = "mm"),
                                                               draw.ulim = T, title.position = "top",ticks = T))+theme_void()
  
  
   
  
  


Map




ggsave(plot = Map,"plots/GGplot_swissmap_district_SF_scaled_2020.svg")
