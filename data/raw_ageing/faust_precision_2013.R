#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
source("code/precisionData.R")

nm <- "faust_precision_2013"       ## Name of study (actually name of file)
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"))
str(df) 
xtabs(~loc+structure,data=df)


## !!! Copy the code below if more than one structure of comparisons
#### XXXXXX ####################################################################
## Enter species name
##       analysis type ("between" or "within")
##       calcified structure (e.g., scales, otoliths, finrays, spines)
##       More about scturcture (e.g., dorsal, pectoral)
##       Process info (e.g., sectioned, crackburn, whole)
##       Possible extra suffix for name ... sometimes needed if above is not
##         adequate to make a unique filename (e.g., with "within" data or
##         with multiple water bodies)
species <- "Northern Pike"
atype <- "between"
strux <- "otoliths"
strux2 <- "saggitae"
proc <- "sectioned"
extra_suffix <- "CL"

df1 <- df %>%
  filterD(loc=="Cable Lake",structure=="Otolith") %>%
  select(R1,R2,R3) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~R1+R2+R3,data=df1)
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
  filterD(loc=="Cable Lake",structure=="Cleithrum") %>%
  select(R1,R2,R3) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~R1+R2+R3,data=df1)
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
  filterD(loc=="Devils Lake",structure=="Otolith") %>%
  select(R1,R2,R3) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~R1+R2+R3,data=df1)
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
  filterD(loc=="Devils Lake",structure=="Cleithrum") %>%
  select(R1,R2,R3) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~R1+R2+R3,data=df1)
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
