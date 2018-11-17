cat("\014")
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- read_excel(paste0(pth,"brenden_sectioned_2006.xls"),
                 sheet = "Ages",na=c("","excluded")) %>%
  select(-`X__1`) %>%
  rename(majority=`Majority Age`,consensus=`Decided Upon Age`,final=`Final Ages`,
         finrays_Brenden=Brenden,finrays_Hale=Hale,finrays_Staples=Staples)
df

write.csv(df,file="data/raw_ageing/brenden_sectioned_2006.csv",
          quote=FALSE,row.names=FALSE)
