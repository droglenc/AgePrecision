cat("\014"); rm(list=ls())
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"
nm <- paste0(pth,"LMB_Aug_2010.xls")

#Dewart
nm2 <- "Dewart"
df1 <- read_excel(nm,sheet=nm2,skip=1,na=c("","R")) %>%
  rename(id=Fish_ID,tl=TL,
         scales_Steve=Steve,scales_Angie=Angie,scales_Reid=Reid,
         finrays_Steve=Steve__1,finrays_Angie=Angie__1,finrays_Reid=Reid__1,
         spines_Steve=Steve__2,spines_Angie=Angie__2,spines_Reid=Reid__2) %>%
  mutate(tl=tl*10,loc=nm2) %>%
  select(id,tl,loc,contains("scales"),contains("finrays"),contains("spines")) %>%
  filter(!is.na(id))   ## needed to remove the last row that contained the total CV
str(df1)

#Fish
nm3 <- "Fish"
df2 <- read_excel(nm,sheet=nm3,skip=1,na=c("","R")) %>%
  rename(id=Fish_ID,tl=TL,
         scales_Steve=Steve,scales_Angie=Angie,scales_Reid=Reid,
         finrays_Steve=Steve__1,finrays_Angie=Angie__1,finrays_Reid=Reid__1,
         spines_Steve=Steve__2,spines_Angie=Angie__2,spines_Reid=Reid__2) %>%
  mutate(tl=tl*10,loc=nm3) %>%
  select(id,tl,loc,contains("scales"),contains("finrays"),contains("spines")) %>%
  filter(!is.na(id))   ## needed to remove the last row that contained the total CV
str(df2)

#Palestine
nm4 <- "Palestine"
df3 <- read_excel(nm,sheet=nm4,skip=1,na=c("","R","-")) %>%
  rename(id=Fish_ID,tl=TL,
         scales_Steve=Steve,scales_Angie=Angie,scales_Reid=Reid,
         finrays_Steve=Steve__1,finrays_Angie=Angie__1,finrays_Reid=Reid__1,
         spines_Steve=Steve__2,spines_Angie=Angie__2,spines_Reid=Reid__2) %>%
  mutate(tl=tl*10,loc=nm4) %>%
  select(id,tl,loc,contains("scales"),contains("finrays"),contains("spines")) %>%
  filter(!is.na(id))   ## needed to remove the last row that contained the total CV
str(df3)

#Pleasant
nm5 <- "Pleasant"
df4 <- read_excel(nm,sheet=nm5,skip=1,na=c("","R","-")) %>%
  rename(id=Fish_ID,tl=TL,
         scales_Steve=Steve,scales_Angie=Angie,scales_Reid=Reid,
         finrays_Steve=Steve__1,finrays_Angie=Angie__1,finrays_Reid=Reid__1,
         spines_Steve=Steve__2,spines_Angie=Angie__2,spines_Reid=Reid__2) %>%
  mutate(tl=tl*10,loc=nm5) %>%
  select(id,tl,loc,contains("scales"),contains("finrays"),contains("spines")) %>%
  filter(!is.na(id))   ## needed to remove the last row that contained the total CV
str(df4)

#Riddles
nm6 <- "Riddles"
df5 <- read_excel(nm,sheet=nm6,skip=1,na=c("","R","-")) %>%
  rename(id=Fish_ID,tl=TL,
         scales_Steve=Steve,scales_Angie=Angie,scales_Reid=Reid,
         finrays_Steve=Steve__1,finrays_Angie=Angie__1,finrays_Reid=Reid__1,
         spines_Steve=Steve__2,spines_Angie=Angie__2,spines_Reid=Reid__2) %>%
  mutate(tl=tl*10,loc=nm6) %>%
  select(id,tl,loc,contains("scales"),contains("finrays"),contains("spines")) %>%
  filter(!is.na(id))   ## needed to remove the last row that contained the total CV
str(df5)

#Webster
nm7 <- "Webster"
df6 <- read_excel(nm,sheet=nm7,skip=1,na=c("","R","-")) %>%
  rename(id=Fish_ID,tl=TL,
         scales_Steve=Steve,scales_Angie=Angie,scales_Reid=Reid,
         finrays_Steve=Steve__1,finrays_Angie=Angie__1,finrays_Reid=Reid__1,
         spines_Steve=Steve__2,spines_Angie=Angie__2,spines_Reid=Reid__2) %>%
  mutate(tl=tl*10,loc=nm7) %>%
  select(id,tl,loc,contains("scales"),contains("finrays"),contains("spines")) %>%
  filter(!is.na(id))   ## needed to remove the last row that contained the total CV
str(df6)

#Put it all together and write it out
df <- rbind(df1,df2,df3,df4,df5,df6)

write.csv(df,file="data/raw_ageing/morehouse_estimating_2013.csv",
          quote=FALSE,row.names=FALSE)
