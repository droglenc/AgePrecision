#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
source("code/ExtAn_Helper_PrecisionData.R")

nm <- "puchala_size_2018"       ## Name of study (actually name of file)
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"))
str(df) 


#### Within Betsy ####################################################################
species <- "Stonecat"
atype <- "within"
strux <- "spines"
strux2 <- "dorsal"
proc <- "sectioned"
extra_suffix <- "Betsy"

df1 <- df %>%
  select(spines_Betsy_1,spines_Betsy_2) %>%
  filter(complete.cases(.))
ap1 <- agePrecision(~spines_Betsy_1+spines_Betsy_2,data=df1)
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

#### Within Lee ####################################################################
species <- "Stonecat"
atype <- "within"
strux <- "spines"
strux2 <- "dorsal"
proc <- "sectioned"
extra_suffix <- "Lee"

df1 <- df %>%
  select(spines_Lee_1,spines_Lee_2) %>%
  filter(complete.cases(.))
ap1 <- agePrecision(~spines_Lee_1+spines_Lee_2,data=df1)
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

#### Within Alex ####################################################################
species <- "Stonecat"
atype <- "within"
strux <- "spines"
strux2 <- "dorsal"
proc <- "sectioned"
extra_suffix <- "Alex"

df1 <- df %>%
  select(spines_Alex_1,spines_Alex_2) %>%
  filter(complete.cases(.))
ap1 <- agePrecision(~spines_Alex_1+spines_Alex_2,data=df1)
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

#### Between 2nd readings for each of 3 readers ################################
species <- "Stonecat"
atype <- "between"
strux <- "spines"
strux2 <- "dorsal"
proc <- "sectioned"
extra_suffix <- ""

df1 <- df %>%
  select(spines_Alex_2,spines_Betsy_2,spines_Lee_2) %>%
  filter(complete.cases(.))
ap1 <- agePrecision(~spines_Alex_2+spines_Betsy_2+spines_Lee_2,data=df1)
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
