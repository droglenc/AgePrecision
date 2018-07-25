#### SETUP #####################################################################
here::here()
source("code/precisionData.R")

nm <- "Bauerlienetal_2018"       ## Name of study (actually name of file)
df <- read.csv(paste0("data/raw_ageing/",nm,".csv")) %>%
  select(-Mean.age,-MAD,-CV)
str(df) 
levels(df$Structure)

## !!! Copy the code below if more than one structure of comparisons

################################################################################
strux <- "finrays"    ## Calcified strucure (e.g., scales, otoliths, finrays, spines)
strux2 <- "anal"     ## More about scturcture (e.g., dorsal, pectoral)
proc <- "sectioned"  ## Process info (e.g., sectioned, crackburn, whole)

df1 <- df %>%  ## Isolate the variables containing the ages
  filterD(Structure=="Anal",complete.cases(.))

ap1 <- agePrecision(~Cory+Emily+Mike+Rin,data=df1)   ## include the variable names here
pt1SD <- precisionData(ap1,studyID=nm,
                       structure=strux,structure2=strux2,process=proc,
                       type="between",var="SD")  ## possible change to within
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



################################################################################
strux <- "cleithra"    ## Calcified strucure (e.g., scales, otoliths, finrays, spines)
strux2 <- ""     ## More about scturcture (e.g., dorsal, pectoral)
proc <- "whole"  ## Process info (e.g., sectioned, crackburn, whole)

df1 <- df %>%  ## Isolate the variables containing the ages
  filterD(Structure=="Cleithra",complete.cases(.))

ap1 <- agePrecision(~Cory+Emily+Mike+Rin,data=df1)   ## include the variable names here
pt1SD <- precisionData(ap1,studyID=nm,
                       structure=strux,structure2=strux2,process=proc,
                       type="between",var="SD")  ## possible change to within
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



################################################################################
strux <- "cleithra"    ## Calcified strucure (e.g., scales, otoliths, finrays, spines)
strux2 <- ""     ## More about scturcture (e.g., dorsal, pectoral)
proc <- "sectioned"  ## Process info (e.g., sectioned, crackburn, whole)

df1 <- df %>%  ## Isolate the variables containing the ages
  filterD(Structure=="Sectioned Cleithra",complete.cases(.))

ap1 <- agePrecision(~Cory+Emily+Mike+Rin,data=df1)   ## include the variable names here
pt1SD <- precisionData(ap1,studyID=nm,
                       structure=strux,structure2=strux2,process=proc,
                       type="between",var="SD")  ## possible change to within
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



################################################################################
strux <- "finrays"    ## Calcified strucure (e.g., scales, otoliths, finrays, spines)
strux2 <- "dorsal"     ## More about scturcture (e.g., dorsal, pectoral)
proc <- "sectioned"  ## Process info (e.g., sectioned, crackburn, whole)

df1 <- df %>%  ## Isolate the variables containing the ages
  filterD(Structure=="Dorsal",complete.cases(.))

ap1 <- agePrecision(~Cory+Emily+Mike+Rin,data=df1)   ## include the variable names here
pt1SD <- precisionData(ap1,studyID=nm,
                       structure=strux,structure2=strux2,process=proc,
                       type="between",var="SD")  ## possible change to within
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



################################################################################
strux <- "otoliths"    ## Calcified strucure (e.g., scales, otoliths, finrays, spines)
strux2 <- ""     ## More about scturcture (e.g., dorsal, pectoral)
proc <- "sectioned"  ## Process info (e.g., sectioned, crackburn, whole)

df1 <- df %>%  ## Isolate the variables containing the ages
  filterD(Structure=="Otolith",complete.cases(.))

ap1 <- agePrecision(~Cory+Emily+Mike+Rin,data=df1)   ## include the variable names here
pt1SD <- precisionData(ap1,studyID=nm,
                       structure=strux,structure2=strux2,process=proc,
                       type="between",var="SD")  ## possible change to within
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



################################################################################
strux <- "finrays"    ## Calcified strucure (e.g., scales, otoliths, finrays, spines)
strux2 <- "pectoral"     ## More about scturcture (e.g., dorsal, pectoral)
proc <- "sectioned"  ## Process info (e.g., sectioned, crackburn, whole)

df1 <- df %>%  ## Isolate the variables containing the ages
  filterD(Structure=="Pectoral",complete.cases(.))

ap1 <- agePrecision(~Cory+Emily+Mike+Rin,data=df1)   ## include the variable names here
pt1SD <- precisionData(ap1,studyID=nm,
                       structure=strux,structure2=strux2,process=proc,
                       type="between",var="SD")  ## possible change to within
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



################################################################################
strux <- "finrays"    ## Calcified strucure (e.g., scales, otoliths, finrays, spines)
strux2 <- "pelvic"     ## More about scturcture (e.g., dorsal, pectoral)
proc <- "sectioned"  ## Process info (e.g., sectioned, crackburn, whole)

df1 <- df %>%  ## Isolate the variables containing the ages
  filterD(Structure=="Pelvic",complete.cases(.))

ap1 <- agePrecision(~Cory+Emily+Mike+Rin,data=df1)   ## include the variable names here
pt1SD <- precisionData(ap1,studyID=nm,
                       structure=strux,structure2=strux2,process=proc,
                       type="between",var="SD")  ## possible change to within
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



################################################################################
strux <- "scales"    ## Calcified strucure (e.g., scales, otoliths, finrays, spines)
strux2 <- ""     ## More about scturcture (e.g., dorsal, pectoral)
proc <- ""  ## Process info (e.g., sectioned, crackburn, whole)

df1 <- df %>%  ## Isolate the variables containing the ages
  filterD(Structure=="Scales",complete.cases(.))

ap1 <- agePrecision(~Cory+Emily+Mike+Rin,data=df1)   ## include the variable names here
pt1SD <- precisionData(ap1,studyID=nm,
                       structure=strux,structure2=strux2,process=proc,
                       type="between",var="SD")  ## possible change to within
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
