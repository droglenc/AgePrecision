#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
source("code/precisionData.R")

nm <- "faust_precision_2013"       ## Name of study (actually name of file)
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"))
str(df) 

#### XXXXXX ####################################################################
species <- "Northern Pike"
atype <- "between"
strux <- "otoliths"
strux2 <- "saggitae"
proc <- "sectioned"
extra_suffix <- "CL"

df1 <- df %>%
  filterD(loc=="Cable Lake") %>%
  select(contains("Otolith")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~otoliths_R1+otoliths_R2+otoliths_R3,data=df1)
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
species <- "Northern Pike"
atype <- "between"
strux <- "cleithra"
strux2 <- ""
proc <- "whole"
extra_suffix <- "CL"

df1 <- df %>%
  filterD(loc=="Cable Lake") %>%
  select(contains("cleithra")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~cleithra_R1+cleithra_R2+cleithra_R3,data=df1)
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
species <- "Northern Pike"
atype <- "between"
strux <- "otoliths"
strux2 <- "saggitae"
proc <- "sectioned"
extra_suffix <- "DL"

df1 <- df %>%
  filterD(loc=="Devils Lake") %>%
  select(contains("otoliths")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~otoliths_R1+otoliths_R2+otoliths_R3,data=df1)
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
species <- "Northern Pike"
atype <- "between"
strux <- "cleithra"
strux2 <- ""
proc <- "whole"
extra_suffix <- "DL"

df1 <- df %>%
  filterD(loc=="Devils Lake") %>%
  select(contains("cleithra")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~cleithra_R1+cleithra_R2+cleithra_R3,data=df1)
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
