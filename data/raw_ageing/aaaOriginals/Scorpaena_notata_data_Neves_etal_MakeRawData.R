cat("\014"); rm(list=ls())
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- read_excel(paste0(pth,"Scorpaena_notata_data_Neves_etal.xlsx"),
                  sheet="Combined (by Ogle)") %>%
  mutate(tl=tl*10) %>%
  select(tl,sex,contains("otoliths"))
str(df)

write.csv(df,file="data/raw_ageing/neves_age_2015.csv",
          quote=FALSE,row.names=FALSE)
