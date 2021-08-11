### Create data from plots
fn <- "data/raw_ageing/aaaOriginals/Spiegel et al 2010_Data_Scott.xlsx"

## Data for Highfin Carpsucker scales
hfcsc_freq <- readxl::read_excel(fn,sheet="Highfin Carpsucker Scales")
hfcsc_raw <- data.frame(read1=rep(hfcsc_freq$reader1,hfcsc_freq$freq),
                        read2=rep(hfcsc_freq$reader2,hfcsc_freq$freq),
                        structure="Scales",
                        species="Highfin Carpsucker")
FSA::peek(hfcsc_raw)
tmp <- FSA::ageBias(read2~read1,data=hfcsc_raw)
summary(tmp,what="table")  ## looks OK

## Data for Highfin Carpsucker fin rays
hfcfr_freq <- readxl::read_excel(fn,sheet="Highfin Carpsucker Finrays")
hfcfr_raw <- data.frame(read1=rep(hfcfr_freq$reader1,hfcfr_freq$freq),
                        read2=rep(hfcfr_freq$reader2,hfcfr_freq$freq),
                        structure="Fin Rays",
                        species="Highfin Carpsucker")
FSA::peek(hfcfr_raw)
tmp <- FSA::ageBias(read2~read1,data=hfcfr_raw)
summary(tmp,what="table")  ## looks OK


## Data for Quillback Carpsucker scales
qbcsc_freq <- readxl::read_excel(fn,sheet="Quillback Carpsucker Scales")
qbcsc_raw <- data.frame(read1=rep(qbcsc_freq$reader1,qbcsc_freq$freq),
                        read2=rep(qbcsc_freq$reader2,qbcsc_freq$freq),
                        structure="Scales",
                        species="Quillback Carpsucker")
FSA::peek(qbcsc_raw)
tmp <- FSA::ageBias(read2~read1,data=qbcsc_raw)
summary(tmp,what="table")  ## looks OK

## Data for Quillback Carpsucker fin rays
qbcfr_freq <- readxl::read_excel(fn,sheet="Quillback Carpsucker Finrays")
qbcfr_raw <- data.frame(read1=rep(qbcfr_freq$reader1,qbcfr_freq$freq),
                        read2=rep(qbcfr_freq$reader2,qbcfr_freq$freq),
                        structure="Fin Rays",
                        species="Quillback Carpsucker")
FSA::peek(qbcfr_raw)
tmp <- FSA::ageBias(read2~read1,data=qbcfr_raw)
summary(tmp,what="table")  ## looks OK


## Data for River Carpsucker scales
rcsc_freq <- readxl::read_excel(fn,sheet="River Carpsucker Scales")
rcsc_raw <- data.frame(read1=rep(rcsc_freq$reader1,rcsc_freq$freq),
                        read2=rep(rcsc_freq$reader2,rcsc_freq$freq),
                        structure="Scales",
                        species="River Carpsucker")
FSA::peek(rcsc_raw)
tmp <- FSA::ageBias(read2~read1,data=rcsc_raw)
summary(tmp,what="table")  ## looks OK

## Data for River Carpsucker fin rays
rcfr_freq <- readxl::read_excel(fn,sheet="River Carpsucker Finrays")
rcfr_raw <- data.frame(read1=rep(rcfr_freq$reader1,rcfr_freq$freq),
                        read2=rep(rcfr_freq$reader2,rcfr_freq$freq),
                        structure="Fin Rays",
                        species="River Carpsucker")
FSA::peek(rcfr_raw)
tmp <- FSA::ageBias(read2~read1,data=rcfr_raw)
summary(tmp,what="table")  ## looks OK


df <- dplyr::bind_rows(hfcsc_raw,hfcfr_raw,qbcsc_raw,qbcfr_raw,rcsc_raw,rcfr_raw)
FSA::peek(df)

write.csv(df,file="data/raw_ageing/spiegel_precision_2010.csv",
          quote=FALSE,row.names=FALSE)
