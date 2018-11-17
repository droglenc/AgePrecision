#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
source("code/precisionData.R")

nm <- "klein_precision_2017"       ## Name of study (actually name of file)

## Reduced to only fish with a true age to match Klein
df <- read.csv(paste0("data/raw_ageing/",nm,".csv")) %>%
  filterD(!is.na(true_Age)) 
str(df) 

#### XXXXXX ####################################################################
## ULTIMATELY DID NOT USE THE OTOLITH DATA BECAUSE THERE WAS NO VARIAIBILITY
## BETWEEN THE TWO READERS ... THUS NOT USEFUL FOR TESTING THE RELATIONSHIP
## BETWEEN PRECISION METRICS AND AGE.
species <- "Largemouth Bass"
atype <- "between"
strux <- "otoliths"
strux2 <- "sagittae"
proc <- "sectioned"
extra_suffix <- ""

df1 <- df %>%
  select(contains("otoliths")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~otoliths_Tim+otoliths_Bryant,data=df1)
pt1SD <- precisionData(ap1,studyID=nm,species=species,
                       structure=strux,structure2=strux2,process=proc,
                       type=atype,var="SD")
#plot(pt1SD)
#summary(pt1SD,what="tests")

pt1CV <- precisionData(ap1,studyID=nm,species=species,
                       structure=strux,structure2=strux2,process=proc,
                       type=atype,var="CV")
#plot(pt1CV)
#summary(pt1CV,what="tests")

#res <- list(sum=pt1SD$sum,tests=rbind(pt1SD$tests,pt1CV$tests))
#saveRDS(res,paste0("data/results_precision/",nm,"_",species,"_",strux,
#                   ifelse(strux2=="","","_"),strux2,
#                   ifelse(proc=="","","_"),proc,
#                   ifelse(extra_suffix=="","","_"),extra_suffix,".rds"))


#### XXXXXX ####################################################################
species <- "Largemouth Bass"
atype <- "between"
strux <- "spines"
strux2 <- "anal"
proc <- "sectioned"
extra_suffix <- ""

df1 <- df %>%
  select(contains("anal")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~anal_MQ+anal_ZK,data=df1)
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


#### XXXXXX ####################################################################
species <- "Largemouth Bass"
atype <- "between"
strux <- "spines"
strux2 <- "dorsal"
proc <- "sectioned"
extra_suffix <- ""

df1 <- df %>%
  select(contains("dorsal")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~dorsal_MQ+dorsal_ZK,data=df1)
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