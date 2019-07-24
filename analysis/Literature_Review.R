## Setup ----
setwd(here::here())
library(dplyr)
cat("\014")

###  Download file from GoogleDrive
fn <- googledrive::as_id("https://docs.google.com/spreadsheets/d/1RY6DQyi-zCfg_BQ2l_cZRZC_fA6PI3zutFIMIvJfbw8/edit?ts=5bac4a12#gid=0")
googledrive::drive_download(file=fn,path="data/Literature_Review",overwrite=TRUE)

### Setup some factor codes
NAS <- c("-","")
lvls_type <- c("between","within","both")
lvls_strux1 <- c("otoliths","spines","finrays","scales","vertebrae","thorns","other")
lvls_strux2 <- c("sagittae","lapillae","asterisci","statoliths",
                 "anal","dorsal","pectoral","pelvic","caudal",
                 "branchiostegal rays","gular plate","metapterygoid",
                 "pectoral articulating process","scute",
                 "sphenoid")


## Overall database ----
###  Read fish names
fish <- readxl::read_excel("data/Literature_Review.xlsx",sheet="FishNames") %>%
  dplyr::select(-sciname)

###  Read results and append on fish name info
tmp <- readxl::read_excel("data/Literature_Review.xlsx",sheet="Results_Meta")
res <- readxl::read_excel("data/Literature_Review.xlsx",sheet="Results",
                          na=NAS,col_types=tmp$RType) %>%
  dplyr::select(-notes) %>%
  dplyr::left_join(fish,by="species")

###  Read study info and append on results
tmp <- readxl::read_excel("data/Literature_Review.xlsx",sheet="Study_Meta")
df <- readxl::read_excel("data/Literature_Review.xlsx",sheet="Study",
                         na=NAS,col_types=tmp$RType) %>%
  dplyr::select(-notes,-OrigFile) %>%
  dplyr::left_join(res,by="studyID") %>%
  dplyr::filter(USE=="yes") %>%
  dplyr::select(-USE) %>%
  dplyr::mutate(structure=factor(structure,levels=lvls_strux1),
         structure2=factor(structure2,levels=lvls_strux2))

###  Clean up
rm(tmp,fish,res,fn,NAS)


## Creating new variables ----
###  Create some mapvalue categories
R_old <- c("2","3","4","5","6","9")
R_new <- c("2","3","4+","4+","4+","4+")
n_old <- seq(0,3200,200)
n_new <- c("0","200",rep("400+",length(n_old)-2))
strux_old <- lvls_strux1
strux_new <- c("otoliths","spines","finrays","scales","vertebrae","other","other")
class_old <- c("Actinopteri","Elasmobranchii","Holocephali","Petromyzonti")
class_new <- c("Actinopteri","Elasmobranchii","other","other")
loc_old <- unique(df$country)
loc_new1 <- c("USA","Asia","Aus/NZ","SCAmer","SCAmer","SCAmer","Africa","Asia",
              "Europe","Aus/NZ","Africa","Africa","Africa","Europe","SCAmer",
              "Africa","Asia","Europe","Asia","Europe","Europe","Africa",
              "Canada","Europe","Europe","Asia","Europe","Europe","Asia","Asia",
              "Asia","Europe","Europe")
loc_new2 <- c("USA/Can","Eur/Asia","Aus/NZ","other","other","Eur/Asia","USA/Can")


df1 <- df %>% 
  select(-studysite,-(exprnc:AnlyzdData),-Paother,-tech,-dateStamp) %>%
  mutate(structure=FSA::mapvalues(structure,from=strux_old,to=strux_new),
         type=factor(type),
         class=factor(class),
         class1=FSA::mapvalues(class,from=class_old,to=class_new),
         continent=FSA::mapvalues(country,from=loc_old,to=loc_new1),
         continent2=FSA::mapvalues(continent,from=unique(loc_new1),to=loc_new2),
         agemaxcat=FSA::lencat(agemax,w=10,as.fact=TRUE),
         agerange=agemax-agemin,
         agerangecat=FSA::lencat(agerange,breaks=c("0-10"=0,"10-20"=10,"20+"=20),
                                 use.names=TRUE),
         Rcat=FSA::mapvalues(factor(R),from=R_old,to=R_new),
         ncat=FSA::mapvalues(FSA::lencat(n,w=200,as.fact=TRUE),
                             from=n_old,to=n_new),
         ACVused=factor(ifelse(!is.na(ACV),"yes","no"),levels=c("yes","no")),
         ## convert APE to ACV when R=2, call ACVmod
         ACVmod=ifelse(!is.na(ACV),ACV,ifelse(!is.na(APE) & R==2,sqrt(2)*APE,NA)),
         ACVmodused=factor(ifelse(!is.na(ACVmod),"yes","no"),levels=c("yes","no")),
         ## determine if both ACV and APE were used
         bothACVnAPEused=factor(ifelse(!is.na(ACV) & !is.na(APE),"yes","no"),
                                levels=c("yes","no")),
         ## logs of precision metrics
         logAPE=log(APE),
         logACV=log(ACV),
         logACVmod=log(ACVmod),
  )
