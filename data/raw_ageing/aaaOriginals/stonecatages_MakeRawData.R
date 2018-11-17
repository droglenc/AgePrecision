cat("\014"); rm(list=ls())
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- read.csv(paste0(pth,"stonecatages.csv"),stringsAsFactors=FALSE) %>%
  rename(id=ID,tl=length,sex=Sex,
         spines_Betsy_1=Betsy_2,spines_Betsy_2=Betsy_3,
         spines_Alex_1=Alex_2,spines_Alex_2=Alex_3,
         spines_Lee_1=Lee_2,spines_Lee_2=Lee_3,
         spines_CONSENSUS=FinalAge) %>%
  mutate(sex=mapvalues(sex,from=c("F","M","U","Uk","UK"),
                       to=c("female","male","unknown","unknown","unknown"))) %>%
  select(-Betsy_1,-Alex_1,-Lee_1) %>% # these were burn-in estimates ... don't use
  select(id,tl,sex,contains("spines"))
str(df)

write.csv(df,file="data/raw_ageing/puchala_size_2018.csv",
          quote=FALSE,row.names=FALSE)
