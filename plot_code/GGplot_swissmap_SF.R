library(raster)
library(sf)
library(ggspatial)
library(sp)
library(ggplot2)
library(ggrepel)

#read rds to global not required here because the data is in the folder 
# source("functions/read_RDS_to_global.R")
# read_RDS_to_global("Rdata/gadm36_CHE_0_sp.rds")
# read_RDS_to_global("Rdata/gadm36_CHE_1_sp.rds")
# read_RDS_to_global("Rdata/gadm36_CHE_2_sp.rds")
# read_RDS_to_global("Rdata/gadm36_CHE_3_sp.rds")


# load datasets 
Sw                <- readRDS("Rdata/gadm36_CHE_0_sp.rds")%>%st_as_sf()
Sw_canton         <- readRDS("Rdata/gadm36_CHE_1_sp.rds")%>%st_as_sf()
Sw_gemeinde       <- readRDS("Rdata/gadm36_CHE_2_sp.rds")%>%st_as_sf()
SW_ort            <- readRDS("Rdata/gadm36_CHE_3_sp.rds")%>%st_as_sf()


# first plot ####
#sf object s of Zuerich,Gemeinden and a box surrounding Zürich

Zuerich             =  subset(Sw_canton, NAME_1 == "Zürich")             
Zuerich_gemeinde    =  subset(Sw_gemeinde, NAME_1 == "Zürich")[-10,]  #remove schaffhausen
Zuerich_box         =  st_as_sfc(st_bbox(Zuerich))                    #box           



#create swissmap wit canton emphasized

swissmap =      ggplot()+                                                         # basic plot                                                          # country settings
  geom_sf(data = Sw_canton, fill="grey", color="white")+
  geom_sf(data = Sw, fill=NA, color="black")+
  geom_sf(data = Zuerich, fill="lightgreen", color="black")+theme_void()+
  # geom_sf(data = Zuerich_gemeinde, fill="gray", color="black")+          # Would add subborders of districts                                                       # district settings
    annotation_north_arrow(location="tr",which_north="true",style=north_arrow_fancy_orienteering ())+
  


geom_sf(data = Zuerich_box, fill=NA, size=1, color="green")+              # adding box
  geom_segment(aes(y=47.5 , yend=47.5, x=9, xend=9.8), linetype = "solid", color = "red", size = 0.8)+

  # annotate(geom = "text", x = 10.1, y = 47.5, label = "Canton of Zürich", 
           # fontfamily = "serif", color = "grey22", size = 4,face="bold")+
  
  # annotate(geom = "text", x = 10.1, y = 47.7, label = "Map of Switzerland", 
           # fontfamily = "serif", color = "grey22", size = 6,face="bold")+
  
                                                               # removing grid and titles



ggsave(plot = swissmap ,"plots/GGplot_swissmap_SF.svg")
