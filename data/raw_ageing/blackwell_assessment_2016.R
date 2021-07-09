#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
source("code/ExtAn_Helper_PrecisionData.R")

nm <- "blackwell_assessment_2016"
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"))
str(df) 


#### XXXXXX ####################################################################
species <- "Northern Pike"
atype <- "between"
strux <- "cleithra"
strux2 <- ""
proc <- "sectioned"
extra_suffix <- ""

df1 <- df %>%
  select(contains("cleithra_section")) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~cleithra_section_R1+cleithra_section_R2,data=df1)
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
extra_suffix <- ""

df1 <- df %>%
  select(contains("cleithra_whole")) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~cleithra_whole_R1+cleithra_whole_R2,data=df1)
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
strux2 <- "sagittae"
proc <- "sectioned"
extra_suffix <- ""

df1 <- df %>%
  select(contains("otoliths")) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~otoliths_R1+otoliths_R2,data=df1)
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
strux <- "scales"
strux2 <- ""
proc <- "pressed"
extra_suffix <- ""

df1 <- df %>%
  select(contains("scales")) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~scales_R1+scales_R2,data=df1)
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
strux <- "bones"
strux2 <- "metapterygoid"
proc <- "whole"
extra_suffix <- ""

df1 <- df %>%
  select(contains("metap")) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~metapt_R1+metapt_R2,data=df1)
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
