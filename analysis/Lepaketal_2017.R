#### SETUP #####################################################################
here::here()
source("code/precisionData.R")

nm <- "Lepaketal_2017"
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"))
str(df) 

#### SCALES ####################################################################
strux <- "scales"
strux2 <- ""
proc <- ""
df1 <- df %>%
  select(starts_with("scale")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~scaleAge_TAL+scaleAge_DHO,data=df1)
pt1SD <- precisionData(ap1,studyID=nm,
                       structure=strux,structure2=strux2,process=proc,
                       type="between",var="SD")
plot(pt1SD)
summary(pt1SD,what="tests")

pt1CV <- precisionData(ap1,studyID=nm,
                       structure=strux,structure2=strux2,process=proc,
                       type="between",var="CV")
plot(pt1CV)
summary(pt1CV,what="tests")

res <- list(sum=pt1SD$sum,tests=rbind(pt1SD$tests,pt1CV$tests))
saveRDS(res,paste0("data/results_precision/",nm,"_",strux,
                   ifelse(strux2=="","","_"),strux2,
                   ifelse(proc=="","","_"),proc,".rds"))


#### otoliths ##################################################################
strux <- "otoliths"
strux2 <- ""
proc <- "sectioned"
  
df1 <- df %>%
  select(starts_with("oto")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~otoAge_TAL+otoAge_DHO,data=df1)
pt1SD <- precisionData(ap1,studyID=nm,
                       structure=strux,structure2=strux2,process=proc,
                       type="between",var="SD")
plot(pt1SD)
summary(pt1SD,what="tests")

pt1CV <- precisionData(ap1,studyID=nm,
                       structure=strux,structure2=strux2,process=proc,
                       type="between",var="CV")
plot(pt1CV)
summary(pt1CV,what="tests")

res <- list(sum=pt1SD$sum,tests=rbind(pt1SD$tests,pt1CV$tests))
saveRDS(res,paste0("data/results_precision/",nm,"_",strux,
                   ifelse(strux2=="","","_"),strux2,
                   ifelse(proc=="","","_"),proc,".rds"))
