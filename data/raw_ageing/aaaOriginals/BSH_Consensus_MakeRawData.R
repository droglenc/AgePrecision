cat("\014"); rm(list=ls())
setwd(here::here())
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- readxl::read_excel(paste0(pth,"BSH_Consensus.xlsx"),sheet = "AgeBiasPlots") %>%
  rename(id=Tag,length=`Length (cm)`,reader1=`Reader 1`,reader2=`Reader 2`) %>%
  select(id,length,starts_with("reader"))
df

write.csv(df,file="data/raw_ageing/mukherji_age_2021.csv",
          quote=FALSE,row.names=FALSE)
