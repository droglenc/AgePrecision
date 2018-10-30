#### SETUP #####################################################################
cat("\014")
setwd(here::here())
source("code/precisionData.R")

library(readxl)
df <- read_excel("data/raw_ageing/Originals/Interagency Age Comparison 2003_Ogle.xlsx",
                 sheet = "Ages") %>%
  rename(id=`FISH ID`,tl=TL,wt=WT,
         otolith_CV=ER1OTL,otolith_RZ=ER2OTL,otolith_LB=IR1OTL,
         scale_IR=IR1SCL,scale_KK=ER1SCL,
         spine_WF=ER1SPN,spine_TS=`ER2SPN TODD`) %>%
  mutate(sex=ifelse(SEXCON<6,"male","female")) %>%
  select(-AGENCY,-SEXCON) %>%
  as.data.frame()
str(df)

write.csv(df,file="data/raw_ageing/vandergoot_WAE_unpublished.csv",
          quote=FALSE,row.names=FALSE)
