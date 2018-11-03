#### SETUP #####################################################################
cat("\014")
setwd(here::here())
source("code/precisionData.R")
library(readxl)

df <- read_excel("data/raw_ageing/originals/Master_SHB_age_database_11_28_16.xlsx",
                 sheet="All_ages_master") %>%
  rename(loc=System,year=Year,id=Age_ID_Link,
         scale_AT_1=AT_1_count,scale_AT_2=AT_2_count,
         scale_CH_1=CH_1_count,scale_CH_2=CH_2_count,
         scale_consensus=Consensus_count,
         edgeIsAnnulus=`Last annuli on edge?`) %>%
  select(id,loc,year,contains("scale"),edgeIsAnnulus) %>%
  mutate(loc=mapvalues(loc,from=c("CHE","CHA","BIG"),
                       to=c("Chestatee R","Chattahoochee R","Big Creek")))

str(df)

write.csv(df,file="data/raw_ageing/long_evaluation_2018.csv",
          quote=FALSE,row.names=FALSE)
