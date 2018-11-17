## Notes
##   1. deleted weights because most were missing and some include "?"
##   2. deleted date because we don't use it and multiple formats were used such
##      that they were not imported correctly
##   3. deleted FL because not needed
##   4. had to handle one age that was entered as hyphenated
cat("\014"); rm(list=ls())
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- read_excel(paste0(pth,"Stewart et al 2015 - Data.xlsx")) %>%
  rename(id=ID,sex=Sex,loc=Llocation,gear=Capture,tl=`TL (cm)`,
         spines_R1=`Reader 1 (N.D. Stewart)`,spines_R2=`Reader 2 (M.J. Dadswell)`,
         spines_CONSENSUS=`Age (Final)`) %>%
  mutate(spines_R2=ifelse(spines_R2=="43-45",44,spines_R2),
         spines_R2=as.numeric(spines_R2)) %>%
  select(id,loc,tl,contains("spines"))
str(df)

write.csv(df,file="data/raw_ageing/Stewart_et_al_2015.csv",
          quote=FALSE,row.names=FALSE)
