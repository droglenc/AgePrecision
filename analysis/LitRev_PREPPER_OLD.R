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
library(dplyr)
setwd(here::here())
cat("\014")

### Read main files ... doing this here to minimize the number of calls to
###   googlesheets when troubleshooting; i.e., just run this and then modify
###   the main files below rather than have the googlesheet call as part of 
###   modification piping chain. Also gave modified files below a diff name.
fn <- "https://docs.google.com/spreadsheets/d/1xXJhTcd1-IlshWydIheBeqeNzTg4gqBzUm685sTgTY0/edit?usp=sharing"

fish <- googlesheets4::read_sheet(fn,sheet="FishNames") %>%
  dplyr::select(-sciname)
res <- googlesheets4::read_sheet(fn,sheet="Results",na=c("-","")) %>%
  dplyr::select(-dateStamp,-notes)
study <- googlesheets4::read_sheet(fn,sheet="Study",na=c("-","")) %>%
  dplyr::select(-studysite,-(notes:OrigFile))


### Factor codes and mapvalue vectors
unique(fish$class)
classes <- data.frame(
  old=c("Actinopteri","Elasmobranchii","Holocephali","Petromyzonti"),
  new=c("Actinopteri","Elasmobranchii","other","other")
  )


unique(res$type)
lvls_type <- c("between","within","both","unknown")


unique(res$structure)
structures <- data.frame(
  old=c("otoliths","spines","finrays","scales","vertebrae",
        "thorns","cleithra","opercles","other"),
  new=c("otoliths","spines","finrays","scales","vertebrae",
         "other","other","other","other")
)
# Use this to set levels later ... levels=unique(structures$new)


unique(res$structure2)
structures2 <- c("sagittae","lapillae","asterisci","statoliths",
                 "anal","dorsal","pectoral","pelvic","caudal",
                 "branchiostegal rays","clavicles","denticles",
                 "gular plate","maxillae","medial nuchais","metapterygoid",
                 "pectoral articulating process","postcleithra","scute",
                 "sphenoid","subopercular","vomerine tooth plate")


unique(res$R)
Rs <- data.frame(
  old= c("2","3",  "4", "5", "6","9"),
  new3=c("2","3+","3+","3+","3+","3+"),
  new4=c("2","3", "4+","4+","4+","4+")
)


range(res$n,na.rm=TRUE)
ns <- data.frame(
  old=c(0,50,200,400,4000),
  new=c("1-50","51-199","200-399","400+","400+")
)


range(res$agemax,na.rm=TRUE)
ageranges <- tibble(
  old=seq(0,140,10),
  new=paste(old,c(old[-1],max(old)+10),sep="-")
)


tmp <- unique(study$country)
countries <- data.frame(
  old=tmp[order(tmp)],
  new1=c("Africa","Africa","other","SCAmer","Aus/NZ","Europe","Africa",
         "SCAmer","Europe","USA/Can","Asia","SCAmer","Europe","SCAmer",
         "Africa","Africa","SCAmer","Europe","SCAmer","Europe","Europe",
         "SCAmer","Asia","Asia","Europe","Europe","Asia","Africa",
         "SCAmer","Aus/NZ","Europe","Asia","Aus/NZ","Europe","Europe",
         "Africa","Europe","Europe","Africa","Asia","Europe","Europe",
         "Asia","Asia","Africa","Europe","Africa","Europe","USA/Can"),
  new2=c("other","other","other","other","Aus/NZ","Eur/Asia","other",
         "other","Eur/Asia","USA/Can","Eur/Asia","other","Eur/Asia","other",
         "other","other","other","Eur/Asia","other","Eur/Asia","Eur/Asia",
         "other","Eur/Asia","Eur/Asia","Eur/Asia","Eur/Asia","Eur/Asia","other",
         "other","Aus/NZ","Eur/Asia","Eur/Asia","Aus/NZ","Eur/Asia","Eur/Asia",
         "other","Eur/Asia","Eur/Asia","other","Eur/Asia","Eur/Asia","Eur/Asia",
         "Eur/Asia","Eur/Asia","other","Eur/Asia","other","Eur/Asia","USA/Can")
)
unique(countries$new2)

lvls_country <- c("USA/Can","Eur/Asia","Aus/NZ","other")


lvls_yn <- c("yes","no")

## Create database ----
### Prepare fish names
fish2 <- fish %>%
  dplyr::mutate(
    class=factor(class,levels=classes$old),
    class1=plyr::mapvalues(class,from=classes$old,to=classes$new)
  )

### Prepare main results
res2 <- res %>%
  dplyr::mutate(
    type=factor(type,levels=lvls_type),

    structure=plyr::mapvalues(structure,from=structures$old,to=structures$new),
    structure=factor(structure,levels=unique(structures$new)),
    structure2=factor(structure2,levels=structures2),
    
    Rcat3=plyr::mapvalues(R,from=Rs$old,to=Rs$new3),
    Rcat4=plyr::mapvalues(R,from=Rs$old,to=Rs$new4),
    
    ncat=plyr::mapvalues(FSA::lencat(n,breaks=ns$old),from=ns$old,to=ns$new),
    
    agemaxcat=FSA::lencat(agemax,w=10,as.fact=TRUE),
    agerange=agemax-agemin,
    agerangecat=plyr::mapvalues(FSA::lencat(agerange,w=10),
                                from=ageranges$old,to=ageranges$new),
    
    ACVused=factor(ifelse(!is.na(ACV),"yes","no"),levels=lvls_yn),
    ## determine if both ACV and APE were used
    bothACVnAPEused=factor(ifelse(!is.na(ACV) & !is.na(APE),"yes","no"),
                           levels=lvls_yn),
    
    ## convert APE to ACV when R=2, call ACVmod
    ACVmod=ifelse(!is.na(ACV),ACV,ifelse(!is.na(APE) & R==2,sqrt(2)*APE,NA)),
    ACVmodused=factor(ifelse(!is.na(ACVmod),"yes","no"),levels=lvls_yn),
    
    logAPE=log(APE),
    logACV=log(ACV),
    logACVmod=log(ACVmod),
    
    checkbias=factor(checkbias,levels=lvls_yn),
    biaspresent=factor(biaspresent,levels=lvls_yn),
    checkrelage=factor(checkrelage,levels=lvls_yn)
  )

### Prepare study
study2 <- study %>%
  dplyr::mutate(
    marine=factor(marine,levels=lvls_yn),
    exprnc=factor(exprnc,levels=lvls_yn),
    continent=plyr::mapvalues(country,from=countries$old,to=countries$new1),
    continent2=plyr::mapvalues(country,from=countries$old,to=countries$new2),
    continent2=factor(continent2,levels=lvls_country)
  )

### Combine all three together into one data.frame and only keep those for which
###   the USE variables is "yes"
tmp <- dplyr::right_join(study2,res2,by="studyID") %>%
  dplyr::left_join(fish2,by="species") %>%
  dplyr::filter(USE=="yes")
### Rearrange the variables and remove USE and tech
LR <- tmp %>%
  dplyr::select(
    studyID,pubyear,country,continent,continent2,marine,exprnc,
    species,family,order,class,class1,
    structure,structure2,process,
    agemin,agemax,agemaxcat,agerange,agerangecat,
    type,R,Rcat3,Rcat4,n,ncat,
    APE,logAPE,ACV,logACV,ACVmod,logACVmod,ACVused,ACVmodused,bothACVnAPEused,
    PA0,PA1,PAother,ASD,AAD,APE2,ACV2,AD,
    checkbias,biasmethod,biaspresent,
    checkrelage,typerelage) %>%
  as.data.frame()


nms_tmp <- names(tmp)
nms_LR <- names(LR)

nms_tmp[!nms_tmp %in% nms_LR]

## Output database ----
#### As an RData object ... maintains variable types, factor order, etc.
save(LR,file="data/LitReview.RData")
#### As a CSV file ... loses structure ... don't use, just a back-up in case!
write.csv(LR,file="data/LitReview_BACKUP.csv",row.names=FALSE)
