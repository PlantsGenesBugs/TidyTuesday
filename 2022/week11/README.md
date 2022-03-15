## Week 11

This week the data comes from [Robert Flight's Github](https://github.com/rmflight/vignette_analysis), where he aimed to analyze the changes in the number of vignettes over time, in order to quantify the effect of knitr and rmarkdown. Two data sets are available: one for packages in CRAN and one for packages in Bioconductor. For each current and available package under the CRAN archive, Robert counted how many sweave and markdown vignettes were present. For Bioconductor, he counted how many of each vignette type was present at each commit.

The data sets can be accessed from the #TidyTuesday [Github](https://github.com/rfordatascience/tidytuesday/blob/master/data/2022/2022-03-15/readme.md) page. 

I'm not sure I understood the data as Robert meant it. That said, I still uncovered some interesting patterns where the maximum number of available vignettes for any given package in Bioconductor created a pattern that could be analysed. The microbiome package showed a maximum vignette number of 37 (recorded in 2017, roughly 9 years since its first commit). Other packages that showed a vignette count of >15 include ELMER, pRoloc and biodb. Curiously, two packages are recorded to be older than 50 years (flowDensity and STATegRa), which seems questionable.

![Dot plot of number of vignettes associated with different packages in the Bioconductor repository. On the x axis is number of years between first and most recent upload/update. On the Y axis is the maximal number of vignettes (either created through sweave or knitr). 4 packages have more than 15 max vignettes - see text for details](https://github.com/PlantsGenesBugs/TidyTuesday/blob/main/Vignettes.png)
