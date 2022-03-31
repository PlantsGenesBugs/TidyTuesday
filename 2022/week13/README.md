## Week 13

The data this week comes from [Equity in Athletics Data Analysis](https://ope.ed.gov/athletics/#/datafile/list). The data is collected from co-educational postsecondary institutions that receive Title IV funding in the USA and that have an intercollegiate athletics progam. These are institutions that participate in federal student aid programs. Data is submitted annually as a requirement by the Equity in Athletics Disclosure Act (EADA). More information about the incorporation of this data set in TidyTuesday is available [here](https://github.com/rfordatascience/tidytuesday/blob/master/data/2022/2022-03-29/readme.md).

As a refresher: both equality and equity aim to achieve fairness. Equality does this by treating everyone the same (regardless of need). Equity means that fairness is achieved by treating people differently dependent on need. Therefore the aim of these surveys is to ensure that every student is treated according to their need when it comes to access to sport.

The data set is incredibly rich and you can find all sorts of trends and curiosities in it. There is even more data available at the website. The possibilities are endless...

### Participation by gender

I decided to look at differences in participation in different sport between men and women in one year (2019). It highlighted the impressive dominance of football (American football) in the sports environment in the USA. The institution with the largest number of football players was ASA College in Brooklyn, NY (331). There are no female football teams or baseball teams, but other sports were exclusively represented by female teams, including synchronized swimming (present at only 4 institutions nationwide), softball, equestrian, field hockey and badminton. 

I was surprised to see rifle be better represented as a sport with women compared to men (only one institution has a male-only rifle team, although this might be a side-effect of not including co-ed teams in my analysis). 

![A lollipop graph, running horizontally. On the Y axis is a list of sports. On the X axis is number of athletes. For each sport there are overlaid lollipop "sticks and dots" - the dots represent the number of athletes participating in that specific sport at a specific school in the USA. There are separate lollipops for men and women, for each sport. Football is a dominant sport in the graph, dwarving all other sports in terms of participation. For more details, read text in README](https://github.com/PlantsGenesBugs/TidyTuesday/blob/main/2022/week13/popularity.png)

### Expense per athlete

I also wanted to look at how much institutions invest per athlete (regardless gender) and managed to create a really nice interactive plot, but alas I haven't as yet been able to figure out how to incorporate it here, so a static image will have to do. I identified the institutions that spent the most per athlete for any given sport and plotted this information based on the home state of that institution. It becomes clear that most states highly fund one sport. However, exceptions to this rule are Florida (home to top spenders in 5 different sports) and Texas (also features top spenders in 5 sports). Sometimes one school will spend a lot on a single sport, but other schools will cover several sports in that state. For example, Texas Christian University is the top spender on baseball, beach volleybal and rifle. Florida State University is the highest spender on football and soccer. Duke University in North Carolina spends an eye-watering amount on basketball.

Other interesting high spenders include:

- Kentucky: Archery
- Ohio: Synchronized swimming
- Pennsylvania: Fencing
- Puerto Rico: Table tennis
           
It would be interesting to see if high spenders also have great success in that specific sport. A very quick Google confirms my suspicions as (e.g.) the Ohio Buckeyes [won the national synchronized swimming championship](https://eu.dispatch.com/story/sports/2022/03/27/synchronized-swimming-ohio-state-wins-33rd-national-championship/7186445001/) for the 33rd time. In addition, Texas Christian University's Beach Volleyball team [remains undefeated this year](https://gofrogs.com/sports/womens-beach-volleyball/schedule/2022).

![A bar graph with state on the X axis and expenditure per athlete in USD on the Y axis. The data represents top spenders for each individual sport, by state. Some states are top spenders in a single sport, while others (like Texas and Florida) are top spenders in several sports. For further explanation, read text in README](https://github.com/PlantsGenesBugs/TidyTuesday/blob/main/2022/week13/expense.png)
