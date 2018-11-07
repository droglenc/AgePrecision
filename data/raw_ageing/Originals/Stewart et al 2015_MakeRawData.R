cat("\014")
setwd(here::here())
source("code/precisionData.R")
library(readxl)

## Notes
##   1. deleted weights because most were missing and some include "?"
##   2. deleted date because we don't use it and multiple formats were used such
##      that they were not imported correctly
##   3. deleted FL because not needed
##   4. had to handle one age that was entered as hyphenated
df <- read_excel("data/raw_ageing/Originals/Stewart et al 2015 - Data.xlsx",na=c("")) %>%
  rename(id=ID,sex=Sex,loc=Llocation,gear=Capture,tl="TL (cm)",
         r1="Reader 1 (N.D. Stewart)",r2="Reader 2 (M.J. Dadswell)",
         consensus="Age (Final)") %>%
  mutate(r2=ifelse(r2=="43-45",44,r2),
         r2=as.numeric(r2)) %>%
  select(id,loc,tl,r1,r2,consensus)
str(df)

write.csv(df,file="data/raw_ageing/Stewart_et_al_2015.csv",
          quote=FALSE,row.names=FALSE)
