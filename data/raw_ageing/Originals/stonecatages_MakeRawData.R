#### SETUP #####################################################################
cat("\014")
setwd(here::here())
source("code/precisionData.R")

df <- read.csv("data/raw_ageing/originals/stonecatages.csv",stringsAsFactors=FALSE) %>%
  rename(id=ID,tl=length,sex=Sex,
         spine_Betsy_1=Betsy_2,spine_Betsy_2=Betsy_3,
         spine_Alex_1=Alex_2,spine_Alex_2=Alex_3,
         spine_Lee_1=Lee_2,spine_Lee_2=Lee_3,
         spine_Consensus=FinalAge) %>%
  mutate(sex=mapvalues(sex,from=c("F","M","U","Uk","UK"),
                       to=c("female","male","unknown","unknown","unknown"))) %>%
  select(-Betsy_1,-Alex_1,-Lee_1) %>% # these were burn-in estimates ... don't use
  select(id,tl,sex,spine_Betsy_1:spine_Consensus)
str(df)

write.csv(df,file="data/raw_ageing/puchala_size_2018.csv",
          quote=FALSE,row.names=FALSE)
