## Week 15

The data this week comes from [Our World in Data](https://ourworldindata.org/indoor-air-pollution) and looks at indoor air pollution, access to clean solid fuel for cooking, and deaths related to air pollution from solid fuels. Our World in Data have written some excellent articles about this data set on the following topics (which can be accessed at the [TidyTuesday page for this week](https://github.com/rfordatascience/tidytuesday/blob/master/data/2022/2022-04-12/readme.md): 

- Indoor air pollution is a leading risk factor for premature death.
- 4.1% of global deaths are attributed to indoor air pollution.
- Death rates from air pollution are highest in low-income countries. There’s a greater than 1000-fold difference between low- and high-income countries.
- The world is making progress: global deaths from indoor air pollution have declined substantially since 1990.
- Death rates from indoor air pollution have declined in almost every country in the world since 1990.
- Indoor air pollution results from a reliance of solid fuels for cooking.
- Only 60% of the world has access to clean fuels for cooking. This share has been steadily increasing.
- The use of solid fuels for cooking has been declining across world regions, but is still high.

As someone who holds South African citizenship, I decided to focus on Africa. It was interesting to see that countries in the far north of Africa have a near 100% access rate to clean solid fuels for indoor cooking. However, even for countries with varying access to clean solid fuels, the deaths caused by household air pollution hovered around 10% (compare Senegal with 40% access to Mali at about 12% access). For all the graphs it almost appeared as if access to indoor fuels was irrelevant for deaths caused by indoor pollution, so I did a very quick and dirty comparison of all the data, comparing deaths vs access, and found a clear negative relationship.

As a point of interest, in 2015 a town in Italy [temporarily banned wood-fired stoves](https://www.bbc.co.uk/news/blogs-news-from-elsewhere-35161213) in bakeries and eateries in order to install special filters to reduce air pollution. You can compare the difference in death rates between countries in one of the interactive graphs produced by Our World in Data [here](https://ourworldindata.org/indoor-air-pollution#death-rates-are-highest-across-low-income-countries) to see how Italy compares to other countries.

![A facetted plot, showing the percentage of deaths caused by indoor pollution and the percentage of the population that have access to clean solid fuel on the Y axis, and the years 2000-2019 on the X axis. The two data sets for the Y values are represented by stacked areas in different colours. There is an individual graph for each country in Africa. Countries in central Africa and around the equator have the lowest access to clean solid fuels. Countries in far north Africa have the highest access % at nearly 100%. Most countries show increasing access to clean solid fuels and static or decreasing % of deaths caused by indoor pollution.](https://github.com/PlantsGenesBugs/TidyTuesday/blob/main/2022/week15/indoorPollution.png) 

![A dot plot with percentage deaths caused by indoor pollution on the Y axis and access to clean fuel as a percentage of the population on the X axis. A negative relationship between these two variables are observed.](https://github.com/PlantsGenesBugs/TidyTuesday/blob/main/2022/week15/deathsVSaccess.png) 


