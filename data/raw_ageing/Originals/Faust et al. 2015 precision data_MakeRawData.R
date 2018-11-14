cat("\014")
setwd(here::here())
library(dplyr)
library(readxl)

df <- read_excel(paste0("data/raw_ageing/originals/Faust et al. 2015 precision data.xlsx")) %>%
  rename(r1="reader 1",r2="reader 2",r3="reader 3")

str(df)
write.csv(df,file="data/raw_ageing/faust_muskellunge_2015.csv",
          quote=FALSE,row.names=FALSE)
