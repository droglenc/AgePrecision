cat("\014")
setwd(here::here())
library(FSA)
library(ggplot2)
library(plyr)
library(dplyr)
options(show.signif.stars=FALSE)

## Get the literature review database ----
load("data/LitReview.RData")
str(LR)
    
#between mu=8.97077467
#within mu=8.61909967

clrs1 <- c("navyblue","gold4")
clrs2 <- c("#5aB4ac","#d8b365")
clrs3 <- c("#67a9cf","#ef8a62")

#### A consistent theme
theme_Gordy <- theme_bw() +
  theme(panel.grid.minor=element_line(linetype="dashed",color="gray95"),
        panel.grid.major=element_line(linetype="dashed",color="gray95"),
        strip.text=element_text(color="white",face="bold"),
        strip.background=element_rect(fill="black",linetype="solid",size=1.5),
        panel.border=element_rect(colour="black",linetype="solid",size=1),
        legend.background=element_blank(),
        legend.key.size=unit(3,"mm"),
        axis.title=element_text(face="bold",size=9),
        legend.title=element_blank(),
        legend.text=element_text(face="bold",size=9),
        aspect.ratio=1)

## Filter LRP object
LRP <- LR %>% 
  filter(class == "Actinopteri",
        !is.na(structure),structure != "other",structure != "vertebrae",
        !is.na(type),type != "both",
        agemax >  2,
        agemax < 100,
        !is.na(Rcat3),Rcat3 == 2,
        !is.na(ACVmod0)) %>%
  mutate(structurep=plyr::mapvalues(structure,
                                      from=c("otoliths","spines",
                                               "finrays","scales"),
                                      to=c("Otoliths","Spines+Finrays",
                                             "Spines+Finrays","Scales")),
         type=plyr::mapvalues(type,from=c("between","within"),
                                to=c("Between","Within")),
         logagemax=log(agemax)) %>%
  select(studyID,structure,structurep,type,ACVmod0,agemax,logACVmod,logagemax)



## Distribution of ACV values ... Objective 1 of poster ----
#### Summarize means by type and structure to put on the plot
mu <- LRP %>%
  group_by(type,structurep) %>%
  dplyr::summarize(n=n(),
                   mn=mean(ACVmod0,na.rm=TRUE))

#### Make the plot
ggplot(data=LRP,mapping=aes(x=ACVmod0,colour=type,fill=type)) +
  geom_density(alpha=0.3) +
  geom_vline(data=mu,mapping=aes(xintercept=mn,colour=type),
             linetype="dashed", size=0.5,show.legend=FALSE) +
  scale_x_continuous(name="Average Coefficient of Variation",
                     expand=expansion(mult=c(0,0)),limits=c(0,NA)) +
  scale_y_continuous(name="Relative Density",
                     expand=expansion(mult=c(0,0.05))) +
  scale_color_manual(values=clrs1) +
  scale_fill_manual(values=clrs1) +
  facet_grid(cols=vars(structurep)) +
  theme_Gordy +
  theme(legend.position=c(0.25,0.9),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())

ggsave("posterfigure1.png",width=6,height=3,dpi=600,units="in")

#### Two-way ANOVA of Results
aov2w <- lm(ACVmod0~structurep+type+structurep:type,data=LRP)

NCStats::assumptionCheck(aov2w)               # no good
NCStats::assumptionCheck(aov2w,lambday=0)     # OK, not great
NCStats::assumptionCheck(aov2w,lambday=0.25)  # Better, hard to explain

aov2wt <- lm(logACVmod~structurep+type+structurep:type,data=LRP)
anova(aov2wt) ## no interaction, no type main effect

aov2wt_noint <- lm(logACVmod~structurep+type,data=LRP)
aov2wt_mc <- emmeans::emmeans(aov2wt_noint,specs=pairwise~structurep,tran="log")
summary(aov2wt_mc,type="response")  ## otos differ, others don't

Summarize(ACVmod0~structurep,data=LRP,digits=1) # get means for poster



## ACV and Max Age relationship (Just structure) ... Objective 2 of poster ----
## Make plot
ggplot(data=LRP,mapping=aes(x=agemax,y=ACVmod0,color=type,fill=type)) +
  geom_point(size=0.5,alpha=0.5) +
  scale_y_continuous(name="Average Coefficient of Variation",trans="log",
                     breaks=c(0.5,1,5,10,25,50)) +
  scale_x_continuous(name="Maximum Age",trans="log",breaks=c(5,10,25,50,75)) +
  scale_color_manual(values=clrs1) +
  scale_fill_manual(values=clrs1) +
  geom_smooth(method="lm",se=TRUE,alpha=0.5) +
  facet_grid(cols=vars(structurep)) +
  theme_Gordy +  
  theme(legend.position=c(0.85,0.1),
        legend.direction="horizontal")

ggsave("posterfigure2.png",width=6,height=3,units="in")


## IVR analysis
#### Just Between first
LRPb <- filter(LRP,type=="Between")

ivr1b <- lm(logACVmod~logagemax+structurep+logagemax:structurep,data=LRPb)
car::Anova(ivr1b) # slightly different slopes

ivr1b.mc <- emmeans::emtrends(ivr1b,specs=pairwise~structurep,var="logagemax")
summary(ivr1b.mc,infer=TRUE) # Otos and S+F differ, nothing else; S+F not flat


LRPw <- filter(LRP,type=="Within")

ivr1w <- lm(logACVmod~logagemax+structurep+logagemax:structurep,data=LRPw)
car::Anova(ivr1w) # no different slopes or intercepts

slr1w <- lm(logACVmod~logagemax,data=LRPw)
summary(slr1w)  # significant negative slope







## ACV and Max Age relationship (type+structure ... FAIL) ... Objective 2 of poster ----

## Make plot
ggplot(data=LRP,mapping=aes(x=agemax,y=ACVmod0,color=type,fill=type)) +
  geom_point(size=0.5,alpha=0.5) +
  scale_y_continuous(name="Average Coefficient of Variation",trans="log",
                     breaks=c(0.5,1,5,10,25,50)) +
  scale_x_continuous(name="Maximum Age",trans="log",breaks=c(5,10,25,50,75)) +
  scale_color_manual(values=clrs1) +
  scale_fill_manual(values=clrs1) +
  geom_smooth(method="lm",se=TRUE,alpha=0.5) +
  facet_grid(cols=vars(structurep)) +
  theme_Gordy +  
  theme(legend.position=c(0.85,0.1),
        legend.direction="horizontal")

ggsave("posterfigure2.png",width=6,height=3,units="in")


## IVR analysis
ivr1 <- lm(logACVmod~logagemax+type+structurep+
             logagemax:type+logagemax:structurep+
             type:structurep+logagemax:type:structurep,data=LRP)
car::Anova(ivr1) # last two not significant

ivr1a <- lm(logACVmod~logagemax+type+structurep+
              type:logagemax+structurep:logagemax,data=LRP)
car::Anova(ivr1a)

newdf <- expand.grid(logagemax=log(c(1,75)),
                     structurep=c("Otoliths","Spines+Finrays","Scales"),
                     type=c("Between","Within")) %>%
  mutate(logACVmod=predict(ivr1a,newdata=.))

ggplot(data=newdf,mapping=aes(x=logagemax,y=logACVmod,color=type)) +
  geom_line() +
  facet_wrap(vars(structurep))
newdf

coef(ivr1a)

mc1 <- emmeans::emtrends(lm1,specs=pairwise~type:structurep,var="logagemax")
summary(mc1,infer=TRUE)


LRP2 <- LRP %>%
  mutate(comb=structurep:type)

lm3 <- lm(logACVmod~logagemax+comb+logagemax:comb,data=LRP2)
anova(lm3)
mc2 <- emmeans::emtrends(lm3,specs=pairwise~comb,var="logagemax")
summary(mc2,infer=TRUE)


###XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX####

## Look at relationship between Fish Age Max and ACV by type
pt <-ggplot(data=LRP) +
  geom_point(size=0.5) +
  scale_y_continuous(name="ACV") +
  scale_x_continuous(name="Age Max",trans="log",breaks=c(1,5,10,20,50,100,150)) +
  theme_bw() +  
  theme(panel.grid.minor=element_blank())
pt

#Describe Relationship
pt + geom_smooth(method="lm",se=FALSE)

pt + geom_smooth(method="gam")

pt + geom_smooth(method="loess",se=FALSE)
## Look at relationship between Fish Age Max and ACV by marine (yes/no)
pm <- ggplot(data=LR,mapping=aes(x=agemax,y=ACV,color=marine)) +
  geom_point(size=0.5) +
  scale_y_continuous(name="ACV") +
  scale_x_continuous(name="Age Max",trans="log",breaks=c(1,5,10,20,50,100,150)) +
  theme_bw() +  
  theme(panel.grid.minor=element_blank())
pm

#Describe Relationship
pm + geom_smooth(method="gam",se=FALSE)

pm + geom_smooth(method="loess",se=FALSE)

## Look at relationship between Fish Age Max and ACV by class
pc <- ggplot(data=filter(LR,!is.na(class),class != "Petromyzonti",class != "Holocephali"),mapping=aes(x=agemax,y=ACV,color=class)) +
  geom_point(size=0.5) +
  scale_y_continuous(name="ACV") +
  scale_x_continuous(name="Age Max",trans="log",breaks=c(1,5,10,20,50,100,150)) +
  theme_bw() +  
  theme(panel.grid.minor=element_blank())
pc

#Describe Relationship
pc + geom_smooth(method="gam",se=TRUE)

pc + geom_smooth(method="loess",se=TRUE)

## Look at relationship between Fish Age Max and ACV by Rcat
pr <- ggplot(data=filter(LR,!is.na(Rcat3),Rcat3 != "NA"),mapping=aes(x=agemax,y=ACV,color=Rcat)) +
  geom_point(size=0.5) +
  scale_y_continuous(name="ACV") +
  scale_x_continuous(name="Age Max",trans="log",breaks=c(1,5,10,20,50,100,150)) +
  theme_bw() +  
  theme(panel.grid.minor=element_blank())
pr

#Describe Relationship
pr + geom_smooth(method="gam",se=TRUE)

pr + geom_smooth(method="loess",se=TRUE)

## Build Confidence Intervals for ACV by type (between/within)
sum1 <- LR %>%
  group_by(type) %>%
  summarize(n=n(),
            mean=mean(ACV,na.rm=TRUE),
            sd=sd(ACV,na.rm=TRUE)) %>%
  mutate(se=sd/sqrt(n),  
         me=qt(0.975,df=n-1)*se) %>%  
  mutate(lsd=mean-sd,usd=mean+sd,
         lse=mean-se,use=mean+se,
         lci=mean-me,uci=mean+me)
sum1

## Describe Relationship
jt <- ggplot(data=filter(LR,!is.na(type),type != "both")) +
  geom_jitter(data=LR,mapping=aes(x=type,y=ACV),
              size=1.5,alpha=0.1,width=0.05) +
  geom_line(data=sum1,mapping=aes(x=type,y=mean,group=1),
            size=0.5,color="red",linetype="dashed") +
  geom_errorbar(data=sum1,mapping=aes(x=type,ymin=lci,ymax=uci),
                size=0.5,color="red",width=0.2) +
  geom_point(data=sum1,mapping=aes(x=type,y=mean),
             size=1.5,pch=21,color="red",fill="white") +
  scale_x_discrete(name="Comparison Type") +
  scale_y_continuous(name="ACV")  +
  theme_bw() +  
  theme(panel.grid.major.x=element_blank())   

jt


## Look at Histogram of Fish Age Max Values
agemaxH <- ggplot(data=LR,mapping=aes(x=agemax)) +
  geom_histogram(color="black",fill="grey70",binwidth=5,boundary=0) +
  scale_y_continuous(name="Frequency",expand=expansion(mult=c(0,0.05))) +
  scale_x_continuous(name="Fish Age Maximum") +
  theme_classic()
agemaxH

sum4 <- LR %>%
  group_by(order) %>%
  summarize(n=n(),
            mean=mean(ACV,na.rm=TRUE),
            sd=sd(ACV,na.rm=TRUE)) %>%
  mutate(se=sd/sqrt(n),  
         me=qt(0.975,df=n-1)*se) %>%  
  mutate(lsd=mean-sd,usd=mean+sd,
         lse=mean-se,use=mean+se,
         lci=mean-me,uci=mean+me)
sum4

jo <- ggplot(data=LR) +
  geom_jitter(data=LR,mapping=aes(x=order,y=ACV),
              size=1.5,alpha=0.1,width=0.05) +
  geom_line(data=sum4,mapping=aes(x=order,y=mean,group=1),
            size=0.5,color="red",linetype="dashed") +
  geom_errorbar(data=sum4,mapping=aes(x=order,ymin=lci,ymax=uci),
                size=0.5,color="red",width=0.2) +
  geom_point(data=sum4,mapping=aes(x=order,y=mean),
             size=1.5,pch=21,color="red",fill="white") +
  scale_y_continuous(name="ACV",breaks=c(5,10,15,20,30,45,60)) +
  scale_x_discrete(name="Order") +
  theme_bw() +  
  theme(panel.grid.minor=element_blank())
jo

sum5 <- filter(LR,!is.na(ncat), ncat != "NA") %>%
  group_by(ncat) %>%
  summarize(n=n(),
            mean=mean(ACV,na.rm=TRUE),
            sd=sd(ACV,na.rm=TRUE)) %>%
  mutate(se=sd/sqrt(n),  
         me=qt(0.975,df=n-1)*se) %>%  
  mutate(lsd=mean-sd,usd=mean+sd,
         lse=mean-se,use=mean+se,
         lci=mean-me,uci=mean+me)


a <-ggplot(data=filter(LR,!is.na(ncat), ncat != "NA"),mapping=aes(x=ncat,y=ACV)) +
  geom_point(size=0.5) +
  scale_y_continuous(name="ACV") +
  scale_x_discrete(name="n") +
  theme_bw() +  
  theme(panel.grid.minor=element_blank())
a

a + geom_line(data=sum5,mapping=aes(x=ncat,y=mean,group=1),
              size=0.5,color="red",linetype="dashed") 

   geom_errorbar(data=sum5,mapping=aes(x=ncat,ymin=lci,ymax=uci),
                size=0.5,color="red",width=0.2) 

  geom_point(data=sum5,mapping=aes(x=ncat,y=mean),
             size=1.5,pch=21,color="red",fill="white")
  
  ## Build Confidence Intervals for ACV by Marine (yes/no)
  sum3 <- LR %>%
    group_by(marine) %>%
    summarize(n=n(),
              mean=mean(ACV,na.rm=TRUE),
              sd=sd(ACV,na.rm=TRUE)) %>%
    mutate(se=sd/sqrt(n),  
           me=qt(0.975,df=n-1)*se) %>%  
    mutate(lsd=mean-sd,usd=mean+sd,
           lse=mean-se,use=mean+se,
           lci=mean-me,uci=mean+me)
  sum3

  ## Look at Relationship between Marine (yes/no) and ACV
  jm <- ggplot(data=LR) +
    geom_jitter(data=LR,mapping=aes(x=marine,y=ACV),
                size=1.5,alpha=0.1,width=0.05) +
    geom_line(data=sum3,mapping=aes(x=marine,y=mean,group=1),
              size=0.5,color="red",linetype="dashed") +
    geom_errorbar(data=sum3,mapping=aes(x=marine,ymin=lci,ymax=uci),
                  size=0.5,color="red",width=0.2) +
    geom_point(data=sum3,mapping=aes(x=marine,y=mean),
               size=1.5,pch=21,color="red",fill="white") +
    scale_y_continuous(name="ACV",breaks=c(5,10,15,20,30,45,60)) +
    scale_x_discrete(name="Marine") +
    theme_bw() +  
    theme(panel.grid.minor=element_blank())
  jm
  
  ## Build Confidence Intervals for ACV by Class
  sum2 <- filter(LR,!is.na(class),class != "Petromyzonti") %>%
    group_by(class) %>%
    summarize(n=n(),
              mean=mean(ACV,na.rm=TRUE),
              sd=sd(ACV,na.rm=TRUE)) %>%
    mutate(se=sd/sqrt(n),  
           me=qt(0.975,df=n-1)*se) %>%  
    mutate(lsd=mean-sd,usd=mean+sd,
           lse=mean-se,use=mean+se,
           lci=mean-me,uci=mean+me)
  sum2
  
  
  ## Look at Relationship between Fish Class and ACV
  jc <- ggplot(data=LR) +
    geom_jitter(data=filter(LR,!is.na(class),class != "Petromyzonti"),mapping=aes(x=class,y=ACV),
                size=1.5,alpha=0.1,width=0.05) +
    geom_line(data=sum2,mapping=aes(x=class,y=mean,group=1),
              size=0.5,color="red",linetype="dashed") +
    geom_errorbar(data=sum2,mapping=aes(x=class,ymin=lci,ymax=uci),
                  size=0.5,color="red",width=0.2) +
    geom_point(data=sum2,mapping=aes(x=class,y=mean),
               size=1.5,pch=21,color="red",fill="white") +
    scale_y_continuous(name="ACV") +
    scale_x_discrete(name="Class") +
    theme_bw() +  
    theme(panel.grid.minor=element_blank())
  
  jc