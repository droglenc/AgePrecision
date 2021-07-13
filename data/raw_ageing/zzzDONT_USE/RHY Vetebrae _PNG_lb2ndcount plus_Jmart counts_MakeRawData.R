cat("\014"); rm(list=ls())
setwd(here::here())
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df1 <- readxl::read_excel(paste0(pth,"RHY Vetebrae _PNG_lb2ndcount plus_Jmart counts.xlsx"),sheet = "set 1") %>%
  rename(id=`Lable No.`,reader1=`Band Pair Count`,reader2=`Jsmart counts`) %>%
  select(id,starts_with("reader"))

df2 <- readxl::read_excel(paste0(pth,"RHY Vetebrae _PNG_lb2ndcount plus_Jmart counts.xlsx"),sheet = "set 2 ") %>%
  rename(id=`label no.`,reader1=`Band Pair Count`,reader2=`JSMART COUNT`) %>%
  select(id,starts_with("reader"))

df <- rbind(df1,df2)
df

write.csv(df,file="data/raw_ageing/baje_age_2018.csv",
          quote=FALSE,row.names=FALSE)
