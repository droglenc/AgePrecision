#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
source("code/ExtAn_Helper_PrecisionData.R")

nm <- "koch_precision_2009"       ## Name of study (actually name of file)
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"))
str(df) 


## !!! NOTE THAT KOCH LOOKED AT PAIRWISE READER PRECISION WHEREAS WE LOOK AT
##     PRECISION ACROSS ALL THREE READERS BELOW
## !!! NOTE THAT IT APPEARS THAT KOCH CALCULATED PRECISION FOR ONLY THOSE
##     STRUCTURES WHERE A CONSENSUS AGE WAS REACHED ... WE DID __NOT__ DO THAT

#### XXXXXX ####################################################################
species <- "Bowfin"
atype <- "between"
strux <- "finrays"
strux2 <- "pectoral"
proc <- "sectioned"
extra_suffix <- ""

df1 <- df %>%
  select(contains("finrays_R")) %>%
  filter(complete.cases(.))
  
ap1 <- agePrecision(~finrays_R1+finrays_R2+finrays_R3,data=df1)
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
species <- "Bowfin"
atype <- "between"
strux <- "gular plates"
strux2 <- ""
proc <- "whole"
extra_suffix <- ""

df1 <- df %>%
  select(contains("gular_R")) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~gular_R1+gular_R2+gular_R3,data=df1)
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
