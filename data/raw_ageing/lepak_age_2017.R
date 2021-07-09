#### SETUP #####################################################################
cat("\014")
setwd(here::here())
source("code/ExtAn_Helper_PrecisionData.R")

nm <- "lepak_age_2017"
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"))
str(df)

species <- "Kiyi"
atype <- "between"

#### SCALES ####################################################################
strux <- "scales"
strux2 <- ""
proc <- ""
extra_suffix <- ""

df1 <- df %>%
  select(starts_with("scale")) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~scaleAge_TAL+scaleAge_DHO,data=df1)
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


#### otoliths ##################################################################
strux <- "otoliths"
strux2 <- "saggitae"
proc <- "sectioned"
extra_suffix <- ""

df1 <- df %>%
  select(starts_with("oto")) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~otoAge_TAL+otoAge_DHO,data=df1)
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
