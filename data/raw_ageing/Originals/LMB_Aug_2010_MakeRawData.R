cat("\014")
setwd(here::here())
source("code/precisionData.R")

nm <- "data/raw_ageing/originals/LMB_Aug_2010.xls"

#Dewart
nm2 <- "Dewart"
df1 <- read_excel(nm,sheet=nm2,skip=1,na=c("","R")) %>%
  rename(id=Fish_ID,tl=TL,
         scales_Steve=Steve,scales_Angie=Angie,scales_Reid=Reid,
         rays_Steve=Steve__1,rays_Angie=Angie__1,rays_Reid=Reid__1,
         spines_Steve=Steve__2,spines_Angie=Angie__2,spines_Reid=Reid__2) %>%
  mutate(tl=tl*10,loc=nm2) %>%
  select(id,tl,contains("scales"),contains("rays"),contains("spines")) %>%
  filter(!is.na(id))   ## needed to remove the last row that contained the total CV
str(df1)

#Fish



#Put it all together and write it out
df <- rbind(df1,df2,df3,df4,df5,df6)

write.csv(df,file="data/raw_ageing/morehouse_estimating_2013.csv",
          quote=FALSE,row.names=FALSE)
