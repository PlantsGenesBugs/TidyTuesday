# Load packages and fonts
library(tidyverse)
library(RColorBrewer)
library(showtext)
font_add_google("Roboto", family = "roboto")
font_add_google("Dosis", family = "dosis")
showtext_auto()


# Get the Data
# Read in the data manually
flights <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-07-12/flights.csv')

# Calculate number of flights per month and create DF for graph
numPerMonth <- flights %>%
  select(YEAR, MONTH_NUM, MONTH_MON, FLT_TOT_1) %>%
  mutate(MONTH_NUM = parse_number(MONTH_NUM)) %>%
  group_by(YEAR, MONTH_MON) %>%
  mutate(FLT_TOT_MONTH = sum(FLT_TOT_1)) %>%
  slice(1) %>%
  select(-FLT_TOT_1)

# Create reference for month labels
monthLabels <- data.frame(MONTH_NUM = c(1:12), MONTH_MON = c("JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEPT", "OCT", "NOV", "DEC"))

# Create subtitle for graph
subTitleA <- c("Flight frequency across the EU has a fixed pattern annually, peaking in the summer months and dropping off over winter. This predictable pattern saw huge disruption during the Covid-19 pandemic (2020-2022). Even though travel restrictions have been widely lifted, flights have not recovered to pre-pandemic levels as of July 2022.\n")
subTitle <- str_wrap(subTitleA, 170)

# Draw graph
numPerMonth %>%
  ggplot(aes(x=MONTH_NUM, y=FLT_TOT_MONTH, colour=as.factor(YEAR))) +
  geom_point() +
  geom_line()+
  scale_x_continuous(breaks=1:12, labels=monthLabels$MONTH_MON)+
  scale_y_continuous(breaks=seq(10000, 3000000, by = 200000), trans='log10')+
  labs(
    title="Commercial flights in the EU (2016-2022)",
      subtitle=subTitle,
      x="",
    y="Total number of flights per month",
    caption = "Data: Eurocontrol  |  #TidyTuesday  |  Visualisation: @PlantsGenesBugs"
    )+
  facet_grid(cols=vars(YEAR))+
  theme(legend.position="none",
        text = element_text(family = "dosis", size=15),
        axis.text = element_text(family = "roboto"),
        axis.text.x = element_text(angle = 90),
        axis.title.y = element_text(vjust = 1, size=15),
        panel.background = element_rect(fill="#F0EEF0"),
        panel.grid.major = element_line(colour="white"),
        panel.grid.minor = element_blank(),
        strip.background=element_rect(fill="white")
  ) +
  scale_colour_brewer(palette="Set2", direction = -1)

# Save graph
ggsave("flights.png", width=45, height = 13, units= "cm", dpi=200)  


