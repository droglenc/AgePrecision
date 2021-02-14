cat("\014")
setwd(here::here())
library(FSA)
library(ggplot2)

## Get the literature review database ----
load("data/LitReview.RData")
str(LR)
    

LRP <- filter(LR, class == "Actinopteri",
              !is.na(structurep),structurep != "other",structurep != "vertebrae",
              !is.na(type),type != "both",
              agemax >  2,
              agemax < 100,
              !is.na(Rcat3)
              )


## Look at Histogram of Fish Age Max Values
agemaxH <- ggplot(data=LR,mapping = aes(x=agemax)) +
  geom_histogram(color="black",fill="grey70",binwidth = 5,boundary = 0) +
  scale_y_continuous(name = "Frequency",expand = expansion(mult = c(0,0.05))) +
  scale_x_continuous(name = "Fish Age Maximum") +
  theme_classic()
agemaxH

## Look at relationship between Fish Age Max and ACV by type
pt <-ggplot(data = filter(LRP),mapping = aes(x=agemax,y=ACV,color = type)) +
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

## Look at relationship between Fish Age Max and ACV by structure
ps <- ggplot(data = LRP,mapping = aes(x=agemax,y=ACV,color = type)) +
  geom_point(size=0.5,alpha = 0.3) +
  scale_y_continuous(name = "ACV") +
  scale_x_continuous(name = "Age Max",trans = "log",breaks = c(1,5,10,20,50,100,150)) +
  theme_bw() +  
  theme(panel.grid.minor=element_blank(),legend.position = "none") +
  facet_grid(cols = vars(structurep),rows = vars(Rcat3))
ps

#Describe Relationship
ps + geom_smooth(method="gam",se = FALSE)

ps + geom_smooth(method = "loess",se=FALSE)

addmargins(xtabs(~marine + structurep,data = LR))

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
pr <- ggplot(data = filter(LR,!is.na(Rcat),Rcat != "NA"),mapping = aes(x=agemax,y=ACV,color = Rcat)) +
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

###XXXXXXXXXXXXXXXXX

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
