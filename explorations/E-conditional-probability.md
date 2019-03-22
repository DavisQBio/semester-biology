------------------------------------------------------------------------

> ### Learning Objectives
>
> -   Build intuition for how the probability of some event can depend
>     on other evidence.
> -   Be able to analyze a potential new test to screen for a disease
> -   Use and interpret equations to calculate conditional probabilities

------------------------------------------------------------------------

As always, you can download [a script with nothing but the R code
here](../../scripts/E-conditional-probability.R).

The challenge of screening for rare diseases
--------------------------------------------

When a disease is common in a population, it can be a good use of public
health funds to conduct *screening*.
[Screening](https://www.hopkinsmedicine.org/healthlibrary/conditions/pathology/screening_tests_for_common_diseases_85,P00965)
is the process of testing a focal population with the aim of detecting a
disease early. In some cases, this allows for treatment to prevent
disease progression. For example, the Pap test can detect cervical
cancer at an early, asympomatic stage, leading to effective early
treatment. Another common example, a cholesterol blood test, can help
inform lifestyle changes or allow medical intervention. Note that we said
*focal population* above. For many tests, you focus your screen only a subset 
of the full population. The Pap test is only recommended for women aged 21-65. 

What exactly does this have to do with probability? Well, it turns out
the details of the test, and the prevalence of the disease in the focal
population you're testing, play a big role in how useful the test
results really are. To understand this, we'll need to define a few
useful terms to describe test features.

> -   **Sensitivity** is the probability that a person who actually has
>     the disease will get a positive test result from the screening
>     test. This is also called the **true positive rate**.
> -   **Specificity** is the probability that a person who does not have
>     the disease will get a negative test result from the screening
>     test. This is also called the **true negative rate**.

<div class="figure">

<iframe src="https://rfurrow.shinyapps.io/DiseaseScreening/?showcase=0" width="100%" height="600px">
</iframe>
<p class="caption">
figure
</p>

</div>

<p style="text-align: right; font-size: small;">
Page built on: 2018-10-05 at 11:03:52
</p>

