#### SETUP #####################################################################
cat("\014")
setwd(here::here())
source("code/precisionData.R")

df1 <- read.table("data/raw_ageing/Originals/SP97AGES.TXT",
                  header=TRUE,na=c("",".")) %>%
  rename(id=DateSpID,species=Species,tl=Length,
         scale_r1=Sage1,scale_r2=Sage2,scale_r3=Sage3,
         wholeoto_r1=Woto1,wholeoto_r2=Woto2,wholeoto_r3=Woto3,
         sectoto_r1=Soto1,sectoto_r2=Soto2,sectoto_r3=Soto3) %>%
  select(id,species,tl,contains("scale"),contains("wholeoto"),contains("sectoto"))
df2 <- read.table("data/raw_ageing/Originals/SP99AGES.TXT",
                  header=TRUE,na=c("",".")) %>%
  rename(id=DateSpID,species=Species,tl=Length,
         scale_r1=Scale1,scale_r2=Scale2,scale_r3=Scale3,
         wholeoto_r1=Woto1,wholeoto_r2=Woto2,wholeoto_r3=Woto3,
         sectoto_r1=Soto1,sectoto_r2=Soto2,sectoto_r3=Soto3) %>%
  select(id,species,tl,contains("scale"),contains("wholeoto"),contains("sectoto"))
df <- rbind(df1,df2)
str(df)

write.csv(df,file="data/raw_ageing/long_precision_2001.csv",
          quote=FALSE,row.names=FALSE)

