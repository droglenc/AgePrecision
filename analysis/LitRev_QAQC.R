## Scripts to help "clean" the literature review data ----
cat("\014")
setwd(here::here())
library(FSA)

## Get the literature review database ----
load("data/LitReview.RData")
str(LR)

# check for non-standard entries
xtabs(~structure,data=LR)
xtabs(~structure2+structure,data=LR)
xtabs(~process+structure,data=LR)
xtabs(~type,data=LR)
xtabs(~checkbias,data=LR)
xtabs(~biasmethod+checkbias,data=LR)  # should not be anthing in the "no" column
xtabs(~class,data=LR)
xtabs(~order+class,data=LR)
any(is.na(LR$class))
any(is.na(LR$order))
any(is.na(LR$family))

# check for NAs or odd values ----
FSA::Summarize(~R,data=LR,digits=1)
FSA::Summarize(~n,data=LR,digits=1)


# Should be a straightline with a slope of sqrt(2) for all R=2 comparisons ----
plot(ACV~APE,data=LR,pch=21,bg=ifelse(R==2,"green","red"))
abline(a=0,b=sqrt(2),col="blue")
abline(a=0,b=1,col="red",lty=2)
plot(ACV~APE,data=LR,pch=21,bg=ifelse(R==2,"green","red"),xlim=c(0,20),ylim=c(0,25))
abline(a=0,b=sqrt(2),col="blue")
abline(a=0,b=1,col="red",lty=2)

plot(I(ACV/APE)~ACV,data=LR,pch=21,bg=ifelse(R==2,"green","red"),ylim=c(1.1,1.6))
abline(h=sqrt(2),col="blue")

# use this to find off values
#with(LR,identify(ACV,ACV/APE))
#as.data.frame(LR)[c(916),c("studyID","species","structure","process","APE","ACV")]

plot(AD~ACV,data=LR,pch=21,bg=ifelse(R==2,"green","red"))
plot(AD~APE,data=LR,pch=21,bg=ifelse(R==2,"green","red"))


plot(PA0~ACV,data=LR,pch=21,bg=ifelse(R==2,"green","red"))
plot(PA1~ACV,data=LR,pch=21,bg=ifelse(R==2,"green","red"))
plot(PA1~PA0,data=LR,pch=21,bg=ifelse(R==2,"green","red"))

hist(~ACV,data=LR,w=2)
hist(ACV~class,data=LR,w=2)
boxplot(ACV~class,data=LR)
Summarize(ACV~class,data=LR)
Summarize(ACV~R,data=LR)
Summarize(APE~R,data=LR)
