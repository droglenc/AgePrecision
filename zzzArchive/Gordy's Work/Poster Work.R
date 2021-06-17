cat("\014")
setwd(here::here())
library(FSA)
library(ggplot2)
library(plyr)
library(dplyr)
options(show.signif.stars = FALSE)

## Get the literature review database ----
load("data/LitReview.RData")
str(LR)
    
#between mu = 8.97077467
#within mu = 8.61909967

## Filter LRP object

LR$logagemax <- log(LR$agemax)

LRP <- LR %>% 
  filter(class == "Actinopteri",
        !is.na(structure),structure != "other",structure != "vertebrae",
        !is.na(type),type != "both",
        agemax >  2,
        agemax < 100,
        !is.na(Rcat3),Rcat3 == 2,
        !is.na(ACVmod)) %>%
  select(studyID,ACVmod,agemax,structure,type,logACVmod,logagemax) %>%
  mutate(structurep = plyr::mapvalues(structure,from = c("otoliths","spines","finrays","scales"),
                         to = c("Otoliths","Spines+Finrays","Spines+Finrays","Scales"))) %>%
  mutate(type = plyr::mapvalues(type,from = c("between","within"),to = c("Between","Within")))
              

## Look at relationship between Fish Age Max and ACV by structure and type
clrs1 <- c("navyblue","gold4")
clrs2 <- c("#5aB4ac","#d8b365")
clrs3 <- c("#67a9cf","#ef8a62")

ps <- ggplot(data = LRP,mapping = aes(x=agemax,y=ACVmod + 0.15,color = type,fill = type)) +
  geom_point(size=0.5,alpha = 0.5) +
  scale_y_continuous(name = "Average Coefficient of Variation",trans = "log",breaks = c(0.5,1,5,10,25,50)) +
  scale_x_continuous(name = "Maximum Age",trans = "log",breaks = c(5,10,25,50,75)) +
  scale_color_manual(values = clrs1) +
  scale_fill_manual(values = clrs1) +
  geom_smooth(method="lm",se = TRUE,alpha = 0.5) +
  facet_grid(cols = vars(structurep)) +
  theme_bw() +  
  theme(panel.grid.minor= element_line(linetype = "dashed",color = "gray95"),
        panel.grid.major = element_line(linetype = "dashed",color = "gray95"),
        panel.border = element_rect(colour = "black",linetype = "solid",size = 1),
        legend.position = c(0.85,0.1),
        legend.key.size = unit(2, 'mm'),
        legend.background = element_blank(),
        legend.direction = "horizontal",
        strip.text = element_text(color = "white",face = "bold",size = 10),
        strip.background = element_rect(fill = "black",linetype = "solid",size = 1.5),
        axis.title = element_text(face = "bold",size = 9),
        legend.text = element_text(face = "bold",size = 9),
        legend.title = element_blank(),
        aspect.ratio = 1)
        
ps
ggsave("posterfigure2.png",ps,width = 6,height = 3,units = "in")

### Density Plot

mu <- LRP %>%
  group_by(type,structurep) %>%
  summarise(n = n(),
            mn = mean(ACVmod,na.rm=TRUE))
mu

pd <- ggplot(data = LRP, mapping = aes(x=ACVmod,colour = type,fill = type)) +
  geom_density(alpha = 0.3) +
  geom_vline(data = mu,mapping = aes(xintercept = mn,colour = type), linetype="dashed", size=0.5,show.legend = FALSE) +
  scale_x_continuous(name = "Average Coefficient of Variation",expand=expansion(mult=c(0,0)),limits = c(0,NA)) +
  scale_y_continuous(name = "Relative Density",expand=expansion(mult=c(0,0.05))) +
  scale_color_manual(values = clrs1) +
  scale_fill_manual(values = clrs1) +
  facet_grid(cols = vars(structurep)) +
  theme_bw() +
  theme(panel.grid.minor= element_line(linetype = "dashed",color = "gray95"),
        panel.grid.major = element_line(linetype = "dashed",color = "gray95"),
        strip.text = element_text(color = "white",face = "bold"),
        strip.background = element_rect(fill = "black",linetype = "solid",size = 1.5),
        panel.border = element_rect(colour = "black",linetype = "solid",size = 1),
        legend.position = c(0.25,0.9),
        legend.background = element_blank(),
        legend.key.size = unit(3,"mm"),
        axis.title = element_text(face = "bold",size = 9),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        legend.title = element_blank(),
        legend.text = element_text(face = "bold",size = 9),
        aspect.ratio = 1)
        
pd
ggsave("posterfigure1.png",pd,width = 6,height = 3,units = "in")

lm1 <- lm(logACVmod~logagemax+type+structurep+logagemax:type+logagemax:structurep+type:structurep+logagemax:type:structurep,data = LRP)
car::Anova(lm1)
anova(lm1)
lm1a <- lm(logACVmod~logagemax+type+structurep+type:logagemax+structurep:logagemax,data = LRP)
car::Anova(lm1a)

mc1 <- emmeans::emtrends(lm1,specs=pairwise~type:structurep,var = "logagemax")
summary(mc1,infer = TRUE)


LRP2 <- LRP %>%
  mutate(comb = structurep:type)

lm3 <- lm(logACVmod~logagemax+comb+logagemax:comb,data = LRP2)
anova(lm3)
mc2 <- emmeans::emtrends(lm3,specs=pairwise~comb,var = "logagemax")
summary(mc2,infer = TRUE)

lm2 <- lm(ACVmod~structurep+type+structurep:type,data = LRP)

NCStats::assumptionCheck(lm2)
NCStats::assumptionCheck(lm2,shifty = 0.15,lambday = 0)
NCStats::assumptionCheck(lm2,lambday = 0.5)
lm2 <- lm(logACVmod~structurep+type+structurep:type,data = LRP)
anova(lm2)

lm2noint <- lm(logACVmod~structurep+type,data = LRP)
  mc1 <- emmeans::emmeans(lm2noint,specs=pairwise~structurep,tran = "log")
  summary(mc1,type = "response")
  Summarize(ACVmod~structurep,data = LRP)

###XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX####

## Look at relationship between Fish Age Max and ACV by type
pt <-ggplot(data = LRP) +
  geom_point(size=0.5) +
  scale_y_continuous(name = "ACV") +
  scale_x_continuous(name = "Age Max",trans = "log",breaks = c(1,5,10,20,50,100,150)) +
  theme_bw() +  
  theme(panel.grid.minor=element_blank())
pt

#Describe Relationship
pt + geom_smooth(method="lm",se=FALSE)

pt + geom_smooth(method="gam")

pt + geom_smooth(method = "loess",se=FALSE)
## Look at relationship between Fish Age Max and ACV by marine (yes/no)
pm <- ggplot(data = LR,mapping = aes(x=agemax,y=ACV,color = marine)) +
  geom_point(size=0.5) +
  scale_y_continuous(name = "ACV") +
  scale_x_continuous(name = "Age Max",trans = "log",breaks = c(1,5,10,20,50,100,150)) +
  theme_bw() +  
  theme(panel.grid.minor=element_blank())
pm

#Describe Relationship
pm + geom_smooth(method="gam",se = FALSE)

pm + geom_smooth(method = "loess",se=FALSE)

## Look at relationship between Fish Age Max and ACV by class
pc <- ggplot(data = filter(LR,!is.na(class),class != "Petromyzonti",class != "Holocephali"),mapping = aes(x=agemax,y=ACV,color = class)) +
  geom_point(size=0.5) +
  scale_y_continuous(name = "ACV") +
  scale_x_continuous(name = "Age Max",trans = "log",breaks = c(1,5,10,20,50,100,150)) +
  theme_bw() +  
  theme(panel.grid.minor=element_blank())
pc

#Describe Relationship
pc + geom_smooth(method="gam",se = TRUE)

pc + geom_smooth(method = "loess",se = TRUE)

## Look at relationship between Fish Age Max and ACV by Rcat
pr <- ggplot(data = filter(LR,!is.na(Rcat3),Rcat3 != "NA"),mapping = aes(x=agemax,y=ACV,color = Rcat)) +
  geom_point(size=0.5) +
  scale_y_continuous(name = "ACV") +
  scale_x_continuous(name = "Age Max",trans = "log",breaks = c(1,5,10,20,50,100,150)) +
  theme_bw() +  
  theme(panel.grid.minor=element_blank())
pr

#Describe Relationship
pr + geom_smooth(method="gam",se = TRUE)

pr + geom_smooth(method = "loess",se = TRUE)

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
jt <- ggplot(data = filter(LR,!is.na(type),type != "both")) +
  geom_jitter(data=LR,mapping = aes(x=type,y=ACV),
              size=1.5,alpha = 0.1,width = 0.05) +
  geom_line(data=sum1,mapping = aes(x=type,y=mean,group = 1),
            size=0.5,color="red",linetype = "dashed") +
  geom_errorbar(data=sum1,mapping = aes(x=type,ymin=lci,ymax=uci),
                size=0.5,color="red",width = 0.2) +
  geom_point(data=sum1,mapping = aes(x=type,y=mean),
             size=1.5,pch = 21,color="red",fill = "white") +
  scale_x_discrete(name = "Comparison Type") +
  scale_y_continuous(name = "ACV")  +
  theme_bw() +  
  theme(panel.grid.major.x=element_blank())   

jt


## Look at Histogram of Fish Age Max Values
agemaxH <- ggplot(data=LR,mapping = aes(x=agemax)) +
  geom_histogram(color="black",fill="grey70",binwidth = 5,boundary = 0) +
  scale_y_continuous(name = "Frequency",expand = expansion(mult = c(0,0.05))) +
  scale_x_continuous(name = "Fish Age Maximum") +
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

jo <- ggplot(data = LR) +
  geom_jitter(data = LR,mapping = aes(x=order,y=ACV),
              size=1.5,alpha = 0.1,width = 0.05) +
  geom_line(data=sum4,mapping = aes(x=order,y=mean,group = 1),
            size=0.5,color="red",linetype = "dashed") +
  geom_errorbar(data=sum4,mapping = aes(x=order,ymin=lci,ymax=uci),
                size=0.5,color="red",width = 0.2) +
  geom_point(data=sum4,mapping = aes(x=order,y=mean),
             size=1.5,pch = 21,color="red",fill = "white") +
  scale_y_continuous(name = "ACV",breaks = c(5,10,15,20,30,45,60)) +
  scale_x_discrete(name = "Order") +
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


a <-ggplot(data = filter(LR,!is.na(ncat), ncat != "NA"),mapping = aes(x=ncat,y=ACV)) +
  geom_point(size=0.5) +
  scale_y_continuous(name = "ACV") +
  scale_x_discrete(name = "n") +
  theme_bw() +  
  theme(panel.grid.minor=element_blank())
a

a + geom_line(data=sum5,mapping = aes(x=ncat,y=mean,group = 1),
              size=0.5,color="red",linetype = "dashed") 

   geom_errorbar(data=sum5,mapping = aes(x=ncat,ymin=lci,ymax=uci),
                size=0.5,color="red",width = 0.2) 

  geom_point(data=sum5,mapping = aes(x=ncat,y=mean),
             size=1.5,pch = 21,color="red",fill = "white")
  
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
  jm <- ggplot(data = LR) +
    geom_jitter(data = LR,mapping = aes(x=marine,y=ACV),
                size=1.5,alpha = 0.1,width = 0.05) +
    geom_line(data=sum3,mapping = aes(x=marine,y=mean,group = 1),
              size=0.5,color="red",linetype = "dashed") +
    geom_errorbar(data=sum3,mapping = aes(x=marine,ymin=lci,ymax=uci),
                  size=0.5,color="red",width = 0.2) +
    geom_point(data=sum3,mapping = aes(x=marine,y=mean),
               size=1.5,pch = 21,color="red",fill = "white") +
    scale_y_continuous(name = "ACV",breaks = c(5,10,15,20,30,45,60)) +
    scale_x_discrete(name = "Marine") +
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
  jc <- ggplot(data = LR) +
    geom_jitter(data = filter(LR,!is.na(class),class != "Petromyzonti"),mapping = aes(x=class,y=ACV),
                size=1.5,alpha = 0.1,width = 0.05) +
    geom_line(data=sum2,mapping = aes(x=class,y=mean,group = 1),
              size=0.5,color="red",linetype = "dashed") +
    geom_errorbar(data=sum2,mapping = aes(x=class,ymin=lci,ymax=uci),
                  size=0.5,color="red",width = 0.2) +
    geom_point(data=sum2,mapping = aes(x=class,y=mean),
               size=1.5,pch = 21,color="red",fill = "white") +
    scale_y_continuous(name = "ACV") +
    scale_x_discrete(name = "Class") +
    theme_bw() +  
    theme(panel.grid.minor=element_blank())
  
  jc