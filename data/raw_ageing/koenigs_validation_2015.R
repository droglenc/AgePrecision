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

ap1 <- agePrecision(~oto_Ryan+oto_Eli,data=df)
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



#### DORSAL SPINES #############################################################
strux <- "spines"
strux2 <- "dorsal"
proc <- "sectioned"

ap2 <- agePrecision(~spine_Ryan+spine_Jack,data=df)
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
                   ifelse(proc=="","","_"),proc,".rds"))

