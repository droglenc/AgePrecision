cat("\014")
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- read_excel(paste0(pth,"2018.11.06 Haglund et al TROUT AGE DATA for Ogle.xlsx")) %>% 
  rename(stream=Stream,species=Species,date=Date,id="File #",
         tl="Length (mm)",wt="Weight (g)",sex=Sex,mat=Maturity,
         otoliths_R1="Reader #1",otoliths_R2="Reader #2",otoliths_R3="Reader #3") %>%
  select(id,stream,species,date,tl,wt,sex,mat,contains("otoliths")) %>%
  filter(!is.na(stream))
df
write.csv(df,file="data/raw_ageing/haglund_age_2017.csv",
          quote=FALSE,row.names=FALSE)
