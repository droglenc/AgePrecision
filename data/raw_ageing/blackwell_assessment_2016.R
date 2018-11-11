#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
source("code/precisionData.R")

nm <- "blackwell_assessment_2016"       ## Name of study (actually name of file)
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"))
str(df) 


## !!! Copy the code below if more than one structure of comparisons

#### XXXXXX ####################################################################
species <- "Northern Pike"
atype <- "between"  # possibly change to "within"
strux <- "cleithra"         # Calcified strucure (e.g., scales, otolith, finray, spine)
strux2 <- ""        # More about scturcture (e.g., dorsal, pectoral)
proc <- "sectioned"          # Process info (e.g., sectioned, crackburn, whole)

df1 <- df %>%       # Process the data to prepare for analysis
  select(contains("cleithra_section")) %>%
  filterD(complete.cases(.))

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
                   ifelse(proc=="","","_"),proc,".rds"))


#### XXXXXX ####################################################################
species <- "Northern Pike"
atype <- "between"  # possibly change to "within"
strux <- "cleithra"         # Calcified strucure (e.g., scales, otolith, finray, spine)
strux2 <- ""        # More about scturcture (e.g., dorsal, pectoral)
proc <- "whole"          # Process info (e.g., sectioned, crackburn, whole)

df1 <- df %>%       # Process the data to prepare for analysis
  select(contains("cleithera_whole")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~cleithera_whole_R1+cleithera_whole_R2,data=df1)   ## include the variable names here
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
strux <- "otolith"         # Calcified strucure (e.g., scales, otolith, finray, spine)
strux2 <- "sagittae"        # More about scturcture (e.g., dorsal, pectoral)
proc <- "sectioned"          # Process info (e.g., sectioned, crackburn, whole)

df1 <- df %>%       # Process the data to prepare for analysis
  select(contains("otolith")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~otolith_R1+otolith_R2,data=df1)   ## include the variable names here
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
strux <- "scales"         # Calcified strucure (e.g., scales, otolith, finray, spine)
strux2 <- ""        # More about scturcture (e.g., dorsal, pectoral)
proc <- "pressed"          # Process info (e.g., sectioned, crackburn, whole)

df1 <- df %>%       # Process the data to prepare for analysis
  select(contains("scale")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~scale_R1+scale_R2,data=df1)   ## include the variable names here
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
strux <- "bones"         # Calcified strucure (e.g., scales, otolith, finray, spine)
strux2 <- "metapterygoid"        # More about scturcture (e.g., dorsal, pectoral)
proc <- "whole"          # Process info (e.g., sectioned, crackburn, whole)

df1 <- df %>%       # Process the data to prepare for analysis
  select(contains("metap")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~metapt_R1+metapt_R2,data=df1)   ## include the variable names here
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
