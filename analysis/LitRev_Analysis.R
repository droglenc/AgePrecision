#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#
#= This reads the flat file in LitReview.RData and .                         =#
#=                                                                           =#
#= If the data on GoogleSheets was changed then source LitReview_PREPPER.R   =#
#=   to recreate the literature review database.                             =#
#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#

## Setup ----
cat("\014")
library(ggplot2)
library(dplyr)
load("data/LitReview.RData")  ## loads LR data.frame

theme_LR <- theme_bw(base_size=12,) +
  theme(panel.grid.minor=element_line(linetype="dashed",color="gray90"),
        panel.grid.major=element_line(linetype="dashed",color="gray90"),
        strip.text=element_text(color="white",face="bold",size=rel(1.1)),
        strip.background=element_rect(fill="black",linetype="solid",size=1.5),
        panel.border=element_rect(colour="black",linetype="solid",size=1),
        legend.background=element_blank(),
        legend.key.size=unit(3,"mm"),
        axis.title=element_text(size=rel(1.2)),
        legend.title=element_blank(),
        legend.text=element_text(size=rel(1.1)))

## XXXX ----
ggplot(data=LR,mapping=aes(x=pubyear)) +
  geom_bar(color="black",fill="gray70",width=0.8) +
  scale_y_continuous(name="Frequency of Precision Calculations",
                     expand=expansion(mult=c(0,0.05))) +
  scale_x_continuous(name="Publication Year",expand=expansion(mult=0.01),
                     breaks=seq(1995,2020,5)) +
  theme_LR

## Removed holocephali and petromyzonti because n was so small
xtabs(~class,data=LR)
ggplot(data=filter(LR,class %in% c("Actinopteri","Elasmobranchii")),
                   mapping=aes(x=structure)) +
  geom_bar(color="black",fill="gray70",width=0.8) +
  scale_y_continuous(name="Frequency of Precision Calculations",
                     expand=expansion(mult=c(0,0.05))) +
  scale_x_discrete(name="Calcified Structure") +
  facet_wrap(vars(class)) +
  theme_LR

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
  
