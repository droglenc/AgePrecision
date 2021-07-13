cat("\014")
setwd(here::here())
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- readxl::read_excel(paste0(pth,"PWF 2013.xlsx"),sheet="PWF 2013") %>%
  select(fishID,tl,ageS1,ageS2,useS,ageO1,ageO2,useO)

dfS <- df %>%
  filter(useS=="YES") %>%
  select(id=fishID,tl,reader1=ageS1,reader2=ageS2) %>%
  mutate(structure="scales")

dfO <- df %>%
  filter(useO=="YES") %>%
  select(id=fishID,tl,reader1=ageO1,reader2=ageO2) %>%
  mutate(structure="otoliths")

df <- rbind(dfS,dfO)
df

write.csv(df,file="data/raw_ageing/stewart_age_2016.csv",
          quote=FALSE,row.names=FALSE)
