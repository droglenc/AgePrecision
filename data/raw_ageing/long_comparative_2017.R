#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
source("code/precisionData.R")

nm <- "long_comparative_2017"       ## Name of study (actually name of file)
df <- read.csv(paste0("data/raw_ageing/",nm,".csv")) %>%
  filterD(sex!="U")  ## as in the paper
str(df) 

#### GRAND ####################################################################
species <- "Paddlefish"
atype <- "between"
strux <- "other"
strux2 <- "maxillae"
proc <- "sectioned"
extra_suffix <- "Grand"

df1 <- df %>%
  filterD(loc=="Grand") %>%
  select(contains("maxillae")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~maxillae_EB+maxillae_BJ+maxillae_AN,data=df1)
pt1SD <- precisionData(ap1,studyID=nm,species=species,
                       structure=strux,structure2=strux2,process=proc,
                       type=atype,var="SD")
plot(pt1SD)
summary(pt1SD,what="tests")

pt1CV <- precisionData(ap1,studyID=nm,species=species,
                       structure=strux,structure2=strux2,process=proc,
                       type=atype,var="CV")
plot(pt1CV)
summary(pt1CV,what="tests")

res <- list(sum=pt1SD$sum,tests=rbind(pt1SD$tests,pt1CV$tests))
saveRDS(res,paste0("data/results_precision/",nm,"_",species,"_",strux,
                   ifelse(strux2=="","","_"),strux2,
                   ifelse(proc=="","","_"),proc,
                   ifelse(extra_suffix=="","","_"),extra_suffix,".rds"))


#### KEYSTONE ##################################################################
species <- "Paddlefish"
atype <- "between"
strux <- "other"
strux2 <- "maxillae"
proc <- "sectioned"
extra_suffix <- "Keystone"

df1 <- df %>%
  filterD(loc=="Keystone") %>%
  select(contains("maxillae")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~maxillae_EB+maxillae_BJ+maxillae_AN,data=df1)
pt1SD <- precisionData(ap1,studyID=nm,species=species,
                       structure=strux,structure2=strux2,process=proc,
                       type=atype,var="SD")
plot(pt1SD)
summary(pt1SD,what="tests")

pt1CV <- precisionData(ap1,studyID=nm,species=species,
                       structure=strux,structure2=strux2,process=proc,
                       type=atype,var="CV")
plot(pt1CV)
summary(pt1CV,what="tests")

res <- list(sum=pt1SD$sum,tests=rbind(pt1SD$tests,pt1CV$tests))
saveRDS(res,paste0("data/results_precision/",nm,"_",species,"_",strux,
                   ifelse(strux2=="","","_"),strux2,
                   ifelse(proc=="","","_"),proc,
                   ifelse(extra_suffix=="","","_"),extra_suffix,".rds"))

