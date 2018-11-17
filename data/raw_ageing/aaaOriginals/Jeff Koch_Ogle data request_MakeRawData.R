cat("\014"); rm(list=ls())
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"
nm <- "Jeff Koch_Ogle data request.xlsx"

## Bowfin
df <- read_excel(paste0(pth,nm),sheet="Bowfin",na=c("",".")) %>%
  rename(finrays_R1=`R1 fin ray`,finrays_R2=`R2 fin ray`,finrays_R3=`R3 fin ray`,
         finrays_CONSENSUS=`consensusfr`,gular_R1=`R1 gular`,gular_R2=`R2 gular`,
         gular_R3=`R3 gular`,gular_CONSENSUS=`consensusgu`,
         tl=`Length`,wt=`Weight`,sex=`Sex`,mat=`Maturity`) %>%
  select(tl,wt,sex,mat,contains("finrays"),contains("gular"))
df

write.csv(df,file="data/raw_ageing/koch_precision_2009.csv",
          quote=FALSE,row.names=FALSE)


## Pallid Sturgeon
df <- read_excel(paste0(pth,nm),sheet="Pallid sturgeon") %>%
  rename(spines_JK=`jk age`,spines_MP=`mp age`,spines_KS=`ks age`,
         spines_CONSENSUS=`consensus`,age_T=`true age`,tl=`length`) %>%
  select(tl,age_T,contains("spines"))
df

write.csv(df,file="data/raw_ageing/koch_validation_2011.csv",
          quote=FALSE,row.names=FALSE)
