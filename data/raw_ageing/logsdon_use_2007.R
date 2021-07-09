#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
source("code/ExtAn_Helper_PrecisionData.R")

nm <- "logsdon_use_2007"       ## Name of study (actually name of file)
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"))
str(df) 


#### XXXXXX ####################################################################
species <- "Walleye"
atype <- "between"
strux <- "otoliths"
strux2 <- "sagittae"
proc <- "cracked"
extra_suffix <- "URL"

df1 <- df %>%
  filter(loc=="East Upper Red") %>%
  select(contains("otoliths")) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~otoliths_Dale+otoliths_Mgmt,data=df1)
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
species <- "Walleye"
atype <- "between"
strux <- "otoliths"
strux2 <- "sagittae"
proc <- "cracked"
extra_suffix <- "ML"

df1 <- df %>%
  filter(loc=="Mille Lacs") %>%
  select(contains("otoliths")) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~otoliths_Dale+otoliths_Mgmt,data=df1)
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
species <- "Walleye"
atype <- "between"
strux <- "spines"
strux2 <- "dorsal"
proc <- "ground"
extra_suffix <- "URL"

df1 <- df %>%
  filter(loc=="East Upper Red") %>%
  select(contains("spines")) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~spines_Dale+spines_Steve,data=df1)
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
species <- "Walleye"
atype <- "between"
strux <- "spines"
strux2 <- "dorsal"
proc <- "ground"
extra_suffix <- "ML"

df1 <- df %>%
  filter(loc=="Mille Lacs") %>%
  select(contains("spines")) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~spines_Dale+spines_Steve,data=df1)
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
