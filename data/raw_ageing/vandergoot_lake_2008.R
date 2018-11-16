#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
source("code/precisionData.R")

nm <- "vandergoot_lake_2008"       ## Name of study (actually name of file)
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"))
str(df) 


## !!! Copy the code below if more than one structure of comparisons
#### XXXXXX ####################################################################
## Enter species name
##       analysis type ("between" or "within")
##       calcified structure (e.g., scales, otoliths, finrays, spines)
##       More about scturcture (e.g., dorsal, pectoral)
##       Process info (e.g., sectioned, crackburn, whole)
##       Possible extra suffix for name ... sometimes needed if above is not
##         adequate to make a unique filename (i.e., with "within" data)
species <- "Yellow Perch"
atype <- "between"
strux <- "scales"
strux2 <- ""
proc <- ""
extra_suffix <- ""

df1 <- df %>%
  select(contains("scale")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~scale_NR+scale_IR+scale_ER,data=df1)
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
species <- "Yellow Perch"
atype <- "between"
strux <- "spines"
strux2 <- "anal"
proc <- "sectioned"
extra_suffix <- ""

df1 <- df %>%
  select(contains("aspine")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~aspine_NR+aspine_IR+aspine_ER,data=df1)
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
species <- "Yellow Perch"
atype <- "between"
strux <- "otoliths"
strux2 <- "sagittae"
proc <- "cracke"
extra_suffix <- ""

df1 <- df %>%
  select(contains("otolith")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~otolith_NR+otolith_IR+otolith_ER,data=df1)
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
