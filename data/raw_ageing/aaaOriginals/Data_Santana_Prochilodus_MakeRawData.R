cat("\014")
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- read_excel(paste0(pth,"Data_Santana_Prochilodus.xlsx"),na=c("","NA")) %>%
  rename(id=Fish_ID,tl=Total_Length,sl=Standard_Length,
         otolith_R1=`Age(otoliths)_Reading1`,otolith_R2=`Age(otoliths)_Reading2`,
         scales_R1=`Age(scales)_Reading1`,scales_R2=`Age(scales)_Reading2`) %>%
  mutate(tl=ifelse(tl==0,NA,tl),sl=ifelse(sl==0,NA,sl))
df

write.csv(df,file="data/raw_ageing/de_santana_age_2017.csv",
          quote=FALSE,row.names=FALSE)
