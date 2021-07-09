#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
source("code/ExtAn_Helper_PrecisionData.R")

nm <- "sotola_precision_2014"       ## Name of study (actually name of file)
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"))
str(df) 

#### LARGEMOUTHS ###############################################################
species <- "LMB"
atype <- "between"
strux <- "opercles"
strux2 <- ""
proc <- "whole"
extra_suffix <- ""

df1 <- df %>%
  filter(species=="LMB") %>%
  select(contains("opercle")) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~opercle_R1+opercle_R2+opercle_R3,data=df1)
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

species <- "LMB"
atype <- "between"
strux <- "otoliths"
strux2 <- "sagittae"
proc <- "cut-and-burnt"
extra_suffix <- ""

df1 <- df %>%
  filter(species=="LMB") %>%
  select(contains("otolith")) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~otolith_R1+otolith_R2+otolith_R3,data=df1)
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

species <- "LMB"
atype <- "between"
strux <- "spines"
strux2 <- "dorsal"
proc <- "sectioned"
extra_suffix <- ""

df1 <- df %>%
  filter(species=="LMB") %>%
  select(contains("spine")) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~spine_R1+spine_R2+spine_R3,data=df1)
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

species <- "LMB"
atype <- "between"
strux <- "scales"
strux2 <- ""
proc <- "mounted"
extra_suffix <- ""

df1 <- df %>%
  filter(species=="LMB") %>%
  select(contains("scale")) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~scale_R1+scale_R2+scale_R3,data=df1)
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
