------------------------------------------------------------------------

> ### Learning Objectives
>
> -   Work with growth rate data to explore mathematical growth models.
> -   Manipulate model parameters to build intuition.

------------------------------------------------------------------------

As always, you can download [a script with nothing but the R code here](../scripts/E-02-growth-rate-models.R).

Loading the growth rate data
----------------------------

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

Okay, we have a few things to unpack. First, we got a suprise message when we loaded `dplyr`. It mentions some "objects" from other packages that are now "masked". This is because dplyr has functions named filter, lag, and intersect, setdiff, etc. But functions with those names already exist in R. So, when `dplyr` is loaded, it masks the other version. Thus, when you call the function `filter()`, it will be the function from the `dplyr` package, not the basic function from the `stats` package. This is usually not a big deal, but it's something to remember if a function seems to be working oddly.

Second, we didn't define the *color* aesthetic this time. Why not? Well, because we are only looking at a single concentration level, so we don't need it.

Comparing with a theoretical model
----------------------------------

Okay, so how do we model this? If you're currently taking BIS 23a or a similar course, you may have learned about this in lecture. For a refresher, this [Khan Academy page](https://www.khanacademy.org/science/biology/ecology/population-growth-and-regulation/a/exponential-logistic-growth) has a walkthrough about modeling population growth.

The simplest model is often the best. If it fits the data well, then you can have clear interpretations and predictions. Let's start with basic, exponential growth and see how it looks. Fundamentally, the exponential model is based on the assumption that a population's growth rate is proportional the current population size. In other words, even though each individual reproduces at a similar rate, on average, the actual rate of new offspring will go up as the population increases. For humans, there are many factors that make the global population growth different from exponential.
[Our World in Data](https://ourworldindata.org/world-population-growth) has a nice deep dive into human population growth trends.

But for bacteria, particularly at small population sizes, the exponential model might fit well. In mathematical terms, our assumption of proportional growth rate can be translated into an equation as $\\frac{dN}{dt} = rN$. Here *N* is the population size, *t* is the time variable, and *r* is a parameter to represent the growth rate. You can think of *r* as a parameter that represents net growth, incorporating both births and deaths. If a population is decreasing, it's totally possible that *r* could be negative, when births are occurring less often than deaths. To put the equation into words, the change in population as a particular moment equals the growth rate *r* times the population size *N*.

This is not a course on differential equations. But it turns out that the solution to this equation is pleasantly simple: *N*(*t*)=*e*<sup>*r**t*</sup>*N*(0). So the population at some time *t* is a function of *N*(0), the intial population, times *e*<sup>*r**t*</sup>. So *N*(*t*) is an expontential function of *t*, hence we call this the exponential model.

But does it fit our data well? This next step will get you used to the typical way that we visualize models in R.

Visualizing the exponential model
---------------------------------

To plot the function, we can generate model output by taking a vector of time points, and applying the function to each one. It feels confusing at first, but it's surprisingly simple to do.

``` r
antibiotic_0 <- mutate(antibiotic_0, model_output = exp(0.57*time)*0.01)
p <- ggplot(antibiotic_0,aes(x=time,y=value))+geom_point()
p <- p + geom_line(aes(y=model_output), color = "red")
p <- p + ylim(c(0,1))
p
```

    ## Warning: Removed 176 rows containing missing values (geom_path).

![figure](E-02-growth-rate-models_files/figure-markdown_github/unnamed-chunk-5-1.png)

The code above might look scary, so let's walk through it. I first updated the dataframe `antibiotic_0`. The `mutate()` function in `dplyr` allows you to create a new column as a function of other columns. So I used the time column and applied the exponential function from above. Note I used 0.01 as the *N*(0), based on the inspection of the data. And I used *r* = 0.57 because I explored and found that that value of *r* fit the data well for early time steps.

But... this model is definitely not fitting the data for later time.

#### Exploration -- model parameters

> \*We got the data to fit fairly well at early time steps, but then it was way off for later times. Can you find *r* and *N*(0) to fit the data better&gt; Explore a little bit by changing the values in the line of code with the `mutate()` function. I suspect you won't ever find a great fit. Why not?

<p style="text-align: right; font-size: small;">
Page built on: 2018-09-11 at 15:34:47
</p>
