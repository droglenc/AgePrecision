cat("\014"); rm(list=ls())
setwd(here::here())
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- readxl::read_excel(paste0(pth,"CBT-reads.xlsx"),sheet="Reads") %>%
  rename(id=`Tag`,tl=`STL`,
         reader1=`Reader 1`,reader2=`Reader 2`) %>%
  select(id,tl,starts_with("reader"))
df

write.csv(df,file="data/raw_ageing/smart_age_2015.csv",
          quote=FALSE,row.names=FALSE)
