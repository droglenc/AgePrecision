cat("\014")
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

## Third age was only used for discrepancies ... not needed for our work
## Did not need any of the back-calculation data
## Removed n=4 individuals with "FES Tank" in the source field (per author's note)
df <- read_excel(paste0(pth,"Fish Data.xlsx"),na=c("","Can't Age")) %>% 
  rename(id=`Fish #`,source=Source,tl=`TL (mm)`,wt=`Wt (g)`,sex=Sex,
         scales_R1=`Age 1 (yrs)`,scales_R2=`Age 2 (yrs)`,
         scales_CONSENSUS=`Concensus Age (yrs)`) %>%
  select(id:sex,contains("scales")) %>%
  mutate(scales_R1=as.numeric(substr(scales_R1,1,1)),
         scales_R2=as.numeric(substr(scales_R2,1,1)),
         scales_CONSENSUS=as.numeric(substr(scales_CONSENSUS,1,1))) %>%
  filter(!grepl("FES",df$Source))
df
write.csv(df,file="data/raw_ageing/oplinger_hard_2015.csv",
          quote=FALSE,row.names=FALSE)

