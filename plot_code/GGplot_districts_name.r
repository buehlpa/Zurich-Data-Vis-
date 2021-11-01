library(raster)
library(sf)
library(ggspatial)
library(sp)
library(ggplot2)
library(ggrepel)
library(rgeos)



# load datasets, NOTE they have to be transformed first

Sw                <- readRDS("Rdata/gadm36_CHE_0_sp.rds")%>%st_as_sf()
Sw_canton         <- readRDS("Rdata/gadm36_CHE_1_sp.rds")%>%st_as_sf()
Sw_gemeinde       <- readRDS("Rdata/gadm36_CHE_2_sp.rds")%>%st_as_sf()
SW_ort            <- readRDS("Rdata/gadm36_CHE_3_sp.rds")%>%st_as_sf()


#  ####
#sf object s of Zuerich,Gemeinden  Zürich

Zuerich             =  subset(Sw_canton, NAME_1 == "Zürich")             
Zuerich_gemeinde    =  subset(Sw_gemeinde, NAME_1 == "Zürich")[-10,]  #remove schaffhausen does not belong to zurich


#ggplot

zuerichp=ggplot()+
  geom_sf(data = Zuerich_gemeinde, fill="grey", color="black")+ #districts
  geom_sf_text(data = st_as_sf(Zuerich_gemeinde ), aes(label =  NAME_2), size = 4,family="serif")+ #annotate districtnames
  
  coord_sf(xlim = c(8.35,8.98), ylim = c( 47.18 ,47.68))+ #overlay a coord system
  
  ggplot2::labs(x = NULL, y = NULL, title = NULL)+ #set labs to NULL " default"
  
  ggspatial::annotation_scale(location = "br",      # scale for measurment
                              bar_cols = c("grey60", "white"),
                              text_family = "ArcherPro Book")+
  theme_void() # theme which removes all background 


#save the plot as svg
ggsave(plot = zuerichp ,"plots/GGplot_districts_name.svg")
