#### SETUP #####################################################################
cat("\014")
setwd(here::here())
source("code/precisionData.R")

library(readxl)
df <- read_excel(paste0("data/raw_ageing/originals/brenden_sectioned_2006.xls"),
                 sheet = "Ages",
                 na=c("","excluded")) %>%
  select(-`X__1`) %>%
  rename(majority=`Majority Age`,consensus=`Decided Upon Age`,
         final=`Final Ages`) %>%
  as.data.frame()
str(df)

write.csv(df,file="data/raw_ageing/brenden_sectioned_2006.csv",
          quote=FALSE,row.names=FALSE)
