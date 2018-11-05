cat("\014")
setwd(here::here())
source("code/precisionData.R")
library(readxl)
 
df <- read_excel("data/raw_ageing/originals/Dembkowskietal_10.3996052017-jfwm-038.s1.xlsx",
                 sheet = "Data S1 - Supplemental data") %>% 
  rename(id=fishid,loc=watername,tl=tlmm,otolith_r1=r1SO,spine_r1=r1SS,
         otolith_r2=r2SO,spine_r2=r2SS) %>%
  select(id,loc,tl,sex,growth,contains("otolith"),contains("spine"))
str(df)
write.csv(df,file="data/raw_ageing/dembkowski_walleye_2017.csv",
          quote=FALSE,row.names=FALSE)

