cat("\014"); rm(list=ls())
setwd(here::here())
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- readxl::read_excel(paste0(pth,"B.D'Alberto_APE Analysis_and_Consensus Data_OCS_PNG.xls"),sheet="Raw Data",skip=2) %>%
  rename(id=`Tag`,tl=`TL`,
         reader1=`Reader 1...2`,reader2=`Reader 2`) %>%
  select(id,tl,reader1,reader2)
df

write.csv(df,file="data/raw_ageing/dalberto_age_2017.csv",
          quote=FALSE,row.names=FALSE)
