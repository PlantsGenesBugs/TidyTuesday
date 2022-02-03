## Week 5

Today's data comes from the American Kennel Club courtesy of [KKakey](https://github.com/kkakey/dog_traits_AKC/blob/main/README.md). The data was previously analysed by [USA Today](https://eu.usatoday.com/picture-gallery/life/2021/06/28/the-50-most-popular-dog-breeds-in-america/45134329/) and [Vox](https://www.vox.com/2016/8/31/12715176/most-popular-dog-breeds). 

Most analyses look at the popularity of dogs over time, and this data really lends itself to trend analysis. There are some valuable insights to be gleaned from the top traits observed in different breeds (e.g. drooling level, playfulness, adaptability, affectionate with family).

For this week I initially wanted to see if the pandemic had any impact on dog preference, but the data only covers 2013-2020, so real trends won't be obvious. Therefore I followed the general trend to look at popularity over time, but I limited my analysis to the top 5 trends in 2020 (and their path to becoming so popular). My ultimate vision was to have images of the dogs next to their final position in 2020 and have a text box next to each listing the breed's top traits (limiting it to traits that score no lower than 4 out of 5), but unfortunately my skill couldn't quite cope with my ambition this year.

At the moment I'm studying Regression Models in the [Johns Hopkins University Dept of Biostatistics coursera course](https://www.coursera.org/learn/regression-models), so I was also tempted to see how ranking relates to traits, but I just never got around to it (and my actual Regression Models course project is already late...!)

So here is my output. An animated graph showing the change in popularity of different dog breeds from 2013 to 2020. The French Bulldog is by far the biggest winner, moving from a ranking of 11 in 2013 to a stellar 2 in 2020, only losing out to the ever popular Labrador Retriever.

![An animated line graph showing the change in popularity ranking for 5 different dog breeds between 2013 and 2020.](https://github.com/PlantsGenesBugs/TidyTuesday/blob/main/2022/week5/dogs.gif)

I was curious to see if this trend in popularity was reflected in Google searches for the term "French Bulldog" in the USA over the corresponding time, and discovered this trend:

![A screen shot showing a graph of the number of times the search term "French Bulldog" was searched for in Google, between 2013 and 2020. It shows a line with a slight positive slope.]("https://github.com/PlantsGenesBugs/TidyTuesday/blob/main/2022/week5/Bulldog%20USA%20Google%20trend-small.png")
