#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
source("code/precisionData.R")

nm <- "de_santana_age_2017"       ## Name of study (actually name of file)
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"))
str(df) 


#### XXXXXX ####################################################################
species <- "Curimba"
atype <- "within"
strux <- "otoliths"
strux2 <- "lapillae"
proc <- "sectioned"
extra_suffix <- ""

df1 <- df %>%
  select(contains("otolith")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~otolith_R1+otolith_R2,data=df1)
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
species <- "Curimba"
atype <- "within"
strux <- "scales"
strux2 <- ""
proc <- "mounted"
extra_suffix <- ""

df1 <- df %>%
  select(contains("scales")) %>%
  filterD(complete.cases(.))

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
