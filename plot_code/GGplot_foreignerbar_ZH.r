# Libraries
library(ggplot2)
library(dplyr)

#laoding the data aggregate multiple datasets from Opendata Zurich
load("Rdata/data_aggregate.rda")


#filter the year
aranged=data_agg %>% filter(year=="2020-01-01")%>%
                     select(district,foreignerratio)%>%
                     arrange(desc(foreignerratio))




##ggplot
fratio=ggplot(data=aranged, aes(x=reorder(district,foreignerratio), y=foreignerratio)) + #the reorder orders the data 
  
  geom_bar(stat="identity",fill="grey") + #add a barchart
  
  coord_flip()+                           #flip the coordinates
  
  scale_y_reverse(position = "right")+    #set the bars on the other side #NOTE that the y is now horizontal
  scale_x_discrete(position = "top")+     #set the tickmarks to the right NOTE this is noiw the top since the coordinates were flipped
  
  labs(x=NULL,y="Foreigner ratio in %",fill="",)+ # labs
  
  theme(panel.grid.minor = element_blank(),      # adding a theme "" could also be a theme_void()
        panel.background = element_blank(),
        axis.text.y=element_text( size=10),
        axis.text.x=element_text( size=10),
        legend.text=element_text(size=10),
        panel.grid.major =element_blank(),
        panel.grid.minor.y = element_blank(),
        plot.background = ggplot2::element_blank(), 
        legend.background = ggplot2::element_blank(),
        legend.key = element_rect(colour = NA, fill = NA)
  )

#save the plot
ggsave(file="plots/GGplot_foreignerbar_ZH.svg", plot=fratio)
