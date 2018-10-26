#### SETUP #####################################################################
cat("\014")
setwd(here::here())
source("code/precisionData.R")

nm <- "Jeff Koch_Ogle data request"
library(readxl)

## Bowfin
df <- read_excel(paste0("data/raw_ageing/originals/",nm,".xlsx"),
                 sheet="Bowfin",na=c("",".")) %>%
  rename(finray_R1=`R1 fin ray`,finray_R2=`R2 fin ray`,finray_R3=`R3 fin ray`,
         finray_C=`consensusfr`,gular_R1=`R1 gular`,gular_R2=`R2 gular`,
         gular_R3=`R3 gular`,gular_C=`consensusgu`,
         tl=`Length`,wt=`Weight`,sex=`Sex`,mat=`Maturity`) %>%
  select(tl,wt,sex,mat,finray_R1,finray_R2,finray_R3,
         gular_R1,gular_R2,gular_R3,
         finray_C,gular_C) %>%
  as.data.frame()

str(df)
head(df,15)

write.csv(df,file="data/raw_ageing/koch_precision_2009.csv",
          quote=FALSE,row.names=FALSE)


## Pallid Sturgeon
df <- read_excel(paste0("data/raw_ageing/originals/",nm,".xlsx"),
                 sheet="Pallid sturgeon") %>%
  rename(age_JK=`jk age`,age_MP=`mp age`,age_KS=`ks age`,
         age_C=`consensus`,age_T=`true age`,
         tl=`length`) %>%
  select(tl,age_JK,age_MP,age_KS,age_C,age_T) %>%
  as.data.frame()

str(df)
head(df,15)

write.csv(df,file="data/raw_ageing/koch_validation_2011.csv",
          quote=FALSE,row.names=FALSE)
