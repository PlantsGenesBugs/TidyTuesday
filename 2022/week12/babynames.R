# Source for princess names: https://en.wikipedia.org/wiki/Disney_Princess 

# Load package for data manipulation
library(tidyverse)

# Get data
babynames <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-22/babynames.csv')

# Filter for girls
girlnames <- babynames %>%
  filter(sex=="F")

# Create list of princess names
disneyPrincess <- c("Snow White", "Cinderella", "Aurora", "Ariel",
                    "Belle", "Jasmine", "Pocahontas", "Mulan", "Tiana", "Rapunzel", "Merida", "Moana")

# Year of movie release
yearPrincess <- c(1937, 1950, 1959, 1989, 1991, 1992, 1995, 1998, 2009, 2010, 2012, 2016)

# Put names and years into data frame
DP <- data.frame(disneyPrincess, yearPrincess)

# Subset girlnames DF for those in the Princess names list
princessData <- girlnames[girlnames$name %in% disneyPrincess,]

# Define a princess pink (and purple, blue and green) palette
palette <- c("#37505C",
             "#9AC2C5",
             "#F06C9B",
             "#F9B9B7",
             "#777DA7",
             "#8A4F7D",
             "#1D70A2",
             "#153243",
             "#68A691",
             "#C36FA7",
             "#E952DE")

# Draw plot
p <- ggplot(princessData, aes(x=year, y=n)) +
  geom_point(aes(colour=name)) +
  facet_wrap(~name, scales="free") +
  labs(
    title="Disney Princesses in the USA",
    subtitle = "Babies are often named after characters in movies. The graphs below show the total number of babies given a
Disney Princess name over the years. Each graph indicates the movie featuring that princess and the year of release.",
    x="",
    y="Number of babies",
    caption = "Data: {babynames} package in R | Analysis: @PlantsGenesBugs | #TidyTuesday"
  )

# Define text to use in graph annotations as well as position (this is adjusted through iteration)
graphText <- data.frame(
  label=c("The Little Mermaid\n(1989)", "Sleeping Beauty (1959)", 
          "Beauty and the Beast\n(1991)", "Cinderella (1950)", "Aladdin (1992)", "Brave (2012)",
          "Moana (2016)", "Mulan (1998)", "Pocahontas (1995)", "Tangled (2010)", "The Princess and\nthe Frog (2009)"),
  name = c("Ariel", "Aurora", "Belle", "Cinderella", "Jasmine", "Merida", "Moana", "Mulan", "Pocahontas", "Rapunzel", "Tiana"),
  x = c(1935, 1938, 1960, 1977, 1935, 1940, 1960, 2003, 1975, 1999, 1970),
  y = c(5150, 43000, 390, 25, 12500, 120, 140, 35, 12, 9, 970)
)

# Customise plot elements and annotate
p + theme(text = element_text(family = "Gabriola"),
          plot.title = element_text(size=20, face="bold"),
          plot.subtitle = element_text(size=16),
          plot.caption = element_text(size=12),
          plot.background  = element_rect(fill = "#FBD9EE"),
          panel.background = element_rect(fill = "#FCF5FA"),
          panel.grid = element_line(linetype="dashed", colour="#FEE8FF"),
          strip.background = element_rect(fill = "#A30481"),
          strip.text = element_text(colour="#FFFFFF", size=16),
          axis.text = element_text(size=18),
          axis.text.x = element_text(angle=45, hjust=1),
          axis.title.y = element_text(size=18),
          legend.position = "none") +
  scale_colour_manual(values=palette) +
  geom_text(
    data=graphText,
    mapping = aes(x=x, y=y, label=label),
    size=3,
    lineheight=0.8
  )
  




