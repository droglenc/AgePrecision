#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
source("code/precisionData.R")

nm <- "koch_precision_2009"       ## Name of study (actually name of file)
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"))
str(df) 


## !!! NOTE THAT KOCH LOOKED AT PAIRWISE READER PRECISION WHEREAS WE LOOK AT
##     PRECISION ACROSS ALL THREE READERS BELOW
## !!! NOTE THAT IT APPEARS THAT KOCH CALCULATED PRECISION FOR ONLY THOSE
##     STRUCTURES WHERE A CONSENSUS AGE WAS REACHED ... WE DID __NOT__ DO THAT

#### XXXXXX ####################################################################
species <- "Bowfin"
atype <- "between"  # possibly change to "within"
strux <- "finrays"         # Calcified strucure (e.g., scales, otolith, finray, spine)
strux2 <- "pectoral"        # More about scturcture (e.g., dorsal, pectoral)
proc <- "sectioned"          # Process info (e.g., sectioned, crackburn, whole)

df1 <- df %>%       # Process the data to prepare for analysis
  select(contains("finray_R")) %>%
  filterD(complete.cases(.))
  
ap1 <- agePrecision(~finray_R1+finray_R2+finray_R3,data=df1)   ## include the variable names here
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
                   ifelse(proc=="","","_"),proc,".rds"))


#### XXXXXX ####################################################################
species <- "Bowfin"
atype <- "between"  # possibly change to "within"
strux <- "gular plates"         # Calcified strucure (e.g., scales, otolith, finray, spine)
strux2 <- ""        # More about scturcture (e.g., dorsal, pectoral)
proc <- "whole"          # Process info (e.g., sectioned, crackburn, whole)

df1 <- df %>%       # Process the data to prepare for analysis
  select(contains("gular_R")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~gular_R1+gular_R2+gular_R3,data=df1)   ## include the variable names here
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
                   ifelse(proc=="","","_"),proc,".rds"))
