cat("\014")
setwd(here::here())
library(readxl)
library(dplyr)
pth <- "data/raw_ageing/aaaOriginals/"

df <- read_excel(paste0(pth,"catfish TLage.xls"),
                 skip=2,na=c("",".","omit")) %>%
  rename(id=`Tag #`,date=`date collected`,tl=`TL @collection`,age_KNOWN=`known age`,
         artic_John=`spine sec`,artic_Bob=`spine sec__1`,artic_CONSENUS=`spine sec__2`,
         spine_John=`Spine`,spine_Bob=`Spine__1`,spine_CONSENUS=`Spine__2`,
         otolith_John=`otolith`,otolith_Bob=`otolith__1`,otolith_CONSENUS=`otolith__2`) %>%
  select(id,date,tl,age_KNOWN,contains("John"),contains("Bob"),contains("CONSENSUS"))
## Put NAs for otoliths for fish #104 (data file says to omit)
df$otolith_Bob[df$id==104] <- df$otolith_John[df$id==104] <- NA

df

write.csv(df,file="data/raw_ageing/buckmeier_validity_2002.csv",
          quote=FALSE,row.names=FALSE)
