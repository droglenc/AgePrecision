#### SETUP #####################################################################
setwd(here::here())
source("code/ExtAn_Helper_PrecisionData.R")

nm <- "herbst_comparison_2011"
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"))
str(df) 

species <- "Lake Whitefish"
atype <- "between"

#### SCALES ####################################################################
strux <- "scales"
strux2 <- ""
proc <- ""
extra_suffix <- ""

df1 <- df %>%
  select(contains("scale")) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~scale1+scale2,data=df1)
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
                   ifelse(proc=="","","_"),
                   ifelse(extra_suffix=="","","_"),extra_suffix,".rds"))


#### otoliths ##################################################################
strux <- "otoliths"
strux2 <- ""
proc <- "crackburn"
extra_suffix <- ""

df1 <- df %>%
  select(contains("otolith")) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~otolith1+otolith2,data=df1)
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
                   ifelse(proc=="","","_"),
                   ifelse(extra_suffix=="","","_"),extra_suffix,".rds"))



#### finrays ###################################################################
strux <- "finrays"
strux2 <- "dorsal"
proc <- "sectioned"
extra_suffix <- ""

df1 <- df %>%
  select(contains("finray")) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~finray1+finray2,data=df1)
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
