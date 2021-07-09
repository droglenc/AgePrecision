cat("\014"); rm(list=ls())
setwd(here::here())
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- read.csv(paste0(pth,"C.fal age counts.csv")) %>%
  rename(id=`Tag`,tl=`length`,
         reader1A=`first`,reader1B=`second`,reader2=`third`) %>%
  select(id,tl,starts_with("reader"))
df

write.csv(df,file="data/raw_ageing/grant_life_2018.csv",
          quote=FALSE,row.names=FALSE)
