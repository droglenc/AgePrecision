#### SETUP #####################################################################
cat("\014")
setwd(here::here())
source("code/precisionData.R")

library(readxl)
df <- read_excel("data/raw_ageing/Originals/YEP Age Comparison Consensus Ages_Ogle.xlsx",
                 sheet = "Ages",na=c("",".")) %>%
  rename(id=ID,tl=TL,wt=WEIGHT,
         aspine_NR=AS_NR1,aspine_IR=AS_MR1,aspine_ER=AS_ER1,
         otolith_NR=OT_NR1_AGE,otolith_IR=OT_MR1_AGE,otolith_ER=OT_ER1_AGE,
         scale_NR=SC_NR1_AGE,scale_IR=SC_MR1_AGE,scale_ER=SC_ER1_AGE) %>%
  mutate(sex=ifelse(SEX==1,"male","female")) %>%
  select(-SEX) %>%
  as.data.frame()
str(df)

write.csv(df,file="data/raw_ageing/vandergoot_lake_2008.csv",
          quote=FALSE,row.names=FALSE)
