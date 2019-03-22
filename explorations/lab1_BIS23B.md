Week 1 Lab
----------

------------------------------------------------------------------------

> ### Pre-lab Assignments/Readings
>
> -   Download and install R and RStudio:
>     <https://davisqbio.github.io/r_intro/computer-setup/>.
> -   Read over the basics in R:
>     <https://davisqbio.github.io/r_intro/readings/R-00-before-we-start/>.
> -   Make sure you set up an R project, as discussed in the second
>     link.
> -   To generate pdfs, instead of just html files, you'll also need to
>     install the `tinytex` package. Run this code in the console:
>     `install.packages("tinytex")`. It may take a few minutes to
>     install.
>
> ### Homework for Next Week
>
> -   Fill in all of the answer blocks.
> -   Complete the coding challenge at the bottom of the Rmd file.
> -   Readings?
>
> ### Learning Objectives
>
> -   Apply genome assembly approaches to real text.
> -   Think formally about using algorithms to solve a problem.
> -   Practice using R to manipulate and analyze strings.
> -   Generate an Rmd file and associated pdf.

------------------------------------------------------------------------

### Overview

Much of today's work will take place working by hand in groups. But we
will use this Rmd file to take notes. Over the quarter, the individual
labs will help us build up a full "lab notebook" and provide a space for
your code, reflection, and synthesis.

### R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax
for authoring HTML, PDF, and MS Word documents. For more details on
using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that
includes both content as well as the output of any embedded R code
chunks within the document. You can embed an R code chunk like this:

    3+5

    ## [1] 8

More on that to come later.

### Genome assembly -- a literature perspective

When you perform DNA sequencing, you don't immediately end up with long
DNA sequences that can be easily connected to data from genomic
databases. Instead, you begin by getting a set of short ***reads***.
Each read is a short sequence of DNA usually ranging from ~50 to 500
base pairs, depending on the sequencing technology used. We will jump
into some reads of real DNA sequences from our halophiles next week. But
this week, let's build our intuition with something closer to our
everyday experience, regular text.

We (your instructors) will hand out some short "reads" of text. Each
read here is only 20 characters long, and consists of the letters a to
z, with underscores \_ indicating spaces between words. Just like DNA,
the characters here have meaning. These reads were created by sequencing
a text "gene". For example, here\_is\_the\_rest\_of\_this
sentence\_as\_two\_reads.

#### Your objective: assemble this text

Here are a few features you'll want to keep in mind.

-   Many of these reads overlap. So multiple reads should cover most
    parts of the text.
-   In fact, the average depth of coverage is 5X. This means that 5
    reads, on average, should cover any letter in the text.
-   Sequencing is not free from errors. There was a 1% error rate in our
    sequencing.

#### Questions to puzzle over -- READ BEFORE BEGINNING ACTIVITY

1.  What strategies did you try? Are there any (general) ways in which
    you could have performed the assembly more quickly?

2.  What problems did you run into?

3.  Is it possible to make a perfect assembly? How would you know?

4.  Assuming a similar read length and coverage, is this task easier or
    harder than assembling real genomes? Why? What are some features
    that differ between genomes and text?

------------------------------------------------------------------------

> #### Answer block -- reflections on assembly strategies. (1-2 sentences each.)
>
> 1.  2.  3.  4.  

------------------------------------------------------------------------

------------------------------------------------------------------------

------------------------------------------------------------------------

### Algorithmic thinking

#### 5-minute task -- making toast

Take 5 minutes to note the steps required to making toast, starting with
a bag of bread and a toaster. Imagine you are explaining this to a
6-year-old who is competent, but has never used a toaster.

#### Class discussion

Instructors will guide.

#### Back to the text

Thinking about the algorithms you used for your assembly. Instructors
will guide.

------------------------------------------------------------------------

> #### Answer block -- formalizing assembly.
>
> With a mind towards algorithms, how might you modify or add to your
> assembly algorithm to incorporate quality control, validation,
> conditional statements, etc. (2-3 sentences.) Answer:

------------------------------------------------------------------------

------------------------------------------------------------------------

------------------------------------------------------------------------

### Getting acquainted with R

So far we haven't gotten into the real benefits of using an R Markdown
document. One of the greatest benefits is that you can easily embed R
code, run it, make plots, and use all of R's functionality while
creating an easy to read document. Let's begin with some basics. R
Markdown files will automatically interpret R code contained within
chunks sandwiched by three back tick symbols.

    x <- 3
    y = 7
    x + y

    ## [1] 10

We defined two different objects here. x is the number 3, and y is the
number 7. Note that we can assign values to a variable using either `<-`
or `=`. The equals sign may seem more intuitive, but equals signs have
some other meanings in other contexts in R, so we'll tend to use `<-`.
As a shortcut, you can type either `alt` and `-` or `cmd` and `-` to
make the symbol `<-`, if you have a pc or mac, respectively.

Let's do something more complicated.

    dna_fragment <- "ACTTCTTCACGCTGCTACGTACGATATTAACGGCCGATCACGATCGACGTAGCTAGCTAGCT"

Now we have a string stored as an object named `dna_fragment` -- a
string is a sequence of characters. These are always surrounded by
quotation marks in R.  
Even with this short string, counting the letters might get tedious.
What can R offer us?

    fragment_length <- nchar(dna_fragment)
    fragment_length  #this is the total number of characters in our string

    ## [1] 62

What about the number of each of the 4 letters (our four different DNA
base pairs)? As you'll continually find out, R works better with vectors
(where each character in the string is its own entry in an array) than
it does with single strings. Let's reformat our string.

    dna_list <- strsplit(dna_fragment,split = "")
    dna_list #this is a list. lists are very flexible objects for 

    ## [[1]]
    ##  [1] "A" "C" "T" "T" "C" "T" "T" "C" "A" "C" "G" "C" "T" "G" "C" "T" "A"
    ## [18] "C" "G" "T" "A" "C" "G" "A" "T" "A" "T" "T" "A" "A" "C" "G" "G" "C"
    ## [35] "C" "G" "A" "T" "C" "A" "C" "G" "A" "T" "C" "G" "A" "C" "G" "T" "A"
    ## [52] "G" "C" "T" "A" "G" "C" "T" "A" "G" "C" "T"

    #data storage, but we want a vector here.

    dna_vec <- unlist(dna_list) #this odd function turns lists into vectors
    dna_vec

    ##  [1] "A" "C" "T" "T" "C" "T" "T" "C" "A" "C" "G" "C" "T" "G" "C" "T" "A"
    ## [18] "C" "G" "T" "A" "C" "G" "A" "T" "A" "T" "T" "A" "A" "C" "G" "G" "C"
    ## [35] "C" "G" "A" "T" "C" "A" "C" "G" "A" "T" "C" "G" "A" "C" "G" "T" "A"
    ## [52] "G" "C" "T" "A" "G" "C" "T" "A" "G" "C" "T"

Now our data is a vector. What have we gained? Well, we can use some
basic R functions like `table()` to make counts of the unique entries
inside. We can easily take a subset of the vector, for example to just
look at the last 6 entries. We can also compare two similar strings to
look for differences.

    table(dna_vec) #a table of the counts of each unique value in the vector

    ## dna_vec
    ##  A  C  G  T 
    ## 15 18 13 16

    dna_vec[57:62]  #the final 6 entries in dna_vec

    ## [1] "C" "T" "A" "G" "C" "T"

    dna_vec_2 <- c("A", "G", "T", "T", "C", "T", "T", "C", "A", "C", "G", "C", 
    "T", "G", "C", "T", "A", "G", "G", "T", "A", "C", "G", "A", "T", 
    "A", "T", "T", "A", "A", "C", "G", "G", "C", "C", "G", "A", "T", 
    "C", "A", "C", "G", "C", "T", "C", "G", "A", "C", "G", "T", "A", 
    "G", "C", "T", "A", "T", "C", "T", "A", "G", "C", "T")

    matches <-  dna_vec == dna_vec_2
    matches

    ##  [1]  TRUE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
    ## [12]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE  TRUE  TRUE  TRUE  TRUE
    ## [23]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
    ## [34]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE  TRUE
    ## [45]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
    ## [56] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE

    sum(matches)/length(matches)

    ## [1] 0.9354839

The first two parts might seem at least somewhat intuitive. `table` made
a nice table for us. Choosing just entries 57 through 62 got the final 6
entries in our vector. But `dna_vec == dna_vec_2` yielded something
weird: a vector of `TRUE` and `FALSE`. As mentioned in the online
reading, comparisons in R using symbols like `<`, `==`, and `!=` are
like asking a question. For vectors, R makes the comparison entry by
entry. So `dna_vec == dna_vec_2` asked: Is the first entry in `dna_vec`
the same as the first entry in `dna_vec_2`? Is the second entry the same
in both? And so on. We can see that they were mostly the same, but the
occasional `FALSE` values reveal places where these two DNA sequences
differed. The output from this kind of comparison is a *logical vector*,
so-called because we call `TRUE` and `FALSE` logical values.

We also took advantage of another useful feature in R. `TRUE` and
`FALSE` are equivalent to `1` and `0`, so you can find the number of
`TRUE` values by just taking the `sum()` of your logical vector. We went
ahead and divided by the `length` (the number of entries) of the vector,
to get the overall fraction of the DNA sequences that were identical.
This fraction comes up repeatedly during genomic analysis. It is often
multiplied by 100 to become a percent, and is called *percent identity*.

Homework for Week 2
-------------------

On Canvas, you'll find a file called "Lab1\_HW\_reads.csv" which
contains 5 short reads. Each read overlaps with at least one other, and
the overlaps are always exactly 10 base pairs long and perfectly
identical. Your task is to write R code to assemble these 5 reads into a
single long contig, and condense it down to a single string.

This main goal of this task is to get you fiddling around in R. Use
comments (\#) in the R code to make it clear what should be happening at
each step. Even if something goes wrong or you just can't make it run,
clear comments that make your logic transparent are worth almost full
credit.

    #Your code here.  Make sure you include lots of comments!
