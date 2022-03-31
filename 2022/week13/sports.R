# Load all required packages
# Note: You will have to change the path to the Candara font on your own device
library(tidyverse)
library(ggdark)
#install.packages("plotly")
library(RColorBrewer)
#install.packages("showtext")
library(showtext)

# Add font 
font_add(family = "Candara", regular = "/Library/Fonts/Microsoft/Candara.ttf")
showtext_auto()

# Get data
sports <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-29/sports.csv')


# Expenditure total by sport, 2019
Y2019 <- sports %>%
  filter(year==2019,
         sports!="Team Handball")


# 1) Participation men & women in 2019
Y2019MF <- Y2019 %>%
  pivot_longer(c(partic_women, partic_men))  %>%
  group_by(sports)

# Draw graph
p2019MFLolli <- ggplot(data=Y2019MF) +
  geom_linerange(aes(x = sports, ymin = 0, ymax = value, colour = name), 
               position = position_dodge(width = 1))+
  geom_point(aes(x = sports, y = value, colour = name),
             position = position_dodge(width = 1)) +
  coord_flip()

# Add colour, annotation etc
p2019MFLolli + dark_theme_grey() +
  scale_colour_discrete(type=c("#e3fa50", "#f74077"),
                        labels= c("Men", "Women")) +
  labs(title="Popularity of sports at schools in the USA, by gender (2019).",
       y="Number of athletes",
       x="",
       caption = "\nData: Equity in Athletics Data Analysis (EADA) | Graph: @PlantsGenesBugs | #TidyTuesday") +
  theme(
    text = element_text(family="Candara"),
    plot.title = element_text(size=20, hjust=0.5, margin=margin(0,0,15,0), face="bold"),
    axis.text = element_text(size=13),
      legend.title = element_blank(),
      legend.position = "right",
      legend.text = element_text(size=12),
      legend.key.size = unit(1,"cm"),
      plot.caption = element_text(hjust=1)) +
  annotate("text", x=33.8, y=128, hjust=0, size=4.5,
           family="Candara",
           label="Each dot represents a school. The position of the dot corresponds to the number
of athletes participating in that sport.
\nThe dominant sport is football, played exclusively by men.
Second most popular is all track disciplines combined, with slightly
more women than men participating. Other sports that are strongly
gendered include wrestling, synchronized swimming, softball, rowing,
equestrian, beach volleyball, baseball and badminton.")

# Save plot
ggsave("popularity.png", width = 36, height = 28, units = "cm")
  


# 2) Biggest "investor" in all sports
top <- Y2019 %>% group_by(sports) %>%
  mutate(totalAthletes = sum_partic_men+sum_partic_women) %>%
  mutate(expAthlete = total_exp_menwomen/totalAthletes)
top <- top %>% group_by(sports) %>% slice_max(n = 1, expAthlete)

# Draw graph
topInv <- ggplot(top, aes(x=state_cd, y=expAthlete, fill=sports))

# Define own colour palette
mycolors <- colorRampPalette(brewer.pal(8, "Accent"))(37)

# Add colour, annotation etc.
topInvInteract <- topInv + geom_bar(stat="identity") +
  dark_theme_grey()+
  scale_fill_manual(values=mycolors) +
  labs(
    title = "States that spent the most on school sports (2019)",
    y = "Expenditure per athlete (USD)",
    x = "State",
    caption = "\nData: Equity in Athletics Data Analysis (EADA) | Graph: @PlantsGenesBugs | #TidyTuesday") +
  theme(
    text = element_text(family="Candara"),
    plot.title = element_text(size=20, hjust=0, margin=margin(0,0,15,0), face="bold"),
    axis.text = element_text(size=13),
    axis.title = element_text(size=14),
    legend.title = element_blank(),
    legend.position = "bottom",
    legend.text = element_text(size=12),
    legend.key.size = unit(1,"cm"),
    plot.caption = element_text(hjust=1)) +
  annotate("text", x=12, y=900000, hjust=0, size=4.5,
           family="Candara",
           label="Each coloured block represents a specific school's expenditure
on that sport per athlete. These represent schools that spent the
most on a sport in the entire USA in 2019.")

# Save plot
ggsave("expense.png", width = 32, height = 21, units = "cm")

  
# Make interactive so hovering over stacked bar reveals sport it represents
#tII <- ggplotly(topInvInteract)
#htmlwidgets::saveWidget(as_widget(tII), "index.html")


