cat("\014"); rm(list=ls())
setwd(here::here())
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- readxl::read_excel(paste0(pth,"Ccoastesi_agecounts.xlsx"),sheet="LB_MGrant") %>%
  rename(id=`Label`,reader1=`Reader 1`,reader2=`Reader 2`)
df

write.csv(df,file="data/raw_ageing/baje_age_2019.csv",
          quote=FALSE,row.names=FALSE)
