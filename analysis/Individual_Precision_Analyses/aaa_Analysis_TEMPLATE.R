#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
source("code/precisionData.R")

nm <- ""       ## Name of study (actually name of file)
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"))
str(df) 


## !!! Copy the code below if more than one structure of comparisons

#### XXXXXX ####################################################################
species <- ""
atype <- "between"  # possibly change to "within"
strux <- ""         # Calcified strucure (e.g., scales, otolith, finray, spine)
strux2 <- ""        # More about scturcture (e.g., dorsal, pectoral)
proc <- ""          # Process info (e.g., sectioned, crackburn, whole)
extra_suffix <- ""  # Extra suffix for name ... sometimes needed if above is not adequate

df1 <- df %>%       # Process the data to prepare for analysis
  select(contains("")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~XXX+XXX,data=df1)   ## include the variable names here
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
