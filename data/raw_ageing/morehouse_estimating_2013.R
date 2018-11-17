#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
source("code/precisionData.R")

nm <- "morehouse_estimating_2013"       ## Name of study (actually name of file)
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"),stringsAsFactors=FALSE)
str(df) 

( lk <- unique(df$loc) )


#### Scales ####################################################################
species <- "Largemouth Bass"
atype <- "between"
strux <- "scales"
strux2 <- "NA"
proc <- "pressed"

for (i in lk) {
  cat(i,"\n")
  extra_suffix <- i
  df1 <- df %>%
    filterD(loc==i) %>%
    select(scales_Steve,scales_Angie,scales_Reid) %>%
    filterD(complete.cases(.))
  ap1 <- agePrecision(~scales_Steve+scales_Angie+scales_Reid,data=df1)
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
}

#### Finrays ####################################################################
species <- "Largemouth Bass"
atype <- "between"
strux <- "finrays"
strux2 <- "pectoral"
proc <- "sectioned"

for (i in lk) {
  cat(i,"\n")
  extra_suffix <- i
  df1 <- df %>%
    filterD(loc==i) %>%
    select(finrays_Steve,finrays_Angie,finrays_Reid) %>%
    filterD(complete.cases(.))
  ap1 <- agePrecision(~finrays_Steve+finrays_Angie+finrays_Reid,data=df1)
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
}


#### Spines ####################################################################
species <- "Largemouth Bass"
atype <- "between"
strux <- "spines"
strux2 <- "dorsal"
proc <- "sectioned"

for (i in lk) {
  cat(i,"\n")
  extra_suffix <- i
  df1 <- df %>%
    filterD(loc==i) %>%
    select(spines_Steve,spines_Angie,spines_Reid) %>%
    filterD(complete.cases(.))
  ap1 <- agePrecision(~spines_Steve+spines_Angie+spines_Reid,data=df1)
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
}
