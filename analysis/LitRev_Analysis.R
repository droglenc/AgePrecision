#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#
#= This reads the flat file in LitReview.RData and .                         =#
#=                                                                           =#
#= If the data on GoogleSheets was changed then source LitReview_PREPPER.R   =#
#=   to recreate the literature review database.                             =#
#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#

## Setup ----
cat("\014")
library(ggplot2)
source("code/ggplot_theme.R")
library(dplyr)

# loads LR data.frame
load("data/LitReview.RData")

# data.frame of individual studies (not by precision estimate) ... includes ...
#   variables that identify which metrics were used
#   
LRBS <- LR %>%
  group_by(studyID,pubyear,pubyear5) %>%
  summarize(across(c(APE,ACV,APE2,ACV2,AD,AAD,ASD,PA0,PA1),
                   ~!all(is.na(.)))) %>%
  mutate(PA=PA0 | PA1) %>%
  ungroup()
LRBS

## Sample size by years ----
SUMLR_n_years <- LR %>%
  group_by(pubyear,pubyear5) %>%
  summarize(n=n()) %>%
  ungroup()

SUMLR_n_years5 <- SUMLR_n_years %>%
  group_by(pubyear5) %>%
  summarize(minyr=min(pubyear),
            maxyr=max(pubyear),
            maxn=max(n),
            n_ests=sum(n))
SUMLR_n_years5

SUMLRBS_n_years <- LRBS %>%
  group_by(pubyear,pubyear5) %>%
  summarize(n=n()) %>%
  ungroup()
SUMLRBS_n_years5 <- SUMLRBS_n_years %>%
  group_by(pubyear5) %>%
  summarize(n_pubs=sum(n))
SUMLRBS_n_years5

SUM_n_years5 <- SUMLR_n_years5 %>%
  left_join(SUMLRBS_n_years5) %>%
  mutate(nlbl=paste0(n_ests," estimates in\n",n_pubs," publications"))
SUM_n_years5

ggplot() +
  geom_bar(data=SUMLR_n_years,mapping=aes(x=pubyear,y=n,fill="Estimates"),
           stat="identity",color="black",width=0.8,size=0.3) +
  geom_bar(data=SUMLRBS_n_years,mapping=aes(x=pubyear,y=n,fill="Publications"),
           stat="identity",color="black",width=0.8,size=0.3) +
  scale_y_continuous(name="Frequency",expand=expansion(mult=c(0,0.15))) +
  scale_x_continuous(name="Publication Year",expand=expansion(mult=0.02),
                     breaks=seq(1995,2020,5)) +
  scale_fill_manual(values=c("Publications"="gray30","Estimates"="gray70")) +
  geom_segment(data=SUM_n_years5,mapping=aes(x=minyr-0.4,xend=maxyr+0.4,
                                               y=maxn+3,yend=maxn+3)) +
  geom_text(data=SUM_n_years5,
            mapping=aes(x=(minyr+maxyr)/2,y=maxn+3,label=nlbl),
            vjust=-0.1,size=3) +
  theme(legend.position=c(0,1),legend.justification=c(0,1),legend.box="none")
            
ggsave(file="docs/Figs/Figure_N_by_year.pdf",device="pdf",
       width=7.25,height=7.25*(3/4),units="in",dpi=1000,scale=1)



## Sample size by class ----
## Removed holocephali and petromyzonti because n was so small
xtabs(~class,data=LR)

SUMLR_n_class_strux <- LR %>%
  filter(class %in% c("Actinopteri","Elasmobranchii")) %>%
  group_by(class,structure) %>%
  summarize(n=n()) %>%
  mutate(Percent=n/sum(n)*100,
         plbl=paste0(formatC(Percent,format="f",digits=0),"%")) %>%
  ungroup()
SUMLR_n_class_strux

ggplot(data=SUMLR_n_class_strux,
       mapping=aes(x=structure,y=n,fill=class)) +
  geom_bar(stat="identity",color="black",width=0.8,size=0.3) +
  scale_y_continuous(name="Frequency of Precision Estimates",
                     expand=expansion(mult=c(0,0.05))) +
  scale_x_discrete(name="Calcified Structure") +
  scale_fill_manual(values=c("Actinopteri"="gray70",
                             "Elasmobranchii"="gray30")) +
  theme(legend.position=c(1,1),legend.justification=c(1,1),legend.box="none")

ggsave(file="docs/Figs/Figure_N_by_class_structure.pdf",device="pdf",
       width=3.5,height=3.5,units="in",dpi=1000,scale=1)



## Sample size by type ----
## Removed "both" because n was so small
xtabs(~type,data=LR)

tmp <- xtabs(~structure+type,data=droplevels(filter(LR,type!="Both")))
( chi <- chisq.test(tmp) )
tmp2 <- NCStats::chisqPostHoc(chi)
tmp2$comparison[which(tmp2$adj.p<0.05)]

tmp <- LR %>%
  filter(type!="Both") %>%
  group_by(structure,type) %>%
  summarize(freq=n()) %>%
  mutate(perc=freq/sum(freq)*100) %>%
  ungroup()
tmp2 <- tmp %>%
  filter(type=="Within") %>%
  mutate(lets=c("b","bc","bc","c","a","ab"),
         plbl=paste0(formatC(perc,format="f",digits=0),"%"),
         nlbl=paste0("n=",freq))

ggplot() +
  geom_bar(data=tmp,mapping=aes(x=structure,y=perc,fill=type),
           stat="identity",color="black",width=0.8,size=0.3) +
  scale_y_continuous(name="Percentage of Precision Calculations",
                     expand=expansion(mult=c(0,0.04))) +
  scale_x_discrete(name="Calcified Structure") +
  scale_fill_manual(values=c("Between"="gray70","Within"="gray30")) +
  annotate(geom="text",x=1,y=100,label="Between",
           angle=90,size=2.5,hjust=1.1) +
  annotate(geom="text",x=1,y=0,label="Within",
           angle=90,size=2.5,color="white",hjust=-0.1) +
  geom_text(data=tmp2,mapping=aes(x=structure,y=perc,label=plbl),
            vjust=-0.3,size=2.5) +
  geom_text(data=tmp2,mapping=aes(x=structure,y=perc,label=lets),
            vjust=1.3,size=2.5,color="white") +
  geom_text(data=tmp2,mapping=aes(x=structure,y=100,label=nlbl),
            vjust=-0.3,size=2.5) +
  theme(legend.position="none")

ggsave(file="docs/Figs/Figure_P_by_type_structure.pdf",device="pdf",
       width=3.5,height=3.5,units="in",dpi=1000,scale=1)



## Sample size by R
tmp <- xtabs(~pubyear5+Rcat4,data=LR)
chisq.test(tmp)
tmp <- xtabs(~pubyear5+Rcat3,data=LR)
chi1 <- chisq.test(tmp)
NCStats::chisqPostHoc(chi1)


SUMLR_n_R_year5 <- LR %>%
  group_by(pubyear5,Rcat4) %>%
  summarize(freq=n()) %>%
  mutate(perc=freq/sum(freq)*100)

SUMLR_n_R_year5a <- SUMLR_n_R_year5 %>%
  summarize(freq=sum(freq)) %>%
  mutate(nlbl=paste0("n=",freq))

ggplot() +
  geom_bar(data=SUMLR_n_R_year5,mapping=aes(x=pubyear5,y=perc,fill=Rcat4),
           stat="identity",color="black",width=0.8,size=0.3,
           position=position_stack(reverse=TRUE)) +
  scale_x_discrete(name="R (Number of Repeated Readings)") +
  scale_y_continuous(name="Frequency of Precision Calculations",
                     expand=expansion(mult=c(0,0.04))) +
  scale_fill_manual(values=c("2"="gray20","3"="gray50","4+"="gray80")) +
  geom_text(data=SUMLR_n_R_year5a,mapping=aes(x=pubyear5,y=100,label=nlbl),
            vjust=-0.3,size=2.5) +
  annotate(geom="text",x=1,y=58/2,label="R=2",size=2.5,color="white") +
  annotate(geom="text",x=1,y=58+42/2,label="R=3",size=2.5) +
  annotate(geom="text",x=5,y=100-8.75/2,label="R=4+",size=2.5) +
  theme(legend.position="none")

ggsave(file="docs/Figs/Figure_P_by_R_year.pdf",device="pdf",
       width=3.5,height=3.5,units="in",dpi=1000,scale=1)


SUMLR_n_R <- LR %>%
  group_by(Rcat4) %>%
  summarize(freq=n()) %>%
  mutate(perc=freq/sum(freq)*100)

ggplot(data=SUMLR_n_R,mapping=aes(x=Rcat4,y=freq)) +
  geom_bar(stat="identity",color="black",fill="gray30",width=0.8,size=0.3) +
  scale_x_discrete(name="R (Number of Repeated Readings)") +
  scale_y_continuous(name="Frequency of Precision Calculations",
                     expand=expansion(mult=c(0,0.02))) +
  theme_LR

ggsave(file="docs/Figs/Figure_n_by_R.pdf",device="pdf",
       width=3.5,height=3.5,units="in",dpi=1000,scale=1)






## Metrics Used ----


# Number/Percent metrics used across all STUDIES
SUMBS_ALL <- LRBS %>%
  summarize(n=n(),across(c(PA,APE,ACV,APE2,ACV2,AD,AAD,ASD),sum))
SUMBS_ALL
SUMBS_ALL_P <- SUMBS_ALL %>%
  mutate(across(PA:ASD,~./n*100))
SUMBS_ALL_P
## ASD and APE* were in only 1 pub each, ACV and AAD were in 0 ... thus removed

# Hacky ... trying to make a plot of percent by precision metric, but some bars
# separatedy by whether the metric was used alone or with something else.
xtabs(~ACV,data=filter(LRBS,APE))
xtabs(~APE,data=filter(LRBS,ACV))
xtabs(~I(ACV|APE|AD),data=filter(LRBS,PA))
xtabs(~I(ACV|APE),data=filter(LRBS,AD))

SUMBS_ALL2 <- tibble(Metric=c("PA","PA","APE","APE","ACV","ACV","AD","AD"),
                     CUSE=c("Alone","OTHER","Alone","OTHER",
                            "Alone","OTHER","Alone","OTHER"),
                     Percent=c(40,187,88,119,138,119,0,16)/387*100) %>%
  mutate(Metric=factor(Metric,levels=c("PA","ACV","APE","AD")),
         CUSE=factor(CUSE,levels=c("OTHER","Alone")))

cuselbls <- tibble(SUMBS_ALL2,
                   clbl=c("Only","With APE,\nACV, or AD","Only","With ACV",
                          "Only","With APE","","With APE\nor ACV"),
                   clbly=c(10.3/2,10.3+48.3/2,22.7/2,22.7+30.7/2,
                           35.7/2,30.7+35.7/2,NA,20)
                   )

plbls <- SUMBS_ALL_P %>%
  select(PA,APE,ACV,AD) %>%
  tidyr::pivot_longer(cols=everything(),
                      names_to="Metric",values_to="Percent") %>%
  mutate(Metric=factor(Metric,levels=c("PA","ACV","APE","AD")),
         plbl=paste0(formatC(Percent,format="f",digits=0),"%"))


ggplot() +
  geom_bar(data=SUMBS_ALL2,mapping=aes(x=Metric,y=Percent,fill=CUSE),
           stat="identity",color="black",width=0.8) +
  scale_x_discrete(name="Precision Metric") +
  scale_y_continuous(name="Percent of Studies",
                     expand=expansion(mult=c(0,0.05))) +
  scale_fill_manual(values=c("Alone"="gray40","OTHER"="gray80")) +
  geom_text(data=cuselbls,mapping=aes(x=Metric,y=clbly,label=clbl,color=CUSE)) +
  scale_color_manual(values=c("Alone"="white","OTHER"="black")) +
  annotate(geom="curve",x=4.15,y=16,xend=4.2,yend=3,
           arrow=arrow(angle=20,length=unit(3,"mm"),type="closed"),
           curvature=-0.5) +
  geom_text(data=plbls,mapping=aes(x=Metric,y=Percent,label=plbl),vjust=-0.4) +
  theme_LR +
  theme(legend.position="none")






SUMBS_YR <- LRBS %>%
  group_by(pubyear) %>%
  summarize(n=n(),
            across(c(PA,APE,ACV,APE2,ACV2,AD,AAD,ASD,ACVnAPE,PAnACVorAPE),
                   ~sum(.)/n*100)) %>%
  as.data.frame()

SUMBS_YR2 <- SUMBS_YR %>%
  select(pubyear,PA,APE,ACV) %>%
  tidyr::pivot_longer(cols=PA:ACV,names_to="Metric",values_to="Percent")

ggplot(data=SUMBS_YR2,mapping=aes(x=pubyear,y=Percent,color=Metric)) +
  geom_point(size=2) +
  geom_smooth(data=filter(SUMBS_YR2,pubyear>2000))
  
  geom_line(size=1.25,alpha=0.25)




## XXXX ----
LR_ACV_noNA <- filter(LR,!is.na(ACVmod))
kruskal.test(ACVmod~structure,data=LR_ACV_noNA)
tmp <- FSA::dunnTest(ACVmod~structure,data=LR_ACV_noNA)
tmp$res$Comparison[which(tmp$res$P.adj<0.05)]

strux_sum <- LR_ACV_noNA %>%
  group_by(structure) %>%
  summarize(n=n(),
            mdn=median(ACVmod)) %>%
  mutate(nlbl=paste0("n=",n),
         nx=40,
         lets=c("a","b","bc","c","b","c"),
         mdnlbl=paste0(formatC(mdn,format="f",digits=1)," (",lets,")"))
strux_sum

ggplot() + 
  ggdist::stat_halfeye(data=filter(LR,!is.na(ACVmod)),
                       mapping=aes(y=structure,x=ACVmod),
                       adjust=0.5,height=0.9,justification=0,alpha=0.7,
                       .width=0,point_colour=NA) +
  geom_point(data=filter(LR,!is.na(ACVmod)),
             mapping=aes(y=structure,x=ACVmod),
             shape=108,size=2,alpha=0.3,position=position_nudge(y=-0.05)) +
  geom_point(data=strux_sum,mapping=aes(y=structure,x=mdn),
             shape=25,size=2,fill="black",position=position_nudge(y=0.075)) +
  geom_text(data=strux_sum,mapping=aes(y=structure,x=mdn,label=mdnlbl),
            nudge_y=0.075,vjust=-0.5,hjust=0.1) +
  geom_text(data=strux_sum,mapping=aes(y=structure,x=nx,label=nlbl),
            nudge_y=0.075,vjust=-0.5,hjust=0) +
  scale_y_discrete(name="Calcified Structure",limits=rev) +
  scale_x_continuous(name="ACV",expand=expansion(mult=0.01)) +
  coord_cartesian(ylim=c(1.4,NA),clip="off") +
  theme_LR
  
