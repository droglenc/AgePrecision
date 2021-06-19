#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#
#= This reads the flat file in LitReview.RData and uses a variety of         =#
#=   summaries to help screen the raw data for "errors".                     =#
#=                                                                           =#
#= If the data on GoogleSheets was changed then source LitReview_PREPPER.R   =#
#=   to recreate the literature review database. This script is not run once =#
#=   the data in GoogleSheet has been deemed adequately "clean."             =#
#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#
cat("\014")

## Get the literature review database ----
load("data/LitReview.RData")
str(LR)

# check for non-standard entries ----
xtabs(~structure,data=LR)
xtabs(~structure2+structure,data=LR)
# pectoral and caudal scales used correctly for Quist 2007 paper
xtabs(~process+structure,data=LR)
xtabs(~process2+structure,data=LR)
xtabs(~type,data=LR)
xtabs(~checkbias,data=LR)
xtabs(~biasmethod+checkbias,data=LR)  # "no" column should be empty
xtabs(~bias_usedplot,data=LR)
xtabs(~bias_usedregression,data=LR)
xtabs(~bias_usedsymtest,data=LR)
xtabs(~bias_usedttest,data=LR)
xtabs(~bias_usedother,data=LR)
xtabs(~class,data=LR)
xtabs(~class+class1,data=LR)
xtabs(~order+class,data=LR)
any(is.na(LR$class))  # should be FALSE
any(is.na(LR$order))
any(is.na(LR$family))

# check for NAs or odd values ----
FSA::Summarize(~R,data=LR,digits=1)
FSA::Summarize(~n,data=LR,digits=1) 
# 9 minimum is correct and from acre_comparison_2017.
# 2 missing values is correct

# Should be a straightline with a slope of sqrt(2) for all R=2 comparisons ---
plot(ACV~APE,data=LR,pch=21,bg=ifelse(R==2,"green","red"))
abline(a=0,b=sqrt(2),col="blue")
abline(a=0,b=1,col="red",lty=2)
plot(ACV~APE,data=LR,pch=21,bg=ifelse(R==2,"green","red"),xlim=c(0,20),ylim=c(0,25))
abline(a=0,b=sqrt(2),col="blue")
abline(a=0,b=1,col="red",lty=2)

plot(I(ACV/APE)~ACV,data=dplyr::filter(LR,R==2),
     pch=21,bg=ifelse(R==2,"green","red"),ylim=c(1.2,1.6),xlim=c(0,30))
abline(h=sqrt(2),col="blue")

# use this to find off values
#with(LR,identify(ACV,ACV/APE)) 
LR[c(202,1221,1226),c("studyID","species","structure","process","APE","ACV")]
# notes are in database ..
#   Driggers is likely a rounding error (to whole numbers)
#   Geremedhin is likely a rounding error (to whole numbers)

plot(AD~ACV,data=LR,pch=21,bg=ifelse(R==2,"green","red"))
plot(AD~APE,data=LR,pch=21,bg=ifelse(R==2,"green","red"))

plot(PA0~ACV,data=LR,pch=21,bg=ifelse(R==2,"green","red"))
plot(PA1~ACV,data=LR,pch=21,bg=ifelse(R==2,"green","red"))
plot(PA1~PA0,data=LR,pch=21,bg=ifelse(R==2,"green","red"))
abline(a=0,b=1,col="blue")
#with(LR,identify(PA0,PA1))
LR[c(1123),c("studyID","species","structure","process","PA0","PA1")]

FSA:::hist.formula(~ACV,data=LR,w=2)
FSA:::hist.formula(ACV~class,data=LR,w=2)
boxplot(ACV~class,data=LR)
FSA::Summarize(ACV~class,data=LR) #Petromyzonti papers only using APE
FSA::Summarize(ACV~R,data=LR)
FSA::Summarize(APE~R,data=LR)

FSA:::hist.formula(~n,data=LR,w=25,xlim=c(0,500))
