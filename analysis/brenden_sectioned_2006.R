#### SETUP #####################################################################
cat("\014")
setwd(here::here())
source("code/precisionData.R")

nm <- "brenden_sectioned_2006"
library(readxl)
df <- read_excel(paste0("data/raw_ageing/",nm,".xls"),sheet = "Ages")
str(df)

species <- "Muskellunge"

#### PELVIC FIN RAYS ###########################################################
strux <- "finrays"
strux2 <- "pelvic"
proc <- "sectioned"


df1 <- df %>%
  rename(Final=`Final Ages`) %>%
  select(ID,Brenden,Hale,Staples,Final) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~Brenden+Hale+Staples,data=df1)
pt1SD <- precisionData(ap1,studyID=nm,species=species,
                       structure=strux,structure2=strux2,process=proc,
                       type="between",var="SD")
plot(pt1SD)
summary(pt1SD,what="tests")

pt1CV <- precisionData(ap1,studyID=nm,species=species,
                       structure=strux,structure2=strux2,process=proc,
                       type="between",var="CV")
plot(pt1CV)
summary(pt1CV,what="tests")

res <- list(sum=pt1SD$sum,tests=rbind(pt1SD$tests,pt1CV$tests))
saveRDS(res,paste0("data/results_precision/",nm,"_",strux,
                   ifelse(strux2=="","","_"),strux2,
                   ifelse(proc=="","","_"),proc,".rds"))

