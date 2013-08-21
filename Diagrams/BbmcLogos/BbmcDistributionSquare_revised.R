require(ggplot2)
require(grid)

color1 <- "#B20D35" #Official OU RGB specification #http://en.wikipedia.org/wiki/Crimson
color2 <- "gray50"
lineSize <- 1
interpolationPoints <- 1001

g <- ggplot(data.frame(x=seq(from=0, to=10, length=5)), aes(x)) +
#   geom_vline(x=0, color=color2) +
#   geom_hline(y=0, color=color2) +
  stat_function(fun = dchisq, args=list(df=1), colour=color2, size=lineSize, n=interpolationPoints) +
  stat_function(fun = dchisq, args=list(df=2), colour=color2, size=lineSize, n=interpolationPoints) +
  stat_function(fun = dchisq, args=list(df=3), colour=color1, size=lineSize, n=interpolationPoints) +
  stat_function(fun = dchisq, args=list(df=4), colour=color1, size=lineSize, n=interpolationPoints) +
  stat_function(fun = dchisq, args=list(df=5), colour=color2, size=lineSize, n=interpolationPoints) +
  stat_function(fun = dchisq, args=list(df=6), colour=color2, size=lineSize, n=interpolationPoints) +
  stat_function(fun = dchisq, args=list(df=7), colour=color1, size=lineSize, n=interpolationPoints) +
  stat_function(fun = dchisq, args=list(df=8), colour=color1, size=lineSize, n=interpolationPoints) +

  scale_x_continuous(expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0), limits=c(0, .41)) +
  #labs(x="Biomedical and Behavioral Methodology CORE", y=NULL, main=NULL) +
  labs(x=NULL, y=NULL, main=NULL) +
#   annotate(geom="text", x=1, y=.4, label="BBMC", hjust=0, size=28, color=color2, fontface="bold") +
  #annotate(geom="text", x=9.85, y=.55, label="beta*beta*Mu*italic(C)", parse=TRUE, hjust=1, vjust=1,
  annotate(geom="text", x=9.9, y=.3, label="beta*beta*Mu*italic(C)", parse=TRUE, hjust=1, vjust=1, 
           size=15, color=color1, fontface="bold") +  
#   annotate(geom="text", x=9.9, y=.3, label="OUHSC\nPediatrics", hjust=1, vjust=1, lineheight=.7,
#            size=7, color=color2) +  
  
  theme_bw() +
  theme(panel.grid=element_blank()) +
  theme(panel.border=element_blank()) +
  theme(axis.text=element_blank()) +
  theme(axis.title.x=element_text(colour=color2, size=7)) +
  theme(axis.title=element_text(face="italic", vjust=1)) +
  theme(plot.background=element_blank()) +
  theme(panel.background=element_blank()) +
  theme(axis.ticks=element_blank()) +
  theme(plot.margin = unit(c(0,0,0,0), "cm"))

ggsave(filename="./Diagrams/BbmcLogos/BbmcDistributionsBackgroundSquareClear2.png", width=2.2, height=2.2, dpi=400, bg=NA)
ggsave(filename="./Diagrams/BbmcLogos/BbmcDistributionsBackgroundSquareWhite2.png", width=2.2, height=2.2, dpi=400, bg="white")

shell.exec(file.path(getwd(),"Diagrams/BbmcLogos/BbmcDistributionsBackgroundSquareClear2.png"))
shell.exec(file.path(getwd(),"Diagrams/BbmcLogos/BbmcDistributionsBackgroundSquareWhite2.png"))


# dev.off()
