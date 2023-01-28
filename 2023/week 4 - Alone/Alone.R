# get data

survivalists <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-01-24/survivalists.csv')
loadouts <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-01-24/loadouts.csv')
episodes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-01-24/episodes.csv')
seasons <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-01-24/seasons.csv')

# load required packages
library(tidyverse)
library(ggpubr)
library(png)

# read in image for background
img <- readPNG("aloneBG.png")

# plot viewers per season; colour by rating
p <- ggplot(episodes, aes(x=season, y=viewers)) +
  background_image(img) +
  geom_vline(aes(xintercept = season), colour="#CCCCCC", alpha=0.4) +
  geom_hline(yintercept = seq(1, 2.5, 0.25), colour="#CCCCCC", alpha=0.4) +
  geom_point(aes(colour=imdb_rating), size=2, shape=18)

p + scale_color_gradient(low="#3300FF",
                          high="#FFFF00",
                         name = "IMDB rating") +
  labs(x = "Season",
       y = "Number of viewers (millions)") +
  annotate("rect", xmin = 1, xmax = 8.5, ymin = 2.525, ymax = 2.8,
           alpha = .5, col="#CCCCCC") +
  annotate("text", x=4.575, y=2.675, col="white", size=2.5, fontface=2,
           label="Numbers of viewers and viewer ratings of\neach episode of Alone across 8 seasons") +
  annotate("text", x=4, y=2.2,col="white", size=1.8, hjust=0,
           label = "The audience size of Alone has decreased\nover the seasons, but the rating of the show\nhas increased and become more consistent\nover time. Season 7 was particularly good.") +
  scale_x_continuous(breaks=c(seq(1,8,1))) +
  scale_y_continuous(breaks=c(seq(1, 2.5, 0.25))) +
  theme(
    text = element_text(size=6),
    legend.key.size = unit(.4, 'cm')
  ) 

ggsave("Alone.png", height = 7.5, width = 10, units = "cm", dpi=300)

