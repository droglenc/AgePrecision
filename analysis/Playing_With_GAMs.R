library(mgcv)

str(df1)

df2 <- df1 %>%
  filter(!is.na(ACVmod),
         type!="both")

gam1 <- gam(ACVmod~type+Rcat+Rcat:type+
              structure+structure:type+
              class1+
              s(agerange,by=type)+
              s(n),
            data=df2,method="REML")

summary(gam1)
anova(gam1)

plot(gam1,page=1,all.terms=TRUE,shade=TRUE,rug=FALSE,shift=coef(gam1)[1])
gam.check(gam1)
