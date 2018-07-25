library(FSA)
library(dplyr)

precisionData <- function(res,studyID,
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
  pre <- data.frame(studyID=studyID,
                    structure=structure,structure2=structure2,process=process,
                    type=type,var=var)
  
  ## Get precision tests done
  pt1 <- precisionTests(res,var=var,digits=digits,alpha=alpha)
  tests <- cbind(pre,pt1$tests)
  ## Prepare precision summary
  sum <- cbind(pre,summary(ap1,what="precision",show.prec2=TRUE),
               age.min=min(res$detail$mean,na.rm=TRUE),
               age.10=quantile(res$detail$mean,probs=0.1,na.rm=TRUE,names=FALSE),
               age.90=quantile(res$detail$mean,probs=0.9,na.rm=TRUE,names=FALSE),
               age.max=max(res$detail$mean,na.rm=TRUE))
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
  LMHet <- nlme::gls(y~x,method="ML",weights=nlme::varPower(form=~x))
  QM <- nlme::gls(y~x+I(x^2),method="ML")
  QMHet <- nlme::gls(y~x+I(x^2),method="ML",weights=nlme::varPower(form=~x))
  ## Need to model heteroscedasity in the linear model?
  resHetInLM <- anova(LM,LMHet)
  ## Need to model heteroscedasity in the quadratic model?
  resHetInQM <- anova(QM,QMHet)
  ## Need quadratic term, with no heteroscedasticity?
  resQMNoHet <- anova(LM,QM)
  ## Need quadratic term, with heteroscedasticity?
  resQMHet <- anova(LMHet,QMHet)
  ## Slope in linear model without heteroscedasticity
  resSlopeLMNoHet <- anova(LM)
  ## Slope in linear model with heteroscedasticity
  resSlopeLMHet <- anova(LMHet)
  ## Put together
  sum <- data.frame(HetInLM=round(resHetInLM[2,"p-value"],digits),
                    HetInQM=round(resHetInQM[2,"p-value"],digits),
                    QMNoHet=round(resQMNoHet[2,"p-value"],digits),
                    QMHet=round(resQMHet[2,"p-value"],digits),
                    SlopeLMNoHet=round(resSlopeLMNoHet[2,"p-value"],digits),
                    SlopeLMHet=round(resSlopeLMHet[2,"p-value"],digits))
  sum$Hetero <- with(sum,
                     dplyr::case_when(
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
  preds <- data.frame(x=tmp,
                      LM=predict(LM,data.frame(x=tmp)),
                      LMHet=predict(LMHet,data.frame(x=tmp)),
                      QM=predict(QM,data.frame(x=tmp)),
                      QMHet=predict(QMHet,data.frame(x=tmp)))
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
  lines(LMHet~x,data=x$preds,col="red",lwd=2,lty=2)
  lines(QM~x,data=x$preds,col="blue",lwd=3)
  lines(QMHet~x,data=x$preds,col="green",lwd=2,lty=2)
}
