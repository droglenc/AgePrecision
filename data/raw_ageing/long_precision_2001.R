#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
source("code/ExtAn_Helper_PrecisionData.R")

nm <- "long_precision_2001"       ## Name of study (actually name of file)
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"))
str(df) 



#### Largemouth Bass ####################################################################
species <- "Largemouth Bass"
atype <- "between"
strux <- "scales"
strux2 <- ""
proc <- "pressed"
extra_suffix <- ""

df1 <- df %>%
  filter(species=="LMB") %>%
  select(contains("scales")) %>%
  filter(complete.cases(.))

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
                   ifelse(proc=="","","_"),proc,
                   ifelse(extra_suffix=="","","_"),extra_suffix,".rds"))

#### Largemouth Bass ####################################################################
species <- "Largemouth Bass"
atype <- "between"
strux <- "otoliths"
strux2 <- "sagittae"
proc <- "whole"
extra_suffix <- ""

df1 <- df %>%
  filter(species=="LMB") %>%
  select(contains("wholeoto")) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~wholeoto_R1+wholeoto_R2+wholeoto_R3,data=df1)
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

#### Largemouth Bass ####################################################################
species <- "Largemouth Bass"
atype <- "between"
strux <- "otoliths"
strux2 <- "sagittae"
proc <- "sectioned"
extra_suffix <- ""

df1 <- df %>%
  filter(species=="LMB") %>%
  select(contains("sectoto")) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~sectoto_R1+sectoto_R2+sectoto_R3,data=df1)
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


#### Spotted Bass ####################################################################
species <- "Spotted Bass"
atype <- "between"
strux <- "scales"
strux2 <- ""
proc <- "pressed"
extra_suffix <- ""

df1 <- df %>%
  filter(species=="SPB") %>%
  select(contains("scales")) %>%
  filter(complete.cases(.))

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
                   ifelse(proc=="","","_"),proc,
                   ifelse(extra_suffix=="","","_"),extra_suffix,".rds"))

#### Spotted Bass ####################################################################
species <- "Spotted Bass"
atype <- "between"
strux <- "otoliths"
strux2 <- "sagittae"
proc <- "whole"
extra_suffix <- ""

df1 <- df %>%
  filter(species=="SPB") %>%
  select(contains("wholeoto")) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~wholeoto_R1+wholeoto_R2+wholeoto_R3,data=df1)
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

#### Spotted Bass ####################################################################
species <- "Spotted Bass"
atype <- "between"
strux <- "otoliths"
strux2 <- "sagittae"
proc <- "sectioned"
extra_suffix <- ""

df1 <- df %>%
  filter(species=="SPB") %>%
  select(contains("sectoto")) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~sectoto_R1+sectoto_R2+sectoto_R3,data=df1)
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
