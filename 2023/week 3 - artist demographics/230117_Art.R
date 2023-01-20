# load packages to use
install.packages("ggdark")
library(ggdark)
library(tidyverse)
library(ggpubr)

# Get the data
artists <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-01-17/artists.csv')

# Remove all NA
artists[artists == "N/A"] <- NA
artists <- na.omit(artists)


# Appearance of male and female artists over time
gender_split <- artists %>%
  group_by(year) %>%
  count(artist_gender) 

p1 <- ggplot(gender_split, aes(x=year, y=n, colour=artist_gender))+
  geom_point(size=2) +
  dark_theme_gray() +
  theme(
    legend.position = c(0.1,0.95),
    legend.title = element_blank()
  ) +
  labs(y="Number of artists",
       x="")+
  scale_x_continuous(breaks=seq(1920, 2020, 10)) +
  scale_y_continuous(breaks=seq(0, 350, 50))
 
p1 + labs(
  title="Gender of artists who appear in Janson's History of Art and\nGardner's Art Through the Ages.",
  caption = "#TidyTuesday2023  |  Data: saralemus7.github.io/arthistory/  |  Graph: @PlantsGenesBugs"
)
ggsave("Graphs/genderArt.png", width=16, height = 15, units= "cm", dpi=300)


# Coverage of different races over time
race_split <- artists %>%
  group_by(year) %>%
  count(artist_race)

p2 <- ggplot(race_split, aes(x=year, y=n, colour=artist_race)) +
  geom_point(size=2) +
  dark_theme_gray() +
  theme(
    legend.position = c(0.25,0.87),
    legend.title = element_blank()
  ) +
  labs(y="Number of artists",
       x="")

p2 +
  scale_x_continuous(breaks=seq(1920, 2020, 10)) +
  scale_y_continuous(breaks=seq(0, 350, 50)) +
  labs(
    title="Race of artists who appear in Janson's History of Art and\nGardner's Art Through the Ages.",
    caption = "#TidyTuesday2023  |  Data: saralemus7.github.io/arthistory/  |  Graph: @PlantsGenesBugs"
  )

ggsave("Graphs/raceArt.png", width=16, height = 15, units= "cm", dpi=300)



p3 <- p2 +
  scale_x_reverse(breaks=seq(2020, 1920, -10)) +
  scale_y_continuous(position = "right",
                     breaks=seq(0, 350, 50))+
  theme(
    legend.position = c(0.71,0.9),
    legend.title = element_blank()
  )

# Prepare to merge two graphs in one
title <- paste("The scarab beetle of widely covered artists:",
                "The gender (left horn) and race (right horn) of",
                "artists in Janson's History of Art and Gardner's",
                "Art Through the Ages.", sep="\n")
tgrob <- text_grob(title, size=14, color="white", face="bold", just="left")
empty <- text_grob(".", size=12, color="black")

# Draw the title as a separate plot 
p0 <- as_ggplot(tgrob) +
  dark_theme_gray() +
  theme(
    plot.margin = margin(0, 13, 0, 0, "cm")
  )


p_empty <- as_ggplot(empty) +
  theme(
    panel.background = element_rect(fill="black")
  )

# arrange all plots in final
ggarrange(p0, p_empty, p1, p3,
          ncol=2, nrow=2, heights=c(1,5))

ggsave("Graphs/beetleArt.png", width=28, height = 18, units= "cm", dpi=300)

