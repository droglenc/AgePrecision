#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
source("code/precisionData.R")

nm <- "fernando_ageing_2014"       ## Name of study (actually name of file)
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"))
str(df) 


#### Early Whole ###############################################################
species <- "Largemouth Bass"
atype <- "between"
strux <- "otoliths"
strux2 <- "saggitae"
proc <- "whole"
extra_suffix <- "04_05"

df1 <- df %>%
  filter(year<2008) %>%
  select(wholeoto_R1,wholeoto_R2) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~wholeoto_R1+wholeoto_R2,data=df1)
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


#### Late Whole ###############################################################
species <- "Largemouth Bass"
atype <- "between"
strux <- "otoliths"
strux2 <- "saggitae"
proc <- "whole"
extra_suffix <- "10"

df1 <- df %>%
  filter(year>2008) %>%
  select(wholeoto_R1,wholeoto_R2) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~wholeoto_R1+wholeoto_R2,data=df1)
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


#### Early Sectioned ###########################################################
species <- "Largemouth Bass"
atype <- "between"
strux <- "otoliths"
strux2 <- "saggitae"
proc <- "sectioned"
extra_suffix <- "04_05"

df1 <- df %>%
  filter(year<2008) %>%
  select(sectoto_R1,sectoto_R2) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~sectoto_R1+sectoto_R2,data=df1)
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


#### Late Sectioned ############################################################
species <- "Largemouth Bass"
atype <- "between"
strux <- "otoliths"
strux2 <- "saggitae"
proc <- "sectioned"
extra_suffix <- "10"

df1 <- df %>%
  filter(year>2008) %>%
  select(sectoto_R1,sectoto_R2) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~sectoto_R1+sectoto_R2,data=df1)
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
