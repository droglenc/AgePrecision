cat("\014"); rm(list=ls())
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- read_excel(paste0(pth,"Interagency Age Comparison 2003_Ogle.xlsx"),
                 sheet = "Ages") %>%
  rename(id=`FISH ID`,tl=TL,wt=WT,
         otoliths_CV=ER1OTL,otoliths_RZ=ER2OTL,otoliths_LB=IR1OTL,
         scales_IR=IR1SCL,scales_KK=ER1SCL,
         spines_WF=ER1SPN,spines_TS=`ER2SPN TODD`) %>%
  mutate(sex=ifelse(SEXCON<6,"male","female")) %>%
  select(id,tl,wt,sex,contains("otoliths"),contains("scales"),contains("spines"))
df

write.csv(df,file="data/raw_ageing/vandergoot_WAE_unpublished.csv",
          quote=FALSE,row.names=FALSE)
