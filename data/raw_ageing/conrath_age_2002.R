#### SETUP #####################################################################
cat("\014")
setwd(here::here())
source("code/precisionData.R")

nm <- "conrath_age_2002" # Name of study (actually name of file)
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"))
str(df) 

species <- "Smooth Dogfish"
atype <- "between"
strux <- "vertebrae"
strux2 <- ""
proc <- "sectioned"

df1 <- df

ap1 <- agePrecision(~vertebrae_R1+vertebrae_R2,data=df1)
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
