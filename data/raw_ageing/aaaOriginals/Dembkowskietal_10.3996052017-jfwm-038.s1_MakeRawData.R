cat("\014"); rm(list=ls())
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- read_excel(paste0(pth,"Dembkowskietal_10.3996052017-jfwm-038.s1.xlsx"),
                 sheet = "Data S1 - Supplemental data") %>% 
  rename(id=fishid,loc=watername,tl=tlmm,
         otoliths_R1=r1SO,spines_R1=r1SS,otoliths_R2=r2SO,spines_R2=r2SS) %>%
  select(id,loc,growth,tl,sex,contains("otoliths"),contains("spines"))
df
write.csv(df,file="data/raw_ageing/dembkowski_walleye_2017.csv",
          quote=FALSE,row.names=FALSE)