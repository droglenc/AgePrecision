#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
source("code/ExtAn_Helper_PrecisionData.R")

nm <- "neves_modelling_2017"       ## Name of study (actually name of file)


#### BETWEEN ####################################################################
df <- read.csv(paste0("data/raw_ageing/",nm,"_B.csv"))
str(df) 
species <- "Black Seabream"
atype <- "between"
strux <- "otoliths"
strux2 <- "sagittae"
proc <- "whole"
extra_suffix <- "between"

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


#### WITHIN ####################################################################
df <- read.csv(paste0("data/raw_ageing/",nm,"_W.csv"))
str(df) 
species <- "Black Seabream"
atype <- "within"
strux <- "otoliths"
strux2 <- "sagittae"
proc <- "whole"
extra_suffix <- "within"

df1 <- df %>%
  select(contains("otoliths")) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~otoliths_R2+otoliths_R3,data=df1)
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
