#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
source("code/precisionData.R")

nm <- "long_evaluation_2018"
df <- read.csv(paste0("data/raw_ageing/",nm,".csv")) %>%
  filterD(mon=="May")  ## Just Spring fish as suggested by Jim Long

## find duplicated IDs and make sure they are duplicates ... looks like they are
dupes <- which(duplicated(df$id))
tmp <- df[df$id %in% df$id[dupes],]
tmp[order(tmp$id),]

## Remove the second of the duplicated IDs (i.e., recaptured fish ... not used in Long paper either)
df <- df[!duplicated(df$id),]

#### Within Reader1 ####################################################################
species <- "Shoal Bass"
atype <- "within"
strux <- "scales"
strux2 <- "NA"
proc <- "mounted"
extra_suffix <- "R1"

df1 <- df %>%
  select(scales_AT_1,scales_AT_2) %>%
  filterD(complete.cases(.))
ap1 <- agePrecision(~scales_AT_1+scales_AT_2,data=df1)
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


#### Within Reader2 ####################################################################
species <- "Shoal Bass"
atype <- "within"
strux <- "scales"
strux2 <- "NA"
proc <- "mounted"
extra_suffix <- "R2"

df1 <- df %>%
  select(scales_CH_1,scales_CH_2) %>%
  filterD(complete.cases(.))
ap1 <- agePrecision(~scales_CH_1+scales_CH_2,data=df1)
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


#### Between Readers ####################################################################
## Did just between the second readings
species <- "Shoal Bass"
atype <- "between"
strux <- "scales"
strux2 <- "NA"
proc <- "mounted"
extra_suffix <- ""

df1 <- df %>%
  select(contains("2")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~scales_AT_2+scales_CH_2,data=df1)
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
