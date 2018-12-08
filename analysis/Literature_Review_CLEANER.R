## Scripts to help "clean" the literature review data
cat("\014")
setwd(here::here())
library(FSA)

## Create the literature review database
source("analysis/Literature_Review.R")
str(df)

# check for non-standard entries
xtabs(~structure,data=df)
xtabs(~structure2+structure,data=df)
xtabs(~process+structure,data=df)
xtabs(~type,data=df)
xtabs(~checkbias,data=df)
xtabs(~biasmethod+checkbias,data=df)  # should not be a "no" column
xtabs(~class,data=df)
xtabs(~order+class,data=df)
any(is.na(df$class))
any(is.na(df$order))
any(is.na(df$family))

# check for NAs or odd values
Summarize(~R,data=df,digits=1)
Summarize(~n,data=df,digits=1)


# Should be a straightline with a slope of sqrt(2) for all R=2 comparisons
plot(ACV~APE,data=df,pch=21,bg=ifelse(R==2,"green","red"))
abline(a=0,b=sqrt(2),col="blue")
abline(a=0,b=1,col="red",lty=2)
plot(ACV~APE,data=df,pch=21,bg=ifelse(R==2,"green","red"),xlim=c(0,20),ylim=c(0,25))
abline(a=0,b=sqrt(2),col="blue")
abline(a=0,b=1,col="red",lty=2)

plot(I(ACV/APE)~ACV,data=df,pch=21,bg=ifelse(R==2,"green","red"),ylim=c(1.1,1.6))
abline(h=sqrt(2),col="blue")

# use this to find off values
#with(df,identify(ACV,ACV/APE))
#as.data.frame(df)[c(916),c("studyID","species","structure","process","APE","ACV")]

plot(AD~ACV,data=df,pch=21,bg=ifelse(R==2,"green","red"))
plot(AD~APE,data=df,pch=21,bg=ifelse(R==2,"green","red"))


plot(PA0~ACV,data=df,pch=21,bg=ifelse(R==2,"green","red"))
plot(PA1~ACV,data=df,pch=21,bg=ifelse(R==2,"green","red"))
plot(PA1~PA0,data=df,pch=21,bg=ifelse(R==2,"green","red"))

hist(~ACV,data=df,w=2)
hist(ACV~class,data=df,w=2)
boxplot(ACV~class,data=df)
Summarize(ACV~class,data=df)
Summarize(ACV~R,data=df)
Summarize(APE~R,data=df)


## Messing with ggplot
library(ggplot2)
theme_set(theme_bw())

ggplot(df,aes(x=ACV,fill=class)) +
  geom_density(alpha=0.3)

ggplot(df,aes(y=ACV,x=class,color=class)) +
  geom_violin(fill="white") +
  scale_color_brewer(palette="Dark2") +
  theme(legend.position="none")

### Need to collapse some orders
ggplot(df,aes(y=ACV,x=order,color=order)) +
  geom_violin(fill="white") +
  scale_color_brewer(palette="Dark2")



ggplot(df,aes(x=ACV)) +
  geom_density(fill="black",alpha=0.3) +
  facet_wrap(~class,ncol=1)

xtabs(~order,data=df)

ggplot(df,aes(x=ACV,fill=order)) +
  geom_density(alpha=0.3)
