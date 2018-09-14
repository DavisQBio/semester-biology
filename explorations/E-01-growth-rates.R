## ---- eval=TRUE----------------------------------------------------------
library(growthrates)

## ---- eval=TRUE----------------------------------------------------------
if(!require(growthrates)) install.packages("growthrates",repos = "http://cran.us.r-project.org")

## ---- eval=FALSE---------------------------------------------------------
## ?growthrates

## ---- eval=FALSE---------------------------------------------------------
## data(package = "growthrates")

## ---- eval=FALSE---------------------------------------------------------
## ?antibiotic

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

## ---- child="../_page_built_on.Rmd"--------------------------------------



