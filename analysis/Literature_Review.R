cat("\014")
setwd(here::here())

library(dplyr)
library(readxl)

fn <- googledrive::as_id("https://docs.google.com/spreadsheets/d/1RY6DQyi-zCfg_BQ2l_cZRZC_fA6PI3zutFIMIvJfbw8/edit?ts=5bac4a12#gid=0")
googledrive::drive_download(file=fn,path="data/Literature_Review",overwrite=TRUE)

## Make the overall database
##   Read fish names
fish <- read_excel("data/Literature_Review.xlsx",sheet="FishNames") %>%
  select(-sciname)
##   Read results and append on fish name info
tmp <- read_excel("data/Literature_Review.xlsx",sheet="Results_Meta")
res <- readxl::read_excel("data/Literature_Review.xlsx",sheet="Results",
                          na=c("-",""),col_types=tmp$RType) %>%
  select(-notes)
res <- left_join(res,fish,by="species")
##   Read study info and append on results
tmp <- read_excel("data/Literature_Review.xlsx",sheet="Study_Meta")
df <- read_excel("data/Literature_Review.xlsx",sheet="Study",
                    na=c("-",""),col_types=tmp$RType) %>%
  select(-notes,-OrigFile)
df <- left_join(df,res,by="studyID") %>%
  filter(USE=="yes") %>%
  select(-USE) %>%
  mutate(structure=factor(structure,levels=c("otoliths","spines","finrays",
                                             "scales","vertebrae","thorns",
                                             "other")),
         structure2=factor(structure2,levels=c("sagittae","lapillae","asterisci","statoliths",
                                               "anal","dorsal","pectoral","pelvic","caudal",
                                               "branchiostegal rays","gular plate","metapterygoid",
                                               "pectoral articulating process","scute",
                                               "sphenoid")))
##   Clean up
rm(tmp,fish,res,fn)


##   Creating new variables

