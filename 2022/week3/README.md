## Week 3

This week the data was provided by flavorsofcacao.com where over [2500 chocolate bars have been rated](http://flavorsofcacao.com/chocolate_database.html). This was a recommendation by [Georgios and Kelsey](https://github.com/rfordatascience/tidytuesday/issues/408).
The data contains information about:
1. The bar's reference number (related to when it was rated)
2. The company that manufactured the bar
3. The location of the company
4. The review date
5. The country of origin of the cocoa beans
6. The specific bean origin or bar name
7. The percentage cocoa in the bar
8. The number and type of ingredients (B - beans, S - sugar, S* - sweetener, C - cocoa butter, V - vanilla, L - lecithin and Sa - salt)
9. The most memorable characteristics (in words)
10. The rating as a number from 1 to 5

I considered several ways to probe the data... 
- Who's the biggest supplier?
- Does the rating correlate to the number of ingredients or the % cocoa?
- Do some manufacturers prefer specific countries?
- Is there trends in flavour notes (by date/location)?
- HOW can I use the information locked up in the memorable characteristics column?

I decided to go for the first 2 questions above. Employing various levels of sophistication, I illustrated the number of suppliers both as a bar chart and as a heat map projected onto a world map. A quick look at the relationship between rating and % cocoa revealed that a high percentage cocoa is no guarantee of a good bar of chocolate!

![A bar graph showing country identity on the Y axis and count on the X axis. The count is the number of times that country was a supplier of cocoa beans for making chocolate bars. There are 5 countries that supply the bulk of beans, namely Venezuela, Peru, the Dominican Republic, Ecuador and Madagascar.](https://github.com/PlantsGenesBugs/TidyTuesday/blob/main/2022/week3/BarPlotCocoaSource.png)

Fig 1. Number of times a specific country supplied cocoa beans for chocolate bars worldwide.

![A world map with colours indicating the relative number of times a country was a supplier of cocoa beans. The heat scale goes from yellow (small numbers) through orange to red (high numbers). The red colour is concentrated in countries in the north of South America and the island of Madagascar off the East coast of Africa.](https://github.com/PlantsGenesBugs/TidyTuesday/blob/main/2022/week3/WorldMapCocoaSource.png)

Fig 2. World map indicating the location of the countries in the bar graph above, as well as the number of times they supplied cocoa beans.

![A dot plot with percentage of cocoa on the X axis and rating for that specific chocolate bar on the Y axis (from 1 to 5). There is no specific pattern with all cocoa percentages having obtained both low and high ratings](https://github.com/PlantsGenesBugs/TidyTuesday/blob/main/2022/week3/CocoaVSRating.png)

Fig 3. Dot plot showing the relationship between percentage cocoa in a chocolate bar and its given rating by the assessor. There seems to be no specific pattern, showing that experience of a chocolate bar is not exclusively linked to its cocoa content.
