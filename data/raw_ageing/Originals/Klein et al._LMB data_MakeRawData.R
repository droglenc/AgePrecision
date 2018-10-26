#### SETUP #####################################################################
cat("\014")
setwd(here::here())
source("code/precisionData.R")

nm <- "Klein et al._LMB data"
library(readxl)

df1 <- read_excel(paste0("data/raw_ageing/originals/",nm,".xlsx"),
                  sheet="Raw data",range=cell_limits(c(2,1),c(NA,10)),
                  na=c("","N/A")) %>%
  rename(id=`Structure ID`,species=`Species`,tl=`TL (mm)`,wt=`WT (g)`,
         oto_Tim=`Tim Age Estimate`,oto_Bryant=`Bryant Age Estimate`,
         otoConf_Tim=`Tim Confidence`,otoConf_Bryant=`Bryant Confidence`,
         oto_C=`Consensus Age`,true_Age=`True (known) Age`) %>%
  select(species,id,tl,wt,true_Age,oto_Tim,oto_Bryant,oto_C,
         otoConf_Tim,otoConf_Bryant)

df2 <- read_excel(paste0("data/raw_ageing/originals/",nm,".xlsx"),
                  sheet="Raw data",range=cell_limits(c(2,11),c(NA,17)),
                  na=c("","..")) %>%
  rename(id=`Fish ID`,anal_MQ=`MQ Age`,analConf_MQ=`MQ Con.`,
         anal_ZK=`ZK Age`,analConf_ZK=`ZK Con.`,anal_C=`Consensus`) %>%
  select(id,anal_MQ,anal_ZK,anal_C,analConf_MQ,analConf_ZK) %>%
  mutate(id=as.numeric(id))

df <- right_join(df1,df2,id=id)

df3 <- read_excel(paste0("data/raw_ageing/originals/",nm,".xlsx"),
                  sheet="Raw data",range=cell_limits(c(2,20),c(NA,26)),
                  na=c("","..")) %>%
  rename(id=`Fish ID`,dorsal_MQ=`MQ Age`,dorsalConf_MQ=`MQ Con.`,
         dorsal_ZK=`ZK Age`,dorsalConf_ZK=`ZK Con.`,dorsal_C=`Consensus`) %>%
  select(id,dorsal_MQ,dorsal_ZK,dorsal_C,dorsalConf_MQ,dorsalConf_ZK) %>%
  mutate(id=as.numeric(id))

df <- right_join(df,df3,id=id) %>%
  select(species:true_Age,oto_Tim,oto_Bryant,anal_MQ,anal_ZK,dorsal_MQ,dorsal_ZK,
         contains("_C"),contains("Conf"))

write.csv(df,file="data/raw_ageing/klein_precision_2017.csv",
          quote=FALSE,row.names=FALSE)

