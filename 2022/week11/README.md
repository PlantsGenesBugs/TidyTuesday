## Week 11

This week the data comes from [Robert Flight's Github](https://github.com/rmflight/vignette_analysis), where he aimed to analyze the changes in the number of vignettes over time, in order to quantify the effect of knitr and rmarkdown. Two data sets are available: one for packages in CRAN and one for packages in Bioconductor. For each current and available package under the CRAN archive, Robert counted how many sweave and markdown vignettes were present. For Bioconductor, he counted how many of each vignette type was present at each commit.

The data sets can be accessed from the #TidyTuesday [Github](https://github.com/rfordatascience/tidytuesday/blob/master/data/2022/2022-03-15/readme.md) page. 

I'm not sure I understood the data as Robert meant it. That said, I still uncovered some interesting patterns where the max number of available vignettes for any given package in Bioconductro still created a pattern that could be analysed, with microbiom showing a maximum vignette number of 37 (somewhere in 2017, roughly 9 years since its first commit). Other packages that showed a vignette count of >15 include ELMER, pRoloc and biodb. Curiously, two packages are recorded to be older than 50 years (flowDensity and STATegRa), which seems questionable.
