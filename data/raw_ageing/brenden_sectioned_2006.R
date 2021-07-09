#### SETUP #####################################################################
cat("\014")
setwd(here::here())
source("code/ExtAn_Helper_PrecisionData.R")

nm <- "brenden_sectioned_2006"
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"))
str(df)

species <- "Muskellunge"
atype <- "between"
strux <- "finrays"
strux2 <- "pelvic"
proc <- "sectioned"
extra_suffix <- ""

df1 <- df %>%
  select(contains("finrays")) %>%
  filter(complete.cases(.))

ap1 <- agePrecision(~finrays_Brenden+finrays_Hale+finrays_Staples,data=df1)
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

