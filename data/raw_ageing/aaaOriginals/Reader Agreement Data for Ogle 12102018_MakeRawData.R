cat("\014"); rm(list=ls())
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- read_excel(paste0(pth,"Reader Agreement Data for Ogle 12102018.xlsx"),
                 col_types=c("guess","text","numeric","text","skip","numeric",
                             "numeric","numeric","skip","numeric","numeric",
                             "skip","skip","skip","numeric",
                             "numeric","numeric","skip","numeric","numeric",
                             "skip","skip","skip","numeric",
                             "numeric","numeric","skip","numeric","numeric",
                             "skip","skip","skip","numeric",
                             "skip","skip","skip","skip","skip","skip","skip",
                             "skip","skip"),skip=1,na=c("",".")) %>%
  filter(!is.na(`Fish ID`)) %>%
  rename(id=`Fish ID`,date=`Harvested`,tl=`TL (mm)`,age_KNOWN=`Age`,sex=Sex,
         otolith_Dave1=Dave,otolith_Nate1=Nate,
         otolith_Dave2=Dave2,otolith_Nate2=Nate2,otolith_CONSENSUS=Concert,
         scale_Dave1=`Dave__1`,scale_Nate1=`Nate__1`,
         scale_Dave2=`Dave2__1`,scale_Nate2=`Nate2__1`,scale_CONSENSUS=`Concert__1`,
         finray_Dave1=`Dave__2`,finray_Nate1=`Nate__2`,
         finray_Dave2=`Dave2__2`,finray_Nate2=`Nate2__2`,finray_CONSENSUS=`Concert__2`) %>%
  mutate(date=ifelse(date=="spring 2008",39448,date),
         date=as.numeric(date),date=janitor::excel_numeric_to_date(date),
         year=lubridate::year(date),
         otolith_Dave1=year-otolith_Dave1,otolith_Nate1=year-otolith_Nate1,
         otolith_Dave2=year-otolith_Dave2,otolith_Nate2=year-otolith_Nate2,
         otolith_CONSENSUS=year-otolith_CONSENSUS,
         scale_Dave1=year-scale_Dave1,scale_Nate1=year-scale_Nate1,
         scale_Dave2=year-scale_Dave2,scale_Nate2=year-scale_Nate2,
         scale_CONSENSUS=year-scale_CONSENSUS,
         finray_Dave1=year-finray_Dave1,finray_Nate1=year-finray_Nate1,
         finray_Dave2=year-finray_Dave2,finray_Nate2=year-finray_Nate2,
         finray_CONSENSUS=year-finray_CONSENSUS) %>%
  select(id,tl,sex,age_KNOWN,date,year,
         contains("otolith"),contains("scale"),contains("finray"))

df

write.csv(df,file="data/raw_ageing/buckmeier_utility_2012.csv",
          quote=FALSE,row.names=FALSE)
