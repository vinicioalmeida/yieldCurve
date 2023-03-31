remove(list=ls())
setwd("/Users/almei/Dropbox/Fortem/GitHub/yieldCurve")

library(GetTDData)
library(ggplot2)
library(tidyverse)
library(writexl)
library(readxl)

#download.TD.data(            # retrieves data from Tesouro Nacional
#  asset.codes = NULL,
#  dl.folder = getwd(),
#  do.clean.up = FALSE,
#  do.overwrite = FALSE,
#  n.dl = NULL
#)

df.yield = get.yield.curve()  # from ANBIMA  
str(df.yield)                 # display internal structure of the object
df.yield = df.yield %>% mutate(type = str_replace(type, "implicit_inflation", "Implicit inflation"))
df.yield = df.yield %>% mutate(type = str_replace(type, "nominal_return", "Nominal return"))
df.yield = df.yield %>% mutate(type = str_replace(type, "real_return", "Real return"))
Year = df.yield$ref.date
Return = df.yield$value

p = ggplot(df.yield, aes(x=Year, y = Return) ) +
  geom_line(linewidth=0.5) + geom_point() + 
  facet_grid(~type, scales = 'free') + 
  labs(title = paste0('Brazilian Yield Curve '),
       subtitle = paste0('Date: ', df.yield$current.date[1]))     
print(p)

# Short term nominal rate
days = 23
rf = ((1 + (Return[75]) / 100) ^ (days / 252) - 1) * 100
rf

# Historical yield curve
date = df.yield$current.date[1]
ycfile = paste("yc", date, ".xlsx", sep = "")
write_xlsx(df.yield, ycfile)

# Plot curves