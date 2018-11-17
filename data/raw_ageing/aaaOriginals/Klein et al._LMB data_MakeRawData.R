cat("\014"); rm(list=ls())
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

## Did not include confidence ratings
df <- read_excel(paste0(pth,"Klein et al._LMB data.xlsx"),
                 sheet="Raw data",na=c("","N/A","..","."),skip=1) %>%
  rename(id=`Structure ID`,species=`Species`,
         tl=`TL (mm)`,wt=`WT (g)`,true_Age=`True (known) Age`,
         otoliths_Tim=`Tim Age Estimate`,otoliths_Bryant=`Bryant Age Estimate`,
         otoliths_CONSENSUS=`Consensus Age`,
         anal_MQ=`MQ Age`,anal_ZK=`ZK Age`,anal_CONSENSUS=`Consensus`,
         dorsal_MQ=`MQ Age__1`,dorsal_ZK=`ZK Age__1`,dorsal_CONSENSUS=`Consensus__1`) %>%
  select(id,species,tl,wt,true_Age,
         contains("otoliths_"),contains("anal_"),contains("dorsal_"))
df

write.csv(df,file="data/raw_ageing/klein_precision_2017.csv",
          quote=FALSE,row.names=FALSE)

