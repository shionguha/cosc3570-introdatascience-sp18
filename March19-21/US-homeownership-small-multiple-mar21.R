library(ggplot2)
library(dplyr)
library(data.table)

#load data
rawData <- fread("homeownership.txt")

ggplot(data=rawData[state=="United States", ], aes(x=year, y=value)) +
  geom_line(color="red", size=1) +
  theme_minimal() +
  geom_text(data=rawData[state=="United States" & year==2015,],hjust=0,aes(label=paste(" ",round(value,1))))+
  geom_point(data=rawData[state=="United States" & year==2015,],color="blue",size=3)+
  scale_x_continuous(breaks=unique(rawData$year)) +
  scale_y_continuous(breaks = waiver()) +
  coord_cartesian(xlim = c(1895, 2020)) +
  labs(x="",y="", title="Homeownership rate (%)",
       subtitle = "United States") +
  theme(plot.caption=element_text(hjust=0)) +
  theme(axis.text=element_text(size=7))


ggplot(data=rawData[! (state %in% c("United States","District of Columbia")),],aes(x=year,y=value))+
  geom_line(color="red",size=.95)+
  theme_minimal()+
  geom_text(data=rawData[! (state %in% c("United States","District of Columbia")) & year==2015,],hjust=0,aes(label=paste(" ",round(value,0))),size=2)+
  geom_point(data=rawData[! (state %in% c("United States","District of Columbia")) & year==2015,],color="blue",size=1)+
  scale_x_continuous(breaks=c(1900,2015))+
  scale_y_continuous(breaks=waiver())+
  coord_cartesian(xlim=c(1895,2025))+facet_wrap(~state,ncol=5)+
  labs(x="",y="",title="Homeownership rate (%)",
       subtitle="by state")+
  theme(plot.caption=element_text(hjust=0))+
  theme(axis.text=element_text(size=7))



ggplot(data=rawData[(state %in% c("Hawaii","California", "Wisconsin", "Michigan", "Texas", "New York")),],aes(x=year,y=value))+
  geom_line(color="red",size=1)+
  theme_minimal()+
  scale_x_continuous(breaks=c(1900,1925,1950,1975,2000,2025))+
  scale_y_continuous(breaks=waiver())+
  coord_cartesian(xlim=c(1895,2025))+facet_wrap(~state,ncol=2)+
  labs(x="",y="",title="Homeownership rate (%)",
       subtitle="by state")+
  theme(plot.caption=element_text(hjust=0))+
  theme(axis.text=element_text(size=7))