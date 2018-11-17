#### SETUP #####################################################################
cat("\014")
setwd(here::here())
source("code/precisionData.R")

nm <- "koenigs_validation_2015"
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"))
str(df)

species <- "Walleye"
atype <- "between"

#### OTOLITHS ##################################################################
strux <- "otoliths"
strux2 <- "saggitae"
proc <- "sectioned"
extra_suffix <- ""

df1 <- df %>%
  select(contains("otoliths")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~otoliths_Ryan+otoliths_Eli,data=df1)
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



#### DORSAL SPINES #############################################################
strux <- "spines"
strux2 <- "dorsal"
proc <- "sectioned"
extra_suffix <- ""

df1 <- df %>%
  select(contains("spines")) %>%
  filterD(complete.cases(.))

ap2 <- agePrecision(~spines_Ryan+spines_Jack,data=df)
pt2SD <- precisionData(ap2,studyID=nm,species=species,
                       structure=strux,structure2=strux2,process=proc,
                       type=atype,var="SD")
plot(pt2SD)
summary(pt2SD,what="tests")

pt2CV <- precisionData(ap2,studyID=nm,species=species,
                       structure=strux,structure2=strux2,process=proc,
                       type=atype,var="CV")
plot(pt2CV)
summary(pt2CV,what="tests")

res <- list(sum=pt2SD$sum,tests=rbind(pt2SD$tests,pt2CV$tests))
saveRDS(res,paste0("data/results_precision/",nm,"_",species,"_",strux,
                   ifelse(strux2=="","","_"),strux2,
                   ifelse(proc=="","","_"),proc,
                   ifelse(extra_suffix=="","","_"),extra_suffix,".rds"))
