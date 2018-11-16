#### SETUP #####################################################################
cat("\014"); rm(list=ls())
setwd(here::here())
source("code/precisionData.R")

nm <- "tyszko_comparing_2017"       ## Name of study (actually name of file)
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"),stringsAsFactors=FALSE) %>%
  mutate(locyr=mapvalues(locyr,from="82013_2014",to="UpperSandusky_2014"))
str(df) 

( ly <- unique(df$locyr) )

## !!! Copy the code below if more than one structure of comparisons
#### XXXXXX ####################################################################
## Cycle through each location for scales
species <- "Largemouth  Bass"
atype <- "between"
strux <- "scales"
strux2 <- ""
proc <- "pressed-mounted"

for (i in (ly)) {
  extra_suffix <- i
  
  df1 <- df %>%
    filterD(locyr==i) %>%
    select(contains("scale")) %>%
    filterD(complete.cases(.))
  
  ap1 <- agePrecision(~scale_1+scale_2+scale_3,data=df1)
  pt1SD <- precisionData(ap1,studyID=nm,species=species,
                         structure=strux,structure2=strux2,process=proc,
                         type=atype,var="SD")
  pt1CV <- precisionData(ap1,studyID=nm,species=species,
                         structure=strux,structure2=strux2,process=proc,
                         type=atype,var="CV")
  res <- list(sum=pt1SD$sum,tests=rbind(pt1SD$tests,pt1CV$tests))
  saveRDS(res,paste0("data/results_precision/",nm,"_",species,"_",strux,
                     ifelse(strux2=="","","_"),strux2,
                     ifelse(proc=="","","_"),proc,
                     ifelse(extra_suffix=="","","_"),extra_suffix,".rds"))
}

#### XXXXXX ####################################################################
## Cycle through each location for scales
species <- "Largemouth  Bass"
atype <- "between"
strux <- "otoliths"
strux2 <- "sagittae"
proc <- "broken-burnt"

for (i in (ly)) {
  extra_suffix <- i
  
  df1 <- df %>%
    filterD(locyr==i) %>%
    select(contains("otolith")) %>%
    filterD(complete.cases(.))
  
  ap1 <- agePrecision(~otolith_1+otolith_2+otolith_3,data=df1)
  pt1SD <- precisionData(ap1,studyID=nm,species=species,
                         structure=strux,structure2=strux2,process=proc,
                         type=atype,var="SD")
  pt1CV <- precisionData(ap1,studyID=nm,species=species,
                         structure=strux,structure2=strux2,process=proc,
                         type=atype,var="CV")
  res <- list(sum=pt1SD$sum,tests=rbind(pt1SD$tests,pt1CV$tests))
  saveRDS(res,paste0("data/results_precision/",nm,"_",species,"_",strux,
                     ifelse(strux2=="","","_"),strux2,
                     ifelse(proc=="","","_"),proc,
                     ifelse(extra_suffix=="","","_"),extra_suffix,".rds"))
}