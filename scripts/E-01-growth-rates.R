## ---- eval=TRUE----------------------------------------------------------
## only uncomment the next line if you need to install growthrates
#install.packages("growthrates")

## loading the package
library(growthrates)

## ---- eval=FALSE---------------------------------------------------------
?growthrates

## ---- eval=FALSE---------------------------------------------------------
data(package = "growthrates")

## ---- eval=FALSE---------------------------------------------------------
?antibiotic

## ------------------------------------------------------------------------
data(antibiotic)

## ------------------------------------------------------------------------
str(antibiotic)

## ------------------------------------------------------------------------
library(ggplot2)
ggplot(antibiotic,aes(x=time,y=value))+geom_point()

## ------------------------------------------------------------------------
ggplot(antibiotic,aes(x=time,y=value,color=conc))+geom_point()

## ------------------------------------------------------------------------
ggplot(antibiotic,aes(x=time,y=value,color=factor(conc)))+geom_point()

## ------------------------------------------------------------------------
ggplot(antibiotic,aes(x=time,y=value)) +
    geom_point() +
    facet_wrap(~ conc)

