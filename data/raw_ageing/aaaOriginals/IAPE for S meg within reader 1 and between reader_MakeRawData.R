cat("\014"); rm(list=ls())
setwd(here::here())
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- readxl::read_excel(paste0(pth,"IAPE for S meg within reader 1 and between reader.xlsx"),sheet = "WIthin reader") %>%
  rename(id=`Shark Number`,read1=`Age Est 1`,read2=`Age Est 2`,read3=`Age Est 3`) %>%
  select(id,starts_with("read"))
df

write.csv(df,file="data/raw_ageing/rygby_comparison_2015W.csv",
          quote=FALSE,row.names=FALSE)


df <- readxl::read_excel(paste0(pth,"IAPE for S meg within reader 1 and between reader.xlsx"),sheet = "Between reader") %>%
  rename(id=`Shark Number`,reader1=`Age Est 1`,reader2=`Age Est 2`) %>%
  select(id,starts_with("reader"))
df

write.csv(df,file="data/raw_ageing/rygby_comparison_2015B.csv",
          quote=FALSE,row.names=FALSE)
