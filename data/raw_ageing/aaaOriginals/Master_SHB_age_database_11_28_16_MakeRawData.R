cat("\014"); rm(list=ls())
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- read_excel(paste0(pth,"Master_SHB_age_database_11_28_16.xlsx"),
                 sheet="All_ages_master") %>%
  rename(loc=System,year=Year,id=Age_ID_Link,
         scales_AT_1=AT_1_count,scales_AT_2=AT_2_count,scales_AT_final=AT_final_count,
         scales_CH_1=CH_1_count,scales_CH_2=CH_2_count,scales_CH_final=CH_final_count,
         scales_CONSENSUS=Consensus_count,
         edgeIsAnnulus=`Last annuli on edge?`) %>%
  mutate(date=substring(id,first=5,last=12),
         id=substring(id,first=14),
         date=as.Date(gsub("_","/",date,fixed=TRUE),format="%m/%d/%y"),
         mon=months(date)) %>%
  select(id,loc,mon,year,contains("scale"),edgeIsAnnulus) %>%
  mutate(loc=mapvalues(loc,from=c("CHE","CHA","BIG"),
                       to=c("Chestatee R","Chattahoochee R","Big Creek")))
str(df)

write.csv(df,file="data/raw_ageing/long_evaluation_2018.csv",
          quote=FALSE,row.names=FALSE)
