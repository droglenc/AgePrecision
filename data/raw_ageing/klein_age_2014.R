#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
source("code/precisionData.R")

## To more closely match Klein et al. (2014), remove the five lines that have
##   some missing data for some of the structures. This is not necessary for
##   our purposes here, so I did not do that. We could do that though by adding
##   the following after the read.csv() line
##
## %>%
##  filter(complete.cases(select(.,contains("branchio"),contains("finrays"),contains("otoliths"))))

nm <- "klein_age_2014"       ## Name of study (actually name of file)
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"))
str(df) 

#### XXXXXX ####################################################################
species <- "Burbot"
atype <- "between"
strux <- "other"
strux2 <- "branchiostegal rays"
proc <- "sectioned"
extra_suffix <- ""

df1 <- df %>%
  select(branchio_MT,branchio_ZK) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~branchio_MT+branchio_ZK,data=df1)
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
species <- "Burbot"
atype <- "between"
strux <- "finrays"
strux2 <- "pectoral"
proc <- "sectioned"
extra_suffix <- ""

df1 <- df %>%
  select(finrays_MT,finrays_ZK) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~finrays_MT+finrays_ZK,data=df1)
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
species <- "Burbot"
atype <- "between"
strux <- "otoliths"
strux2 <- "sagittae"
proc <- "sectioned"
extra_suffix <- ""

df1 <- df %>%
  select(otoliths_MT,otoliths_ZK) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~otoliths_MT+otoliths_ZK,data=df1)
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
