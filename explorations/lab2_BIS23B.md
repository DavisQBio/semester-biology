---
title: "Lab 2 write-up"
layout: page
---


Week 2 Lab
----------

------------------------------------------------------------------------

> ### Homework for Next Week
>
> -   Fill in all of the answer blocks and coding tasks in this lab notebook.
> -   Complete all tasks in the Homework section (bottom of the Rmd).
>
> ### Learning Objectives
>
> -   Understand the features and formatting of common genomic data files.
> -   Explore how genome sequence features influence the accuracy/quality of an assembly.
> -   Get comfortable manipulating DNA sequences in R.
> -   Create custom functions in R to perform analyses using less code.

------------------------------------------------------------------------

### Overview

This week we will get acquainted with real sequence data, and try out some approaches to assembling a few individual genes. Then we'll look at our large, whole genome files and take some time to understand exactly what they tell us. We'll also start writing our own functions in R. Data analysis can get repetitive. If you find yourself writing the same code over and over again, making a function to do it for you saves time and makes your code more readable.

### Last week's coding challenge

Take a minute to look back over your HW code for assembling the sequences. Then check in with your group about their approaches. Instructors will guide a discussion.

### Other HW (algorithms, reading)

Brief discussion.

### Assembly in R

If you haven't already, please download the supplemental R script `Lab2_assembly.R` and save it in the `scripts` folder. This should be inside your BIS23 folder, where you created your R Project. If everything is in the right place, when you run the next line you will load the script, which includes some custom functions we wrote, as well as some data we'll explore.

``` r
# Note that file and variable names are case sensitive. So make sure the folder
# is called scripts, all lowercase.
source("../scripts/Lab2_assembly.R")
```

If everything went okay, you should now see a few new objects in your global environment in RStudio. These include several custom functions as well as 7 sets of mystery sequences. These functions require the package `Biostrings` to be loaded , as they use one of the package's functions to align two strings. But when you ran the script, you loaded that package as well. If you're curious about what the file looks like, open up `Lab2_assembly.R` at some point and read through it. (Don't do this now -- it's a rabbit hole.)

But let's get back to our new mystery data. We can begin by looking at `mystery1`.

``` r
mystery1
```

    ## [1] "GATTACGACTCACT"   "TTACGACTCACTGGA"  "TCACTGAAGTATCGCG"
    ## [4] "ATCGCGATCATCAAC"

``` r
length(mystery1)
```

    ## [1] 4

``` r
nchar(mystery1)
```

    ## [1] 14 15 16 15

With these three lines of code we first viewed the raw data, then counted the number of separate entries (strings) in the vector, then counted the number of characters in each string. In this case, the reads are not all the same length. But that won't matter for the `assemble()` function.

Let's use this `assemble()` function. We'll talk about this together as a class before setting you loose on some other data.

``` r
a1 <- assemble(mystery1, penalty = -3, min_overlap = 4)

##################################
###  Your code here            ###
##################################

# fill in some code as we calculate coverage and other features


##################################
##################################
```

After you've assembled a set of sequences, you often want to make some calculations about the quality of your assembly. *Did they all overlap well enough to form a single sequence (contig)? How long is the contig? What's the coverage (the average number of reads for any given site in the contig)?* Next week you'll get more in depth with assessing assembly quality -- we need to assess the quality of our halophile data.

------------------------------------------------------------------------

**Pause here for an instructor-led discussion.**

------------------------------------------------------------------------

#### Back of the envelope probability calculations

One last thing -- what's a good minimum overlap to require? It's obvious that an overlap of 1 isn't worth much. We don't want to accidentally combine two sequences that are from distinct parts of the genome. But if we allow an overlap of 1 that could happen just by chance. Let's think through this systematically, in terms of probabilities. Instructors will work through this on the board.

#### (Slightly) larger data sets

We still won't get anywhere near the size of a typical FASTQ file of sequencing reads, but let's assemble some of our other sets of reads.

#### A scavenger hunt to complete with your group

1.  Two of these mystery vectors are actually different sets of reads from the same exact sequence. Which ones are they? How do you know?

2.  One of these sets of reads is from a complete, circular sequence of DNA. Which one? How do you know?

3.  Does the minimum overlap make much of a difference for the assembly? What happens if it's very small, or large relative to your read lengths?

4.  Do you get the same assembly every time if you run the exact same code? Check with group to see if your assemblies look the same.

------------------------------------------------------------------------

> #### Answer block -- scavenger hunt answers (1-2 sentences each.)
>
> Q1.
>
> Q2.
>
> Q3.
>
> Q4.

------------------------------------------------------------------------

``` r
# Assemble mystery2, 3, 4, 5, 6, and 7, and store them as
# a2, a3, a4, a5, a6, a7

##################################
###  Your code here            ###
##################################




##################################
##################################
```

------------------------------------------------------------------------

**Pause here for some discussion of our assembly findings**

------------------------------------------------------------------------

### How can functions help us?

We have assembled 7 different sets of mystery reads. We'll want to calculate some statistics about each of them, for example the total coverage. Let's create some functions to do this work for us, so that we don't have to rewrite the same code many times.

``` r
# Practice creating functions

# we first specify the function's name and the name of the arguments (inputs)

contig_num <- function(assembly)
{
    # this function, contig_num, takes an assembly
    # we'll assume the assembly is a vector of strings
    
    # the number of contigs is the number of different strings
    # in the vector, which is given by the length() function
    len <- length(contig_num)
    
    # at the end of a function, either just put name of the output, (here 
    # it's len), or use return() with your output
    return(len)
}

# This was not a useful function.  length() does the job by itself.
contig_num(a1)
```

    ## [1] 1

``` r
length(a1)
```

    ## [1] 1

``` r
# But maybe we want to count the number of "A" base pairs in each contig.
# That requires a bit more code

count_A <- function(assembly)
{
    # this function, count_A, takes an assembly (vector of strings)
    # and will return a vector of integers (# of As in each contig)
    
    # split the string(s) into a list, then into a vector
    assembly_vec <- unlist(strsplit(assembly, split = ""))
    
    # note: we nested two functions, unlist() and strsplit(), to write
    # more compact code
    
    #check which entries equal A
    A_total <- sum(assembly_vec == "A")
    
    return(A_total)
}

# Run the lines above, and the function should now appear the 
# Functions section in your environment

count_A(a1)
```

    ## [1] 10

Functions can be very useful. You may even find yourself writing some short utility functions, then calling them inside of larger functions you write. If you read the code for `assemble()`, you'll see that it calls several simpler functions. This follows the principle of modular programming, where you write small programs to handle each distinct computational task, then combine them together in the right order inside of a larger function or loop.

``` r
# Write a function called contig_cov() that can calculate the 
# coverage of an assembly given the assembly and the initial reads.


##################################
###  Your code here            ###
##################################

contig_cov <- function(assembly,reads)
{
    # make sure you include comments to explain the code
}

# Now use this function to calculate the coverage for each of the
# assembled sequences.



##################################
##################################
```

------------------------------------------------------------------------

**Pause here, we'll look at some data together.**

------------------------------------------------------------------------

### What does genomic data look like?

We are mostly going to avoid dealing with the raw sequencing read data (FASTQ files). These files are very large and messy to work with. It turns out that R doesn't manage its memory efficiently for gigantic data sets, so genome assembly programs tend to be written in other languages.

Let's focus first on FASTA files. These are really just text files, but with a specific format. Find the file `22501_18_FS.fasta`, and open it in a text editor. If you don't have a text editor that works just follow along with the instructor. But it's good practice to have a lightweight text editor, for example [atom](https://atom.io/) or [Notepad++ (windows only)](https://notepad-plus-plus.org/). Some hardcore people like [VIM](https://www.vim.org/download.php), but it's not as easy for starting out.

As we start looking through the strains, you'll each have two strains to focus on. One that is yours alone, and one that you share with a group (which happens to be today's lab group).

[Google doc](https://docs.google.com/spreadsheets/d/1AH2dUxqbX-yTVgs_x191YZiRu33ZxCfYKrPmFfsMzbQ/edit?usp=sharing)

------------------------------------------------------------------------

> #### Answer block -- understanding FASTA files.
>
> Spend some time exploring the fasta files for `22501_18_FS`, as well as for your two other strains. DON'T FILL ANYTHING OUT BELOW -- instead, enter these data into the google doc.
>
> Features of interest:
>
> -   How many contigs are there?
>
> -   How long is the longest contig?
>
------------------------------------------------------------------------

------------------------------------------------------------------------

**Pause here, we'll transition to looking up sequences in a database.**

------------------------------------------------------------------------

### DNA does stuff

So far we've been analyzing things without much thought about biology. Let's take our first step at connecting this new halophile data to some genomic databases. One gene we'll be interested in investigating is the 16S rRNA gene. Don't be fooled by the name -- it's a DNA segment. But this gene codes for an RNA segment that becomes part of the ribosomes of a cell. As a reminder, ribosomes are the main machinery of protein synthesis. They're critical for a cell, as they are the way for the cell to turn its DNA into proteins, which in turn manage all the cell's functions and its interaction with the extracellular environment.

It turns out that evolutionary biologists studying prokaryotes love the 16S rRNA gene. It evolves very slowly, which makes it useful as a way to tell the relatedness of different organisms. For a first pass at figuring out the species of your strains, you'll want to find the sequence of their 16S rRNA genes and compare them with a genomic database.

Let's begin with a puzzle. You actually already have two 16S rRNA gene sequences. `a2` and `a3` are the assembled versions, and they came from the same strain, 22502\_06\_Cabo. We're going to use a family of algorithms called BLAST to look for matches to these sequences in a huge genomic database. Navigate to <https://blast.ncbi.nlm.nih.gov/Blast.cgi>. We have nucleotide sequences, as opposed to protein sequences, so we could use either BLASTn (compares with a nucleotide database) or BLASTx (translates the nucleotide sequence into potential protein sequences and searches a protein database). But the 16S rRNA gene is strange -- it doesn't code for a protein. Instead the cell uses the RNA that's transcribed directly in the building of ribosomes. So we'll use BLASTn, which even has an option to focus just on 16S databases. Let's use BLASTn (the big button on the left that says Nucleotide BLAST). Click the button.

You'll see some options. You would be successful just pasting in your sequence (enter `a2` in the R console, then copy and paste the string into the text box on the BLASTn site). But it will be faster if you focus only on the 16S database. You'll find that on the Database dropdown in the "Choose Search Set" section. Choose "16S ribosomal RNA sequences (Bacteria and Archaea)".

Now you're set. Click BLAST at the bottom left.

Note the genus and species name of the few best matching sequences.

Now do the same for the the sequence from `a3`, using a new tab (so you don't have to close your first results).

------------------------------------------------------------------------

> #### Answer block -- reconciling our BLAST results (1-2 sentences)
>
> You blasted two sequences from the same assembled genome. But they matched different groups of organisms. Talk with your group-mates. What might cause this? Spend a few moments online looking into one of the best matching organism for each sequence (based on highest percent identity, assuming nearly complete query coverage). Are these two groups of organisms similar in terms of their genetics or the environments in which they live?
>
> Your answer:

------------------------------------------------------------------------

Homework for Week 3, due Wednesday, 4/17, at 10:59pm
----------------------------------------------------

Besides the data entry in the google doc, all work should be completed inside of this Rmd file and uploaded to Canvas as a pdf or html file.

------------------------------------------------------------------------

### Finish up labwork (1 pt)

Make sure that any short responses or coding snippets above have been filled in with your work, and your other data is entered into the google doc.

------------------------------------------------------------------------

### Readings and response (2 pts)

Read over these three very short blog posts: one from Keith Bradnam (he was formerly at UC Davis) summarizing an effort to compare genome assembly approaches, and two from Elin Videvall (she is now a postdoc in conservation genomics at the Smithsonian) explaining the N50 statistic.

-   <https://haldanessieve.org/2013/01/28/our-paper-making-pizzas-and-genome-assemblies/>,
-   <https://www.molecularecologist.com/2017/03/whats-n50/>,
-   <https://www.molecularecologist.com/2017/04/the-first-problem-with-n50/>.

#### Response prompt

In week 3 we'll spend some time assessing the quality of the assemblies of our halophile genomes. Assembly quality is often evaluated using statistics like N50, or simple counts like the number of contigs, the total summed length of all the contigs (compared with a known genome of a similar organism), etc.

With assembly quality in mind, what are 1-2 main take-aways from the Assemblathon 2 effort?

What is one kind of biological/bioinformatic analysis you might want to do with your genomes? In what ways might you want to measure assembly quality to make sure your data is appropriate for that question? (For example, you might care about different issues if you're focused on finding key genes vs. looking at broad patterns of nucleotide or codon usage.)

#### Your response here (200-300 words)

------------------------------------------------------------------------

### Data Exploration (2 pts)

#### Data

Create a folder inside of your `data` folder called `processed`. Download the file "Lab2\_contigs.RData" from Canvas, and save it into your `data/processed` folder in your R project.

#### Coding

In lab 2 we learned to write functions in R. We also took a look at the two (!) 16S rRNA genes that appeared in strain "22502\_06\_Cabo". You main data task for this week is to find the 16S rRNA genes in your strains, write a function to pull out just the sequences, and BLAST them against the 16S database to find which species appear to be most closely related.

To begin, find which contig has the 16S rRNA gene, and the start and end point in that contig. This we can do by hand. Use a text editor to open the genbank (.gbk) file, which already includes an annotation that maps the sequences to known genes. Search for "16S ribosomal RNA". When you find the line that says 'product = "16S ribosomal RNA"', you can go up two lines to see the start and stop points. (Don't worry if it also says complement() around the numbers, it won't matter for the BLAST algorithms.) If you scroll up a few more lines, you'll see the label LOCUS, followed by a NODE number. That is the contig number. Now you know exactly the contig and the start and end site of your gene. But getting it directly from a FASTA file might be annoying. To that end, your instructors have formatted the data for easier use in R.

``` r
# We did you the favor of formatting the contigs for each
# strain a little easier

load("../data/processed/Lab2_contigs.RData")

# This loaded a large list called seqs
# Each entry lines up with the last two digits of 5-digit
# strain code. For example 22502 is the second entry
# in the list.

# So if we wanted to focus 22502_06_Cabo (our weird assembly
# from earlier), we could enter
contigs_22502 <- seqs[[2]]

# Note that taking entries from a list requires double brackets,
# [[]], not the single brackets [] you use for a vector.

# let's double check the structure of this data
str(contigs_22502)
```

    ##  chr [1:885] "TATAAGAGACAGCGGTCGCCCCGTCCGACCGCCGGCGCCCGCACCCGCGCCGATCCGGGTCCGCCACCGCGCACACGACGGTCGACCGGCCCGGCCGTACGCGGGGCGTCG"| __truncated__ ...

``` r
# It's a character vector with 885 entries, and each entry is a string.
# As you might have guessed, this represents the string for each contig.
# This (weird) strain has 885 contigs. That's a lot. Most of your 
# strains will not have that many.

# If you want a particular contig, you can just pull that entry from the 
# vector.

s22502_c7 <- contigs_22502[7]

# We now need to pull out just a small part of this contig.
# Last week you got some practice pulling out a subset of a DNA string. 
# There we converted to a vector and using square brackets [] to 
# pull out particular entries.
# You could do it that way, but you could also try out a function called
# substr(). Use ?substr() to see the help file.

# Either way, here is your full task.  Write a function that starts with a
# vector of contigs, e.g. contigs_22502, takes a contig #, a start point,
# and an end point, and pulls out just that sequence as a single 
# string.

# This will allow you to pull out your 16S sequences that 
# you looked up earlier, to then BLASTn them.


##################################
###  Your code here            ###
##################################

# Make sure you include lots of comments!
# Before each of line code where you're doing something new,
# use # to add a comment to explain what you're doing.

gene_puller <- function(contigs, contig_num, start, end)
{
    # Starts with a vector of contigs (strings), and uses a contig number,
    # a start point, and an end point to return
    # a subsequence of the DNA as a single string
    
    
    
    # you should call your final string "gene"
    return(gene)
}


# Now pull the appropriate strain(s) from the seqs list, and 
# use this function to get the 16S sequences for your strains.



# As a double-check, if you use your function on the first strain, 22501,
contigs_22501 <- seqs[[1]]

# gene_16s_01 <- gene_puller(contigs_22501, 27, 3674,5199)  # uncomment to run after
# you've written and loaded your function (make sure it's in your
# environment)

# your string should be a gene of length 1526 that starts with AAGGAGGTGATCC...

##################################
##################################
```

#### Checking against the database

You should now have two sequences. Following what we did during lab, pull up BLASTn from the [NCBI site](https://blast.ncbi.nlm.nih.gov/Blast.cgi) and BLAST each of the sequences against the 16S database.

You should all find several species that are a very good match for each strain. If not, email us to try to trouble-shoot what went wrong with the sequence-pulling.

Enter some data for your primary strain into the google doc in the appropriate columns: \* the sequence you pulled, \* the name of the top matching species, as well as the query coverage (which is the overlap) and the percent identity, \* the second best matching species that is different from the top species (the top results might be several different genomes from the same species), plus query coverage and percent identity.

Your additional strain sequence will already be filled in on the doc. Double-check that you have found the same results. This our "positive control", making sure that the process worked okay.

------------------------------------------------------------------------

Code Appendix
-------------

This includes all of the inline code you wrote in the coding sections while you were exploring in this week's lab. You don't need to run anything -- it will automatically fill itself in.

``` r
a1 <- assemble(mystery1, penalty = -3, min_overlap = 4)

##################################
###  Your code here            ###
##################################

# fill in some code as we calculate coverage and other features


##################################
##################################

# Assemble mystery2, 3, 4, 5, 6, and 7, and store them as
# a2, a3, a4, a5, a6, a7

##################################
###  Your code here            ###
##################################




##################################
##################################

# Write a function called contig_cov() that can calculate the 
# coverage of an assembly given the assembly and the initial reads.


##################################
###  Your code here            ###
##################################

contig_cov <- function(assembly,reads)
{
    # make sure you include comments to explain the code
}

# Now use this function to calculate the coverage for each of the
# assembled sequences.



##################################
##################################
# We did you the favor of formatting the contigs for each
# strain a little easier

load("../data/processed/Lab2_contigs.RData")

# This loaded a large list called seqs
# Each entry lines up with the last two digits of 5-digit
# strain code. For example 22502 is the second entry
# in the list.

# So if we wanted to focus 22502_06_Cabo (our weird assembly
# from earlier), we could enter
contigs_22502 <- seqs[[2]]

# Note that taking entries from a list requires double brackets,
# [[]], not the single brackets [] you use for a vector.

# let's double check the structure of this data
str(contigs_22502)

# It's a character vector with 885 entries, and each entry is a string.
# As you might have guessed, this represents the string for each contig.
# This (weird) strain has 885 contigs. That's a lot. Most of your 
# strains will not have that many.

# If you want a particular contig, you can just pull that entry from the 
# vector.

s22502_c7 <- contigs_22502[7]

# We now need to pull out just a small part of this contig.
# Last week you got some practice pulling out a subset of a DNA string. 
# There we converted to a vector and using square brackets [] to 
# pull out particular entries.
# You could do it that way, but you could also try out a function called
# substr(). Use ?substr() to see the help file.

# Either way, here is your full task.  Write a function that starts with a
# vector of contigs, e.g. contigs_22502, takes a contig #, a start point,
# and an end point, and pulls out just that sequence as a single 
# string.

# This will allow you to pull out your 16S sequences that 
# you looked up earlier, to then BLASTn them.


##################################
###  Your code here            ###
##################################

# Make sure you include lots of comments!
# Before each of line code where you're doing something new,
# use # to add a comment to explain what you're doing.

gene_puller <- function(contigs, contig_num, start, end)
{
    # Starts with a vector of contigs (strings), and uses a contig number,
    # a start point, and an end point to return
    # a subsequence of the DNA as a single string
    
    
    
    # you should call your final string "gene"
    return(gene)
}


# Now pull the appropriate strain(s) from the seqs list, and 
# use this function to get the 16S sequences for your strains.



# As a double-check, if you use your function on the first strain, 22501,
contigs_22501 <- seqs[[1]]

# gene_16s_01 <- gene_puller(contigs_22501, 27, 3674,5199)  # uncomment to run after
# you've written and loaded your function (make sure it's in your
# environment)

# your string should be a gene of length 1526 that starts with AAGGAGGTGATCC...

##################################
##################################
```
