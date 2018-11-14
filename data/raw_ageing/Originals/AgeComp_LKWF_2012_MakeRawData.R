#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
library(readxl)
library(dplyr)
library(tidyr)

df <- read_excel("data/raw_ageing/Originals/AgeComp_LKWF_2012.xlsx",
                 col_types=c("skip","text","text","text","numeric","skip")) %>%
  rename(id=ID,structure=Material,reader=Reader,age=Age) %>%
  mutate(read=paste0(structure,"_R",reader)) %>%
  select(id,read,age) %>%
  spread(key="read",value="age")
df

write.csv(df,file="data/raw_ageing/zhu_comparison_2015.csv",
          quote=FALSE,row.names=FALSE)
