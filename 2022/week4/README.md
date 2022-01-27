## Week 4

This week the data was provided by [Board Games Geek](https://www.boardgamegeek.com/) - with credit to [Kaggle](https://www.kaggle.com/jvanelteren/boardgamegeek-reviews/version/3?select=2022-01-08.csv) and [David & Georgios](https://github.com/rfordatascience/tidytuesday/issues/382#issuecomment-1020305849).

Board Games Geek (BGG) is an online resource for all things board and card game! The website contains reviews, ratings, images, play-aids, translations and session reports. It's also a hub for game trading. BGG makes its game data available for analysis and provides helpful advice about how to [obtain this](https://boardgamegeek.com/wiki/page/Data_Mining#). Luckily for the TidyTuesday-ers, we have been provided with a pre-made dataset, available, as always, from the [mothership](https://github.com/rfordatascience/tidytuesday/blob/master/data/2022/2022-01-25/readme.md). The data in the database consists of two .CSV files. One contains ratings data, the other contains details of the games.

I am a closet Scrabble fan. I'd probably play it more if I could find someone to play with. The game holds fond memories of games I played with friends in the past, as well as games I played with my dad before he passed away. So I wanted to know if the mighty Scrabble featured in this database which, of course, it did. I then had two follow-up questions: 

1. How many word games are there?
2. How many other games did the creator of Scrabble design?

The answer to question one turns out to be: about 1 word game for every 1000 other types of games. I suppose this isn't surprising seeing as word games provide a fairly limited arena to work in. The answer to question 2 was surprising: Alfred Mosher Butts (an architect by training) designed only 2 games ever, and they were both Word Games. The first was Scrabble (he considered the names "Lexiko", "Criss Cross Words" and "It" before settling on the now-famous title). The other was simply called "Alfreds Other Game". There is a great [photo of Alfred](https://boardgamegeek.com/image/422606/alfreds-other-game) on the cover of his "Other Game" at BGG. 

![A bar graph showing number of games (y axis) from 1900 to 2020 (x axis). The number of word games per year is shown in one colour and the total number of games is in another colour stacked on top of it to form a single bar per year. The number of word games increases from nothing in the early 1900's to roughly 10 per year from around 1980 to 2020. The number of other games increase from around 10 in 1950 to over 1000 in 1980 and currently at 10000.](https://github.com/PlantsGenesBugs/TidyTuesday/blob/main/2022/week4/BoardGames.png)
