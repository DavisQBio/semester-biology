## ------------------------------------------------------------------------
library(growthrates)
data(antibiotic)
str(antibiotic)

## ------------------------------------------------------------------------
library(ggplot2)
ggplot(antibiotic,aes(x=time,y=value,color=factor(conc)))+geom_point()

## ------------------------------------------------------------------------
library(dplyr)
antibiotic_0 <- filter(antibiotic, conc == 0)
ggplot(antibiotic_0,aes(x=time,y=value))+geom_point()

## ------------------------------------------------------------------------
r <- 0.57
N0 <- 0.01
antibiotic_0 <- mutate(antibiotic_0, model_output = exp(r*time)*N0)
p <- ggplot(antibiotic_0,aes(x=time,y=value))+geom_point()
p <- p + geom_line(aes(y=model_output), color = "red")
p <- p + ylim(c(0,1))
p

## ------------------------------------------------------------------------
log_growth <- function(t,K,r,N0)
{
    N <- K*N0/(N0+(K-N0)*exp(-r*t))
    return(N)
}

## ------------------------------------------------------------------------
K <- .75
r <- .57
N0 <- 0.01
antibiotic_0 <- mutate(antibiotic_0, model_logistic_output = log_growth(time,K,r,N0))
p <- ggplot(antibiotic_0,aes(x=time,y=value))+geom_point()
p <- p + geom_line(aes(y=model_logistic_output), color = "red")
p <- p + ylim(c(0,1))
p

## ---- child="../_page_built_on.Rmd"--------------------------------------



