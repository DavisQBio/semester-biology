---
title: "Lab 1 write-up"
layout: page
---

Week 1 Lab
----------

------------------------------------------------------------------------

> ### Pre-lab Assignments/Readings
>
> -   Download and install R and RStudio: <https://davisqbio.github.io/r_intro/computer-setup/>.
> -   Read over and try out the basics in R:
> -   -   <https://davisqbio.github.io/r_intro/readings/R-00-before-we-start_BIS23B/>
>
> -   -   <https://davisqbio.github.io/r_intro/readings/R-01-intro-to-r/>.
>
> -   Make sure you **set up an R project**, as discussed in the "Before we start" reading.
>
> ### Homework for Next Week
>
> -   Fill in all of the answer blocks.
> -   Complete the writing assignment in the Homework section.
> -   Complete the coding assignment in the Homework section.
> -   Read this short news piece from some UC Davis faculty: <https://biology.ucdavis.edu/news/language-biology-how-heck-do-scientists-assemble-genome>
> -   Install the `tidyverse`, `BiocManager`, and `Biostrings` packages. See code at the bottom for instructions (installing `Biostrings` is a different process).
> -   Download the zip file of all of the sequences from Canvas, and unzip it in the "raw" folder inside of your "data" folder in your R Project. The individual files should be sitting directly inside of the raw folder, not nested deeper inside of other folders.
>
> ### Learning Objectives
>
> -   Apply genome assembly approaches to real text.
> -   Think formally about using algorithms to solve a problem.
> -   Practice using R to manipulate and analyze strings.
> -   Generate an Rmd file and associated html file.

------------------------------------------------------------------------

### Overview

Much of today's work will take place working by hand in groups. But we will use this Rmd file to take notes. Over the quarter, the individual labs will help us build up a full "lab notebook" and provide a space for your code, reflection, and synthesis.

### R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

``` r
3+5
```

    ## [1] 8

More on that to come later.

### Genome assembly -- a literature perspective

When you perform DNA sequencing, you don't immediately end up with long DNA sequences that can be easily connected to data from genomic databases. Instead, you begin by getting a set of short **reads**. Each read is a short sequence of DNA usually ranging from ~50 to 500 base pairs, depending on the sequencing technology used. We will jump into some reads of real DNA sequences from our halophiles next week. But this week, let's build our intuition with something closer to our everyday experience, regular text.

We (your instructors) will hand out some short "reads" of text. Each read here is only 20 characters long, and consists of the letters a to z, with underscores \_ indicating spaces between words. Just like DNA, the characters here have meaning. These reads were created by sequencing a text "gene". For example, here\_is\_the\_rest\_of\_this sentence\_as\_two\_reads.

------------------------------------------------------------------------

Pause here for instructions before going on. \*\*\*

#### Your objective: assemble this text

Here are a few features you'll want to keep in mind.

-   Many of these reads overlap. So multiple reads should cover most parts of the text.
-   In fact, the average depth of coverage is 5X. This means that 5 reads, on average, should cover any letter in the text.
-   Sequencing is not free from errors. There was a 1% error rate in our "sequencing.

#### Questions to puzzle over -- READ BEFORE BEGINNING ACTIVITY

1.  What strategies did you try? Are there any (general) ways in which you could have performed the assembly more quickly?

2.  What problems did you run into?

3.  Is it possible to make a perfect assembly? How would you know?

4.  Assuming a similar read length and coverage, is this task easier or harder than assembling real genomes? Why? What are some features that differ between genomes and text?

------------------------------------------------------------------------

> #### Answer block -- reflections on assembly strategies. (1-2 sentences each.)
>
> Q1.
>
> Q2.
>
> Q3.
>
> Q4.

------------------------------------------------------------------------

------------------------------------------------------------------------

------------------------------------------------------------------------

### Algorithmic thinking

#### 5-minute task -- making toast

Take 5 minutes to write down the steps required to making toast, starting with a bag of bread and a toaster. Imagine you are explaining this to a 5-year-old who is a reasonable human being, but has never used a toaster themselves.

#### Class discussion

Instructors will guide.

------------------------------------------------------------------------

------------------------------------------------------------------------

### Getting acquainted with R

So far we haven't gotten into the real benefits of using an R Markdown document. One of the greatest benefits is that you can easily embed R code, run it, make plots, and use all of R's functionality while creating an easy to read document. Let's begin with some basics. R Markdown files will automatically interpret R code contained within chunks sandwiched by three back tick symbols.

R is basically a fancy calculator. But it can store objects such as variables or functions, which is useful. Instead of having to arithmetic over and over again, you can use functions in R to do your bidding. Let's define some objects.

``` r
# assigning the value 3 to the variable x
x <- 3

# assigning the value 7 to the variable y
y = 7

# evaluating the sum of x and y
x + y
```

    ## [1] 10

We defined two different objects here. `x` was defined as the number 3, and `y` was defined as the number 7. Note that we can assign values to a variable using either `<-` or `=`. The equals sign may seem more intuitive, but equals signs have some other meanings in other contexts in R, so we'll tend to use `<-`. As a shortcut, you can type either `alt` and `-` or `cmd` and `-` to make the symbol `<-`, if you have a pc or mac, respectively.

As you go through, you can use `ctrl` and `enter` to run a single line of code, or click the green play button at the right corner of the code block to run the whole block. You can also just copy and paste into the console, but that is slow and will eventually drive you insane.

Let's define something more complicated.

``` r
# storing a string of base pairs at the variable dna_fragment
dna_fragment <- "ACTTCTTCACGCTGCTACGTACGATATTAACGGCCGATCACGATCGACGTAGCTAGCTAGCT"
```

Now we have a string stored as an object named `dna_fragment` -- a string is a sequence of characters. These are always surrounded by quotation marks in R.
Even with this short string, counting the letters might get tedious. What functions can can R offer us?

``` r
fragment_length <- nchar(dna_fragment)
fragment_length  #this is the total number of characters in our string
```

    ## [1] 62

When you call functions in R, they will always have their argument (their input) surrounded by round brackets, (). So we can see that `nchar()` is a function. It can take a single strings as an argument, as we saw above. But it can also take a vector of multiple strings. Let's define a vector and check it out.

``` r
# storing a vector with multiple strings
dna_fragments <- c("ATACCAT","GTTTGAGATC","CC")
dna_fragments
```

    ## [1] "ATACCAT"    "GTTTGAGATC" "CC"

``` r
#counting the number of characters in each string in the vector
nchar(dna_fragments)
```

    ## [1]  7 10  2

Two things to unpack. First, we just used R's most fundamental function, `c()`. This creates a vector out of the entries you put inside. Second, you just used the function `nchar()` on a whole vector, instead of a single string. Many functions in R can work with a single value, or a vector of values. These are called vectorized functions, and they're convenient for doing a lot of work with a small bit of code.

What about the number of each of the 4 letters (our four different DNA base pairs)? As you'll continually find out, R works better with vectors of individual characters (where each character in the string is its own entry in an array) than it does with single strings. Let's reformat our original string, `dna_fragment`, using the function `strsplit()`.

``` r
#breaking a string into individual characters
dna_list <- strsplit(dna_fragment,split = "")
dna_list # this looks almost like a vector, but it's actually a list
```

    ## [[1]]
    ##  [1] "A" "C" "T" "T" "C" "T" "T" "C" "A" "C" "G" "C" "T" "G" "C" "T" "A"
    ## [18] "C" "G" "T" "A" "C" "G" "A" "T" "A" "T" "T" "A" "A" "C" "G" "G" "C"
    ## [35] "C" "G" "A" "T" "C" "A" "C" "G" "A" "T" "C" "G" "A" "C" "G" "T" "A"
    ## [52] "G" "C" "T" "A" "G" "C" "T" "A" "G" "C" "T"

``` r
# we can recover the vector in two ways
unlist(dna_list)  # using this function that smooshes all list entries 
```

    ##  [1] "A" "C" "T" "T" "C" "T" "T" "C" "A" "C" "G" "C" "T" "G" "C" "T" "A"
    ## [18] "C" "G" "T" "A" "C" "G" "A" "T" "A" "T" "T" "A" "A" "C" "G" "G" "C"
    ## [35] "C" "G" "A" "T" "C" "A" "C" "G" "A" "T" "C" "G" "A" "C" "G" "T" "A"
    ## [52] "G" "C" "T" "A" "G" "C" "T" "A" "G" "C" "T"

``` r
# into a vector, OR

dna_list[[1]]  # it turns out the first entry in our list was a 
```

    ##  [1] "A" "C" "T" "T" "C" "T" "T" "C" "A" "C" "G" "C" "T" "G" "C" "T" "A"
    ## [18] "C" "G" "T" "A" "C" "G" "A" "T" "A" "T" "T" "A" "A" "C" "G" "G" "C"
    ## [35] "C" "G" "A" "T" "C" "A" "C" "G" "A" "T" "C" "G" "A" "C" "G" "T" "A"
    ## [52] "G" "C" "T" "A" "G" "C" "T" "A" "G" "C" "T"

``` r
# a vector of characters

# let's create a new object to store this vector
dna_vec <- unlist(dna_list)
dna_vec
```

    ##  [1] "A" "C" "T" "T" "C" "T" "T" "C" "A" "C" "G" "C" "T" "G" "C" "T" "A"
    ## [18] "C" "G" "T" "A" "C" "G" "A" "T" "A" "T" "T" "A" "A" "C" "G" "G" "C"
    ## [35] "C" "G" "A" "T" "C" "A" "C" "G" "A" "T" "C" "G" "A" "C" "G" "T" "A"
    ## [52] "G" "C" "T" "A" "G" "C" "T" "A" "G" "C" "T"

Now our data is a vector. What have we gained? Well, we can use some basic R functions like `table()` to make counts of the unique entries inside. We can easily take a subset of the vector, for example to just look at the last 6 entries.

``` r
table(dna_vec) # a table of the counts of each unique value in the vector
```

    ## dna_vec
    ##  A  C  G  T 
    ## 15 18 13 16

``` r
dna_vec[31] # the 31st entry in the vector
```

    ## [1] "C"

``` r
dna_vec[c(1,5,12)] # the 1st, 5th, and 12th entries
```

    ## [1] "A" "C" "C"

``` r
dna_vec[57:62]  #the final 6 entries in dna_vec
```

    ## [1] "C" "T" "A" "G" "C" "T"

Oh, the `table()` function is nice. It counts the unique entries in a vector (and can do more complex counting too). Then we took advantage of a nice feature of vectors; it's easy to select smaller sets of entries inside. For vectors you use the square brackets, \[\], and can enter a single integer or a vector of multiple integers. The code `57:62` does exactly what you think. It makes a vector with the numbers 57,58, ...,62.

Your turn to fiddle. Try these out on your own, and flag us down if you're getting stuck.

``` r
##################################
###  Your code here            ###
##################################

# create a vector named dog, consisting of the values 5, 7, 9, and 126.3
# remember to wrap the values in the c() function


# use the function mean() to calculate the mean of the vector dog


# use the command ?mean to see R's documentation of the function.
# ? before a function name pulls a useful help file.
# mean() has some extra arguments that you can use. 
# what can you do by setting a trim argument?


# below is a string stored as the object bird
# use strsplit() and table() to count the number of occurrences of the letter r
bird <- "chirp_chirp_i_am_a_bird_chirp"


###
# extra things to play with, time permitting
# check out the help file for strsplit()


# we used the argument split="" to split every character apart.
# try using strsplit() with split="_" on the variable bird.


# what is your output?  (use the # symbol at the start of the line
# to write your response as a comment, otherwise
# R will get confused when you create your final document)



# Can you imagine any scenarios where this might be useful?



##################################
##################################
```

------------------------------------------------------------------------

Pause here and wait for instructions on the next step. \*\*\*

#### A first step into bioinformatics

Okay, we now have almost enough tools to do some bioinformatics. Let's compare two DNA sequences.

``` r
# a different dna sequence (conveniently already in vector form)
dna_vec_2 <- c("A", "G", "T", "T", "C", "T", "T", "C", "A", "C", "G", "C", 
"T", "G", "C", "T", "A", "G", "G", "T", "A", "C", "G", "A", "T", 
"A", "T", "T", "A", "A", "C", "G", "G", "C", "C", "G", "A", "T", 
"C", "A", "C", "G", "C", "T", "C", "G", "A", "C", "G", "T", "A", 
"G", "C", "T", "A", "T", "C", "T", "A", "G", "C", "T")

# checking which entries are equal 
matches <-  dna_vec == dna_vec_2
matches
```

    ##  [1]  TRUE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
    ## [12]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE  TRUE  TRUE  TRUE  TRUE
    ## [23]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
    ## [34]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE  TRUE
    ## [45]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
    ## [56] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE

``` r
# adding up the matches, and dividing by the length (the number of characters)
sum(matches)/length(matches)
```

    ## [1] 0.9354839

Check in with you lab neighbors. What did we just do? What is that final value?

We created an interesting vector called `matches` from the command `dna_vec == dna_vec_2`. It looks a little weird: a vector of `TRUE` and `FALSE`. As mentioned in the online reading, comparisons in R using symbols like `<`, `==`, and `!=` are like asking a question. For vectors, R makes the comparison entry by entry. So `dna_vec == dna_vec_2` asked: Is the first entry in `dna_vec` the same as the first entry in `dna_vec_2`? Is the second entry the same in both? And so on. We can see that they were mostly the same, but the occasional `FALSE` values reveal places where these two DNA sequences differed. The output from this kind of comparison is a *logical vector*, so-called because we call `TRUE` and `FALSE` logical values that come from making logical comparisons betweem values.

We also took advantage of another useful feature in R. `TRUE` and `FALSE` are equivalent to `1` and `0`, so you can find the number of `TRUE` values by just taking the `sum()` of your logical vector. We went ahead and divided by the `length` (the number of entries) of the vector, to get the overall fraction of the DNA sequences that were identical. This fraction comes up repeatedly during genomic analysis. It is often multiplied by 100 to become a percent, and is called *percent identity*. You will start seeing this value next week when we try to figure out which species have sequences that best match our halophile genomes.

``` r
# Following the approach above, find the percent identity 
# for these two sequences
seq1 <- "CCTAACGTCAGCAGATCAAACGCCGATTC"
seq2 <- "CCGAAGGACTAGCTAGCTAGCGCGGATTG"

##################################
###  Your code here            ###
##################################



# After calculating it, what do you think? Are these sequences similar?
# We'll gradually get more and more context for this as the course goes on.

##################################
##################################
```

Next week we'll try out a simple genome assembly in R. To get ready for that, you'll be getting used to wrangling and assembling a few short reads for your homework. Below we'll combine a few tools we've seen above to get things started.

``` r
# Above we compared two sequences that were already reasonably
# well aligned. But actual reads coming from DNA sequencing start
# at random places. So, as we saw using the text, we instead want 
# to look for overlaps.

seq3 <- c("A", "T", "G", "C", "A", "G", "A", "C", "T", "C", "A", "A", 
"C", "T", "G", "T", "G")
seq4 <- c("A", "A", "C", "T", "G", "T", "G", "A", "C", "G", "C", "G", 
"C", "G", "C", "G", "A", "A", "G")

# To find the best overlap, we would need to slide the sequences along
# each other and check the percent identity each time.  
# Let's not worry about that yet.

# Instead, let's use a logical comparison
seq3[11:17] == seq4[1:7]
```

    ## [1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE

``` r
# the last 7 base pairs in seq3 are idential to the first 7 in seq4.

# That is vanishingly unlikely to have occurred by chance, so we strongly
# suspect that these two reads overlap in the real genome.

# So, how do we combine them?  The c() function, yet again.

seq_joined <- c(seq3,seq4[8:19])  # using all of seq3, and the latter
# part of seq4


# one final tool, paste()... and also paste0()
# check out the help file for paste(), using ?paste


# we'll need to set the argument collapse = "", which
# tells the function to smush everything back to a single string

paste(seq_joined, sep = "", collapse = "")
```

    ## [1] "ATGCAGACTCAACTGTGACGCGCGCGAAG"

``` r
# paste0 saves some writing -- it defines sep = "" by default

paste0(seq_joined, collapse = "")
```

    ## [1] "ATGCAGACTCAACTGTGACGCGCGCGAAG"

``` r
# don't worry about sep yet; it's only relevant when you're pasting 
# multiple vectors.
```

Homework for Week 2, due Wednesday, 4/10, at 10:59pm
----------------------------------------------------

Besides the package installations and the data downloads, all work should be completed inside of this Rmd file and uploaded to Canvas as a pdf or html file.

------------------------------------------------------------------------

### Finish up labwork

Make sure that any short responses or coding snippets above have been filled in with your work.

------------------------------------------------------------------------

### Writing

In 200-300 words, write out a detailed algorithm for how you would assemble a set of reads into a genome. Keep in mind the concepts we discussed regarding algorithms, including quality control, validation, and conditional statements.

In addition, in a few sentences (keeping the article in mind, <https://biology.ucdavis.edu/news/language-biology-how-heck-do-scientists-assemble-genome>), explain why it might be helpful to have the genome sequences of more than one individual of a particular species.

------------------------------------------------------------------------

### Coding

Below we define a vector that contains 5 short reads stored as vectors. Each read overlaps with at least one other, and the overlaps are always exactly 10 base pairs long and perfectly identical. Your task is to write R code to assemble these 5 reads into a single long contig, and then condense it down to a single string. Name that string `genome`.

This main goal of this task is to get you fiddling around in R. Use comments (\#) in the R code to make it clear what should be happening at each step. Even if something goes wrong or you just can't make it run, clear comments that make your logic transparent are worth almost full credit. Don't forget the value of the help function `?` if a function isn't working how you expect it to.

``` r
lab1_hw_reads <- c("GTTATCTAAGACCCATCTTCTCACTGGTCACTCACTCCACTGGCATATTC",
                   "CCACTAAAGCTTTACTTGCTAAATTACTGAATGAGAGTCACGAATCTTTT",
                   "ACAAATCTCAGATAATCGCACACTCTAGTATCAGATTAGGCTCCCACCGG",
                   "CGAATCTTTTTGTTGTTCGAGAGGCCTGTGACACCCCTGGGTTATCTAAG",
                   "TGGCATATTCGTCAAACAGTTCTGATGCCTGATACAACTGACAAATCTCA")

##################################
###  Your code here            ###
##################################

# Make sure you include lots of comments!
# Before each of line code where you're doing someting new,
# use # to add a comment to explain what you're doing.




##################################
##################################
```

#### Installing the packages for next week's class

We will install `tidyverse` in the usual way that R installs packages. But `Biostrings` is a Bioconductor package, so we need to install and load `BiocManager` first.

``` r
# run this if you haven't installed tidyverse recently
install.packages("tidyverse")

# run this if you haven't installed BiocManager recently
install.packages("BiocManager")

# run this if you haven't installed Biostrings recently
library(BiocManager, quietly = TRUE)
install("Biostrings")
```

If you're getting errors and things just won't work, contact one of your instructors before next Thursday's lab.

### Data

Download the file "BIS23B\_sequences.zip", and extract it into your `data/raw` folder in your R project. The individual files (of filetype FASTA, gbk, and gff) should be sitting loose inside of that folder.

Code Appendix
-------------

This includes all of the inline code you wrote in the coding sections while you were exploring in this week's lab.

``` r
##################################
###  Your code here            ###
##################################

# create a vector named dog, consisting of the values 5, 7, 9, and 126.3
# remember to wrap the values in the c() function


# use the function mean() to calculate the mean of the vector dog


# use the command ?mean to see R's documentation of the function.
# ? before a function name pulls a useful help file.
# mean() has some extra arguments that you can use. 
# what can you do by setting a trim argument?


# below is a string stored as the object bird
# use strsplit() and table() to count the number of occurrences of the letter r
bird <- "chirp_chirp_i_am_a_bird_chirp"


###
# extra things to play with, time permitting
# check out the help file for strsplit()


# we used the argument split="" to split every character apart.
# try using strsplit() with split="_" on the variable bird.


# what is your output?  (use the # symbol at the start of the line
# to write your response as a comment, otherwise
# R will get confused when you create your final document)



# Can you imagine any scenarios where this might be useful?



##################################
##################################
# Following the approach above, find the percent identity 
# for these two sequences
seq1 <- "CCTAACGTCAGCAGATCAAACGCCGATTC"
seq2 <- "CCGAAGGACTAGCTAGCTAGCGCGGATTG"

##################################
###  Your code here            ###
##################################



# After calculating it, what do you think? Are these sequences similar?
# We'll gradually get more and more context for this as the course goes on.

##################################
##################################
lab1_hw_reads <- c("GTTATCTAAGACCCATCTTCTCACTGGTCACTCACTCCACTGGCATATTC",
                   "CCACTAAAGCTTTACTTGCTAAATTACTGAATGAGAGTCACGAATCTTTT",
                   "ACAAATCTCAGATAATCGCACACTCTAGTATCAGATTAGGCTCCCACCGG",
                   "CGAATCTTTTTGTTGTTCGAGAGGCCTGTGACACCCCTGGGTTATCTAAG",
                   "TGGCATATTCGTCAAACAGTTCTGATGCCTGATACAACTGACAAATCTCA")

##################################
###  Your code here            ###
##################################

# Make sure you include lots of comments!
# Before each of line code where you're doing someting new,
# use # to add a comment to explain what you're doing.




##################################
##################################
```
