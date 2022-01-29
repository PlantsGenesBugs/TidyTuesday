# Load all the packages required to get and tidy data
install.packages("tidytuesdayR")
library(tidytuesdayR)
library(tidyverse)
library(ggplot2)
library(wesanderson)

# Download data
tuesdata <- tidytuesdayR::tt_load('2022-01-25')

# Separate file of interest out of tuesdata
details <- tuesdata$details

# Look at column names
colnames(details)

# According to the Data Dictionary [here](https://github.com/rfordatascience/tidytuesday/blob/master/data/2022/2022-01-25/readme.md)
# The primary name of the game is in the $primary column. Assuming normal spelling, I want to see if Scrabble is included in this data base (personal interest).
scrabble <- details %>%
  filter(primary=="Scrabble")

# Identify game category and designer
scrabble$boardgamecategory
scrabble$boardgamedesigner

# Scrabble is present and categorised as a ['Word game'] and the designer is
# ['Alfred Mosher Butts']"

# QUESTIONS:
# 1. What are the trends with word games over time? (What proportion of the total?)
# 2. Did Alfred Butts design more games? If so, were they also word games?

# Both the above questions only use the details data set

# 1. What are the trends with word games over time? (What proportion of the total?)
# Choose values of interest (decrease size of df) and add total count for games per year
wordGame <- details %>%
  select(yearpublished, primary, boardgamecategory, boardgamedesigner)

# Boardgamecategory contains several words, sometimes 'Word game' features in that list
# Tidy up category column and identify all with Word Game in it (and mark it as such)
wordGame$boardgamecategory <- gsub("(\\[')|(')|('\\])", "", wordGame$boardgamecategory)
wordGame$boardgamecategory2 <- ifelse(grepl("Word Game", wordGame$boardgamecategory), "Word Game", "Other")

# Summarise data for game category
wordGameDF <- wordGame %>% 
  group_by(yearpublished, boardgamecategory2) %>%
  summarise(n=n())

# Plot data
# Because word games are so scarce, and records start in the year -3500, limit the visualisation to 1900-2022, and to make it easier to see,
# put on log scaled Y axis
ggplot(wordGameDF, aes(fill=boardgamecategory2, y=n, x=yearpublished)) + 
  geom_bar(position="stack", stat="identity") +
  xlim(1900, 2022) +
  scale_y_continuous(trans="log10")  +
  ggtitle("Word games over the years") +
  xlab("Year of publication") +
  ylab("Number of board games recorded") +
  labs(fill = "Board game category") +
  scale_fill_manual(values=wes_palette(name="Royal2", type="discrete")) +
  theme(plot.title = element_text(size=15),
        panel.border = element_blank(),
        plot.background = element_rect(fill = "#5e6472"),
        panel.background = element_rect(fill = "#5e6472"),
        legend.background = element_rect(fill = "#5e6472"),
        legend.text = element_text(color = "white"),
        axis.text = element_text(color = "white"),
        text= element_text(color = "white", family="American Typewriter Bold")
  )
 

# There really isn't a lot of different word games - approximately 1000x more other games than word games!
# But that can be expected as word games provide a fairly limited arena for play

# 2. Did Alfred Butts design more games? If so, were they also word games?
# Tidy up designer column and identify all with Alfred Mosher Butts in it (and mark it as such)
wordGame$boardgamedesigner <- gsub("(\\[')|(')|('\\])", "", wordGame$boardgamedesigner)
wordGame$boardgamedesigner2 <- ifelse(grepl("Alfred Mosher Butts", wordGame$boardgamedesigner), "AM Butts", "Other")

# Summarise data for game designer
designGameDF <- wordGame %>% 
  group_by(boardgamedesigner2) %>%
  summarise(n=n())

# AM Butts designed 2 board games. Both were Word Games.



