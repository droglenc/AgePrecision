#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
source("code/ExtAn_Helper_PrecisionData.R")

nm <- "grant_life_2018"       ## Name of study (actually name of file)
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
species <- "Silky Shark"
atype <- "within"
strux <- "vertebrae"
strux2 <- ""
proc <- "sectioned"
extra_suffix <- ""

df1 <- df %>%
  select(contains("reader1")) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~reader1A+reader1B,data=df1)
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
## Enter species name
##       analysis type ("between" or "within")
##       calcified structure (e.g., scales, otoliths, finrays, spines)
##       More about scturcture (e.g., dorsal, pectoral)
##       Process info (e.g., sectioned, crackburn, whole)
##       Possible extra suffix for name ... sometimes needed if above is not
##         adequate to make a unique filename (i.e., with "within" data)
species <- "Silky Shark"
atype <- "between"
strux <- "vertebrae"
strux2 <- ""
proc <- "sectioned"
extra_suffix <- ""

df1 <- df %>%
  select(reader1B,reader2) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~reader1B+reader2,data=df1)
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
