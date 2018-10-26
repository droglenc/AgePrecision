#### SETUP #####################################################################
cat("\014")
setwd(here::here())
source("code/precisionData.R")

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

df1 <- rbind(df1,df2) %>%
  as.data.frame()
str(df1)

scales <- read_excel(paste0("data/raw_ageing/originals/",nm,".xlsx"),
                     sheet="Sheet2",range=cell_limits(c(2,1),c(NA,4)),
                     skip=1,na=c("","-","X")) %>%
  rename(id=`Fish`) %>%
  gather(reader,age,-id) %>%
  mutate(strux="scale")
spines <- read_excel(paste0("data/raw_ageing/originals/",nm,".xlsx"),
                     sheet="Sheet2",range=cell_limits(c(2,6),c(NA,9)),
                     skip=1,na=c("","-","X")) %>%
  rename(id=`Fish`) %>%
  mutate(R1=as.numeric(R1),R2=as.numeric(R2),R3=as.numeric(R3)) %>%
  gather(reader,age,-id) %>%
  mutate(strux="spine")
otos <- read_excel(paste0("data/raw_ageing/originals/",nm,".xlsx"),
                     sheet="Sheet2",range=cell_limits(c(2,11),c(NA,14)),
                     skip=1,na=c("","-","X")) %>%
  rename(id=`Fish`) %>%
  gather(reader,age,-id) %>%
  mutate(strux="otolith")
opercles <- read_excel(paste0("data/raw_ageing/originals/",nm,".xlsx"),
                     sheet="Sheet2",range=cell_limits(c(2,16),c(NA,19)),
                     skip=1,na=c("","-","X")) %>%
  rename(id=`Fish`) %>%
  tidyr::gather(reader,age,-id) %>%
  mutate(strux="opercle")
df2 <- rbind(scales,spines,otos,opercles) %>%
  mutate(read=paste(strux,reader,sep="_")) %>%
  select(-reader,-strux) %>%
  tidyr::spread(read,age) %>%
  as.data.frame()
str(df2)

df <- right_join(df1,df2,id=id)
df

write.csv(df,file="data/raw_ageing/sotola_precision_2014.csv",
          quote=FALSE,row.names=FALSE)
