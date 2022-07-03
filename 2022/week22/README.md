## Week 22

I've taken a small break from Tidy Tuesday due to work and other things (I'm aiming to cycle 600km in Finland soon - it requires quite a lot of training, both physically and navigationally!). But I wanted to dip back in because I realised my R skills were atrophying. So here we are... I used the data for week 22, although TidyTuesday has already rolled into week 23. I just found the data really interesting, so I will spend a bit of time analysing it.

The data for week 22 comes from the [Axios Harris Poll 100](https://theharrispoll.com/partners/media/axios-harrispoll-100/). The poll methodology itself is also quite interesting, although I have to admit I'm not a social scientist so my opinions are based on curiousity, not expertise. In a 2-step process the poll first identifies companies that have, according to respondents, very good or very bad reputations. This list of companies is then ranked in the second part of the process by a separate set of respondents. For step 1, a total number of 6,118 people were polled. Although they are selected to be representative of the entire USA, the number seems small to me. The second step employs 33,096 respondents (also selected to be a representative sample).

The Corporate Reputation Rankings therefore don't necessarily tell us which companies are most profitable or successful - no, the rankings tell us which companies are either very good at marketing, or stick in people's minds because of exceptional service (either good or bad), or for controversy surrounding the brand. 

My first overview of the data revealed that of the different sectors of industry included in the poll, retail businesses are foremost in people's minds. In fact, retail business has dominated this poll since 2017, with the number of businesses in other sectors remaining constant annually in the poll. I imagine this reflects the frequency with which people interact with different sectors of industry. 

The obvious next question is: which companies are included in the poll and how have their rankings changed over time? The nature of the first step of the poll would suggest that the companies in each sector will rank either very high or very low. But will companies manage to change rank? Or disappear entirely off the poll? I'll answer that in a follow-up post next week.

![A packed circle graph, where each circle represents a sector of industry and the size of the circle represents the number of businesses included in the Axios Harris poll for that industry. The largest circle is represented by the Retail industry, followed by Tech, Food & Beverage and Financial services. The smallest circle is Insurance.](https://github.com/PlantsGenesBugs/TidyTuesday/blob/main/2022/week22/CompanyReputationA.png)


## Week 22 (part 2)

The data from the Axios Harris Poll 100 tells us which companies are memorable, either for good or bad reasons. In the first round of polling, respondents identify companies that are memorable/visible. A second set of respondents then rank them according to 7 key dimensions of reputation, ending in the final list of 100 companies. For the second part of my analysis I looked at the ranking of all companies in the poll, split by industry, over the past 5 years. The large facetted graph that I pulled out of the data has some interesting patterns and I took a deeper dive into some industries that had unusual patterns over time. Overall, as shown in the bubble plot above, retail dominates in terms of visibility with most companies present in the poll every year. This visibility in each year is true in most industries, although some companies disappear for a few years and then reappear, or some companies appear anew (especially in 2022).

![A facetted graph including 19 point-and-line graphs showing the ranking of all companies in the Axios Harris 100 poll, split by industry.](https://github.com/PlantsGenesBugs/TidyTuesday/blob/main/2022/week22/repTimeNoLegend.png)

I selected E-commerce, media, telecoms, logistics, pharma and "other" as industries to analyse more closely (simpler patterns and smaller numbers in each category).


### E-commerce

Amazon ranks consistently high in the polls. In the eyes of the consumer (or, at least, in the eyes of the 33 000 or so respondents polled in the ranking phase of the poll), Amazon is both visible and is assessed favourably. It's rival, eBay, has consistently ranked lower (and has reached an all-time low ranking of 83 in 2022). Interestingly, both My Pillow and Wish.com suddenly appeared mid-pandemic and scored very low. Possibly a reflection of politics and more time spent online. In fact, for many of these data points I speculate the strong hand of politics and the effect of the pandemic on human behaviour. The My Pillow company made themselves very visible in the past couple of years outside of their actual product and many people view them unfavourably due to their political involvement. But as the saying goes, "there's no such thing as bad publicity"...

![A point and line graph showing the ranking of companies in the E-commerce sector in the Axios Harris Poll between 2017 and 2022. Four companies are represented: Amazon.com ranks consistenly high across all years. eBay starts at around 30 and drops down to about 83 in 2022. My Pillow appears in 2021 at aoround 90 and increases a small amount in 2022. Wish.com appears in 2021 in the upper 90's and drops closer to 100 in 2022 (the lowest position in the poll).](https://github.com/PlantsGenesBugs/TidyTuesday/blob/main/2022/week22/ecomm.png)


### Media

Four media companies have proven visible enough to be included in the poll. Comcast (rated consistently low), the Walt Disney Company (a steady trajectory downwards), Spotify (appeared suddenly in 2022) and Fox Corporation (appeared in 2020 and rates consistenly low - even lower than Comcast). The most dramatic change here is in the Walt Disney company's rankings. Axios themselves have [ascribed this plummet in ranking to political drama](https://www.axios.com/2022/05/24/axios-harris-poll-100-corporate-brands-politics) - notably to the adoption of the "Don't Say Gay" bill in Florida.

![A point and line graph showing the ranking of companies in the media sector in the Axios Harris Poll between 2017 and 2022. Four companies are represented: Spotify (appears in 2022 at about number 60), The Walt Disney Company (has a high ranking in 2017 and slides down the ranks to about 70 in 2022), Comcast (consistently low) and Fox Corporation (appears in 2020 at the bottom end of the rank and stays there for the following years).](https://github.com/PlantsGenesBugs/TidyTuesday/blob/main/2022/week22/media.png)


### Telecommunications

Once again, 4 companies have made the cut: both Verizon and AT&T have always been visible and always rank fairly low (lower than position 50 in the poll). Two companies have appeared over time: T-Mobile appeared just below position 50 on the poll in 2022. This is pure speculation on my part, but I wonder if the [T-Mobile Super Bowl 2022 commercial](https://www.youtube.com/watch?v=sdi-oGP7ndQ) has anything to do with it...? The timing would work out (the first round of the poll is completed in February, with the ranking then happening March-April). However, if this were true then it wouldn't explain the lack of other companies also associated with the Super Bowl (or perhaps people aren't as worked up about [Lindsay Lohan](https://www.youtube.com/watch?v=4TEKZo6b11M) as they are about Miley Cyrus?). The fourth telecommunications company in the ranking is Spectrum, that went from a stellar 11th position in 2021 to a terrible 82 in 2022. I cannot find anything obvious about this company that could explain the ranking, except that in 2022 the company announced a new [$20 standard minimum wage](https://fortune.com/company/charter-communications/fortune500/)...

![A point and line graph showing the ranking of companies in the telecommunications sector in the Axios Harris Poll between 2017 and 2022. Four companies are represented: Verizon and AT&T are present in all years of the poll and both rank consistenly low (lower than 50). T-Mobile appears once in 2022 at around position 52. Spectrum appears in 2021 at position ~13 but drops significantly in 2022 to position ~80.](https://github.com/PlantsGenesBugs/TidyTuesday/blob/main/2022/week22/telecom.png)


### Logistics

Only 2 logistics companies are visible enough to reach the poll: UPS and FedEx. Both actually rank quite high, with UPS beating FedEx consistently. Interestingly, both companies have slid a bit down the ranking in the past couple of years (perhaps higher volumes during the pandemic have affected the ability of both companies to provide their usual service).

![A point and line graph showing the ranking of companies in the logistics sector in the Axios Harris Poll between 2017 and 2022. Only 2 companies are represented: UPS and FedEx. UPS is present in every year and ranks consistenly highly (above position 25). FedEx is present in 2017 and then in 2020-2022 and ranks highly but always below UPS.](https://github.com/PlantsGenesBugs/TidyTuesday/blob/main/2022/week22/logist.png)


### Pharmaceuticals

The effect of the pandemic is clear in this industry, where only 2 companies are represented in the poll: Johnson & Johnson and Pfizer. J&J have been in the poll every year and started off with a very high ranking in 2017 (close to top spot), but then saw a steady decline and a rapid drop in 2020, the year it was one of the producers of a vaccine against Covid-19. In that year (2020) Pfizer suddenly appeared on the poll, scoring just above J&J (but still under position 50). Pfizer then rockets up to position 7 in 2021, before dropping back down to 44 in 2022. This was all, almost certainly, because of health concerns around the vaccines, and the fact that the CDC preferentially advised the [use of the Pfizer vaccine over the J&J vaccine](https://www.cdc.gov/coronavirus/2019-ncov/vaccines/different-vaccines/janssen.html).

![A point and line graph showing the ranking of companies in the pharmacuetical sector in the Axios Harris Poll between 2017 and 2022. Only 2 companies are represented: Pfizer and J&J. J&J is present in every year and has slid down the rankings from ~5th spot in 2017 to ~73 in 2022. Pfizer is present from 2020 onwards. In 2020 it ranked close to J&J, then shot up to ~ position 5, before dropping back down the ranking (to ~55) in 2022.](https://github.com/PlantsGenesBugs/TidyTuesday/blob/main/2022/week22/pharma.png)


### Other

I probably don't have to say too much about this. For those who don't know, Berkshire Hathaway is a multinational conglomerate holding company that owns 13 other companies wholly (e.g. Duracell, Dairy Queen, Fruit of the Loom, Pampered Chef) and have shares in several more including the Kraft Heinz Company, American Express, and The Coca-Cola Company. You might be familiar with the company's Chairman and CEO, Warren E. Buffett, [one of the most successful investors of all time](https://www.forbes.com/profile/warren-buffett/?sh=1447fb374639). Buffett has promised to donate over 99% of his wealth and has so far donated $45 billion.  

![A point and line graph showing the ranking of other companies in the Axios Harris Poll between 2017 and 2022. Only 2 companies are represented: Berkshire Hathaway and The Trump Organization. Berkshire Hathaway is present in every year and has maintained a fairly high ranking over time. The Trump Org appears in 2018 at the bottom of the poll and stays there, finishing in position 100 in 2022.](https://github.com/PlantsGenesBugs/TidyTuesday/blob/main/2022/week22/other.png)
