
# TidyTuesday week 22B

# load packages and fonts
library(tidyverse)
library(plotly)
library(viridis)
library(ggdark)
library(ggthemes)
library(ggrepel)

library(showtext)
font_add_google("Oswald", family = "oswald")
font_add_google("Roboto", family = "roboto")
showtext_auto()

# Get the Data
poll <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-31/poll.csv')

# The original data underwent some substantial cleaning and the code for it is actually a 
# good exercise in studying R (see github: https://github.com/rfordatascience/tidytuesday/tree/master/data/2022/2022-05-31)
# The cleaning script has some impressive regex patterns used in gsub() and also gives
# examples of using json files as sources; it also features the somewhat new base R pipe |>

# Extract 2022 rank data and reorganise to match original data frame format
Y2022 <- poll %>%
  select(1:3) %>%
  pivot_longer(3, names_to = "year", values_to = "rank")
  
Y2022$year <- 2022
Y2022 <- unique(Y2022)


# Part B - More granular analysis
# Merge rank data for all years
AllRank <- poll %>%
  select(c(1, 2, 6, 7)) %>%
  rbind(Y2022)

# Set levels to arrange facetted graphs from most to least represented industry
levels <- data.frame(table(Y2022$industry))
levels <- levels %>%
  rename(industry = Var1,
         count = Freq) %>%
  arrange(-count)

# Investigate rank over time
p2 <- ggplot(AllRank, aes(x=year, y=rank, colour=company)) +
  geom_point()+
  geom_line()+
  scale_y_reverse()+
  facet_wrap(~factor(industry, levels=levels$industry))

# Change theme for easier visualisation 
p2 + dark_mode(theme_fivethirtyeight()) +
  theme(legend.position="none",
        axis.title.y = element_text(size=12)) +
  labs(title = "Ranking of all companies in the Axios Harris 100 poll - split by industry",
       subtitle = "100 companies ranked from best (1) to worst (100) in the past 5 years",
       y = "Ranking")

# Save plot
ggsave("repTimeNoLegend.png", width=40, height = 30, units= "cm", dpi=200)

# Create an interactive plot to easily identify companies with curious patterns
ggplotly(p2)

# Select: ecommerce, media, telecom, logistics, pharma and other as being of interest

# Ecommerce
ecomm <- AllRank %>%
  filter(industry == "Ecommerce")

ggplot(ecomm, aes(x=year, y=rank, colour=company)) +
  geom_point()+
  geom_line()+
  scale_y_reverse() +
  dark_mode(theme_fivethirtyeight()) +
  theme(legend.position="none",
       axis.text = element_text(face="bold"),
        axis.title.y = element_text(size=13, face="bold")) +
  labs(title = str_wrap("Ranking of E-commerce companies in the Axios Harris 100 poll", 40),
       y = "Ranking") +
  geom_label_repel(aes(label=ifelse(year == 2022,as.character(company),'')),
                   nudge_x       = 3,
                   box.padding   = 0.35, 
                   point.padding = 0.5,
                   segment.color = 'black') +
  scale_x_continuous(expand = expand_scale(mult = c(0.1, 0.2))) 

ggsave("ecomm.png", width=20, height = 15, units= "cm", dpi=200)

# Media
media <- AllRank %>%
  filter(industry == "Media")

ggplot(media, aes(x=year, y=rank, colour=company)) +
  geom_point()+
  geom_line()+
  ylim(100,0) +
  dark_mode(theme_fivethirtyeight()) +
  theme(legend.position="none",
        axis.text = element_text(face="bold"),
        axis.title.y = element_text(size=13, face="bold")) +
  labs(title = str_wrap("Ranking of media companies in the Axios Harris 100 poll", 40),
       y = "Ranking") +
  geom_label_repel(aes(label=ifelse(year == 2022,as.character(company),'')),
                   nudge_x       = 3,
                   box.padding   = 0.35, 
                   point.padding = 0.5,
                   segment.color = 'black') +
  scale_x_continuous(expand = expand_scale(mult = c(0.1, 0.2))) 

ggsave("media.png", width=20, height = 15, units= "cm", dpi=200)

# Telecom
telecom <- AllRank %>%
  filter(industry == "Telecom")

ggplot(telecom, aes(x=year, y=rank, colour=company)) +
  geom_point()+
  geom_line()+
  ylim(100,0) +
  dark_mode(theme_fivethirtyeight()) +
  theme(legend.position="none",
        axis.text = element_text(face="bold"),
        axis.title.y = element_text(size=13, face="bold")) +
  labs(title = str_wrap("Ranking of telecommunications companies in the Axios Harris 100 poll", 40),
       y = "Ranking") +
  geom_label_repel(aes(label=ifelse(year == 2022,as.character(company),'')),
                   nudge_x       = 3,
                   box.padding   = 0.35, 
                   point.padding = 0.5,
                   segment.color = 'black') +
  scale_x_continuous(expand = expand_scale(mult = c(0.1, 0.2))) 

ggsave("telecom.png", width=20, height = 15, units= "cm", dpi=200)


# Logistics
logist <- AllRank %>%
  filter(industry == "Logistics")

ggplot(logist, aes(x=year, y=rank, colour=company)) +
  geom_point()+
  geom_line()+
  ylim(100,0) +
  dark_mode(theme_fivethirtyeight()) +
  theme(legend.position="none",
        axis.text = element_text(face="bold"),
        axis.title.y = element_text(size=13, face="bold")) +
  labs(title = str_wrap("Ranking of logistics companies in the Axios Harris 100 poll", 40),
       y = "Ranking") +
  geom_label_repel(aes(label=ifelse(year == 2022,as.character(company),'')),
                   nudge_x       = 0.1,
                   nudge_y       = 8,
                   box.padding   = 0.35, 
                   point.padding = 0.5,
                   segment.color = 'black') +
  scale_x_continuous(expand = expand_scale(mult = c(0.1, 0.2))) 

ggsave("logist.png", width=20, height = 15, units= "cm", dpi=200)

# Pharma
pharma <- AllRank %>%
  filter(industry == "Pharma")

ggplot(pharma, aes(x=year, y=rank, colour=company)) +
  geom_point()+
  geom_line()+
  ylim(100,0) +
  dark_mode(theme_fivethirtyeight()) +
  theme(legend.position="none",
        axis.text = element_text(face="bold"),
        axis.title.y = element_text(size=13, face="bold")) +
  labs(title = str_wrap("Ranking of pharmaceutical companies in the Axios Harris 100 poll", 40),
       y = "Ranking") +
  geom_label_repel(aes(label=ifelse(year == 2022,as.character(company),'')),
                   nudge_x       = 0.2,
                   nudge_y       = 8,
                   box.padding   = 0.35, 
                   point.padding = 0.5,
                   segment.color = 'black') +
  scale_x_continuous(expand = expand_scale(mult = c(0.1, 0.2))) 

ggsave("pharma.png", width=20, height = 15, units= "cm", dpi=200)

# Other
other <- AllRank %>%
  filter(industry == "Other")

ggplot(other, aes(x=year, y=rank, colour=company)) +
  geom_point()+
  geom_line()+
  ylim(100,0) +
  dark_mode(theme_fivethirtyeight()) +
  theme(legend.position="none",
        axis.text = element_text(face="bold"),
        axis.title.y = element_text(size=13, face="bold")) +
  labs(title = str_wrap("Ranking of other companies in the Axios Harris 100 poll", 40),
       y = "Ranking") +
  geom_label_repel(aes(label=ifelse(year == 2022,as.character(company),'')),
                   nudge_x       = 0.2,
                   nudge_y       = 8,
                   box.padding   = 0.35, 
                   point.padding = 0.5,
                   segment.color = 'black') +
  scale_x_continuous(expand = expand_scale(mult = c(0.1, 0.2))) 

ggsave("other.png", width=20, height = 15, units= "cm", dpi=200)
