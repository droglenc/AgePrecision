cat("\014"); rm(list=ls())
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"
nm <- "WAE precision data for Dr. Ogle.xlsx"

df1 <- read_excel(paste0(pth,nm),sheet="Female",skip=1) %>%
  select(-`Length (in)`) %>%
  rename(date=Date,id=`Tag Number/ID`,sex=Sex,mat=Maturity,tl=`Length (mm)`,
         otoliths_Ryan=`Ryan's Otolith Age`,otoliths_Eli=`Eli's Otolith Age`,
         spines_Jack=`Jack's Spine Age`,spines_Ryan=`Ryan's Spine Age`) %>%
  mutate(sex="female")

df2 <- read_excel(paste0(pth,nm),sheet="Male",skip=1) %>%
  select(-`Length (in)`) %>%
  rename(date=Date,id=`Tag Number/ID`,sex=Sex,mat=Maturity,tl=`Length (mm)`,
         otoliths_Ryan=`Ryan's Otolith Age`,otoliths_Eli=`Eli's Otolith Age`,
         spines_Jack=`Jack's Spine Age`,spines_Ryan=`Ryan's Spine Age`) %>%
  mutate(sex="male") %>%
  select(colnames(df1))

df <- rbind(df1,df2) %>%
  select(id,date,tl,sex,mat,contains("otoliths"),contains("spines"))
df

write.csv(df,file="data/raw_ageing/koenigs_validation_2015.csv",
          quote=FALSE,row.names=FALSE)
