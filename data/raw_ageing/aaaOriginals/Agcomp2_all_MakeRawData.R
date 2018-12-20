cat("\014"); rm(list=ls())
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- read_excel(paste0(pth,"Agcomp2_all.xls"),
                 skip=2,na=c("","?",".")) %>%
  rename(year=YEAR,day=`X__1`,fl=`X__5`,sex=`X__7`,id=`X__8`,
         scale_MG1=`AGE(S1M)`,scale_MG2=`AGE(S2M)`,
         scale_KH1=`AGE(S1K)`,scale_KH2=`AGE(S2K)`,
         otolith_MG1=`AGE(OM1)`,otolith_MG2=`AGE(OM2)`,
         otolith_KH1=`AGE(OK1)`,otolith_KH2=`AGE(OK2)`,
         finray_MG1=`AGE(PM1)`,finray_MG2=`AGE(PM2)`,
         finray_KH1=`AGE(PK1)`,finray_KH2=`AGE(PK2)`) %>%
  select(id,year,day,fl,sex,contains("scale"),contains("otolith"),contains("finray"))
df

write.csv(df,file="data/raw_ageing/howland_age_2004.csv",
          quote=FALSE,row.names=FALSE)
