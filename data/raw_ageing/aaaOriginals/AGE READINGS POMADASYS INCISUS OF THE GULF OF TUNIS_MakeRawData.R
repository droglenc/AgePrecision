cat("\014"); rm(list=ls())
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- read_excel(paste0(pth,"AGE READINGS POMADASYS INCISUS OF THE GULF OF TUNIS.xlsx"),
                 sheet = "Feuil1") %>%
  rename(id=`N°`,sex=Sex,wt=weight,tl=`total length`,
         otoliths_R1=`1st reaging`,otoliths_R2=`2nd reading`) %>%
  mutate(tl=tl*10) %>%
  select(id,tl,wt,sex,contains("otoliths"))
df

write.csv(df,file="data/raw_ageing/chater_otolith_2015.csv",
          quote=FALSE,row.names=FALSE)