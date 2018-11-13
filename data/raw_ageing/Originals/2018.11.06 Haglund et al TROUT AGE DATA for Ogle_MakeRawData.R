cat("\014")
setwd(here::here())
source("code/precisionData.R")
library(readxl)

nm <- "2018.11.06 Haglund et al TROUT AGE DATA for Ogle"

df <- read_excel(paste0("data/raw_ageing/originals/",nm,".xlsx"),
                 na=c("")) %>% 
  rename(stream=Stream,species=Species,date=Date,id="File #",
         tl="Length (mm)",wt="Weight (g)",sex=Sex,mat=Maturity,
         r1="Reader #1",r2="Reader #2",r3="Reader #3") %>%
  select(id,stream,species,date,tl,wt,sex,mat,r1,r2,r3) %>%
  filter(!is.na(stream))
                   

str(df)
write.csv(df,file="data/raw_ageing/haglund_age_2017.csv",
          quote=FALSE,row.names=FALSE)
