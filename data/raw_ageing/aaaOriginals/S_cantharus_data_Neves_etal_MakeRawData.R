cat("\014"); rm(list=ls())
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

dfB <- read_excel(paste0(pth,"S_cantharus_data_Neves_etal.xlsx"),
                  sheet="Between readers") %>%
  rename(tl=`TL (cm)`,sex=Sex,otoliths_R1=`Reader 1`,otoliths_R2=`Reader 2`) %>%
  mutate(tl=tl*10)
str(dfB)

write.csv(dfB,file="data/raw_ageing/neves_modelling_2017_B.csv",
          quote=FALSE,row.names=FALSE)

dfW <- read_excel(paste0(pth,"S_cantharus_data_Neves_etal.xlsx"),
                  sheet="Between reads") %>%
  rename(tl=`TL (cm)`,sex=Sex,otoliths_R2=`2st read`,otoliths_R3=`3nd read`) %>%
  mutate(tl=tl*10)
str(dfW)

write.csv(dfW,file="data/raw_ageing/neves_modelling_2017_W.csv",
          quote=FALSE,row.names=FALSE)
