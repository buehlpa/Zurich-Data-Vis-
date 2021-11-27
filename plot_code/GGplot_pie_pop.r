library(ggplot2)
#data is extracted from here
#https://www.bfs.admin.ch/bfs/de/home/statistiken/bevoelkerung/stand-entwicklung.html

# Create Data

data <- data.frame(
  group=c("Other Cantons","Zurich"),
  value=c(8.5,1.52)
)

# Basic piechart

pie=ggplot(data, aes(x="", y=value, fill=group)) +
  coord_polar("y", start=5)+
  theme_void()+
  
  geom_bar(stat="identity", width=4, color="black")+
  scale_fill_manual('', values=c('grey','lightgreen'))+
  
  annotate(geom = "text", x = 1.5, y = 0.7, label = "17.9 %", 
           color = "black", size = 7)+
  
  theme(legend.key.size = unit(1, 'cm'),
        legend.text = element_text(size=15),
        legend.position = "top")

#save the plot
ggsave(plot = pie ,"plots/GGplot_pie_pop.svg")
