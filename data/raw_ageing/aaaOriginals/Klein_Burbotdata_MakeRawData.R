cat("\014"); rm(list=ls())
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"
nm <- paste0(pth,"Klein_Burbotdata.xlsx")

df <- read_excel(nm,skip=1,na=c("na",">3000")) %>%
  rename(id=X__1,tl=X__2,wt=X__3,
         branchio_MT=Brachiostegal,branchio_ZK=Brachiostegal__2,
         branchio_CONSENSUS=Brachiostegal__4,
         finrays_MT=`Pectoral Fin`,finrays_ZK=`Pectoral Fin__2`,
         finrays_CONSENSUS=`Pectoral Fin__4`,
         otoliths_MT=Otolith,otoliths_ZK=Otolith__2,
         otoliths_CONSENSUS=Otolith__4) %>%
  select(id,tl,wt,contains("branchio"),contains("finrays"),contains("otoliths"))
str(df)

write.csv(df,file="data/raw_ageing/klein_age_2014.csv",quote=FALSE,row.names=FALSE)
