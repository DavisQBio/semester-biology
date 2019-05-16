---
title: "Lab 7 write-up"
layout: page
---

Week 7 Lab
----------

------------------------------------------------------------------------

> ### Homework for Next Week
>
> -   Fill in all of the answer blocks and coding tasks in this lab
>     notebook.
> -   Complete all tasks in the Homework section (bottom of the Rmd).
>     You will submit this Rmd as your results/analysis write-up that we
>     will use for peer feedback in next week’s lab.
>
> ### Learning Objectives
>
> -   Code a sliding window analysis to look for regions in a contig
>     with unusually high or low GC content.
> -   Use the `biofiles` package to manipulate genbank files to easily
>     find genes, their sequences, and their translations (their amino
>     acid sequences).
> -   Have a clear plan for generating the first set of results for your
>     project.

------------------------------------------------------------------------

### Scripts and installations for Lab 7

Download the `utils_lab7.R` script from Canvas and put it into your
scripts folder. Install the `biofiles` package and load everything by
running the scripts below.

    # You only need to install this once
    install.packages("biofiles")

    # Loading the packages we'll use today
    suppressPackageStartupMessages(suppressWarnings(library(tidyverse)))
    suppressPackageStartupMessages(suppressWarnings(library(biofiles)))
    suppressPackageStartupMessages(suppressWarnings(library(Biostrings)))

    # loading today's script
    source("../scripts/utils_lab7.R")

    # loading some old data from week 2
    load("../data/processed/Lab2_contigs.RData")

### Overview

Today is mainly devoted to working on your individual projects. Dr. Nord
and Dr. Furrow will have 5 minute check-ins with each of you to help
with any questions and get you into the data
gathering/processing/analyzing phase of your work. But before we do
that, we’ll show an example of a sliding window analysis and some R
tools for pulling out specific sequences from a genbank file.

### Continuing from lecture – themes and tools

We will continue to build a list of some of the key themes of the
projects and some tools you might use to ask your questions.

### Finding weird genomic regions using sliding window analyses

We don’t need any new data for today, because we already have our FASTA
and genbank files, and we also have the Lab2 data with easy-to-access
sequences for every contig of every sample.

*The Plan: look at 500 base pair windows throughout a contig to find
places where the GC content looks different.*

*Your task: with your group, outline how you would do this in R. Your
starting data is a contig (as a single string), and your final data
should be a vector with the GC content for each of your windows.*

------------------------------------------------------------------------

> #### Answer block – Sliding window algorithm
>
> Step 1:
>
> Step 2:
>
> …

------------------------------------------------------------------------

------------------------------------------------------------------------

**After you’ve finished, pause here. We will talk about the algorithm,
then live-code it as a class.**

------------------------------------------------------------------------

    # Watch out for the seqs data -- it's huge and can freeze R if you try to
    # view the whole thing at once.

    # seqs is a list.  We can pull the first sample with the double-brackes [[]]
    s01 <- seqs[[1]]

    # each entry in the list is the vector of contigs, each as a string

    # here are the length of the first 10 contigs for sample 01
    nchar(s01)[1:10]

    ##  [1] 472201 436823 262566 252655 234959 219081 198193 186437 162179 160644

    # let's pull out the third contig
    s01_c3 <- s01[3]

    # and get its length
    c_length <- nchar(s01_c3)

    # let's get the overall GC content of the contig.
    # str_count (from tidyverse) can count all occurrences of a pattern
    gc_total <- str_count(s01_c3,pattern = "C|G")/c_length
    gc_total

    ## [1] 0.6158604

    # Now let's code up a sliding window

    ##################################
    ###  Your code here            ###
    ##################################

    # we'll do this with a window size of 500bp



    # now let's make a data.frame



    # now we can visualize our data



    ##################################
    ##################################

After we’ve completed that, we should have identified a low GC region
from about 74,000 bp until 84,500 bp. What can we do with it?

    # So, we have a picture of the approximate start and end of this region

    # We could just open up our genbank file and scroll down to this 
    # part of the third contig (NODE_3) to see what is annotated there.

    # But R has some tools to handle this as well.
    # One uses the gbRecord() function from the biofiles package

    s01_gb <- gbRecord("../data/raw/22501_18_FS.gbk")

    ## Warning: executing %dopar% sequentially: no parallel backend registered

    # this has a highly formatted table version of the annotations in each 
    # contig, as a list with a table for each contig

    # we can select a single contig, using the usual list syntax
    s01_c3 <- s01_gb[[3]]

    summary(s01_c3)

    ## [[ACCESSION]]
    ##   262566 bp: Genus species strain strain.
    ##   Id Feature Location                   GeneId Product              ...
    ##    1 source  1..262566                  NA     NA                   ...
    ##    2 CDS     complement(30..1499)       NA     hypothetical protein ...
    ##    3 CDS     1610..2797                 rsbP   Phosphoserine phosph ...
    ##    4 CDS     2790..3278                 NA     hypothetical protein ...
    ##    5 CDS     3311..4351                 gpsA   Glycerol-3-phosphate ...
    ##    6 CDS     complement(4352..5512)     csd    putative cysteine de ...
    ##    7 CDS     5606..6187                 NA     hypothetical protein ...
    ##  ... ...     ...                        ...    ...                  ...
    ##  240 CDS     253419..253730             NA     hypothetical protein ...
    ##  241 CDS     complement(253724..255256) mcpQ_2 Methyl-accepting che ...
    ##  242 CDS     255538..256620             NA     hypothetical protein ...
    ##  243 CDS     256690..257337             NA     hypothetical protein ...
    ##  244 CDS     257342..258745             dinB_2 DNA polymerase IV    ...
    ##  245 CDS     258742..261819             dnaE2  Error-prone DNA poly ...
    ##  246 CDS     261842..262336             NA     hypothetical protein ...

    # your instructors have put together a tiny function, region_reader()
    # that will pull out only a region of interest

    # let's focus on the region we saw in the plots above
    low_gc_region <- region_reader(s01_c3,74501,84501)
    summary(low_gc_region)

    ##  Id Feature Location                 GeneId Product                 ...
    ##  69 CDS     complement(74973..76019) bshA_2 N-acetyl-alpha-D-glucos ...
    ##  70 CDS     complement(76012..77001) NA     hypothetical protein    ...
    ##  71 CDS     77234..78652             NA     hypothetical protein    ...
    ##  72 CDS     78995..80185             bshA_3 N-acetyl-alpha-D-glucos ...
    ##  73 CDS     complement(80193..80966) queC_2 7-cyano-7-deazaguanine  ...
    ##  74 CDS     complement(80978..82081) capA   Capsule biosynthesis pr ...
    ##  75 CDS     complement(82074..83207) NA     hypothetical protein    ...
    ##  76 CDS     complement(83323..84357) kanE_1 Alpha-D-kanosaminyltran ...

    # it was particularly low right after 80,000 bp into the contig
    # let's choose the capA gene (the 6th row in this table)

    # the translation() function pulls out the amino acid sequence
    low_gc_aa_6 <- translation(low_gc_region[6])

    # but this package (and many that work with genomic data) won't 
    # print everything by default.  That's a good thing, it avoids
    # freezing your R session by trying to print giant strings.

    # If you want the full sequence, the easiest way is to just use
    # as.character to convert back to a regular string in R
    low_gc_aa_string_6 <- as.character(translation(low_gc_region[6]))

With this we can go to NCBI’s BLAST
<a href="https://blast.ncbi.nlm.nih.gov/Blast.cgi" class="uri">https://blast.ncbi.nlm.nih.gov/Blast.cgi</a>
and use a BLASTp search (the protein version that takes an amino acid
sequence and searches protein databases).

This might take a minute. We will go over these results as a class, in
particular noting the relatively poor identity with most known proteins,
and looking at the “Distance tree of results” (link just above Graphic
Summary).

### Rest of class, working on your projects.

We will ask you to write out a detailed outline of an analysis before
you leave, so we can ensure that everyone has the tools and support they
need.

#### Some extra gene sequence analysis examples that people may find useful

    # We won't go over this in lab, but here are a few other things you can do
    # by combining the Biostrings and biofiles packages

    # you can count up the amino acids for each gene in your region of interest
    # using alphabetFrequency
    alphabetFrequency(translation(low_gc_region))

    # you can also get the DNA sequence
    getSequence(low_gc_region)

    # but watch out, some are forward and some are reverse
    strand(low_gc_region)

    # if one is on the -1 strand, that means you need to read the reverse complement
    # hey, there's a function for that
    strand(low_gc_region[2])

    # this one is on the negative strand, so let's reverse it
    seq_2_low_gc_region <- reverseComplement(getSequence(low_gc_region[2]))

    # let's double check that our translation taken from the DNA
    # sequence
    translate(seq_2_low_gc_region)
    # matches the translation directly in the gbk file
    translation(low_gc_region[2])


    # more genererally, if you were looping through, you could use
    # an if() statement to check the strand, then reverse as needed

    # a character vector to store our sequences
    seqs_low_gc_region <- character(length = length(low_gc_region))

    # looping over each feature (here all genes) in our region
    for(i in 1:length(low_gc_region))
    {
        if(strand(low_gc_region[i]) == -1)
        {
            seqs_low_gc_region[i] <- reverseComplement(getSequence(low_gc_region[i]))
        } else 
        {
            seqs_low_gc_region[i] <- getSequence(low_gc_region[i])
        }
    }

    # now we have a nice vector of each gene's DNA sequence as a character vector
    seqs_low_gc_region

For more details about using the `biofiles` package to automatically
pull out genes of interest and find their locations/sequences, check out
<a href="https://github.com/gschofl/biofiles" class="uri">https://github.com/gschofl/biofiles</a>.

Homework (these points count towards your project grade, not your HW grade)
---------------------------------------------------------------------------

### Finish up labwork (1 pt)

Make sure that the short response and coding snippet above have been
filled in with your work.

### Project work – your first result (4 pts)

We’re transitioning into the substance of the projects. You have
generated fantastic ideas, but you will now see the iterative,
stop-and-go process of performing the analysis on real data. Your HW
task is to perform some part of your project analysis, producing a
figure/table, and include both the code used and a written explanation.
*If it requires coding in R, you should do your coding right here inside
of the Rmd. If it uses other tools, you might still want to use R to
make some figures. In addition, you should write 3-4 paragraphs in this
Rmd explaining the steps of what you are doing. We will use this
write-up for a peer review session next week in lab.*

#### Your written explanation

#### Your code

    #Your code here.  Make sure you include lots of comments!
