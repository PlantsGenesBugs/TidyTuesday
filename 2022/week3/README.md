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

![A barchart showing country identity on the Y axis and count on the X axis. The count is the number of times that country was a supplier of cocoa beans for making chocolate bars. There are 5 countries that supply the bulk of beans, namely Venezuela, Peru, the Dominican Republic, Ecuador and Madagascar.](https://github.com/PlantsGenesBugs/TidyTuesday/blob/main/2022/week3/BarPlotCocoaSource.png)
