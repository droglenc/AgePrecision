## Setup ----
cat("\014")
setwd(here::here())
library(tidyverse)
library(patchwork)

NAS <- c("-","")
lvls_type <- c("between","within","both")
lvls_strux1 <- c("otoliths","spines","finrays","scales","vertebrae","thorns","other")
lvls_strux2 <- c("sagittae","lapillae","asterisci","statoliths",
                 "anal","dorsal","pectoral","pelvic","caudal",
                 "branchiostegal rays","gular plate","metapterygoid",
                 "pectoral articulating process","scute",
                 "sphenoid")

## ggplot2 Theme ----
### Colors at http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf

fill_color <- "darkgreen"
results_text_size <- 8
ACV_limts <- c(0,70)
ACV_breaks <- seq(0,60,10)

theme_josh <- theme_classic(base_family="serif") +
  theme(panel.background=element_rect(fill="white",color="black"),
        panel.grid.major=element_line(color="gray65",linetype="dashed"),
        title=element_text(size=30,color="black",face="bold"),
        axis.title=element_text(size=36,color="black"),
        axis.text=element_text(size=32,color="black"),
        axis.title.x=element_text(margin=margin(t=10,r=0,b=0,l=0)),
        axis.title.y=element_text(margin=margin(t=0,r=10,b=0,l=0)),
        plot.margin=unit(c(10,10,10,10),"points")
        )

## Make overall database ----
fn <- googledrive::as_id("https://docs.google.com/spreadsheets/d/1RY6DQyi-zCfg_BQ2l_cZRZC_fA6PI3zutFIMIvJfbw8/edit?ts=5bac4a12#gid=0")
googledrive::drive_download(file=fn,path="data/Literature_Review",overwrite=TRUE)
fn <- "data/Literature_Review.xlsx"

## Fish names
fish <- readxl::read_excel(fn,sheet="FishNames") %>%
  select(-sciname)

## Paper results, append fish name info
tmp <- readxl::read_excel(fn,sheet="Results_Meta")
res <- readxl::read_excel(fn,sheet="Results",na=NAS,col_types=tmp$RType) %>%
  select(-notes) %>%
  left_join(fish,by="species")

## Paper info, append on results
##   get only those studies identified as useful
##   convert structure items to factors
tmp <- readxl::read_excel(fn,sheet="Study_Meta")
df <- readxl::read_excel(fn,sheet="Study",na=NAS,col_types=tmp$RType) %>%
  select(-notes,-OrigFile) %>%
  left_join(res,by="studyID") %>%
  filter(USE=="yes") %>%
  select(-USE) %>%
  mutate(type=factor(type,levels=lvls_type),
         structure=factor(structure,levels=lvls_strux1),
         structure2=factor(structure2,levels=lvls_strux2))

## Clean up
rm(tmp,fish,res,fn,NAS)

## Josh's Poster Data 1 ----
R_old <- c("2","3","4","5","6","9")
R_new <- c("2","3","4+","4+","4+","4+")
n_old <- seq(0,3200,200)
n_new <- c("0","200",rep("400+",length(n_old)-2))
strux_old <- lvls_strux1
strux_new <- c("otoliths","spines","finrays","scales","vertebrae","other","other")
class_old <- c("Actinopterygii","Elasmobranchii","Holocephali","Petromyzonti")
class_new <- c("Actinopterygii","Elasmobranchii","other","other")
loc_old <- unique(df$country)
loc_new1 <- c("USA","Asia","Aus/NZ","SCAmer","SCAmer","SCAmer","Africa","Asia",
              "Europe","Aus/NZ","Africa","Africa","Africa","Europe","SCAmer",
              "Africa","Asia","Europe","Asia","Europe","Europe","Africa",
              "Canada","Europe","Europe","Asia","Europe","Europe","Asia","Asia",
              "Asia","Europe","Europe")
loc_new2 <- c("USA/Can","Asia","Aus/NZ","other","other","Asia","USA/Can")

df1 <- df %>% 
  select(-studysite,-(exprnc:AnlyzdData),-Paother,-(ASD:dateStamp), checkrelage,typerelage,checkbias,biasmethod,biaspresent) %>%
  mutate(structure=FSA::mapvalues(structure,from=strux_old,to=strux_new),
         type=factor(type),
         class=factor(class),
         typerelage=factor(typerelage),
         class1=FSA::mapvalues(class,from=class_old,to=class_new),
         continent=FSA::mapvalues(country,from=loc_old,to=loc_new1),
         continent2=FSA::mapvalues(continent,from=unique(loc_new1),to=loc_new2),
         agemaxcat=FSA::lencat(agemax,w=10,as.fact=TRUE),
         agerange=agemax-agemin,
         agerangecat=FSA::lencat(agerange,breaks=c("0-10"=0,"10-20"=10,"20+"=20),use.names=TRUE),
         Rcat=FSA::mapvalues(factor(R),from=R_old,to=R_new),
         ncat=FSA::mapvalues(FSA::lencat(n,w=200,as.fact=TRUE),from=n_old,to=n_new),
         logAPE=log(APE),
         logACV=log(ACV),
         ACVused=factor(ifelse(!is.na(ACV),"yes","no"),levels=c("yes","no")),
         APEused=factor(ifelse(!is.na(APE),"yes","no"),levels=c("yes","no")),
         PA0used=factor(ifelse(!is.na(PA0),"yes","no"),levels=c("yes","no")),
         ACVmod=ifelse(!is.na(ACV),ACV,ifelse(!is.na(APE)&R==2,sqrt(2)*APE,NA)),
         logACVmod=log(ACVmod),
         ACVmodused=factor(ifelse(!is.na(ACVmod),"yes","no"),levels=c("yes","no")),
         bothACVnAPEused=factor(ifelse(!is.na(ACV) & !is.na(APE),"yes","no"),
                                levels=c("yes","no")))

## Initial Summaries ----
## How many studies remain
length(unique(df1$studyID))

## ACV Overall Summary
hist(~ACVmod,data=df1,w=2)
FSA::Summarize(~ACVmod,data=df1,digits=2)

## What years did they come from
tmp <- unique(df1[,c("studyID","pubyear")])
hist(~pubyear,data=tmp,w=1)
( pubyr_tbl <- xtabs(~pubyear,data=tmp) )
FSA::rcumsum(pubyr_tbl)

### Very few "other" class fish
xtabs(~class1,data=df1)

### Delete the "both" types of studies
xtabs(~type,data=df1)

xtabs(~country,data=df1)
xtabs(~continent,data=df1)
xtabs(~continent2,data=df1)

xtabs(~R,data=df1)

hist(~n,data=df1,w=200)
xtabs(~ncat,data=df1)

hist(~agemax,data=df1,w=2)
hist(~agerange,data=df1,w=2)
FSA::Summarize(~agerange,data=df1,digits=1)
xtabs(~agerangecat,data=df1)
sum(is.na(df1$agerangecat))

### Eight results had ACV=0 ... probably look at these more closely and probably
###   delete or add a small amount if we model with logs
summary(df1$ACV)
summary(df1$ACVmod)
df1[which(df1$ACVmod==0),c("studyID","species","structure")]


plot(ACVmod~agerange,data=df1)
plot(logACVmod~log(agerange),data=df1)
plot(ACVmod~n,data=df1)
plot(logACVmod~log(n),data=df1)


## Results #####################################################################
## Studies Used ACV ----
### Number of studies since Campana (2001) (so, >2001) that used the ACV
tmp <- filter(df1,pubyear>2001)
nrow(tmp)  # results since 2001

### Compute the percentage of recordings for each study that used the ACV ... a
###   value greater than 0 indicates that they used the ACV at least once
tmp2 <- tmp %>%
  group_by(continent2,studyID) %>%
  summarise(pct=sum(ACVused=="yes")/n()) %>%
  mutate(ACVused=factor(ifelse(pct>0,"yes","no"),levels=c("yes","no")))
nrow(tmp2)  # studies since 2001
( studies_that_used_ACV <- xtabs(~ACVused,data=tmp2) ) 
NCStats::percTable(studies_that_used_ACV,digits=1)

( used_ACV_by_continent <- xtabs(~continent2+ACVused,data=tmp2) )
NCStats::percTable(used_ACV_by_continent,margin=1,digits=1)


( chi_ACV_by_continent <- chisq.test(used_ACV_by_continent) )

#APE since Campana
tmp3 <- tmp %>%
  group_by(continent2,studyID) %>%
  summarise(pctape=sum(APEused=="yes")/n()) %>%
  mutate(APEused=factor(ifelse(pctape>0,"yes","no"),levels=c("yes","no")))
nrow(tmp3)  # studies since 2001
( studies_that_used_APE <- xtabs(~APEused,data=tmp3) ) 
NCStats::percTable(studies_that_used_APE,digits=1)

#PA0 since Campana
tmp4 <- tmp %>%
  group_by(continent2,studyID) %>%
  summarise(pctPA0=sum(PA0used=="yes")/n()) %>%
  mutate(PA0used=factor(ifelse(pctPA0>0,"yes","no"),levels=c("yes","no")))
nrow(tmp4)  # studies since 2001
( studies_that_used_PA0 <- xtabs(~PA0used,data=tmp4) ) 
NCStats::percTable(studies_that_used_PA0,digits=1)

#APEnACV since Campana
tmp5 <- tmp %>%
  group_by(continent2,studyID) %>%
  summarise(pctb=sum(bothACVnAPEused=="yes")/n()) %>%
  mutate(bothACVnAPEused=factor(ifelse(pctb>0,"yes","no"),levels=c("yes","no")))
nrow(tmp5)  # studies since 2001
( studies_that_used_both <- xtabs(~bothACVnAPEused,data=tmp5) ) 
NCStats::percTable(studies_that_used_both,digits=1)

#Check relationship with age?
tmp6 <- df1 %>%
  group_by(continent2,studyID) %>%
  summarise(pctr=sum(checkrelage=="yes")/n()) %>%
  mutate(checkrelage=factor(ifelse(pctr>0,"yes","no"),levels=c("yes","no")))
nrow(tmp6)  # studies
( studies_that_used_relage <- xtabs(~checkrelage,data=tmp6) ) 
NCStats::percTable(studies_that_used_relage,digits=1)

#Only Studies that checked relage ACV
tmp7 <- filter(df1,checkrelage=="yes")
tmp7a <- tmp7 %>%
  group_by(continent2,studyID) %>%
  summarise(pct=sum(ACVused=="yes")/n()) %>%
  mutate(ACVused=factor(ifelse(pct>0,"yes","no"),levels=c("yes","no")))
nrow(tmp7a)  # studies
( studies_that_used_ACV <- xtabs(~ACVused,data=tmp7a) ) 
NCStats::percTable(studies_that_used_ACV,digits=1)

#Relage APE
tmp7b <- tmp7 %>%
  group_by(continent2,studyID) %>%
  summarise(pctape=sum(APEused=="yes")/n()) %>%
  mutate(APEused=factor(ifelse(pctape>0,"yes","no"),levels=c("yes","no")))
nrow(tmp7b)  # studies 
( studies_that_used_APE <- xtabs(~APEused,data=tmp7b) ) 
NCStats::percTable(studies_that_used_APE,digits=1)

#Relage PA0
tmp7c <- tmp7 %>%
  group_by(continent2,studyID) %>%
  summarise(pctPA0=sum(PA0used=="yes")/n()) %>%
  mutate(PA0used=factor(ifelse(pctPA0>0,"yes","no"),levels=c("yes","no")))
nrow(tmp7c)  # studies
( studies_that_used_PA0 <- xtabs(~PA0used,data=tmp7c) ) 
NCStats::percTable(studies_that_used_PA0,digits=1)

#Typerelage
(freq1 <- xtabs(~typerelage,data=tmp7))

#Check Bias
tmp8 <- filter(df1,checkbias=="yes")
nrow(tmp8)
tmp8a <- tmp8 %>%
  group_by(continent2,studyID,checkbias) %>%
  summarise(pct=sum(ACVused=="yes")/n()) %>%
  mutate(ACVused=factor(ifelse(pct>0,"yes","no"),levels=c("yes","no")))
nrow(tmp8a)  # studies
( studies_that_used_ACV <- xtabs(~ACVused,data=tmp8a) ) 
NCStats::percTable(studies_that_used_ACV,digits=1)

#BiasMethod
(freq2 <- xtabs(~biasmethod,data=tmp8))
(freq3 <- xtabs(~biaspresent,data=tmp8))



### Note: I checked papers that did not use ACV for each comp, they were OK
tmp2[tmp2$pct>0 & tmp2$pct<1,]

### Percent of comparisons that used both APE and ACV
NCStats::percTable(xtabs(~ACVused+bothACVnAPEused,data=tmp),margin=1,digits=1)


## Overall ACV ----
df1a <- filter(df1,!is.na(ACVmod))

tmp <- FSA::Summarize(~ACVmod,data=df1a,digits=2)

ACV <- ggplot(df1a,aes(x=ACVmod)) +
  geom_density(fill=fill_color) +
  geom_vline(xintercept=tmp[["median"]],color="white",lwd=1) +
  geom_text(label=paste0("Median ACV = ",formatC(tmp[["median"]],format="f",digits=1),"%"),
            x=Inf,y=Inf,hjust=1.2,vjust=1.2,size=results_text_size) +
  scale_x_continuous(name="",expand=c(0.01,0),
                     limits=ACV_limts,breaks=ACV_breaks) +
  scale_y_continuous(name="Relative Density",expand=c(0,0),
                     limits=c(0,0.061),breaks=c(0,0.06)) +
  ggtitle("A: Overall")
ACV


## Between/Within ----
df2 <- filter(df1,!is.na(ACVmod))
df2a <- filter(df2,type!="both")

wilcox.test(ACVmod~type,data=df2a)
( BW.KW <- kruskal.test(ACVmod~type,data=df2a) )

BWsum <- group_by(df2a,type) %>%
  summarize(n=n()) %>%
  mutate(ACVmod=Inf,
         lets=c("",""),
         lbl=paste0("\nn=",n,"  ",lets," "))

BWcomp <- ggplot(data=df2a,aes(x=type,y=ACVmod)) +
  geom_violin(fill=fill_color,draw_quantiles=c(0.5),lwd=1,color="white") +
  geom_violin(fill=NA,draw_quantiles=c(0.25,0.75),lwd=1) +
  scale_y_continuous(name="",expand=c(0.01,0),
                     limits=ACV_limts,breaks=ACV_breaks) +
  scale_x_discrete(name="",labels=c("Between\nReader","Within\nReader")) +
  geom_text(data=BWsum,aes(x=type,y=ACVmod,label=lbl),size=results_text_size,hjust=1.1) +
  geom_text(label=paste0("K-W ",FSA::kPvalue(BW.KW$p.value,latex=FALSE,digits=3)),
            x=Inf,y=Inf,hjust=1.2,vjust=1.2,size=results_text_size) +
  coord_flip() +
  ggtitle("B: Comparison Type")
BWcomp


#### No difference in between and within so don't separate, and continue to
#### include the results where type=="both" ... so use df2 going forward

## Class ----
df2c <- filter(df2,class1!="other")
(Class.KW <- kruskal.test(ACVmod~class1,data=df2c) )
FSA::Summarize(ACVmod~class1,data=df2c,digits=1)

Classsum <- group_by(df2c,class) %>%
  summarize(n=n()) %>%
  mutate(ACVmod=Inf,
         lets=c("",""),
         lbl=paste0("\nn=",n,"  ",lets," "))

Classcomp <- ggplot(data=df2c,aes(x=class,y=ACVmod)) +
  geom_violin(fill=fill_color,draw_quantiles=c(0.5),lwd=1,color="white") +
  geom_violin(fill=NA,draw_quantiles=c(0.25,0.75),lwd=1) +
  scale_y_continuous(name="",expand=c(0.01,0),
                     limits=ACV_limts,breaks=ACV_breaks) +
  scale_x_discrete(name="",labels=c("Actinop-\nterygii","Elasmo-\nbranchii")) +
  geom_text(data=Classsum,aes(x=class,y=ACVmod,label=lbl),size=results_text_size,hjust=1.1) +
  geom_text(label=paste0("K-W ",FSA::kPvalue(Class.KW$p.value,latex=FALSE,digits=3)),
            x=Inf,y=Inf,hjust=1.2,vjust=1.2,size=results_text_size) +
  coord_flip() +
  ggtitle("C: Class of Fish")
Classcomp


## R ----
( R.KW <- kruskal.test(ACVmod~Rcat,data=df2) )
FSA::dunnTest(ACVmod~Rcat,data=df2)
FSA::Summarize(ACVmod~Rcat,data=df2,digits=1)

Rsum <- group_by(df2,Rcat) %>%
  summarize(n=n()) %>%
  mutate(ACVmod=Inf,
         lets=c("A","B","AB"),
         lbl=paste0("\nn=",n,"  ",lets," "))

Rcomp <- ggplot(data=df2,aes(x=Rcat,y=ACVmod)) +
  geom_violin(fill=fill_color,draw_quantiles=c(0.5),lwd=1,color="white") +
  geom_violin(fill=NA,draw_quantiles=c(0.25,0.75),lwd=1) +
  scale_y_continuous(name="ACV (%)",expand=c(0.01,0),
                     limits=ACV_limts,breaks=ACV_breaks) +
  scale_x_discrete(name="") +
  geom_text(data=Rsum,aes(x=Rcat,y=ACVmod,label=lbl),size=results_text_size,hjust=1) +
  geom_text(label=paste0("K-W ",FSA::kPvalue(R.KW$p.value,latex=FALSE,digits=3)),
            x=Inf,y=Inf,hjust=1.2,vjust=1.2,size=results_text_size) +
  coord_flip() +
  ggtitle("D: # of Readings")
Rcomp


## Age ----
df2b <- filter(df2,!is.na(agerangecat))
( Age.KW <- kruskal.test(ACVmod~agerangecat,data=df2b) )
FSA::dunnTest(ACVmod~agerangecat,data=df2b)
FSA::Summarize(ACVmod~agerangecat,data=df2b,digits=1)

AGEsum <- group_by(df2b,agerangecat) %>%
  summarize(n=n()) %>%
  mutate(ACVmod=Inf,
         lets=c("A","B","B"),
         lbl=paste0("\nn=",n,"  ",lets," "))

Agecomp <- ggplot(data=df2b,aes(x=agerangecat,y=ACVmod)) +
  geom_violin(fill=fill_color,draw_quantiles=c(0.5),lwd=1,color="white") +
  geom_violin(fill=NA,draw_quantiles=c(0.25,0.75),lwd=1) +
  scale_y_continuous(name="ACV (%)",expand=c(0.01,0),
                     limits=ACV_limts,breaks=ACV_breaks) +
  scale_x_discrete(name="") +
  geom_text(data=AGEsum,aes(x=agerangecat,y=ACVmod,label=lbl),size=results_text_size,hjust=1.1) +
  geom_text(label=paste0("K-W ",FSA::kPvalue(Age.KW$p.value,latex=FALSE,digits=3)),
            x=Inf,y=Inf,hjust=1.2,vjust=1.2,size=results_text_size) +
  coord_flip() +
  ggtitle("E: Range of Ages")
Agecomp

## Structure ----
df2d <- filter(df2,!is.na(structure),structure!="other") %>%
  mutate(structure=factor(structure,
                          levels=c("otoliths","spines","finrays","vertebrae","scales")))
( Strux.KW <- kruskal.test(ACVmod~structure,data=df2d) )
FSA::dunnTest(ACVmod~structure,data=df2d)
FSA::Summarize(ACVmod~structure,data=df2d)

Struxsum <- group_by(df2d,structure) %>%
  summarize(n=n()) %>%
  mutate(ACVmod=Inf,
         lets=c("A","B","B","B","C"),
         lbl=paste0("\nn=",n,"  ",lets," "))

Struxcomp <- ggplot(data=df2d,aes(x=structure,y=ACVmod)) +
  geom_violin(fill=fill_color,draw_quantiles=c(0.5),lwd=1,color="white") +
  geom_violin(fill=NA,draw_quantiles=c(0.25,0.75),lwd=1) +
  scale_y_continuous(name="ACV (%)",expand=c(0.01,0),
                     limits=ACV_limts,breaks=ACV_breaks) +
  scale_x_discrete(name="") +
  geom_text(data=Struxsum,aes(x=structure,y=ACVmod,label=lbl),size=results_text_size,hjust=1.1) +
  geom_text(label=paste0("K-W ",FSA::kPvalue(Strux.KW$p.value,latex=FALSE,digits=3)),
            x=Inf,y=Inf,hjust=1.2,vjust=1.2,size=results_text_size) +
  coord_flip() +
  ggtitle("F: Structure")
Struxcomp


## Plots Together ----
dmnsn <- 7
ncol <- 3
nrow <- 2
ACV + BWcomp + Classcomp + Rcomp + Agecomp + Struxcomp +
  plot_layout(ncol=ncol,nrow=nrow) & theme_josh
ggsave("analysis/AFSPoster/PosterPlots.png",width=ncol*dmnsn,height=nrow*dmnsn,units="in")

#APE Summaries

df1APE <- filter(df1,!is.na(APE))

tmp <- FSA::Summarize(~APE,data=df1APE,digits=2)
tmp

APE <- ggplot(df1APE,aes(x=APE)) +
  geom_density(fill=fill_color) +
  geom_vline(xintercept=tmp[["median"]],color="white",lwd=1) +
  geom_text(label=paste0("Median APE = ",formatC(tmp[["median"]],format="f",digits=1),"%"),
            x=Inf,y=Inf,hjust=1.2,vjust=1.2,size=results_text_size) +
  scale_x_continuous(name="",expand=c(0.01,0),
                     limits=ACV_limts,breaks=ACV_breaks) +
  scale_y_continuous(name="Relative Density",limits=c(0,0.1),breaks=c(0,0.1)) +
  ggtitle("Overall")
APE
----------------------------------
APE <- ggplot(df1APE,aes(x=APE)) +
  geom_density(fill=fill_color) +
  geom_vline(xintercept=tmp[["median"]],color="white",lwd=1) +
  geom_text(label=paste0("Median APE = ",formatC(tmp[["median"]],format="f",digits=1),"%"),
            x=Inf,y=Inf,hjust=1.2,vjust=1.2,size=results_text_size) +
  scale_x_continuous(name="",expand=c(0.01,0),
                     limits=ACV_limts,breaks=ACV_breaks) +
  scale_y_continuous(name="Relative Density",expand=c(0,0),
                     limits=c(0,0.061),breaks=c(0,0.06)) +
  ggtitle("A: Overall")
