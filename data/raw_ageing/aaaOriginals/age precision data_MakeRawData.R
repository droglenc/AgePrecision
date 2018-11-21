cat("\014"); rm(list=ls())
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- read_excel(paste0(pth,"age precision data.xlsx"),sheet = "Sheet1") %>%
  rename(loc=Lake,id=`Fish Number`,efl=`EFL (mm)`,wt=`Weight (kg)`,sex=SEX,
         maxillae_EB=EB,maxillae_BJ=BJ,maxillae_AN=AN,
         CONSENSUS=AGE) %>%
  select(id,loc,efl,wt,sex,contains("maxillae"))
df

write.csv(df,file="data/raw_ageing/long_comparative_2017.csv",
          quote=FALSE,row.names=FALSE)
