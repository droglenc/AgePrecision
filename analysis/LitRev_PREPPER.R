#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#
#= This reads the sheets from the GoogleSheet called Literature_Review,      =#
#=   adds or modifies variables in each sheet, joins them to a flat database =#
#=   prepared for analysis. The flat file is saved into LitReview.RData      =#
#=                                                                           =#
#= This script is run only to update LitReview.RData if the GoogleSheet has  =#
#=   been updated (i.e., added to).                                          =#
#=                                                                           =#
#= The resultant cleaned data may be loaded into analysis scripts with       =#
#=   load("data/LitReview.RData"). The data will be in the LR data.frame.    =#
#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#


## Setup ----
setwd(here::here())
cat("\014")

### Factor codes and mapvalue vectors
NAS <- c("-","")
lvls_type <- c("between","within","both")
lvls_strux1 <- c("otoliths","spines","finrays","scales","vertebrae",
                 "thorns","other")
lvls_strux2 <- c("sagittae","lapillae","asterisci","statoliths",
                 "anal","dorsal","pectoral","pelvic","caudal",
                 "branchiostegal rays","gular plate","metapterygoid",
                 "pectoral articulating process","scute",
                 "sphenoid")

class_old <- c("Actinopteri","Elasmobranchii","Holocephali","Petromyzonti")
class_new <- c("Actinopteri","Elasmobranchii","other","other")
strux_old <- lvls_strux1
strux_new <- c("otoliths","spines","finrays","scales","vertebrae","other","other")
R_old <- c("2","3","4","5","6","9")
R_new <- c("2","3","4+","4+","4+","4+")
n_old <- seq(0,3200,200)
n_new <- c("0-199","200-399",rep("400+",length(n_old)-2))


## Create database ----
fn <- "https://docs.google.com/spreadsheets/d/1xXJhTcd1-IlshWydIheBeqeNzTg4gqBzUm685sTgTY0/edit?usp=sharing"

###  Read fish names and prepare variables
fish <- googlesheets4::read_sheet(fn,sheet="FishNames") %>%
  dplyr::select(-sciname) %>%
  dplyr::mutate(class=factor(class),
                class1=FSA::mapvalues(class,from=class_old,to=class_new))

###  Read results page and prepare variables
res <- googlesheets4::read_sheet(fn,sheet="Results",na=NAS) %>%
  dplyr::select(-notes) %>%
  dplyr::mutate(
    structure=FSA::mapvalues(structure,from=strux_old,to=strux_new),
    structure=factor(structure,levels=lvls_strux1),
    structure2=factor(structure2,levels=lvls_strux2),
    type=factor(type,levels=c("between","within","both")),
    Rcat=FSA::mapvalues(factor(R),from=R_old,to=R_new),
    ncat=FSA::mapvalues(FSA::lencat(n,w=200,as.fact=TRUE),from=n_old,to=n_new),
    agemaxcat=FSA::lencat(agemax,w=10,as.fact=TRUE),
    agerange=agemax-agemin,
    agerangecat=FSA::lencat(agerange,breaks=c("0-10"=0,"10-20"=10,"20+"=20),
                            use.names=TRUE),
    ACVused=factor(ifelse(!is.na(ACV),"yes","no"),levels=c("yes","no")),
    ## determine if both ACV and APE were used
    bothACVnAPEused=factor(ifelse(!is.na(ACV) & !is.na(APE),"yes","no"),
                           levels=c("yes","no")),
    ## convert APE to ACV when R=2, call ACVmod
    ACVmod=ifelse(!is.na(ACV),ACV,ifelse(!is.na(APE) & R==2,sqrt(2)*APE,NA)),
    ACVmodused=factor(ifelse(!is.na(ACVmod),"yes","no"),levels=c("yes","no")),
    logAPE=log(APE),
    logACV=log(ACV),
    logACVmod=log(ACVmod),
    checkbias=factor(checkbias,levels=c("yes","no")),
    biaspresent=factor(biaspresent,levels=c("yes","no")),
    checkrelage=factor(checkrelage,levels=c("yes","no")),
  )

###  Read study info and prepare variables
study <- googlesheets4::read_sheet(fn,sheet="Study",na=NAS) %>%
  dplyr::select(-(notes:OrigFile))

#####  Create some mapvalue categories
loc_old <- unique(study$country)
loc_old <- loc_old[order(loc_old)]
loc_new1 <- c("Africa","Africa","other","SCAmer","Aus/NZ","Europe","Africa",
              "SCAmer","SCAmer","Europe","USA/Can","Asia","SCAmer","Europe","SCAmer",
              "Africa","Africa","SCAmer","Europe","SCAmer","Europe","Europe",
              "SCAmer","Asia","Asia","Europe","Europe","Asia","Africa",
              "SCAmer","other","Aus/NZ","Europe","Asia","Aus/NZ","Europe","Europe",
              "Africa","Europe","Europe","Africa","Asia","Europe","Europe","Asia","Asia",
              "Africa","Europe","Africa","Europe","USA/Can","USA/Can","other")
loc_new1a <- unique(loc_new1)
loc_new1a <- loc_new1a[order(loc_new1a)]
loc_new2 <- c("other","Eur/Asia","Aus/NZ","Eur/Asia","other","other","USA/Can")
#####  check it out
cbind(loc_old,loc_new1)
cbind(loc_new1a,loc_new2)

study <- study %>%
  dplyr::mutate(
    marine=factor(marine,levels=c("yes","no")),
    exprnc=factor(exprnc,levels=c("yes","no")),
    continent=FSA::mapvalues(country,from=loc_old,to=loc_new1),
    continent2=FSA::mapvalues(continent,from=loc_new1a,to=loc_new2))
### Check continent and continent2 match
xtabs(~continent+continent2,data=study)

### Combine all three together into one data.frame
LR <- dplyr::right_join(study,res,by="studyID") %>%
  dplyr::left_join(fish,by="species") %>%
  dplyr::filter(USE=="yes") %>%
  dplyr::select(
    studyID,pubyear,country,continent,continent2,marine,exprnc,
    species,family,order,class,class1,
    structure,structure2,process,
    agemin,agemax,agemaxcat,agerange,agerangecat,
    type,R,Rcat,n,ncat,
    APE,logAPE,ACV,logACV,ACVmod,logACVmod,ACVmodused,bothACVnAPEused,
    PA0,PA1,ASD,AAD,APE2,ACV2,AD,
    checkbias,biasmethod,biaspresent,
    checkrelage,typerelage) %>%
  as.data.frame()

LR


## Output database ----
#### As an RData object ... maintains variable types, factor order, etc.
save(LR,file="data/LitReview.RData")
#### As a CSV file ... loses structure ... don't use, just a back-up in case!
write.csv(LR,file="data/LitReview_BACKUP.csv",row.names=FALSE)
