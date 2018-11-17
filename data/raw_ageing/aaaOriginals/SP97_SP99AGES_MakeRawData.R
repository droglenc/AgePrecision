cat("\014"); rm(list=ls())
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df1 <- read.table(paste0(pth,"SP97AGES.TXT"),header=TRUE,na=c("",".")) %>%
  rename(id=DateSpID,species=Species,tl=Length,
         scales_R1=Sage1,scales_R2=Sage2,scales_R3=Sage3,
         wholeoto_R1=Woto1,wholeoto_R2=Woto2,wholeoto_R3=Woto3,
         sectoto_R1=Soto1,sectoto_R2=Soto2,sectoto_R3=Soto3) %>%
  select(id,species,tl,contains("scales"),contains("wholeoto"),contains("sectoto"))

df2 <- read.table(paste0(pth,"SP99AGES.TXT"),header=TRUE,na=c("",".")) %>%
  rename(id=DateSpID,species=Species,tl=Length,
         scales_R1=Scale1,scales_R2=Scale2,scales_R3=Scale3,
         wholeoto_R1=Woto1,wholeoto_R2=Woto2,wholeoto_R3=Woto3,
         sectoto_R1=Soto1,sectoto_R2=Soto2,sectoto_R3=Soto3) %>%
  select(id,species,tl,contains("scales"),contains("wholeoto"),contains("sectoto"))

df <- rbind(df1,df2)
str(df)

write.csv(df,file="data/raw_ageing/long_precision_2001.csv",
          quote=FALSE,row.names=FALSE)
