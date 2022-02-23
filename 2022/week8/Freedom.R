# Load packages for tidying and drawing arrows
library(tidyverse)
library(grid)

# Get data
freedom <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-02-22/freedom.csv')

# Aggregate CL and PR values to obtain 1 assessment score
data <- freedom %>%
  mutate(aggregate=CL+PR)

# Simplify data by picking data of interest
world <- data %>%
  select(country, year, is_ldc, aggregate) 

# Identify top 3 worlds in both dev=0 and dev=1 for most recent year (2020)
currentTop <- world %>%
  filter(year==2020) %>%
  group_by(is_ldc) %>%
  group_by(aggregate) %>%
  arrange(is_ldc, desc(aggregate))

# Low dev countries (1) with high freedom values (low aggregate score)
currentLowDev <- currentTop %>%
  ungroup() %>%
  filter(is_ldc==1) %>%
  slice_tail(n=3)

# High dev countries (0) with low freedom values (high aggregate score)
currentHighDev <- currentTop %>%
  ungroup()%>%
  filter(is_ldc==0) %>%
  slice_head(n=3) 

# Select countries from original DF
selection <- rbind(currentHighDev, currentLowDev)

graphData <- world %>%
  filter(country %in% selection$country)

# Refactor countries for graphing purposes
graphData$country <- factor(graphData$country, levels = c("Tuvalu", "Kiribati", "Solomon Islands", "Equatorial Guinea", "Saudi Arabia", "Democratic People's Republic of Korea"))

# Annotation for LDC and non-LDC countries
annotateTop <- c("LDC countries")
annotateMiddle <- c("Tuvalu and Kiribati coincide")
annotateBottom <- c("non-LDC countries")

# Draw graph
p <- ggplot(graphData, aes(x=year, y=aggregate, colour=country)) +
  geom_line() +
  theme_void() +
  xlab("Year") +
  ylab("Aggregate score: political rights\n& civil liberties") +
  scale_y_reverse(limits=c(15, 0)) +
  labs(title = "DEVELOPMENT STATUS DOES NOT ALWAYS\nREFLECT RIGHTS AND LIBERTIES",
       subtitle = "\nOn a scale from 14 to 2 (worst to best), some countries that are considered 'least developed'
(LDC) outscore countries that are considered 'developed' for political rights and civil liberties.\n",
       caption = "\nData: FreedomHouse | @PlantsGenesBugs | #TidyTuesday")
  
# Customise graph
p + scale_colour_manual(values=c("#654321","red3", "black", "gold2", "#4682b4", "forestgreen"),
                        labels=c("Tuvalu (LDC)", "Kiribati (LDC)", "Solomon Islands (LDC)", "Equatorial Guinea", "Saudi Arabia", "Democratic People's Republic of Korea")) +
  theme(
    plot.title = element_text(family = "Gill Sans", size = 20, hjust = 0.5),
    plot.subtitle=element_text(family = "Gill Sans", size = 13, hjust = 0),
    plot.caption = element_text(family = "Gill Sans", size = 10, hjust = 0),
    plot.margin = unit(c(5, 5, 5,5), "mm"),
    plot.background  = element_rect(fill="seashell"),
    panel.grid.major  = element_line(size = 0.3, linetype = 'solid',
                                     colour = "grey"),
    panel.grid.minor  = element_line(size=0.2, color = "grey"),
    panel.background = element_rect(fill = "seashell"),
    axis.title = element_text(family = "Gill Sans", size = 12, angle=90, vjust=4),
    axis.text.x = element_text(family = "Gill Sans", size = 10),
    axis.text.y = element_text(family = "Gill Sans", size = 10, hjust=-0.2),
    axis.line.y = element_line(arrow=arrow(length=unit(0.3, "cm"), ends="last", type="closed")),
    legend.title=element_blank(),
    legend.text = element_text(family = "Gill Sans", size = 10),
    legend.position="bottom"
  ) +
  annotate(geom="text", x=2017, y=0, label=annotateTop, family="Gill Sans", size=4) +
  annotate(geom="text", x=2017.75, y=1, label=annotateMiddle, family="Gill Sans", size=3) +
  annotate(geom="text", x=2017, y=13, label=annotateBottom, family="Gill Sans", size=4)


