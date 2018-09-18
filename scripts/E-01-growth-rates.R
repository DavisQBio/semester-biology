## only uncomment the next line if you need to install growthrates
#install.packages("growthrates")

## loading the package
library(growthrates)

if(!require(growthrates)) install.packages("growthrates",repos = "http://cran.us.r-project.org")

?growthrates

data(package = "growthrates")

?antibiotic

## loading the data
data(antibiotic)

str(antibiotic)

## loading ggplot2
library(ggplot2)

## basic plot
ggplot(antibiotic,aes(x=time,y=value))+geom_point()

## plot with colors for antibiotic concentration
ggplot(antibiotic,aes(x=time,y=value,color=conc))+geom_point()

## better looking plot, turning concentrations into factors instead of numeric data
ggplot(antibiotic,aes(x=time,y=value,color=factor(conc)))+geom_point()

