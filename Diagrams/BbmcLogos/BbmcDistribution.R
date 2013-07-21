require(ggplot2)
require(grid)

color1 <- "#B20D35" #maroon4" #http://en.wikipedia.org/wiki/Crimson
color2 <- "gray50"
lineSize <- 1
interpolationPoints <- 1001

g <- ggplot(data.frame(x=seq(from=0, to=10, length=5)), aes(x)) +
  geom_vline(x=0, color=color2) +
  geom_hline(y=0, color=color2) +
  stat_function(fun = dchisq, args=list(df=1), colour=color2, size=lineSize, n=interpolationPoints) +
  stat_function(fun = dchisq, args=list(df=2), colour=color2, size=lineSize, n=interpolationPoints) +
  stat_function(fun = dchisq, args=list(df=3), colour=color1, size=lineSize, n=interpolationPoints) +
  stat_function(fun = dchisq, args=list(df=4), colour=color1, size=lineSize, n=interpolationPoints) +
  stat_function(fun = dchisq, args=list(df=5), colour=color2, size=lineSize, n=interpolationPoints) +
  stat_function(fun = dchisq, args=list(df=6), colour=color2, size=lineSize, n=interpolationPoints) +
  stat_function(fun = dchisq, args=list(df=7), colour=color1, size=lineSize, n=interpolationPoints) +
  stat_function(fun = dchisq, args=list(df=8), colour=color1, size=lineSize, n=interpolationPoints) +

#   geom_rug(color=color2, sides="b") +
#   geom_rug(data=data.frame(y=seq(from=0, to=.5, length=5)),mapping=aes(x, y=y), color=color2, sides="l") +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0), limits=c(0, .6)) +
#   coord_cartesian(xlim=c(0, 2, ylim=c(0, .6))) +
  labs(x="Biomedical and Behavioral Methodology CORE", y=NULL, main=NULL) +
#   annotate(geom="text", x=1, y=.4, label="BBMC", hjust=0, size=28, color=color2, fontface="bold") +
#   annotate(geom="text", x=1, y=.4, label="Beta*Beta*Mu*C", parse=TRUE, hjust=0, size=28, color=color2, fontface="bold") +
#   annotate(geom="text", x=1, y=.4, label="beta*beta*mu*c", parse=TRUE, hjust=0, size=28, color=color2, fontface="bold") +
#   annotate(geom="text", x=1, y=.4, label="beta*beta*Mu*C", parse=TRUE, hjust=0, size=28, color=color2, fontface="bold") +  
#   annotate(geom="text", x=1, y=.4, label="beta*Psi*Mu*C", parse=TRUE, hjust=0, size=28, color=color2, fontface="bold") +  
#   annotate(geom="text", x=1, y=.4, label="over(beta,psi)*Mu%subset%3", parse=TRUE, hjust=0, size=26, color=color2, fontface="bold") +  
#   annotate(geom="text", x=2, y=.375, label="bgroup('(', atop(beta, psi), ')')*Mu%subset%phantom(0)", parse=TRUE, hjust=0, size=20, color=color2, fontface="bold") +  
#   annotate(geom="text", x=2, y=.375, label="bgroup('(', atop(beta, psi), ')')*Mu*(phantom(10))", parse=TRUE, hjust=0, size=20, color=color2, fontface="bold") +  
#  annotate(geom="text", x=.6, y=.45, label="beta%.%psi %.% Mu %.% (phantom(10))", parse=TRUE, hjust=0, size=20, color=color2, fontface="bold") +  
#   annotate(geom="text", x=.6, y=.45, label="beta*psi %~% Mu*(phantom(10))", parse=TRUE, hjust=0, size=20, color=color2, fontface="bold") +  
#   annotate(geom="text", x=.6, y=.45, label="list(beta,...,psi)*Mu*(phantom(10))", parse=TRUE, hjust=0, size=20, color=color2, fontface="bold") +  
#   annotate(geom="text", x=.6, y=.45, label="beta*ldots*psi*Mu*(phantom(10))", parse=TRUE, hjust=0, size=20, color=color2, fontface="bold") +  
#   annotate(geom="text", x=1.4, y=.4, label="widehat(beta*psi)*Mu*(phantom(10))", parse=TRUE, hjust=0, size=28, color=color2, fontface="bold") +  
# annotate(geom="text", x=1, y=.4, label="integral(beta*psi)*Mu*italic(dc)", parse=TRUE, hjust=0, size=20, color=color2, fontface="bold") +  
# annotate(geom="text", x=.4, y=.45, label="(beta+psi)*Mu*italic(c)", parse=TRUE, hjust=0, size=20, color=color2, fontface="bold") +  
#   annotate(geom="text", x=.4, y=.45, label="(beta*+beta)*Mu*italic(c)", parse=TRUE, hjust=0, size=20, color=color2, fontface="bold") +  
#annotate(geom="text", x=.5, y=.4, label="beta*beta*Mu*italic(c)", parse=TRUE, hjust=0, size=34, color=color2, fontface="bold") +  
annotate(geom="text", x=2.3, y=Inf, label="beta*beta*Mu*italic(C)", parse=TRUE, hjust=0, vjust=1, size=34, color=color1, fontface="bold") +  
  
  theme_bw() +
  theme(panel.grid=element_blank()) +
  theme(panel.border=element_blank()) +
  theme(axis.text=element_blank()) +
  theme(axis.title.x=element_text(colour=color2)) +
  theme(axis.title=element_text(face="italic", vjust=1)) +
  theme(plot.background=element_blank()) +
  theme(panel.background=element_blank()) +
  theme(axis.ticks=element_line(colour=color1)) + 
  theme(plot.margin = unit(c(0,0,0,0), "cm"))

ggsave(filename="./Publications/Logos/BbmcDistributionsBackgroundClear.png", width=5.5, height=2.2, dpi=400, bg=NA)
ggsave(filename="./Publications/Logos/BbmcDistributionsBackgroundWhite.png", width=5.5, height=2.2, dpi=400, bg="white")
# ggsave(filename="./Publications/Logos/BbmcDistributionsBackgroundClear.svg", width=5.5, height=2.2, dpi=400, bg=NA)


# dev.off()
