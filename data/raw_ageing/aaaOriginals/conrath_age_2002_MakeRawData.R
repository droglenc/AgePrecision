cat("\014"); rm(list=ls())
setwd(here::here())
library(FSA)

### Create data from table 1
r1rs <- c(0,1,1,2,2,3,3,3,4,4,5,5,5,6,6,7,7,8,8, 8,9, 9, 9,10,10,10,10,11,11,11,12,12,13,13,14,14)
r2rs <- c(0,1,2,1,2,2,3,4,4,5,4,5,6,5,6,6,7,8,9,10,9,10,11,10,11,12,13,11,12,13,11,12,13,14,14,15)
frrs <- c(53,19,1,2,19,1,19,3,2,2,1,6,2,1,11,2,14,4,1,1,2,1,1,1,2,1,2,2,1,1,1,2,2,0,1,0)
df <- data.frame(vertebrae_R1=rep(r1rs,frrs),vertebrae_R2=rep(r2rs,frrs))

ab1 <- ageBias(vertebrae_R2~vertebrae_R1,data=df)
summary(ab1,what="table")  # matches, though their table 1 is odd with the zeroes
str(df) 

write.csv(df,file="data/raw_ageing/conrath_age_2002.csv",
          quote=FALSE,row.names=FALSE)
