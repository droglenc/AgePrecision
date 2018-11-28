cat("\014")
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- read_excel(paste0(pth,"CCAT age data_Ogle request .xlsx"),
                 sheet = "2007 spines",na=c("","bad")) %>%
  rename(age_Aaron=`Aaron Age`,age_Tony=`Tony Age`) %>%
  mutate(strux="spines",year=2007)

tmp <- read_excel(paste0(pth,"CCAT age data_Ogle request .xlsx"),
                  sheet = "2008 spines",na=c("","bad")) %>%
  rename(age_Aaron=`Aaron Age`,age_Tony=`Tony Age`) %>%
  mutate(strux="spines",year=2008)
df <- rbind(df,tmp)

tmp <- read_excel(paste0(pth,"CCAT age data_Ogle request .xlsx"),
                  sheet = "2009 spines",na=c("","bad")) %>%
  rename(age_Aaron=`Aaron Age`,age_Tony=`Tony Age`) %>%
  mutate(strux="spines",year=2009)
df <- rbind(df,tmp)

tmp <- read_excel(paste0(pth,"CCAT age data_Ogle request .xlsx"),
                  sheet = "07-09 otoliths",na=c("","bad")) %>%
  rename(age_Aaron=`Aaron Age`,age_Tony=`Tony Age`) %>%
  mutate(strux="otoliths",year=NA)
df <- rbind(df,tmp)

df

write.csv(df,file="data/raw_ageing/barada_bias_2011.csv",
          quote=FALSE,row.names=FALSE)
