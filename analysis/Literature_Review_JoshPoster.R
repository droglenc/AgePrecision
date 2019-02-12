cat("\014")
setwd(here::here())
library(plyr)
library(dplyr)
library(magrittr)

fn <- googledrive::as_id("https://docs.google.com/spreadsheets/d/1RY6DQyi-zCfg_BQ2l_cZRZC_fA6PI3zutFIMIvJfbw8/edit?ts=5bac4a12#gid=0")
googledrive::drive_download(file=fn,path="data/Literature_Review",overwrite=TRUE)

## Make the overall database
##   Read fish names
fish <- readxl::read_excel("data/Literature_Review.xlsx",sheet="FishNames") %>%
  select(-sciname)
##   Read results and append on fish name info
tmp <- readxl::read_excel("data/Literature_Review.xlsx",sheet="Results_Meta")
res <- readxl::read_excel("data/Literature_Review.xlsx",sheet="Results",
                          na=c("-",""),col_types=tmp$RType) %>%
  select(-notes)
res <- left_join(res,fish,by="species")
##   Read study info and append on results
tmp <- read_excel("data/Literature_Review.xlsx",sheet="Study_Meta")
df <- read_excel("data/Literature_Review.xlsx",sheet="Study",
                    na=c("-",""),col_types=tmp$RType) %>%
  select(-notes,-OrigFile)
df <- left_join(df,res,by="studyID") %>%
  filter(USE=="yes") %>%
  select(-USE) %>%
  mutate(structure=factor(structure,levels=c("otoliths","spines","finrays",
                                             "scales","vertebrae","thorns",
                                             "other")),
         structure2=factor(structure2,levels=c("sagittae","lapillae","asterisci","statoliths",
                                               "anal","dorsal","pectoral","pelvic","caudal",
                                               "branchiostegal rays","gular plate","metapterygoid",
                                               "pectoral articulating process","scute",
                                               "sphenoid")))
##   Clean up
rm(tmp,fish,res,fn)


#Filter and Manipulation
library(FSA)
library(magrittr)
library(ggplot2)
library(plotly)
library(NCStats)
library(multcomp)
str(df)

df %<>% mutate(agemaxcat=lencat(agemax,w=10)) %>%
  mutate(agerange=(agemax-agemin)) %>%
  mutate(agecat=lencat(agerange,w=10)) %>%
  mutate(R=factor(R)) %>%
  mutate(agecat=factor(agecat)) %>%
  mutate(agemaxcat=factor(agemaxcat)) %>%
  mutate(logAPE=log(APE)) %>%
  mutate(logACV=log(ACV)) %>%
  mutate(ncat=lencat(n,w=200)) %>%
  mutate(type=factor(type))%>%
  mutate(class=factor(class))
df %<>% mutate(ACVmod=ifelse(!is.na(ACV),ACV,ifelse(!is.na(APE)&R==2,sqrt(2)*APE,NA))) %>%
  mutate(logACVmod=log(ACVmod))
df %<>% mutate(ACVcheck=ifelse(!is.na(ACV),"yes","no"))
df %<>% mutate(ACVmodcheck=ifelse(!is.na(ACVmod),"yes","no"))

old <- c("2","3","4","5","6","9")
new <- c("2","3","4+","4+","4+","4+")
df %<>% mutate(Rcat=mapvalues(R,from=old,to=new))

oldn <- c("0","200","400","600","800","1000","1200","1400","1600","1800","2000","2200","2800","3200")
newn <- c("0","200","400+","400+","400+","400+","400+","400+","400+","400+","400+","400+","400+","400+")
df %<>% mutate(truencat=mapvalues(ncat,from=oldn,to=newn))

olds <- c("otoliths","spines","finrays","scales","vertebrae","thorns","other")
news <- c("otoliths","spines","finrays","scales","vertebrae","other","other")
df %<>% mutate(truestructure=mapvalues(structure,from=olds,to=news))

dfr2 <- filterD(df,R==2)

dfoto <- filterD(df,structure=="otoliths")
dfoto <- filterD(dfoto,process=="sectioned" | process=="whole")

dfbw <- filterD(df,type=="between" | type=="within")
dfb <- filterD(df,type=="between")
dfw <- filterD(df,type=="within")
dfob <- filterD(dfoto,type=="between")
dfow <- filterD(dfoto,type=="within")

dftc <- filterD(df,class=="Actinopteri" | class=="Elasmobranchii")

dfacv <- filterD(df,ACVcheck=="yes")
dfacv1 <- filterD(df,ACV>0)

dfamod <- filterD(df,ACVmodcheck=="yes")
dfamod1 <- filterD(df,ACVmod>0)
dftype <- filterD(dfamod1,type=="between" | type=="within")
dfamod1class <- filterD(dfamod1,class=="Actinopteri" | class=="Elasmobranchii") 


#GGPlot

#APE vs ACV by Rcat
qplot(APE,ACV,data=df,geom=c("point","smooth"),alpha=I(.5),
      method="lm",formula=y~x, color=Rcat,
      main="ACV vs APE",
      xlab="ACV",ylab="APE")
qplot(logAPE,ACV,data=df,geom=c("point","smooth"),alpha=I(.5),
      method="lm",formula=y~x, color=Rcat,
      xlab="ACV",ylab="logAPE")
qplot(logAPE,logACV,data=df,geom=c("point","smooth"),alpha=I(.5),
      method="lm",formula=y~x, color=Rcat,
      xlab="logACV",ylab="logAPE")
qplot(APE,ACV,data=dfr2,geom=c("point","smooth"),alpha=I(.5),
      method="lm",formula=y~x,
      xlab="ACV",ylab="APE")

#Boxplot of precision metrics by agecat
qplot(agecat,APE,data=df,geom=c("boxplot","jitter"),fill=agecat,
      main="APE by Age Range Category",xlab="",ylab="APE")
qplot(agecat,ACV,data=df,geom=c("boxplot","jitter"),fill=agecat,
      main="ACV by Age Range Category",xlab="",ylab="ACV")
qplot(agecat,PA0,data=df,geom=c("boxplot","jitter"),fill=agecat,
      main="PA0 by Age Range Category",xlab="",ylab="PA0")

#Density Plot by Rcat

mu <- ddply(df,"Rcat",summarise,grp.mean=mean(APE))
head(mu)
p <- ggplot(df,aes(x=APE,color=Rcat)) + geom_density() +
  geom_vline(data=mu,aes(xintercept=grp.mean,color=Rcat),linetype="dashed")
p

mu1 <- ddply(df,"Rcat",summarise,grp.mean=mean(ACV))
head(mu2)
p1 <- ggplot(df,aes(x=ACV,color=Rcat)) + geom_density() +
  geom_vline(data=mu1,aes(xintercept=grp.mean,color=Rcat),linetype="dashed")
p1

mu2 <- ddply(df,"truencat",summarise,grp.mean=mean(ACV))
head(mu2)
p2 <- ggplot(df,aes(x=ACV,color=truencat)) + geom_density() +
  geom_vline(data=mu2,aes(xintercept=grp.mean,color=truencat),linetype="dashed")
p2

mu3 <- ddply(df,"class",summarise,grp.mean=mean(ACVmod))
p3 <- ggplot(df,aes(x=ACVmod,color=class)) + geom_density() 
p3

p3w <- ggplot(dfw,aes(x=ACVmod,color=class)) + geom_density() 
p3w

p3b <- ggplot(dfb,aes(x=ACVmod,color=class)) + geom_density() 
p3b

mu4 <- ddply(df,"marine",summarise,grp.mean=mean(ACV))
head(mu4)
p4 <- ggplot(df,aes(x=ACV,color=marine)) + geom_density() +
  geom_vline(data=mu4,aes(xintercept=grp.mean,color=marine),linetype="dashed")
p4

mu5 <- ddply(dfacv,"truestructure",summarise,grp.mean=mean(ACV))
head(mu5)
p5 <- ggplot(df,aes(x=ACVmod,color=truestructure)) + geom_density()
p5

p5w <- ggplot(dfw,aes(x=ACVmod,color=truestructure)) + geom_density()
p5w

p5b <- ggplot(dfb,aes(x=ACVmod,color=truestructure)) + geom_density()
p5b

mu6 <- ddply(dfoto,"process",summarise,grp.mean=mean(ACV))
head(mu5)
p6<- ggplot(dfoto,aes(x=ACVmod,color=process)) + geom_density() 
p6

p6w<- ggplot(dfow,aes(x=ACVmod,color=process)) + geom_density() 
p6w

p6b<- ggplot(dfob,aes(x=ACVmod,color=process)) + geom_density() 
p6b

p7<- ggplot(dftype,aes(x=ACVmod,color=type)) + geom_density() 
p7

#Analysis
summary(df$ACV)

#ACVCheck by Class
 
(ACVclass <- xtabs(~class+ACVcheck,data=dftc))
chisq.test(ACVclass,correct=FALSE)
round(prop.table(ACVclass,margin=1)*100,digits=1)

#ACVCheck by Structure
(ACVstruc <- xtabs(~truestructure+ACVcheck,data=df))
round(prop.table(ACVstruc,margin=1)*100,digits=1)
chisq.test(ACVstruc,correct=FALSE)
(mc <- c(chisq.test(ACVstruc[1:2,])$p.value,
        chisq.test(ACVstruc[1:3,])$p.value,
        chisq.test(ACVstruc[1:4,])$p.value,
        chisq.test(ACVstruc[1:5,])$p.value,
        chisq.test(ACVstruc[1:6,])$p.value,
        chisq.test(ACVstruc[2:3,])$p.value,
        chisq.test(ACVstruc[2:4,])$p.value,
        chisq.test(ACVstruc[2:5,])$p.value,
        chisq.test(ACVstruc[2:6,])$p.value,
        chisq.test(ACVstruc[3:4,])$p.value,
        chisq.test(ACVstruc[3:5,])$p.value,
        chisq.test(ACVstruc[3:6,])$p.value,
        chisq.test(ACVstruc[4:5,])$p.value,
        chisq.test(ACVstruc[4:6,])$p.value,
        chisq.test(ACVstruc[5:6,])$p.value))
p.adjust(mc)

#ACV by R

lm <- lm(ACV~Rcat,data=dfacv1)
anova(lm)
cbind(Ests=coef(lm),confint(lm))
transChooser(lm)
lm.mc <- glht(lm,mcp(Rcat="Tukey"))
summary(lm.mc)
fitPlot(lm,xlab="Rcat",ylab="ACV",main="",ylim=c(0,20))
addSigLetters(lm,lets=c("a","b","ab"),pos=c(2,2,4))

#ACVmod by type

lm1 <- lm(ACVmod~type,data=dftype)
anova(lm1)
transChooser(lm1)
lm1.mc <- glht(lm1,mcp(type="Dunnet"))
summary(lm1.mc)
fitPlot(lm1,xlab="Type",ylab="ACVmod",main="",ylim=c(0,12))
addSigLetters(lm1,lets=c("a","a"),pos=c(2,4))

lm1a <- lm(logACVmod~type,data=dftype)
anova(lm1a)
transChooser(lm1a)
lm1a.mc <- glht(lm1a,mcp(type="Dunnet"))
summary(lm1a.mc)
fitPlot(lm1a,xlab="Type",ylab="logACVmod",main="")
addSigLetters(lm1a,lets=c("a","a"),pos=c(2,4))

#ACVmod by class

lm2 <- lm(ACVmod~class,data=dfamod1class)
anova(lm2)
transChooser(lm2)
lm2.mc <- glht(lm2,mcp(class="Tukey"))
summary(lm2.mc)
fitPlot(lm2,xlab="Class",ylab="ACVmod",main="",ylim=c(0,12))
addSigLetters(lm2,lets=c("a","a"),pos=c(2,4))

lm2a <- lm(logACVmod~class,data=dfamod1class)
anova(lm2a)
transChooser(lm2a)
lm2a.mc <- glht(lm2a,mcp(class="Tukey"))
summary(lm2a.mc)
fitPlot(lm2a,xlab="Class",ylab="logACVmod",main="")
addSigLetters(lm2a,lets=c("a","b"),pos=c(2,4))

#ACVmod by structure 

lm3 <- lm(ACVmod~truestructure,data=dfamod1)
anova(lm3)
transChooser(lm3)
lm3.mc <- glht(lm3,mcp(truestructure="Tukey"))
summary(lm3.mc)
fitPlot(lm3,xlab="Structure",ylab="ACVmod",main="",ylim=c(0,17))
addSigLetters(lm3,lets=c("a","ab","b","c","b","b"),pos=c(2,2,4,4,2,4))

lm4 <- lm(logACVmod~truestructure,data=dfamod1)
anova(lm4)
transChooser(lm4)
lm4.mc <- glht(lm4,mcp(truestructure="Tukey"))
summary(lm4.mc)
fitPlot(lm4,xlab="Structure",ylab="logACVmod",main="",ylim=c(0,3))
addSigLetters(lm4,lets=c("a","b","b","c","b","bc"),pos=c(2,2,4,4,2,4))

#Pubyear analysis

hist(~pubyear,data=df,w=1)
