#### SETUP #####################################################################
cat("\014")
setwd(here::here())
source("code/ExtAn_Helper_PrecisionData.R")

nm <- "Sotola et al. Raw Data"
library(readxl)

df1 <- read_excel(paste0("data/raw_ageing/originals/",nm,".xlsx"),
                  sheet="Sheet1",range=cell_cols("A:E"),
                  na=c("","Tumor Fish")) %>%
  filter(Number!=40) %>%  # remove this fish per message from Sotola
  select(-Number) %>%
  rename(id=`Fish ID Number`,species=`Species`,
         tl=`Length (mm)`,wt=`Weight (kg)`)
df2 <- read_excel(paste0("data/raw_ageing/originals/",nm,".xlsx"),
                  sheet="Sheet1",range=cell_cols("G:K")) %>%
  filter(Number!=35) %>%  # remove this fish per message from Sotola
  select(-Number) %>%
  rename(id=`Fish ID Number`,species=`Species`,
         tl=`Length (mm)`,wt=`Weight (kg)`)
df1 <- rbind(df1,df2)
str(df1)

df2 <- read_excel(paste0("data/raw_ageing/originals/",nm,".xlsx"),
                  sheet="Sheet2",skip=1,na=c("","-","X")) %>%
  rename(id=Fish,
         scale_R1=R1,scale_R2=R2,scale_R3=R3,
         spine_R1=R1__1,spine_R2=R2__1,spine_R3=R3__1,
         otolith_R1=R1__2,otolith_R2=R2__2,otolith_R3=R3__2,
         opercle_R1=R1__3,opercle_R2=R2__3,opercle_R3=R3__3) %>%
  mutate(spine_R1=as.numeric(spine_R1),spine_R2=as.numeric(spine_R2)) %>%
  select(id,contains("scale"),contains("spine"),contains("otolith"),contains("opercle"))
str(df2)

df <- right_join(df1,df2,id=id)
df

write.csv(df,file="data/raw_ageing/sotola_precision_2014.csv",
          quote=FALSE,row.names=FALSE)
