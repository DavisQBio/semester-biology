### Presentation of the survey data

## download.file("https://ndownloader.figshare.com/files/2292169",
##               "data/portal_data_joined.csv")

surveys <- read.csv("data/portal_data_joined.csv")

head(surveys)
## Try also
View(surveys)

## ------------------------------------------------------------------------
str(surveys)


## Challenge
## Based on the output of `str(surveys)`, can you answer the following questions?
## * What is the class of the object `surveys`?
## * How many rows and how many columns are in this object?
## * How many species have been recorded during these surveys?



## Indexing and subsetting data frames

## # first element in the first column of the data frame (as a vector)
surveys[1, 1]
## # first element in the 6th column (as a vector)
surveys[1, 6]
## # first column of the data frame (as a vector)
surveys[, 1]
## # first column of the data frame (as a data.frame)
surveys[1]
## # first three elements in the 7th column (as a vector)
surveys[1:3, 7]
## # the 3rd row of the data frame (as a data.frame)
surveys[3, ]
## # equivalent to head_surveys <- head(surveys)
head_surveys <- surveys[1:6, ]

surveys[, -1]          # The whole data frame, except the first column
surveys[-c(7:34786), ] # Equivalent to head(surveys)

surveys["species_id"]       # Result is a data.frame
surveys[, "species_id"]     # Result is a vector
surveys[["species_id"]]     # Result is a vector
surveys$species_id          # Result is a vector

### Challenges:
###
### 1. Create a `data.frame` (`surveys_200`) containing only the
###    data in row 200 of the `surveys` dataset.
###
### 2. Notice how `nrow()` gave you the number of rows in a `data.frame`?
###
###      * Use that number to pull out just that last row in the data frame
###      * Compare that with what you see as the last row using `tail()` to make
###        sure it's meeting expectations.
###      * Pull out that last row using `nrow()` instead of the row number
###      * Create a new data frame object (`surveys_last`) from that last row
###
### 3. Use `nrow()` to extract the row that is in the middle of the
###    data frame. Store the content of this row in an object named
###    `surveys_middle`.
###
### 4. Combine `nrow()` with the `-` notation above to reproduce the behavior of
###    `head(surveys)`, keeping just the first through 6th rows of the surveys
###    dataset.


### Factors

sex <- factor(c("male", "female", "female", "male"))

levels(sex)
nlevels(sex)

sex # current order
sex <- factor(sex, levels = c("male", "female"))
sex # after re-ordering

## ------------------------------------------------------------------------
as.character(sex)

year_fct <- factor(c(1990, 1983, 1977, 1998, 1990))
as.numeric(year_fct)               # Wrong! And there is no warning...
as.numeric(as.character(year_fct)) # Works...
as.numeric(levels(year_fct))[year_fct]    # The recommended way.

## bar plot of the number of females and males captured 
## during the experiment:
plot(surveys$sex)

## Challenge
##
## * Rename "F" and "M" to "female" and "male" respectively.
## * Now that we have renamed the factor level to "undetermined", can you recreate the
##   barplot such that "undetermined" is last (after "male")

## ## Compare the difference between our data
## ## read as `factor` vs `character`.
surveys <- read.csv("data/portal_data_joined.csv", stringsAsFactors = TRUE)
str(surveys)
surveys <- read.csv("data/portal_data_joined.csv", stringsAsFactors = FALSE)
str(surveys)
## Convert the column "plot_type" into a factor
surveys$plot_type <- factor(surveys$plot_type)

## ---- eval=FALSE, purl=TRUE, echo=FALSE----------------------------------
## ## Challenge:
## ##  There are a few mistakes in this hand-crafted `data.frame`,
## ##  can you spot and fix them? Don't hesitate to experiment!
animal_data <- data.frame(
 animal = c(dog, cat, sea cucumber, sea urchin),
 feel = c("furry", "squishy", "spiny"),
 weight = c(45, 8 1.1, 0.8)
 )
 
## ##   Can you predict the class for each of the columns in the following
## ##   example?
## ##   Check your guesses using `str(country_climate)`:
## ##   * Are they what you expected? Why? why not?
## ##   * What would have been different if we had added `stringsAsFactors = FALSE`
## ##     when we created this data frame?
## ##   * What would you need to change to ensure that each column had the
## ##     accurate data type?
country_climate <- data.frame(country = c("Canada", "Panama", "South Africa", "Australia"),
                           climate = c("cold", "hot", "temperate", "hot/temperate"),
                           temperature = c(10, 30, 18, "15"),
                           northern_hemisphere = c(TRUE, TRUE, FALSE, "FALSE"),
                           has_kangaroo = c(FALSE, FALSE, FALSE, 1))

## ---- eval=FALSE---------------------------------------------------------
str(surveys)

## ---- eval=FALSE, purl=TRUE----------------------------------------------
library(lubridate)

## ------------------------------------------------------------------------
my_date <- ymd("2015-01-01")
str(my_date)

## ------------------------------------------------------------------------
# sep indicates the character to use to separate each component
my_date <- ymd(paste("2015", "1", "1", sep = "-")) 
str(my_date)

## ---- eval=FALSE---------------------------------------------------------
paste(surveys$year, surveys$month, surveys$day, sep = "-")

## ----eval=FALSE----------------------------------------------------------
ymd(paste(surveys$year, surveys$month, surveys$day, sep = "-"))

## ---- results="hide"-----------------------------------------------------
surveys$date <- ymd(paste(surveys$year, surveys$month, surveys$day, sep = "-"))
str(surveys) # notice the new column, with 'date' as the class

## ------------------------------------------------------------------------
summary(surveys$date)

## ---- results=TRUE-------------------------------------------------------
is_missing_date <- is.na(surveys$date)
date_columns <- c("year", "month", "day")
missing_dates <- surveys[is_missing_date,  date_columns]

head(missing_dates)




