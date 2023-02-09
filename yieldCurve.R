remove(list=ls())
setwd("/Users/almei/Dropbox/Fortem/GitHub/yieldCurve")

library(GetTDData)
library(ggplot2)

df.yield = get.yield.curve()  
str(df.yield)

p = ggplot(df.yield, aes(x=ref.date, y = value) ) +
  geom_line(linewidth=1) + geom_point() + facet_grid(~type, scales = 'free') + 
  labs(title = paste0('Brazilian Yield Curve '),
  subtitle = paste0('Date: ', df.yield$current.date[1]))     

print(p)
