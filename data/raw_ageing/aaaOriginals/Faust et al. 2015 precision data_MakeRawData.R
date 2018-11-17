cat("\014"); rm(list=ls())
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- read_excel(paste0(pth,"Faust et al. 2015 precision data.xlsx")) %>%
  rename(cleithra_R1="reader 1",cleithra_R2="reader 2",cleithra_R3="reader 3")
df

write.csv(df,file="data/raw_ageing/faust_muskellunge_2015.csv",
          quote=FALSE,row.names=FALSE)
