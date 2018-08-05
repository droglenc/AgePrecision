library(FSA)
library(dplyr)

precisionData <- function(res,studyID,species,
                          structure,structure2="",process="",
                          type,var=c("SD","CV","AAD","APE","CV2","APE2"),
                          notes="",digits=5,alpha=0.05) {
  ## Handle arguments
  poss_struxs <- c("scales","otoliths","spines","finrays","vertebrae","cleithra")
  if (!structure %in% poss_struxs) stop("'structure' must one of: ",poss_struxs)
  poss_types <- c("between","within","structures")
  if (!type %in% poss_types) stop("'type' must be one of: ",poss_types)
  var <- match.arg(var)
  ## Prepare test specific information
  pre <- data.frame(studyID=studyID,species=species,
                    structure=structure,structure2=structure2,process=process,
                    type=type)
  
  ## Get precision tests done
  pt1 <- precisionTests(res,var=var,digits=digits,alpha=alpha)
  tests <- cbind(pre,var=var,pt1$tests)
  ## Prepare precision summary
  sum <- cbind(pre,summary(ap1,what="precision",show.prec2=TRUE),
               agemin=min(res$detail$mean,na.rm=TRUE),
               age10=quantile(res$detail$mean,probs=0.1,na.rm=TRUE,names=FALSE),
               age90=quantile(res$detail$mean,probs=0.9,na.rm=TRUE,names=FALSE),
               agemax=max(res$detail$mean,na.rm=TRUE))
  ## Return a list
  tmp <- list(sum=sum,tests=tests,df=pt1$df,
              LM=pt1$LM,LMHet=pt1$LMHet,QM=pt1$QM,QMHet=pt1$QMHet,
              preds=pt1$preds,var=pt1$var,notes=notes)
  class(tmp) <- "PrecisionData"
  tmp
}

precisionTests <- function(res,var,digits,alpha) {
  ## Get data
  y <- res$detail[,var]
  x <- res$detail$mean
  ## Fit linear and quadratic models, with and without modeling heteroscedasticity
  LM <- nlme::gls(y~x,method="ML")
  LMHet <- tryCatch(nlme::gls(y~x,method="ML",weights=nlme::varPower(form=~x)),
                    error=function(e) NA)
  QM <- nlme::gls(y~x+I(x^2),method="ML")
  QMHet <- tryCatch(nlme::gls(y~x+I(x^2),method="ML",weights=nlme::varPower(form=~x)),
                    error=function(e) NA)
  ## Need quadratic term, with no heteroscedasticity?
  resQMNoHet <- anova(LM,QM)
  ## Slope in linear model without heteroscedasticity
  resSlopeLMNoHet <- anova(LM)
  if (class(LMHet)=="gls") {
    ## Need to model heteroscedasity in the linear model?
    resHetInLM <- anova(LM,LMHet)
    ## Slope in linear model with heteroscedasticity
    resSlopeLMHet <- anova(LMHet)
    ## Need quadratic term, with heteroscedasticity?
    if (class(QMHet)=="gls") resQMHet <- anova(LMHet,QMHet)
      else resQMHet <- NA
  } else {
    resHetInLM <- resSlopeLMHet <- NA
    ## Need quadratic term, with heteroscedasticity?
    if (class(QMHet)=="gls") resQMHet <- anova(LMHet,QMHet)
    else resQMHet <- NA
  }
  ## Need to model heteroscedasity in the quadratic model?
  if (class(QMHet)=="gls") resHetInQM <- anova(QM,QMHet)
    else resHetInQM <- NA
  ## Put together
  sum <- data.frame(HetInLM=ifelse("anova.lme" %in% class(resHetInLM),
                                   round(resHetInLM[2,"p-value"],digits),NA),
                    HetInQM=ifelse("anova.lme" %in% class(resHetInQM),
                                   round(resHetInQM[2,"p-value"],digits),NA),
                    QMNoHet=round(resQMNoHet[2,"p-value"],digits),
                    QMHet=ifelse("anova.lme" %in% class(resQMHet),
                                 round(resQMHet[2,"p-value"],digits),NA),
                    SlopeLMNoHet=round(resSlopeLMNoHet[2,"p-value"],digits),
                    SlopeLMHet=ifelse("anova.lme" %in% class(resSlopeLMHet),
                                      round(resSlopeLMHet[2,"p-value"],digits),NA))
  sum$Hetero <- with(sum,
                     dplyr::case_when(
                       is.na(HetInLM) & is.na(HetInQM) ~ "--",
                       HetInLM<alpha & HetInQM < alpha ~ "both",
                       HetInLM<alpha ~ "linear",
                       HetInQM<alpha ~ "quad",
                       TRUE ~ "neither"))
  sum$Quad <- with(sum,
                   dplyr::case_when(
                     QMNoHet<alpha & QMHet < alpha ~ "both",
                     QMNoHet<alpha ~ "no hetero",
                     QMHet<alpha ~ "hetero",
                     TRUE ~ "neither"))
  sum$Slope <- with(sum,
                    dplyr::case_when(
                      SlopeLMNoHet<alpha & SlopeLMHet < alpha ~ "both",
                      SlopeLMNoHet<alpha ~ "no hetero",
                      SlopeLMHet<alpha ~ "hetero",
                      TRUE ~ "neither"))
  ## return list
  df <- data.frame(y,x)
  names(df) <- c(var,"mean")
  tmp <- seq(min(df$mean,na.rm=TRUE),max(df$mean,na.rm=TRUE),length.out=99)
  LM.preds <- predict(LM,data.frame(x=tmp))
  if (class(LMHet)=="gls") LMHet.preds <- predict(LMHet,data.frame(x=tmp))
  else LMHet.preds <- NA
  QM.preds <- predict(QM,data.frame(x=tmp))
  if (class(QMHet)=="gls") QMHet.preds <- predict(QMHet,data.frame(x=tmp))
  else QMHet.preds <- NA
  preds <- data.frame(x=tmp,LM=LM.preds,LMHet=LMHet.preds,
                      QM=QM.preds,QMHet=QMHet.preds)
  tmp <- list(tests=sum,df=df,LM=LM,LMHet=LMHet,QM=QM,QMHet=QMHet,preds=preds,var=var)
  class(tmp) <- "PrecisionTests"
  tmp
}

summary.PrecisionData <- function(object,what=c("summary","tests")) {
  what <- match.arg(what)
  if (what=="summary") object$sum
  else object$tests
}

plot.PrecisionData <- function(x,...) {
  plot(x$df$mean,x$df[,x$var],xlab="Mean Age",ylab=x$var,
       pch=19,col=FSA::col2rgbt("black",1/10))
  lines(LM~x,data=x$preds,col="black",lwd=3)
  if (class(x$LMHet)=="gls") lines(LMHet~x,data=x$preds,col="red",lwd=2,lty=2)
  lines(QM~x,data=x$preds,col="blue",lwd=3)
  if (class(x$QMHet)=="gls") lines(QMHet~x,data=x$preds,col="green",lwd=2,lty=2)
}
