#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
source("code/precisionData.R")

nm <- "oele_precision_2015"       ## Name of study (actually name of file)
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"))
str(df) 


## !!! Copy the code below if more than one structure of comparisons

#### XXXXXX ####################################################################
species <- "Northern Pike"
atype <- "between"  # possibly change to "within"
strux <- "scales"         # Calcified strucure (e.g., scales, otolith, finray, spine)
strux2 <- ""        # More about scturcture (e.g., dorsal, pectoral)
proc <- "pressed"          # Process info (e.g., sectioned, crackburn, whole)

df1 <- df %>%       # Process the data to prepare for analysis
  select(contains("scales")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~scales_R1+scales_R2+scales_R3,data=df1)
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
species <- "Northern Pike"
atype <- "between"  # possibly change to "within"
strux <- "finrays"         # Calcified strucure (e.g., scales, otolith, finray, spine)
strux2 <- "anal"        # More about scturcture (e.g., dorsal, pectoral)
proc <- "sectioned"          # Process info (e.g., sectioned, crackburn, whole)

df1 <- df %>%       # Process the data to prepare for analysis
  select(contains("anal")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~anal_R1+anal_R2+anal_R3,data=df1)
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
species <- "Northern Pike"
atype <- "between"  # possibly change to "within"
strux <- "otoliths"         # Calcified strucure (e.g., scales, otolith, finray, spine)
strux2 <- "sagittae"        # More about scturcture (e.g., dorsal, pectoral)
proc <- "sectioned"          # Process info (e.g., sectioned, crackburn, whole)

df1 <- df %>%       # Process the data to prepare for analysis
  select(contains("otolith")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~otolith_R1+otolith_R2+otolith_R3,data=df1)
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
species <- "Northern Pike"
atype <- "between"  # possibly change to "within"
strux <- "cleithra"         # Calcified strucure (e.g., scales, otolith, finray, spine)
strux2 <- ""        # More about scturcture (e.g., dorsal, pectoral)
proc <- "whole"          # Process info (e.g., sectioned, crackburn, whole)

df1 <- df %>%       # Process the data to prepare for analysis
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
                   ifelse(proc=="","","_"),proc,".rds"))
