# Set up packages required for tidying and graphing
library(tidyverse)
library(ggplot2)
install.packages("janitor")
library(janitor)
install.packages("naniar")
library(naniar)
install.packages("gridGraphics")               
library("gridGraphics") 

# Source file is available from https://www.hesa.ac.uk/news/25-01-2022/sb262-higher-education-student-statistics/numbers
# Data relates to figure 5 on the above web page and is accessible through this link: https://www.hesa.ac.uk/data-and-analysis/sb262/figure-5.csv

# Source file includes header information and lots of details
# Import only relevant cells (starting in row 19 with col headers)
data <- read_csv("Figure-5.csv", skip=18, col_names=TRUE)

# Isolate Ethnicity variable after cleaning colnames
data <- data %>%
  clean_names()

ethnicity <- data %>%
  filter(category_marker == "Ethnicity")

# Filter for ALL in all relevant variables except 'category' and 'academic_year'
ethnicityAll <- ethnicity %>%
  filter(academic_year=="2020/21") %>%
  filter(first_year_marker=="All") %>%
  filter(level_of_study=="All") %>%
  filter(mode_of_study=="All") %>%
  filter(country_of_he_provider=="All") %>%
  filter(domicile=="All")

# Only need data on 'category', 'academic_year', 'number' and 'percentage'
# Remove NA values (first have to convert N/A to 'NA')
ethnicityAll <- ethnicityAll %>%
  select('category', 'academic_year', 'number', 'percentage') %>%
  replace_with_na(replace=list(percentage="N/A")) %>%
  drop_na()

# Describe the current status of HE students in a rotated bar chart as per
# WEB DuBois' graph about crime

# DuBois Palette:
# green = "forestgreen"
# black = "black"
# brown = #654321
# gold = gold2
# red = red3
#background = "seashell1"

# Basic bar graph
p <- ethnicityAll %>%
  mutate(category = fct_reorder(category, number)) %>%
  ggplot(aes(fill=category, x=academic_year, y=number))+
  geom_bar(position="stack",
           colour="black",
           size=0.3,
           stat="identity",
           width=0.35,
           show.legend=FALSE) +
  theme_void()

# Add colours and adjust for overplotting
p <- p + 
  scale_fill_manual(values=c("red3", "gold2", "#654321", "black", "forestgreen")) +
  theme(plot.background = element_blank(),
        panel.border=element_blank())
  

# Background graph
# Mock data for background graph
mock <- data.frame(x=seq(from=-1, to=1, length.out=5), y=seq(from=-1, to=1, length.out=5), colour=c("A", "B", "C", "D", "E"))

# Write annotation for graph
text_top <- c("166880")
text_bottom <- c("STUDENTS OUT OF >2MILLION\nENROLLED IN HE IN THE UK\n ARE ETHNICALLY BLACK:    ")

# Basic setup for background plot
p_background <- ggplot(data=mock, aes(x=x, y=y, fill=colour)) +    
  theme_void() +
  geom_point(colour="black", pch=21, size=4) +
  labs(title = "HE student enrolment in the UK",
       subtitle = "Done by @PlantsGenesBugs",
       caption = "Data: Higher Education Statistics Agency | #DuBoisChallenge2022 | #TidyTuesday")+
  ylim(-10,10) +
  xlim(-10, 10)

# Add colours and adjust fonts
p_background +
  scale_fill_manual(values=c("red3", "gold2", "#654321", "black", "forestgreen"),
                    labels=c("OTHER", "MIXED", "BLACK", "ASIAN", "WHITE"),
                    name="") +
  theme(legend.position = c(0.85,0.2),
        legend.text = element_text(size=12, family="Lucida Sans Typewriter"),
        legend.key.size = unit(1,"cm"),
        plot.background = element_rect(fill = "seashell1"),
        plot.title = element_text(family="Baskerville", size=20, hjust=0.4),
        plot.subtitle = element_text(family="Baskerville", size=10, hjust=0.4),
        plot.caption = element_text(hjust = 0)) +
  annotate(geom="text", x=-5, y=9, label=text_top,
           fontface="bold", family="Lucida Sans Typewriter", size=5) +
  annotate(geom="text", x=-5, y=7.5, label=text_bottom,
           family="Lucida Sans Typewriter", size=4,
           lineheight=0.9)
  
 
#grid.newpage()                                 
print(p,                                     # Draw rotated plot
      vp = viewport(width = 0.6,
                    height = 0.8,
                    angle = -40))

