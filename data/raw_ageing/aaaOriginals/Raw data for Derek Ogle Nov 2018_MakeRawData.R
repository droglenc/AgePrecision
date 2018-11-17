cat("\014"); rm(list=ls())
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- read_excel(paste0(pth,"Raw data for Derek Ogle Nov 2018.xlsx")) %>%
  rename(species=Species,stock=Stock,id=`ID #`,year=`Sampling year`,
         whoto_RW_1=`RW Otolith age 1 (whole)`,
         whoto_RW_2=`RW Otolith age 2 (whole)`,
         whoto_RW_3=`RW Otolith age 3 (whole)`,
         whoto_NSC_1=`NSC Otolith age 1 (whole)`,
         whoto_NSC_2=`NSC Otolith age 2 (whole)`,
         whoto_NSC_3=`NSC Otolith age 3 (whole)`,
         sectoto_RW_1=`RW Otolith age 1 (Section)`,
         sectoto_RW_2=`RW Otolith age 2 (Section)`,
         sectoto_RW_3=`RW Otolith age 3 (Section)`,
         sectoto_NSC_1=`NSC Otolith age 1 (sectioned)`,
         sectoto_NSC_2=`NSC Otolith age 2 (sectioned)`,
         sectoto_NSC_3=`NSC Otolith age 3 (sectioned)`,
         pelvic_RW_1=`RW Pelvic fin age 1`,
         pelvic_RW_2=`RW Pelvic fin age 2`,
         pelvic_RW_3=`RW Pelvic fin age 3`,
         pelvic_NSC_1=`NSC pelvic fin age 1`,
         pelvic_NSC_2=`NSC pelvic fin age 2`,
         pelvic_NSC_3=`NSC pelvic fin age 3`,
         pectoral_RW_1=`RW Pectoral fin age 1`,
         pectoral_RW_2=`RW Pectoral fin age 2`,
         pectoral_RW_3=`RW Pectoral fin age 3`,
         pectoral_NSC_1=`NSC pectoral fin age 1`,
         pectoral_NSC_2=`NSC pectoral fin age 2`,
         pectoral_NSC_3=`NSC pectoral fin age 3`) %>%
  select(id,species,stock,year,contains("whoto"),
         contains("sectoto"),contains("pelvic"),contains("pectoral"))
df

write.csv(df,file="data/raw_ageing/gallagher_comparison_2016.csv",
          quote=FALSE,row.names=FALSE)
