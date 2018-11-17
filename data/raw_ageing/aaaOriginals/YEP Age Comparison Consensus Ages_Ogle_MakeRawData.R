cat("\014"); rm(list=ls())
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- read_excel(paste0(pth,"YEP Age Comparison Consensus Ages_Ogle.xlsx"),
                 sheet = "Ages",na=c("",".")) %>%
  rename(id=ID,tl=TL,wt=WEIGHT,
         spines_NR=AS_NR1,spines_IR=AS_MR1,spines_ER=AS_ER1,
         otoliths_NR=OT_NR1_AGE,otoliths_IR=OT_MR1_AGE,otoliths_ER=OT_ER1_AGE,
         scales_NR=SC_NR1_AGE,scales_IR=SC_MR1_AGE,scales_ER=SC_ER1_AGE) %>%
  mutate(sex=ifelse(SEX==1,"male","female")) %>%
  select(id,tl,wt,sex,contains("scales"),contains("spines"),contains("otoliths"))
df

write.csv(df,file="data/raw_ageing/vandergoot_lake_2008.csv",
          quote=FALSE,row.names=FALSE)
