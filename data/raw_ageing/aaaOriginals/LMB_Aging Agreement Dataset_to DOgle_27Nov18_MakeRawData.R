cat("\014")
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- read_excel(paste0(pth,"LMB_Aging Agreement Dataset_to DOgle_27Nov18.xls"),
                 sheet = "LMB aging data",na=c("",".")) %>%
  rename(year=Year,age_TRUE=`True Age`,
         wholeoto_R1=`WvReader 1`,wholeoto_R2=`WvReader 2`,
         sectoto_R1=`CrReader 1`,sectoto_R2=`CrReader 2`,
         wholeoto_CONSENSUS=WvFinal,sectoto_CONSENSUS=CrFinal) %>%
  mutate(id=paste(ID,Code,sep="_")) %>%
  select(id,year,age_TRUE,contains("wholeoto"),contains("sectoto"))

str(df)
df

write.csv(df,file="data/raw_ageing/fernando_ageing_2014.csv",
          quote=FALSE,row.names=FALSE)
