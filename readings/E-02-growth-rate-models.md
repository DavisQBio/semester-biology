------------------------------------------------------------------------

> ### Learning Objectives
>
> -   Work with growth rate data to explore mathematical growth models.
> -   Manipulate model parameters to build intuition.

------------------------------------------------------------------------

As always, you can download [a script with nothing but the R code here](../scripts/E-02-growth-rate-models.R).

Loading the growth rate data.
-----------------------------

You can remind yourself of these data by reviewing the [previous reading](../readings/E-01-growth-rates). Let's quickly load these data again.

``` r
library(growthrates)
```

    ## Loading required package: lattice

    ## Loading required package: deSolve

``` r
data(antibiotic)
str(antibiotic)
```

    ## 'data.frame':    2928 obs. of  5 variables:
    ##  $ time    : num  0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 ...
    ##  $ variable: Factor w/ 48 levels "R_R3_0","R_R3_0.002",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ value   : num  0.00881 0.00981 0.01281 0.01781 0.02281 ...
    ##  $ conc    : num  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ repl    : Factor w/ 4 levels "R3","R4","R5",..: 1 1 1 1 1 1 1 1 1 1 ...

Okay, here's the same quick summary of our data that we saw before. Let's pull up that final plot as well.

``` r
library(ggplot2)
ggplot(antibiotic,aes(x=time,y=value,color=factor(conc)))+geom_point()
```

![figure](E-02-growth-rate-models_files/figure-markdown_github/unnamed-chunk-3-1.png)

Wow, these look like some pretty well-behaved data! The replicates at the same antibiotic concentration are pretty similar to each other, while bacteria grown at increasing antibiotic concentrations show decreasing growth rates. Trying to build a model to include time and antibiotic concentration is a bit above our paygrade right now. Let's just focus on a single concentration; why not start at 0. The package `dplyr` has some nice tools for quickly filtering data to particular subsets. Don't forget to install it first!

``` r
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
antibiotic_0 <- filter(antibiotic, conc == 0)
ggplot(antibiotic_0,aes(x=time,y=value))+geom_point()
```

![figure](E-02-growth-rate-models_files/figure-markdown_github/unnamed-chunk-4-1.png)

<p style="text-align: right; font-size: small;">
Page built on: 2018-09-11 at 14:20:22
</p>
