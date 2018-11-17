cat("\014")
setwd(here::here())
library(readxl)
library(dplyr)
library(tidyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- read_excel(paste0(pth,"AgeComp_LKWF_2012.xlsx"),
                 col_types=c("skip","text","text","text","numeric","skip")) %>%
  rename(id=ID,structure=Material,reader=Reader,age=Age) %>%
  mutate(structure=mapvalues(structure,from=c("Otolith","Fin","Scale"),
                             to=c("otoliths","finrays","scales")),
         read=paste0(structure,"_R",reader)) %>%
  select(id,read,age) %>%
  spread(key="read",value="age")
df

write.csv(df,file="data/raw_ageing/zhu_comparison_2015.csv",
          quote=FALSE,row.names=FALSE)
