#### SETUP #####################################################################
cat("\014")
setwd(here::here())
source("code/precisionData.R")

nm <- "WAE precision data for Dr. Ogle"
library(readxl)
df1 <- read_excel(paste0("data/raw_ageing/originals/",nm,".xlsx"),
                  sheet="Female",skip=1) %>%
  select(-`Length (in)`) %>%
  rename(date=Date,id=`Tag Number/ID`,sex=Sex,mat=Maturity,
         tl=`Length (mm)`,oto_Ryan=`Ryan's Otolith Age`,oto_Eli=`Eli's Otolith Age`,
         spine_Jack=`Jack's Spine Age`,spine_Ryan=`Ryan's Spine Age`) %>%
  mutate(sex="female")
df2 <- read_excel(paste0("data/raw_ageing/originals/",nm,".xlsx"),
                  sheet="Male",skip=1) %>%
  select(-`Length (in)`) %>%
  rename(date=Date,id=`Tag Number/ID`,sex=Sex,mat=Maturity,
         tl=`Length (mm)`,oto_Ryan=`Ryan's Otolith Age`,oto_Eli=`Eli's Otolith Age`,
         spine_Jack=`Jack's Spine Age`,spine_Ryan=`Ryan's Spine Age`) %>%
  mutate(sex="male") %>%
  select(colnames(df1))

df <- rbind(df1,df2) %>%
  as.data.frame()
str(df)

write.csv(df,file="data/raw_ageing/koenigs_validation_2015.csv",
          quote=FALSE,row.names=FALSE)
