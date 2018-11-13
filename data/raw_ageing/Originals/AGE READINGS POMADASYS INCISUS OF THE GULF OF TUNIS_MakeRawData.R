#### SETUP #####################################################################
cat("\014")
setwd(here::here())
library(dplyr)
library(readxl)

df <- read_excel("data/raw_ageing/originals/AGE READINGS POMADASYS INCISUS OF THE GULF OF TUNIS.xlsx",sheet = "Feuil1") %>%
  rename(id=`N°`,sex=Sex,wt=weight,tl=`total length`,
         otoliths_r1=`1st reaging`,otoliths_r2=`2nd reading`) %>%
  mutate(tl=tl*10) %>%
  select(id,tl,wt,sex,contains("otoliths"))
str(df)

write.csv(df,file="data/raw_ageing/chater_otolith_2015.csv",
          quote=FALSE,row.names=FALSE)
