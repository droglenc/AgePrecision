cat("\014"); rm(list=ls())
setwd(here::here())
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- readxl::read_excel(paste0(pth,"AML reads.xlsx"),sheet="AML") %>%
  rename(id=`Tag_Number`,tl=`Total Length (cm)`,sex=Sex,
         reader1=`Read 1`,reader2=`Read 2`) %>%
  select(id,tl,sex,starts_with("reader"))
df

write.csv(df,file="data/raw_ageing/smart_effects_2016.csv",
          quote=FALSE,row.names=FALSE)
