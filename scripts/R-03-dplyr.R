## ---- eval=FALSE---------------------------------------------------------
## ##Only run this if you haven't already installed it
## install.packages("tidyverse")

## ----eval=FALSE----------------------------------------------------------
## ## load the tidyverse packages, incl. dplyr
library("tidyverse")

## ----results=FALSE, message=FALSE----------------------------------------
surveys <- read_csv("data/portal_data_joined.csv")

## inspect the data
str(surveys)

## preview the data using R's excel-like data viewer
View(surveys)

## ---- results = 'hide'---------------------------------------------------
select(surveys, plot_id, species_id, weight)

## ---- results = 'hide'---------------------------------------------------
filter(surveys, year == 1995)

## ------------------------------------------------------------------------
surveys_1995 <- filter(surveys, year == 1995)

## ------------------------------------------------------------------------
surveys2 <- filter(surveys, weight < 5)
surveys_sml <- select(surveys2, species_id, sex, weight)

## ------------------------------------------------------------------------
surveys_sml <- select(filter(surveys, weight < 5), species_id, sex, weight)

## ------------------------------------------------------------------------
surveys %>%
  filter(weight < 5) %>%
  select(species_id, sex, weight)

## ------------------------------------------------------------------------
surveys_sml <- surveys %>%
  filter(weight < 5) %>%
  select(species_id, sex, weight)

surveys_sml

## ---- eval=FALSE, purl=TRUE, echo=FALSE----------------------------------
## ## Pipes Challenge:
## ##  Using pipes, subset the data to include animals collected
## ##  before 1995, and retain the columns `year`, `sex`, and `weight.`

## ----eval=FALSE----------------------------------------------------------
surveys %>%
   mutate(weight_kg = weight / 1000)

## ----eval=FALSE----------------------------------------------------------
surveys %>%
  mutate(weight_kg = weight / 1000,
         weight_kg2 = weight_kg * 2)

## ---- eval=FALSE---------------------------------------------------------
surveys %>%
  mutate(weight_kg = weight / 1000) %>%
  head()

## ---- eval=FALSE---------------------------------------------------------
surveys %>%
  filter(!is.na(weight)) %>%
  mutate(weight_kg = weight / 1000) %>%
  head()

## ------------------------------------------------------------------------
surveys_kg <- surveys %>%
  filter(!is.na(weight)) %>%
  mutate(weight_kg = weight / 1000)

## ---- eval=FALSE, purl=TRUE, echo=FALSE----------------------------------
## ## Mutate Challenge:
## ##  Create a new data frame from the `surveys` data that meets the following
## ##  criteria: contains only the `species_id` column and a column that
## ##  contains values that are half the `hindfoot_length` values (e.g. a
## ##  new column `hindfoot_half`). In this `hindfoot_half` column, there are
## ##  no NA values and all values are < 30.
## 
## ##  Hint: think about how the commands should be ordered to produce this data frame!

## ----results=FALSE-------------------------------------------------------
surveys %>%
  group_by(sex) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))

## ----results=FALSE-------------------------------------------------------
surveys %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))

## ----results=FALSE-------------------------------------------------------
surveys %>%
  filter(!is.na(weight)) %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight))

## ---- results = FALSE----------------------------------------------------
surveys %>%
  filter(!is.na(weight)) %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight)) %>%
  print(n = 15)

## ---- results = FALSE----------------------------------------------------
surveys %>%
  filter(!is.na(weight)) %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight),
            min_weight = min(weight))

## ---- results = FALSE----------------------------------------------------
surveys %>%
  filter(!is.na(weight)) %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight),
            min_weight = min(weight)) %>%
  arrange(min_weight)

## ---- results = FALSE----------------------------------------------------
surveys %>%
  filter(!is.na(weight)) %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight),
            min_weight = min(weight)) %>%
  arrange(desc(mean_weight))

## ------------------------------------------------------------------------
surveys %>%
    count(sex) 

## ---- results = FALSE----------------------------------------------------
surveys %>%
    group_by(sex) %>%
    summarise(count = n())

## ---- results = FALSE----------------------------------------------------
surveys %>%
    count(sex, sort = TRUE) 

## ----results = FALSE-----------------------------------------------------
surveys %>%
  count(sex, species) 

## ----results = FALSE-----------------------------------------------------
surveys %>%
  count(sex, species) %>%
  arrange(species, desc(n))

## ---- eval=FALSE, purl=TRUE, echo=FALSE----------------------------------
## ## Count Challenges:
## ##  1. How many animals were caught in each `plot_type` surveyed?
## 
## ##  2. Use `group_by()` and `summarize()` to find the mean, min, and max
## ## hindfoot length for each species (using `species_id`). Also add the number of
## ## observations (hint: see `?n`).
## 
## ##  3. What was the heaviest animal measured in each year? Return the
## ##  columns `year`, `genus`, `species_id`, and `weight`.

## ----results=FALSE-------------------------------------------------------
surveys_gw <- surveys %>%
  filter(!is.na(weight)) %>%
  group_by(genus, plot_id) %>%
  summarize(mean_weight = mean(weight))

str(surveys_gw)

## ------------------------------------------------------------------------
surveys_spread <- surveys_gw %>%
  spread(key = genus, value = mean_weight)

str(surveys_spread)

## ---- results=FALSE------------------------------------------------------
surveys_gw %>%
  spread(genus, mean_weight, fill = 0) %>%
  head()

## ------------------------------------------------------------------------
surveys_gather <- surveys_spread %>%
  gather(key = genus, value = mean_weight, -plot_id)

str(surveys_gather)

## ------------------------------------------------------------------------
surveys_spread %>%
  gather(key = genus, value = mean_weight, Baiomys:Spermophilus) %>%
  head()

## ---- eval=FALSE, purl=TRUE, echo=FALSE----------------------------------
## ## Reshaping challenges
## 
## ## 1. Make a wide data frame with `year` as columns, `plot_id`` as rows, and where the values are the number of genera per plot. You will need to summarize before reshaping, and use the function `n_distinct` to get the number of unique genera within a chunk of data. It's a powerful function! See `?n_distinct` for more.
## 
## ## 2. Now take that data frame, and make it long again, so each row is a unique `plot_id` `year` combination
## 
## ## 3. The `surveys` data set is not truly wide or long because there are two columns of measurement - `hindfoot_length` and `weight`.  This makes it difficult to do things like look at the relationship between mean values of each measurement per year in different plot types. Let's walk through a common solution for this type of problem. First, use `gather` to create a truly long dataset where we have a key column called `measurement` and a `value` column that takes on the value of either `hindfoot_length` or `weight`. Hint: You'll need to specify which columns are being gathered.
## 
## ## 4. With this new truly long data set, calculate the average of each `measurement` in each `year` for each different `plot_type`. Then `spread` them into a wide data set with a column for `hindfoot_length` and `weight`. Hint: Remember, you only need to specify the key and value columns for `spread`.
## 

## ------------------------------------------------------------------------
surveys_complete <- surveys %>%
  filter(!is.na(weight),           # remove missing weight
         !is.na(hindfoot_length),  # remove missing hindfoot_length
         !is.na(sex))                # remove missing sex

## ------------------------------------------------------------------------
## Extract the most common species_id
species_counts <- surveys_complete %>%
    count(species_id) %>% 
    filter(n >= 50)

## Only keep the most common species
surveys_complete <- surveys_complete %>%
  filter(species_id %in% species_counts$species_id)

## ---- eval=FALSE---------------------------------------------------------
write_csv(surveys_complete, path = "data_output/surveys_complete.csv")




