cat("\014")
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- read_excel(paste0(pth,"2012 NOP ages for Ogle.xlsx"),
                 sheet = "NOP ages",skip=3,na=c("",".")) %>% 
  rename(id=ID,tl=TL,wt=Wt,
         cleithra_section_R1=`R1 SC age`,
         cleithra_section_R2=`R2 SC age`,
         cleithra_section_R3=`R3 SC age`,
         cleithra_whole_R1=`R1 WC age`,
         cleithra_whole_R2=`R2 WC age`,
         cleithra_whole_R3=`R3 WC age`,
         otoliths_R1=`R1 O age`,
         otoliths_R2=`R2 O age`,
         otoliths_R3=`R3 O age`,
         metapt_R1=`R1 M age`,
         metapt_R2=`R2 M age`,
         metapt_R3=`R3 M age`,
         scales_R1=`R1 Scale age`,
         scales_R2=`R2 Scale age`,
         scales_R3=`R3 Scale age`) %>%
  select(-contains("R3")) %>% ## R3 was only used for discrepancies with R1 and R2
  select(id,tl,wt,contains("cleithra"),contains("otoliths"),
         contains("metapt"),contains("scales"))
df
write.csv(df,file="data/raw_ageing/blackwell_assessment_2016.csv",
          quote=FALSE,row.names=FALSE)

