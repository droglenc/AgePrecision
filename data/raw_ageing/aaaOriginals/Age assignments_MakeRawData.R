cat("\014"); rm(list=ls())
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- read_excel(paste0(pth,"Age assignments.xlsx")) %>%
  rename(id=`Serial Number`,loc=Lake,date=Date,tl=`TL (mm)`,sex=Sex,
         spines_Dale=`Dale spine`,spines_Steve=`Steve spine`,
         otoliths_Dale=`Dale otolith`,otoliths_Mgmt=`Mgmt otolith`) %>%
  select(id,loc,date,tl,sex,contains("spines"),contains("otoliths"))
df

write.csv(df,file="data/raw_ageing/logsdon_use_2007.csv",
          quote=FALSE,row.names=FALSE)
