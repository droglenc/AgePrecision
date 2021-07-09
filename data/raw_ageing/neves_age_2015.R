#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
source("code/ExtAn_Helper_PrecisionData.R")

nm <- "neves_age_2015"       ## Name of study (actually name of file)
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"))
str(df) 


#### BETWEEN ####################################################################
species <- "Small Red Scorpionfish"
atype <- "between"
strux <- "otoliths"
strux2 <- "sagittae"
proc <- "whole"
extra_suffix <- "between"

df1 <- df %>%
  select(otoliths_R1,otoliths_R2,otoliths_R3_2) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~otoliths_R1+otoliths_R2+otoliths_R3_2,data=df1)
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



#### BETWEEN ####################################################################
species <- "Small Red Scorpionfish"
atype <- "within"
strux <- "otoliths"
strux2 <- "sagittae"
proc <- "whole"
extra_suffix <- "within"

df1 <- df %>%
  select(otoliths_R3_1,otoliths_R3_2) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~otoliths_R3_1+otoliths_R3_2,data=df1)
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



#### TESTING ####################################################################
## Within results are not close to matching what is in the paper ... this tries
##   using all ages to see if they match the paper ... they do not!!!
df1 <- df %>%
  select(contains("otoliths")) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~otoliths_R3_1+otoliths_R3_2+otoliths_R1+otoliths_R2,data=df1)
pt1SD <- precisionData(ap1,studyID=nm,species=species,
                       structure=strux,structure2=strux2,process=proc,
                       type=atype,var="SD")
