#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
source("code/precisionData.R")

nm <- "klein_precision_2017"       ## Name of study (actually name of file)
df <- read.csv(paste0("data/raw_ageing/",nm,".csv")) %>%
  filterD(!is.na(true_Age)) ## Reduced to only fish with a true age to match Klein
str(df) 


## !!! Copy the code below if more than one structure of comparisons

#### XXXXXX ####################################################################
## ULTIMATELY DID NOT USE THE OTOLITH DATA BECAUSE THERE WAS NO VARIAIBILITY
## BETWEEN THE TWO READERS ... THUS NOT USEFUL FOR TESTING THE RELATIONSHIP
## BETWEEN PRECISION METRICS AND AGE.
species <- "Largemouth Bass"
atype <- "between"  # possibly change to "within"
strux <- "otoliths"         # Calcified strucure (e.g., scales, otolith, finray, spine)
strux2 <- "sagittae"        # More about scturcture (e.g., dorsal, pectoral)
proc <- "sectioned"          # Process info (e.g., sectioned, crackburn, whole)

df1 <- df %>%     # Process the data to prepare for analysis
  select(contains("oto")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~oto_Tim+oto_Bryant,data=df1)   ## include the variable names here
pt1SD <- precisionData(ap1,studyID=nm,species=species,
                       structure=strux,structure2=strux2,process=proc,
                       type=atype,var="SD")
#plot(pt1SD)
#summary(pt1SD,what="tests")

pt1CV <- precisionData(ap1,studyID=nm,species=species,
                       structure=strux,structure2=strux2,process=proc,
                       type=atype,var="CV")
#plot(pt1CV)
#summary(pt1CV,what="tests")

#res <- list(sum=pt1SD$sum,tests=rbind(pt1SD$tests,pt1CV$tests))
#saveRDS(res,paste0("data/results_precision/",nm,"_",species,"_",strux,
#                   ifelse(strux2=="","","_"),strux2,
#                   ifelse(proc=="","","_"),proc,".rds"))


#### XXXXXX ####################################################################
species <- "Largemouth Bass"
atype <- "between"  # possibly change to "within"
strux <- "spines"         # Calcified strucure (e.g., scales, otolith, finray, spine)
strux2 <- "anal"        # More about scturcture (e.g., dorsal, pectoral)
proc <- "sectioned"          # Process info (e.g., sectioned, crackburn, whole)

df1 <- df %>%     # Process the data to prepare for analysis
  select(contains("anal")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~anal_MQ+anal_ZK,data=df1)   ## include the variable names here
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
species <- "Largemouth Bass"
atype <- "between"  # possibly change to "within"
strux <- "spines"         # Calcified strucure (e.g., scales, otolith, finray, spine)
strux2 <- "dorsal"        # More about scturcture (e.g., dorsal, pectoral)
proc <- "sectioned"          # Process info (e.g., sectioned, crackburn, whole)

df1 <- df %>%     # Process the data to prepare for analysis
  select(contains("dorsal")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~dorsal_MQ+dorsal_ZK,data=df1)   ## include the variable names here
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
