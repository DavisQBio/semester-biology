## ---- echo=FALSE, purl=TRUE----------------------------------------------
### Data Visualization with ggplot2

## ---- eval=FALSE---------------------------------------------------------
library(tidyverse)

## ---- eval=FALSE---------------------------------------------------------
surveys_complete <- read_csv("data_output/surveys_complete.csv")

## ----plot-basic----------------------------------------------------------
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point()

## ----using-plus----------------------------------------------------------
# Assign plot to a variable
surveys_plot <- ggplot(data = surveys_complete, 
                       mapping = aes(x = weight, y = hindfoot_length))

# Draw the plot
surveys_plot + 
    geom_point()

## ---- eval=FALSE---------------------------------------------------------
## # This is the correct syntax for adding layers
surveys_plot +
geom_point()
## 
## # This will not add the new layer and will return an error message
surveys_plot
geom_point()

## ---- eval = FALSE-------------------------------------------------------
## install.packages("hexbin")
library(hexbin)

## ---- eval = FALSE-------------------------------------------------------
## surveys_plot +
##  geom_hex()

## ---- echo=FALSE, eval=FALSE, purl=TRUE----------------------------------
## ### Challenge with hexbin
## ##
## ## To use the hexagonal binning with **`ggplot2`**, first install the `hexbin`
## ## package from CRAN:
## 
## install.packages("hexbin")
library(hexbin)
## 
## ## Then use the `geom_hex()` function:
## 
surveys_plot +
    geom_hex()
## 
## ## What are the relative strengths and weaknesses of a hexagonal bin
## ## plot compared to a scatter plot?

## ----adding-alpha--------------------------------------------------------
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
    geom_point(alpha = 0.1)

## ----adding-colors-------------------------------------------------------
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
    geom_point(alpha = 0.1, color = "blue")

## ----color-by-species----------------------------------------------------
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
    geom_point(alpha = 0.1, aes(color = species_id))

## ----boxplot-------------------------------------------------------------
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
    geom_boxplot()

## ----boxplot-with-points-------------------------------------------------
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
    geom_boxplot(alpha = 0) +
    geom_jitter(alpha = 0.3, color = "tomato")

## ----boxplot-challenge, eval=FALSE, purl=TRUE, echo=FALSE----------------
## ## Challenge with boxplots:
## ##  Start with the boxplot we created:
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
    geom_boxplot(alpha = 0) +
    geom_jitter(alpha = 0.3, color = "tomato")
## 
## ##  1. Replace the box plot with a violin plot; see `geom_violin()`.
## 
## ##  2. Represent weight on the log10 scale; see `scale_y_log10()`.
## 
## ##  3. Create boxplot for `hindfoot_length` overlaid on a jitter layer.
## 
## ##  4. Add color to the data points on your boxplot according to the
## ##  plot from which the sample was taken (`plot_id`).
## ##  *Hint:* Check the class for `plot_id`. Consider changing the class
## ##  of `plot_id` from integer to factor. Why does this change how R
## ##  makes the graph?
## 

## ------------------------------------------------------------------------
yearly_counts <- surveys_complete %>%
                 count(year, species_id)

## ----first-time-series---------------------------------------------------
ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
     geom_line()

## ----time-series-by-species----------------------------------------------
ggplot(data = yearly_counts, mapping = aes(x = year, y = n, group = species_id)) +
    geom_line()

## ----time-series-with-colors---------------------------------------------
ggplot(data = yearly_counts, mapping = aes(x = year, y = n, color = species_id)) +
    geom_line()

## ----first-facet---------------------------------------------------------
ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
    geom_line() +
    facet_wrap(~ species_id)

## ------------------------------------------------------------------------
 yearly_sex_counts <- surveys_complete %>%
                      count(year, species_id, sex)

## ----facet-by-species-and-sex--------------------------------------------
 ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color = sex)) +
     geom_line() +
     facet_wrap(~ species_id)

## ----facet-by-species-and-sex-white-bg-----------------------------------
 ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color = sex)) +
     geom_line() +
     facet_wrap(~ species_id) +
     theme_bw() +
     theme(panel.grid = element_blank())

## ---- eval=FALSE, purl=TRUE, echo=FALSE----------------------------------
## ### Plotting time series challenge:
## ##
## ##  Use what you just learned to create a plot that depicts how the
## ##  average weight of each species changes through the years.
## 

## ----average-weight-time-facet-sex-rows----------------------------------
# One column, facet by rows
yearly_sex_weight <- surveys_complete %>%
    group_by(year, sex, species_id) %>%
    summarize(avg_weight = mean(weight))
ggplot(data = yearly_sex_weight, 
       mapping = aes(x = year, y = avg_weight, color = species_id)) +
    geom_line() +
    facet_grid(sex ~ .)

## ----number-species-year-with-right-labels-------------------------------
ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color = sex)) +
    geom_line() +
    facet_wrap(~ species_id) +
    labs(title = "Observed species in time",
         x = "Year of observation",
         y = "Number of species") +
    theme_bw()

## ----number-species-year-with-right-labels-xfont-size--------------------
ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color = sex)) +
    geom_line() +
    facet_wrap(~ species_id) +
    labs(title = "Observed species in time",
        x = "Year of observation",
        y = "Number of species") +
    theme_bw() +
    theme(text=element_text(size = 16))

## ----number-species-year-with-theme--------------------------------------
ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color = sex)) +
    geom_line() +
    facet_wrap(~ species_id) +
    labs(title = "Observed species in time",
        x = "Year of observation",
        y = "Number of species") +
    theme_bw() +
    theme(axis.text.x = element_text(colour = "grey20", size = 12, angle = 90, hjust = 0.5, vjust = 0.5),
          axis.text.y = element_text(colour = "grey20", size = 12),
          text = element_text(size = 16))

## ----number-species-year-with-right-labels-xfont-orientation-------------
grey_theme <- theme(axis.text.x = element_text(colour = "grey20", size = 12, angle = 90, hjust = 0.5, vjust = 0.5),
                    axis.text.y = element_text(colour = "grey20", size = 12),
                    text = element_text(size = 16))
ggplot(surveys_complete, aes(x = species_id, y = hindfoot_length)) +
    geom_boxplot() +
    grey_theme

## ----install-gridextra, message=FALSE, purl=TRUE, eval=FALSE-------------
## install.packages("gridExtra")

## ----ggsave-example, eval=FALSE------------------------------------------
my_plot <- ggplot(data = yearly_sex_counts,
                  mapping = aes(x = year, y = n, color = sex)) +
    geom_line() +
    facet_wrap(~ species_id) +
    labs(title = "Observed species in time",
         x = "Year of observation",
         y = "Number of species") +
    theme_bw() +
    theme(axis.text.x = element_text(colour = "grey20", size = 12, angle = 90, hjust = 0.5, vjust = 0.5),
          axis.text.y = element_text(colour = "grey20", size = 12),
          text=element_text(size = 16))

ggsave("fig_output/yearly_sex_counts.png", my_plot, width = 15, height = 10)

## # This also works for grid.arrange() plots
combo_plot <- grid.arrange(spp_weight_boxplot, spp_count_plot, ncol = 2, widths = c(4, 6))
ggsave("fig_output/combo_plot_abun_weight.png", combo_plot, width = 10, dpi = 300)

## ----final-challenge, eval=FALSE, purl=TRUE, echo=FALSE------------------
## ### Final plotting challenge:
## ##  With all of this information in hand, please take another five
## ##  minutes to either improve one of the plots generated in this
## ##  exercise or create a beautiful graph of your own. Use the RStudio
## ##  ggplot2 cheat sheet for inspiration:
## ##  https://www.rstudio.com/wp-content/uploads/2015/08/ggplot2-cheatsheet.pdf




