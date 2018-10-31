#### SETUP #####################################################################
setwd(here::here())
source("code/precisionData.R")

### Create data from plots
## Data for Rough Skates (from Figure 3A)
r1rs <- c(0,1,1,2,2,3,3,3, 4,4,4, 5, 5,5,5,5,6,6, 6,6,6,7,7,7,7,7,7,8,8,9)
r2rs <- c(1,1,2,2,3,2,3,4, 4,5,6, 4, 5,6,7,8,4,5, 6,7,9,4,5,6,7,8,9,6,8,9)
frrs <- c(2,2,1,1,1,1,3,1,24,2,2,12,26,4,2,1,6,7,11,4,2,3,4,2,3,1,1,2,1,1)
rs <- data.frame(r1=rep(r1rs,frrs),r2=rep(r2rs,frrs),species="Rough Skate")

## Data for Smooth Skates (from Figure 6A)
r1ss <- c(0,1,1,2,3,4,4,5,5,5,6,6,7,7,7,7, 7,8,8, 8, 8,9,9,9, 9, 9,10,10,10,10,10,10)
r2ss <- c(1,1,2,2,3,4,5,4,5,6,4,6,5,7,8,9,10,7,8,10,11,6,8,9,10,13, 8, 9,10,11,12,13)
frss <- c(2,1,2,3,2,3,1,1,1,1,1,4,1,2,1,1, 1,3,6, 1, 1,1,3,2, 1, 1, 1, 2, 3, 2, 2, 1)
r1ss <- c(r1ss,11,11,11,11,11,11,11,11,12,12,12,12,12,13,13,14,14,14,14,16,16,16,16,18,18,20,22,22,24)
r2ss <- c(r2ss, 7, 8, 9,10,11,12,13,17, 7,10,11,12,13,12,16, 8, 9,13,14,11,12,13,14,16,20,21,19,22,23)
frss <- c(frss, 1, 1, 1, 1, 2, 3, 1, 1, 1, 2, 3, 7, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
ss <- data.frame(r1=rep(r1ss,frss),r2=rep(r2ss,frss),species="Smooth Skate")
df <- rbind(rs,ss)
rm(rs,ss,frss,frrs,r1rs,r1ss,r2rs,r2ss)

str(df) 

write.csv(df,file="data/raw_ageing/francis_age_2001.csv",
          quote=FALSE,row.names=FALSE)
