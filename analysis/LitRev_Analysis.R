

## Metrics Used ----
# Number/Percent metrics used across all STUDIES
SUMLRBS_n_Metrics <- LRBS %>%
  summarize(n=n(),across(c(PA,APE,ACV,APE2,ACV2,AD,AAD,ASD),sum))
SUMLRBS_n_Metrics
SUMLRBS_P_Metrics <- SUMLRBS_n_Metrics %>%
  mutate(across(PA:ASD,~./n*100))
SUMLRBS_P_Metrics
## ASD and APE* were in only 1 pub each, ACV and AAD were in 0 ... thus removed

# Hacky ... trying to make a plot of percent by precision metric, but some bars
# separated by whether the metric was used alone or with something else.
xtabs(~I(ACV|APE|AD),data=filter(LRBS,PA))
xtabs(~APE,data=filter(LRBS,ACV))
xtabs(~ACV,data=filter(LRBS,APE))
xtabs(~I(ACV|APE),data=filter(LRBS,AD))

SUMLRBS_P_Metrics2 <- tibble(Metric=c("PA","PA","ACV","ACV","APE","APE","AD","AD"),
                             CUSE=c("Alone","OTHER","Alone","OTHER",
                                    "Alone","OTHER","Alone","OTHER"),
                             Percent=c(38,187,138,118,87,118,0,16)/383*100) %>%
  mutate(Metric=factor(Metric,levels=c("PA","ACV","APE","AD")),
         CUSE=factor(CUSE,levels=c("OTHER","Alone")))

cuselbls <- tibble(SUMLRBS_P_Metrics2,
                   clbl=c("Only\nPA","With APE,\nACV, or AD",
                          "Without\nAPE","With APE","Without\nACV","With ACV",
                          "","With APE\nor ACV"),
                   clbly=c(9.9/2,9.9+48.8/2,36.0/2,30.8+36.0/2,
                           22.7/2,22.7+30.8/2,NA,15)
                   )

plbls <- SUMLRBS_P_Metrics %>%
  select(PA,APE,ACV,AD) %>%
  tidyr::pivot_longer(cols=everything(),
                      names_to="Metric",values_to="Percent") %>%
  mutate(Metric=factor(Metric,levels=c("PA","ACV","APE","AD")),
         plbl=paste0(formatC(Percent,format="f",digits=0),"%"))


ggplot() +
  geom_bar(data=SUMBS_ALL2,mapping=aes(x=Metric,y=Percent,fill=CUSE),
           stat="identity",color="black",width=0.8,size=0.3) +
  scale_x_discrete(name="Precision Metric") +
  scale_y_continuous(name="Percent of Studies",
                     expand=expansion(mult=c(0,0.05))) +
  scale_fill_manual(values=c("Alone"="gray40","OTHER"="gray80")) +
  geom_text(data=plbls,mapping=aes(x=Metric,y=Percent,label=plbl),
            vjust=-0.4,size=2.5) +
  geom_text(data=cuselbls,mapping=aes(x=Metric,y=clbly,label=clbl,color=CUSE),
            size=2.5) +
  scale_color_manual(values=c("Alone"="white","OTHER"="black")) +
  annotate(geom="curve",x=4.3,y=14,xend=4.2,yend=2,
           arrow=arrow(angle=20,length=unit(1.5,"mm"),type="closed"),
           curvature=-0.3,size=0.3) +
  theme(legend.position="none")

ggsave(file="docs/Figs/Figure_P_MetricUsed.pdf",device="pdf",
       width=3.5,height=3.5,units="in",dpi=1000,scale=1)



SUMBLRBS_P_Metrics_year5 <- LRBS %>%
  group_by(pubyear5) %>%
  summarize(n=n(),
            across(c(PA,APE,ACV,APE2,ACV2,AD,AAD,ASD),
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
  
