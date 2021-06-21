theme_LR <- theme_bw(base_size=10) +
  theme(panel.grid.minor=element_blank(),
        panel.grid.major=element_blank(),
        # control axis text sizes
        axis.text=element_text(size=8,color="black"),
        axis.title=element_text(size=10,color="black"),
        # control facet look
        strip.text=element_text(color="white",face="bold",size=10),
        strip.background=element_rect(fill="black",linetype="solid"),
        strip.text.x=element_text(margin=margin(1,0,1,0)),
        strip.text.y=element_text(margin=margin(0,2,0,2)),
        # put a border around the panel
        panel.border=element_rect(color="black",linetype="solid"),
        # Change legend look
        legend.background=element_blank(),
        legend.title=element_blank(),
        legend.text=element_text(size=7),
        legend.key.size=unit(4,"mm")
  )

theme_set(theme_LR)
