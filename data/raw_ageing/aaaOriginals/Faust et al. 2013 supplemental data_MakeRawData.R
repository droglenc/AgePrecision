cat("\014"); rm(list=ls())
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- read_excel(paste0(pth,"Faust et al. 2013 supplemental data.xlsx"),
                 sheet="Age estimation data",skip=1) %>%
  rename(id=Fish_ID,tl=`Total length (cm)`,loc=Lake,structure=Structure,
         R1=`Reader 1 Age Estimate (years)`,
         R2=`Reader 2 Age Estimate (years)`,
         R3=`Reader 3 Age Estimate (years)`) %>%
  select(id,loc,tl,structure,R1,R2,R3)
df

## Get the IDs and fish info
main <- df %>% select(id,loc,tl) %>%
  unique(.)
main

## Get just otoliths 
otos <- filter(df,structure=="Otolith") %>%
  select(-loc,-tl,-structure) %>%
  rename(otoliths_R1=R1,otoliths_R2=R2,otoliths_R3=R3)

## Get just cleithra
clei <- filter(df,structure=="Cleithrum") %>%
  select(-loc,-tl,-structure) %>%
  rename(cleithra_R1=R1,cleithra_R2=R2,cleithra_R3=R3)

## Put back together
df <- right_join(main,otos,by="id") %>%
  right_join(clei,by="id")

df

write.csv(df,file="data/raw_ageing/faust_precision_2013.csv",
          quote=FALSE,row.names=FALSE)
