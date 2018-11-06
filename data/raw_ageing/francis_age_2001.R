#### SETUP #####################################################################
cat("\014")
setwd(here::here())
source("code/precisionData.R")

nm <- "francis_age_2001"       ## Name of study (actually name of file)

atype <- "between"

df <- read.csv(paste0("data/raw_ageing/",nm,".csv"))
str(df)


#### ROUGH SKATES ##############################################################
species <- "Rough Skate"
strux <- "vertebrae"
strux2 <- ""
proc <- "Sectioned"
df1 <- df %>%
  filterD(species=="Rough Skate")

ap1 <- agePrecision(~r1+r2,data=df1)
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


#### ROUGH SKATES ##############################################################
species <- "Smooth Skate"
strux <- "vertebrae"
strux2 <- ""
proc <- "Sectioned"
df1 <- df %>%
  filterD(species=="Smooth Skate")

ap1 <- agePrecision(~r1+r2,data=df1)
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
