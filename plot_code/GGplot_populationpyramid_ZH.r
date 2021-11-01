# Libraries
library(ggplot2)
library(dplyr)
library(lemon)



#read dataset
popage=read.csv("Rdata/KANTON_ZUERICH_bevoelkerung_1jahresklassen.csv",sep = ";",encoding = "UTF-8")
#filter dataset for only zurich and 2020
popage_zh=popage%>%filter(BEZIRK=="Zürich"& JAHR== 2020)%>%select(ALTERSKLASSE,ANZAHL_PERSONEN,GESCHLECHT_CODE)


#removing charatcter and transform to integer
popage_zh$ALTERSKLASSE=str_remove_all(popage_zh$ALTERSKLASSE, "[ Jahre]")
popage_zh$ALTERSKLASSE=str_remove_all(popage_zh$ALTERSKLASSE, "[+]")
popage_zh$ALTERSKLASSE=as.integer(str_remove_all(popage_zh$ALTERSKLASSE, "[<]"))


popage_zh=popage_zh%>%arrange(ALTERSKLASSE)



#agreggating data 

binning_f<-popage_zh%>%filter(GESCHLECHT_CODE==2)%>%select(ALTERSKLASSE,ANZAHL_PERSONEN)
binning_m<-popage_zh%>%filter(GESCHLECHT_CODE==1)%>%select(ALTERSKLASSE,ANZAHL_PERSONEN)


sum_by_age_f <- aggregate(ANZAHL_PERSONEN~ALTERSKLASSE, data = binning_f, FUN = sum)
sum_by_age_m <- aggregate(ANZAHL_PERSONEN~ALTERSKLASSE, data = binning_m, FUN = sum)

#all summarized by age
sum_by_age_f
sum_by_age_m



#creating bins with binsum 

#women

fmat=matrix(ncol =3,nrow=10,data = 0 )
for( i in  c(1:100) )
{
  if(i<=10 ){fmat[1,3]=fmat[1,3]+sum_by_age_f[i,2]}
  else if(i<=20 ){fmat[2,3]=fmat[2,3]+sum_by_age_f[i,2]}
  else if(i<=30){fmat[3,3]=fmat[3,3]+sum_by_age_f[i,2]}
  else if(i<=40 ){fmat[4,3]=fmat[4,3]+sum_by_age_f[i,2]}
  else if(i<=50 ){fmat[5,3]=fmat[5,3]+sum_by_age_f[i,2]}
  else if(i<=60 ){fmat[6,3]=fmat[6,3]+sum_by_age_f[i,2]}
  else if(i<=70 ){fmat[7,3]=fmat[7,3]+sum_by_age_f[i,2]}
  else if(i<=80 ){fmat[8,3]=fmat[8,3]+sum_by_age_f[i,2]}
  else if(i<=90 ){fmat[9,3]=fmat[9,3]+sum_by_age_f[i,2]}
  else if(i>91 ){fmat[10,3]=fmat[10,3]+sum_by_age_f[i,2]}
} 
fmat[,1]=names=c("-10","11-20","21-30","31-40","41-50","51-60","61-70","71-80","81-90","91+")
fmat[,2]=names=c(rep("Female",10))



#man
mmat=matrix(ncol =3,nrow=10,data = 0 )
for( i in  c(1:100) )
{
  if(i<=10 ){mmat[1,3]=mmat[1,3]+sum_by_age_m[i,2]}
  else if(i<=20 ){mmat[2,3]=mmat[2,3]+sum_by_age_m[i,2]}
  else if(i<=30){mmat[3,3]=mmat[3,3]+sum_by_age_m[i,2]}
  else if(i<=40 ){mmat[4,3]=mmat[4,3]+sum_by_age_m[i,2]}
  else if(i<=50 ){mmat[5,3]=mmat[5,3]+sum_by_age_m[i,2]}
  else if(i<=60 ){mmat[6,3]=mmat[6,3]+sum_by_age_m[i,2]}
  else if(i<=70 ){mmat[7,3]=mmat[7,3]+sum_by_age_m[i,2]}
  else if(i<=80 ){mmat[8,3]=mmat[8,3]+sum_by_age_m[i,2]}
  else if(i<=90 ){mmat[9,3]=mmat[9,3]+sum_by_age_m[i,2]}
  else if(i>91 ){mmat[10,3]=mmat[10,3]+sum_by_age_m[i,2]}
} 
mmat[,1]=names=c("-10","11-20","21-30","31-40","41-50","51-60","61-70","71-80","81-90","91+")
mmat[,2]=names=c(rep("Male",10))



#tag them together
mat =as.data.frame(rbind(fmat,mmat))
colnames(mat)=c("age","sex","pop")

#as numeric
mat$pop=as.integer(mat$pop)
sum(mat$pop)


#plot

poppyramid=ggplot(data = mat, 
       mapping = aes(x = ifelse(test = sex == "Male", yes = -pop, no = pop), #ifelse left or right
                     y = age, fill = sex)) +
  geom_col(width = 0.5) +  #barplot
  scale_x_symmetric(labels = abs) +
  labs(x=NULL,y=NULL,fill="",)+
  
  scale_fill_manual(values=as.vector(c("#ffbf00","#e32636")))+ #Manual colors
  
  theme(panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        axis.text.y=element_text( size=12),
        axis.text.x=element_text( size=12),
        legend.position = c(.1, .1),          #position the legend in the plot
        legend.text=element_text(size=12),
        panel.grid.major =element_line(colour = "lightgrey"),
        panel.grid.minor.y = element_line(colour = "lightgrey"),
        plot.background = ggplot2::element_blank(), 
        legend.background = ggplot2::element_blank(),
        legend.key = element_rect(colour = NA, fill = NA
                                  )
  )


ggsave(file="plots/GGplot_populationpyramid_ZH.svg", plot=poppyramid)
