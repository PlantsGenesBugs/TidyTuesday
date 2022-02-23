## Week 8

This week the data comes from [Freedom House](https://freedomhouse.org/reports/publication-archives). This NGO conducts research and advocacy on democracy, political freedom, and human rights. They gather data on 7 main topics for each country, split between the main categories of Political Rights and Civil Liberties:

*Political Rights*
- Electoral Process: executive and legislative elections, and electoral framework (3 questions) 
- Political Pluralism and Participation: party system, competition, freedom to exercise political choices, and minority voting rights (4 questions)
- Functioning of Government: corruption, transparency, and ability of elected officials to govern in practice (3 questions)

*Civil Liberties*
- Freedom of Expression and Belief: media, religious freedom, academic freedom, and free private discussion (4 questions)
- Associational and Organizational Rights: free assembly, civic groups, and labor unions (3 questions)
- Rule of Law: independent judges and prosecutors, due process, crime and disorder, and legal equality (4 questions)
- Personal Autonomy and Individual Rights: freedom of movement, property rights, personal and family rights, and freedom from economic exploitation (4 questions)

Each country or territory is awarded a score of 0 to 4 points for each of the 25 indicators (questions) listed above. A score of 0 represents the smallest degree of freedom and 4 the greatest degree of freedom. The score totals from the Political Rights (PR) and Civil Liberties (CL) categories are then weighted equally to determine a country/territory’s status of Free (F), Partly Free (PF), or Not Free (NF). 

The data set also includes information [gathered from the UN](https://unstats.un.org/unsd/methodology/m49/overview/), including country code and development status. In the data set countries considered a "least developed country" (LDC) are scored 1, otherwise they're scored 0. According to [Wikipedia](https://en.wikipedia.org/wiki/Least_developed_countries), "The least developed countries (LDCs) are a list of developing countries that, according to the United Nations, exhibit the lowest indicators of socioeconomic development, with the lowest Human Development Index ratings of all countries in the world."

More information about Freedom House's research methodology can be found [here](https://freedomhouse.org/reports/freedom-world/freedom-world-research-methodology). 

The #TidyData [Github page](https://github.com/rfordatascience/tidytuesday/blob/master/data/2022/2022-02-22/readme.md) has more information about the challenge and links out to articles.

I separated the data into LDC and non-LDC countries and analysed the 3 LDC countries that scored best (low aggregate score) and 3 non-LDC countries that scored worst (high aggregate score) for political rights and civil liberties in 2020. I wanted to analyse whether "developed" countries necessarily gave their citizens political rights and civil liberties, and vice versa. The data revealed that the best score for any country was an aggregate score of 2 (countries like Australia, Ireland and Spain had this score) and the worst score was an aggregate of 14 (countries like Saudi Arabia, Turkmenistan and Eritrea had this score). On this scale, I found that the Pacific Islands of Tuvalu, Kiribati and Solomon Islands, while not considered "developed countries", have good aggregate rights and liberties scores (2, 2, and 4 respectively). On the other hand, the developed countries of Saudi Arabia, Equatorial Guinea and the Democratic People's Republic of Korea scored 14.

It's interesting to note that Equatorial Guinea was, in 2017, [the first country to leave the LDC category](https://unctad.org/news/equatorial-guinea-first-country-leave-ldc-category-adoption-sustainable-development-goals) after the adoption of the Sustainable Development Goals. Several countries graduated out of this category before Equatorial Guinea. The Solomon Islands also show an interesting pattern in their score - the dip in score around the year 2000 is almost certainly due to the [coup d'etat that occurred on 5 June 2000](https://en.wikipedia.org/wiki/2000_Solomon_Islands_coup_d%27%C3%A9tat). 

![A line graph showing the aggregate score for political righst and civil liberties, as scored by Freedom House, for 3 least developed countries and 3 non-least developed countries over 25 years. The x axis shows the years 1995 to 2020. The Y axis is inverted and runs from 15 (where it joins the X axis) to 0 at the top end. The LDC countries all cluster together at the top of the chart (have good rights and liberties scores), while the non-LDC countries are at the bottom of the chart (have poor rights and liberties scores). The 3 LDC countries are Tuvalu, Kiribati and Solomon Islands, and the 3 non-LDC countries are Saudi Arabia, Equatorial Guinea and the Democratic People's Republic of Korea.](https://github.com/PlantsGenesBugs/TidyTuesday/blob/main/2022/week8/Freedom.png)
