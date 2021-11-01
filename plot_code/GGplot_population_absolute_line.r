library(dplyr)
library(ggplot2)


#read the data
pop_abs=tibble(read.csv("Rdata/KANTON_ZUERICH_Bevoelkerung_absolut.csv",encoding="UTF-8",sep = ";"))

pop_abs_ts<-pop_abs%>%filter(GEBIET_NAME=="Zürich - ganzer Kanton")%>%select(INDIKATOR_JAHR,INDIKATOR_VALUE)




#main plot
pop_abs_ts$INDIKATOR_VALUE=(pop_abs_ts$INDIKATOR_VALUE)/10^6 # scale the axis


pop_abs_gg=ggplot(data=pop_abs_ts)+
  geom_line(aes(x=INDIKATOR_JAHR ,y=INDIKATOR_VALUE))+
  labs(x = NULL, y = "Population in Millions")+
  
  
  theme(panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        panel.grid.major =element_line(colour = "lightgrey"),
        plot.background = ggplot2::element_blank(), 
        legend.background = ggplot2::element_blank(),
        )


#save the file
ggsave(file="plots/GGplot_population_absolute_line.svg", plot=pop_abs_gg)
