# load required packages
library(tidyverse)
install.packages("showtext")
library(showtext)
font_add_google("Ubuntu", family = "ubuntu")
showtext_auto()

# get the data
big_tech_stock_prices <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-07/big_tech_stock_prices.csv')
big_tech_companies <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-07/big_tech_companies.csv')

# calculate price change per day; create year var for colour discrimination in graph; add copany name
data <- big_tech_stock_prices %>%
  mutate(price_change = close-open,
         year = format(date, format="%Y"))
  
data <- inner_join(data, big_tech_companies, by="stock_symbol")
data$company <- ifelse(data$company == "International Business Machines Corporation", "IBM Corporation", data$company)


# does price change relate to volume sold? Ho: big changes will relate to large volumes
# split by company and colour by year for pattern detection
# put volume on Y and price change on X for easier comparison between companies
# free scales (while it makes direct comparison harder, allows for seeing other companies besides Apple!)
ggplot(data, aes(x=price_change, y=volume, colour=year)) +
  geom_point(aes(alpha=0.8), size=0.5) +
  guides(alpha="none") +
  facet_wrap(facets = ~reorder(company, -volume), scales="free") +
  theme_light() +
  labs(
    title = "Volume of shares traded compared to the change in price for that day (2010-2023)",
    subtitle = "The smaller the price change, the higher the volume of shares traded on that day. Some stocks have remarkably stable prices (Apple)
while others vary widely (Tesla, NVIDIA, Netflix, Adobe). Much smaller volumes of shares seem to be traded in 2023 compared to
the first entries in 2010.",
    caption = "Data: Yahoo Finance via Kaggle  |  #TidyTuesday  | Graph: @PlantsGenesBugs"
  )  +
  xlab("Change in share price ($)") +
  ylab("Number of shares traded") +
  theme(
    text = element_text(family="ubuntu", size=13, lineheight = 0.5),
    plot.title = element_text(size=16),
    axis.title.x = element_text(margin=margin(t=10, b=10))
  )

ggsave("BigTechStock.png", dpi=200, height=15, width=15, units="cm")



