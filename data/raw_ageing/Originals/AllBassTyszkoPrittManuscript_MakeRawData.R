#### SETUP #####################################################################
cat("\014")
setwd(here::here())
source("code/precisionData.R")

df <- read.csv("data/raw_ageing/originals/AllBassTyszkoPrittManuscript.csv",
               stringsAsFactors=FALSE) %>%
  rename(date=Trip_Date,loc=Location,id=FishID,species=Species,tl=len,wt=Weight,
         scale_1=Scale.1,scale_2=Scale.2,scale_3=Scale.3,
         otolith_1=Otolith.1,otolith_2=Otolith.2,otolith_3=Otolith.3) %>%
  mutate(species=mapvalues(species,from=c(77004,77006),
                           to=c("SMB","LMB")),
         loc=mapvalues(loc,from=c(80107,80110,80243,80246,80313,80316,80334,80339,
                                  80358,80394,80404,80424,80428,80433,80501,80517),
                       to=c("Hargus","Kiser","Oxbow",
                            "Pleasant Hill","Findley","Highlandtown",
                            "Long","Spencer","Silver Creek",
                            "Wingfoot","Burr Oak","Lake Snowden","Tycoon",
                            "Wolf Run","Acton","Paint Creek")),
         year=lubridate::year(lubridate::mdy(date)),
         locyr=paste(loc,year,sep="_")) %>%
  select(id,species,locyr,tl,wt,scale_1:otolith_3)

## Some rows don't have any age data ... find them and remove them
tmp <- apply(df[,c("scale_1","scale_2","scale_3",
                   "otolith_1","otolith_2","otolith_3")],
             MARGIN=1,FUN=function(x) all(is.na(x)))
df2 <- df[!tmp,]
  
str(df2)

write.csv(df2,file="data/raw_ageing/tyszko_comparing_2017.csv",
          quote=FALSE,row.names=FALSE)
