#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
source("code/precisionData.R")

nm <- "gallagher_comparison_2016"       ## Name of study (actually name of file)
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"))
str(df) 




#### WITHIN RW READER ##########################################################
species <- "Dolly Varden"
atype <- "within"  # possibly change to "within"
strux <- "otoliths"         # Calcified strucure (e.g., scales, otolith, finray, spine)
strux2 <- "saggitae"        # More about scturcture (e.g., dorsal, pectoral)
proc <- "whole"          # Process info (e.g., sectioned, crackburn, whole)
extra_suffix <- "RW"  # Extra suffix for name ... sometimes needed if above is not adequate

df1 <- df %>%       # Process the data to prepare for analysis
  select(contains("whoto_RW")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~whoto_RW_1+whoto_RW_2+whoto_RW_3,data=df1)
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

#### WITHIN RW READER ##########################################################
species <- "Dolly Varden"
atype <- "within"  # possibly change to "within"
strux <- "otoliths"         # Calcified strucure (e.g., scales, otolith, finray, spine)
strux2 <- "saggitae"        # More about scturcture (e.g., dorsal, pectoral)
proc <- "sectioned"          # Process info (e.g., sectioned, crackburn, whole)
extra_suffix <- "RW"  # Extra suffix for name ... sometimes needed if above is not adequate

df1 <- df %>%       # Process the data to prepare for analysis
  select(contains("sectoto_RW")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~sectoto_RW_1+sectoto_RW_2+sectoto_RW_3,data=df1)
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

#### WITHIN RW READER ##########################################################
species <- "Dolly Varden"
atype <- "within"  # possibly change to "within"
strux <- "finrays"         # Calcified strucure (e.g., scales, otolith, finray, spine)
strux2 <- "pectoral"        # More about scturcture (e.g., dorsal, pectoral)
proc <- "sectioned"          # Process info (e.g., sectioned, crackburn, whole)
extra_suffix <- "RW"  # Extra suffix for name ... sometimes needed if above is not adequate

df1 <- df %>%       # Process the data to prepare for analysis
  select(contains("pectoral_RW")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~pectoral_RW_1+pectoral_RW_2+pectoral_RW_3,data=df1)
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

#### WITHIN RW READER ##########################################################
species <- "Dolly Varden"
atype <- "within"  # possibly change to "within"
strux <- "finrays"         # Calcified strucure (e.g., scales, otolith, finray, spine)
strux2 <- "pelvic"        # More about scturcture (e.g., dorsal, pectoral)
proc <- "sectioned"          # Process info (e.g., sectioned, crackburn, whole)
extra_suffix <- "RW"  # Extra suffix for name ... sometimes needed if above is not adequate

df1 <- df %>%       # Process the data to prepare for analysis
  select(contains("pelvic_RW")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~pelvic_RW_1+pelvic_RW_2+pelvic_RW_3,data=df1)
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




#### WITHIN NSC READER #########################################################
species <- "Dolly Varden"
atype <- "within"  # possibly change to "within"
strux <- "otoliths"         # Calcified strucure (e.g., scales, otolith, finray, spine)
strux2 <- "saggitae"        # More about scturcture (e.g., dorsal, pectoral)
proc <- "whole"          # Process info (e.g., sectioned, crackburn, whole)
extra_suffix <- "NSC"  # Extra suffix for name ... sometimes needed if above is not adequate

df1 <- df %>%       # Process the data to prepare for analysis
  select(contains("whoto_NSC")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~whoto_NSC_1+whoto_NSC_2+whoto_NSC_3,data=df1)
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

#### WITHIN NSC READER #########################################################
species <- "Dolly Varden"
atype <- "within"  # possibly change to "within"
strux <- "otoliths"         # Calcified strucure (e.g., scales, otolith, finray, spine)
strux2 <- "saggitae"        # More about scturcture (e.g., dorsal, pectoral)
proc <- "sectioned"          # Process info (e.g., sectioned, crackburn, whole)
extra_suffix <- "NSC"  # Extra suffix for name ... sometimes needed if above is not adequate

df1 <- df %>%       # Process the data to prepare for analysis
  select(contains("sectoto_NSC")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~sectoto_NSC_1+sectoto_NSC_2+sectoto_NSC_3,data=df1)
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

#### WITHIN NSC READER #########################################################
species <- "Dolly Varden"
atype <- "within"  # possibly change to "within"
strux <- "finrays"         # Calcified strucure (e.g., scales, otolith, finray, spine)
strux2 <- "pectoral"        # More about scturcture (e.g., dorsal, pectoral)
proc <- "sectioned"          # Process info (e.g., sectioned, crackburn, whole)
extra_suffix <- "NSC"  # Extra suffix for name ... sometimes needed if above is not adequate

df1 <- df %>%       # Process the data to prepare for analysis
  select(contains("pectoral_NSC")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~pectoral_NSC_1+pectoral_NSC_2+pectoral_NSC_3,data=df1)
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

#### WITHIN NSC READER #########################################################
species <- "Dolly Varden"
atype <- "within"  # possibly change to "within"
strux <- "finrays"         # Calcified strucure (e.g., scales, otolith, finray, spine)
strux2 <- "pelvic"        # More about scturcture (e.g., dorsal, pectoral)
proc <- "sectioned"          # Process info (e.g., sectioned, crackburn, whole)
extra_suffix <- "NSC"  # Extra suffix for name ... sometimes needed if above is not adequate

df1 <- df %>%       # Process the data to prepare for analysis
  select(contains("pelvic_NSC")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~pelvic_NSC_1+pelvic_NSC_2+pelvic_NSC_3,data=df1)
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



#### BETWEEN RW AND NSC READER #################################################
## This uses all six reads (three from each reader) ... not sure about this so
## I did not output these results.
species <- "Dolly Varden"
atype <- "between"  # possibly change to "within"
strux <- "otoliths"         # Calcified strucure (e.g., scales, otolith, finray, spine)
strux2 <- "saggitae"        # More about scturcture (e.g., dorsal, pectoral)
proc <- "whole"          # Process info (e.g., sectioned, crackburn, whole)
extra_suffix <- ""  # Extra suffix for name ... sometimes needed if above is not adequate

df1 <- df %>%       # Process the data to prepare for analysis
  select(contains("whoto")) %>%
  filterD(complete.cases(.)) %>%
  mutate(whoto_RW=rowMeans(select(.,contains("RW"))),
         whoto_NSC=rowMeans(select(.,contains("NSC"))))

ap1 <- agePrecision(~whoto_RW_1+whoto_RW_2+whoto_RW_3+whoto_NSC_1+whoto_NSC_2+whoto_NSC_3,data=df1)
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
#saveRDS(res,paste0("data/results_precision/",nm,"_",species,"_",strux,
#                   ifelse(strux2=="","","_"),strux2,
#                   ifelse(proc=="","","_"),proc,
#                   ifelse(extra_suffix=="","","_"),extra_suffix,".rds"))
