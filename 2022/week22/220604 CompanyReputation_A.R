# TidyTuesday week 22

# load packages and fonts
library(tidyverse)
library(plotly)
#install.packages("packcircles")
library(packcircles)
library(viridis)
#install.packages("gridGraphics")               
library("gridGraphics") 

library(showtext)
font_add_google("Oswald", family = "oswald")
font_add_google("Roboto", family = "roboto")
showtext_auto()

# Get the Data
poll <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-31/poll.csv')
#reputation <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-31/reputation.csv')

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



# Investigation reveals that trends for visibility has remained static over the past 5 years in terms of numbers of companies per industrial sector
# So we can use the frequency of companies in the poll for 2022 as a general indication of visibility across industries
# Illustrate as packed circles

Y2022count <- Y2022 %>%
  count(industry)

# Control size of circles
Y2022count$circsize <- Y2022count$n*3
packing <- circleProgressiveLayout(Y2022count$circsize, sizetype="area")
Y2022count <- cbind(Y2022count, packing)

# Create circle plot. Each polygon is created with 50 lines forming a circle
dat.gg <- circleLayoutVertices(packing, npoints=50)

# Add frequency information to dat.gg so that circle fill will be linked to value
# Repeat each value 51 times because polygon is made with 50 lines
dat.gg$value <- rep(Y2022count$circsize, each=51)

p <- ggplot() +
  geom_polygon(data=dat.gg, aes(x, y, group=id, fill=value), colour="black", alpha=0.6)+
  geom_text(data=Y2022count, aes(x, y, size=n, label=industry), family = "oswald")+
  scale_size_continuous(range=c(1, 7)) +
  scale_fill_distiller(palette = "Set1") +
  labs(
    title = "Which industry is most visible to consumers?",
    subtitle = "Axios Harris Poll 2022") +
  theme_void()+
  theme(text = element_text(family="roboto"),
        title = element_text(family="oswald", size=18),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        legend.position = "none"
        ) +
  expand_limits(x = c(-10,10), y = c(-13, 0)) +
  coord_equal()

# Add description of graph

textCirc <- c("The size of the circle represents the number of companies in that industry that are included in the poll.")
textCirc <- str_wrap(textCirc,30)

p <- p + annotate(geom="text", x=-22, y=12, label=textCirc,
           family="roboto", size=4,
           lineheight=1.1, hjust=0)

# Draw mock graph underneath to layer descriptive text
mock <- data.frame(x=seq(from=0, to=1, length.out=5), y=seq(from=0, to=1, length.out=5))

# Write annotation for graph
text1 <- c("Corporate reputation rankings are determined by the Axios Harris Poll 100. The poll is based on a survey of 33,096 Americans in a nationally representatitve sample. Respondents are asked to nominate companies with, in their opinion, the best and worst reputations. Since 2017, companies in the retail sector have dominated the public conscious whether that be for good or bad reasons.")
text1 <- str_wrap(text1,90)

# Basic setup for background plot
p_background <- ggplot(data=mock, aes(x=x, y=y)) +    
  theme_void() +
  geom_point(colour="black", pch=21, size=4, alpha=0) +
  labs(caption = "Data: Axios Harris Poll 100 | @PlantsGenesBugs | #TidyTuesday") +
  theme(plot.caption = element_text(hjust =1)) +
  ylim(-0.7,5) +
  xlim(0,5)


# Prepare to save plot
png('my_plot4.png', res=300, width=18, height=18, units="cm")

# Add annotation layer
p_background +
  annotate(geom="text", x=0, y=-.4, label=text1,
           family="roboto", size=4,
           lineheight=1.1, hjust=0)

# Add packed circles
print(p,vp = viewport(width = 1.6,
                    height = 1))
dev.off()




# Merge rank data for all years
AllRank <- poll %>%
  select(c(1, 2, 6, 7)) %>%
  rbind(Y2022)


# Investigate rank over time
p2 <- ggplot(AllRank, aes(x=year, y=rank, colour=company)) +
  geom_point()+
  geom_line()+
  scale_y_reverse()+
  facet_wrap(~industry)

# Create an interactive plot to easily identify companies with curious patterns
ggplotly(p2)


# Retail dominates the poll. 

