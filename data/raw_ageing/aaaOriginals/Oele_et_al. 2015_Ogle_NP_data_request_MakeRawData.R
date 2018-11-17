cat("\014"); rm(list=ls())
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- read_excel(paste0(pth,"Oele_et_al. 2015_Ogle_NP_data_request.xlsx")) %>%
  rename(id=sample.id,year=sample.year,date=`Sample Date`,reader=Reader,
         tl=length.mm,wt=weight.kg,
         scales=scale.ages,anal=anal.fin.ages,
         otoliths=otolith.ages,cleithra=cleithra.ages) %>%
  mutate(reader=mapvalues(reader,from=c("Reader 1","Reader 2","Reader 3"),
                          to=c("R1","R2","R3"))) %>%
  select(id,year,river,tl,wt,sex,reader,scales,anal,otoliths,cleithra) %>%
  filter(id!="0") ## these fish had no ages for any structures
str(df)

dfid <- df %>% select(id:sex) %>% unique()
df1 <- df %>% filter(reader=="R1") %>% select(id,scales:cleithra)
names(df1)[2:5] <- paste0(names(df1)[2:5],"_R1")
df2 <- df %>% filter(reader=="R2") %>% select(id,scales:cleithra)
names(df2)[2:5] <- paste0(names(df2)[2:5],"_R2")
df3 <- df %>% filter(reader=="R3") %>% select(id,scales:cleithra)
names(df3)[2:5] <- paste0(names(df3)[2:5],"_R3")

df <- right_join(dfid,df1,by="id") %>%
  right_join(df2,by="id") %>%
  right_join(df3,by="id") %>%
  select(id:sex,contains("scales"),contains("anal"),
         contains("otolith"),contains("cleithra"))
df

write.csv(df,file="data/raw_ageing/oele_precision_2015.csv",
          quote=FALSE,row.names=FALSE)
