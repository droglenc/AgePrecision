#### SETUP #####################################################################
here::here()
source("code/precisionData.R")

nm <- ""       ## Name of study (actually name of file)
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"))
str(df) 

## !!! Copy the code below if more than one structure of comparisons

#### XXXXXX ####################################################################
strux <- ""    ## Calcified strucure (e.g., scales, otolith, finray, spine)
strux2 <- ""   ## More about scturcture (e.g., dorsal, pectoral)
proc <- ""     ## Process info (e.g., sectioned, crackburn, whole)

df1 <- df %>%  ## Isolate the variables containing the ages
  select(starts_with("scale")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~XXX+XXX,data=df1)   ## include the variable names here
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

