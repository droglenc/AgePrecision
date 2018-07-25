here::here()
source("code/precisionTests.R")

nm <- "Lepaketal_2017"
df <- read.csv(paste0("data/raw_ageing/",nm,".csv"))
str(df) 

## scales
strux <- "scales"
df1 <- df %>%
  select(starts_with("scale")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~scaleAge_TAL+scaleAge_DHO,data=df1)
pt1SD <- precisionTests(ap1,studyID=nm,structure=strux,var="SD")
plot(pt1SD)
summary(pt1SD)
## don't need to model heteroscedasticity, don't need quadratic term
## significant relationship b/w SD and mean

pt1CV <- precisionTests(ap1,studyID=nm,structure=strux,var="CV")
plot(pt1CV)
summary(pt1CV)
## don't need to model heteroscedasticity, don't need quadratic term
## no significant relationship b/w CV and mean

## Put together and write out to an RDS file
res <- list(sum=data.frame(studyID=nm,structure=strux,
                           summary(ap1,what="precision",show.prec2=TRUE)),
            tests=rbind(summary(pt1SD),summary(pt1CV)))
saveRDS(res,paste0("data/results_precision/",nm,"_",strux,".rds"))


## otoliths
strux <- "otoliths"
df1 <- df %>%
  select(starts_with("oto")) %>%
  filterD(complete.cases(.))

ap1 <- agePrecision(~otoAge_TAL+otoAge_DHO,data=df1)
pt1SD <- precisionTests(ap1,"SD",paste0(nm,"_otoliths"))
plot(pt1SD)
summary(pt1SD)
## need to model heteroscedasticity, don't need quadratic term
## significant relationship b/w SD and mean

pt1CV <- precisionTests(ap1,"CV",paste0(nm,"_otoliths"))
plot(pt1CV)
summary(pt1CV)
## need to model heteroscedasticity, don't need quadratic term
## no significant relationship b/w SD and mean

res <- list(sum=data.frame(studyID=nm,structure=strux,
                           summary(ap1,what="precision",show.prec2=TRUE)),
            tests=rbind(summary(pt1SD),summary(pt1CV)))
saveRDS(res,paste0("data/results_precision/",nm,"_",strux,".rds"))
