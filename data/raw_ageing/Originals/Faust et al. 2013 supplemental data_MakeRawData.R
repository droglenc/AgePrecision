#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
library(readxl)
library(dplyr)

df <- read_excel("data/raw_ageing/Originals/Faust et al. 2013 supplemental data.xlsx",
                 sheet="Age estimation data",skip=1) %>%
  rename(id=Fish_ID,tl=`Total length (cm)`,loc=Lake,structure=Structure,
         R1=`Reader 1 Age Estimate (years)`,
         R2=`Reader 2 Age Estimate (years)`,
         R3=`Reader 3 Age Estimate (years)`) %>%
  select(id,loc,tl,structure,R1,R2,R3)
df

write.csv(df,file="data/raw_ageing/faust_precision_2013.csv",
          quote=FALSE,row.names=FALSE)
