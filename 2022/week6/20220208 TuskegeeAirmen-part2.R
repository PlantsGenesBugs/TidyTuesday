# Acknowledgement: With gratitude to Ijeamaka Anyene, Charlie Gallagher and Sonja Winter
# for providing their code for reproducing graphs using this design

# Load required packages
library(ggplot2)
library(tidyverse)

# Get the Data
airmen <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-02-08/airmen.csv')

# Goal is to reproduce the visually appealing swirl of the furniture data using rank at graduation as number values
# With gratitude to @CharlieGallaghr (https://github.com/charlie-gallagher/tidy-tuesday/blob/master/dubois/dubois.R)
# whose code allowed me to draw this graph at all!! Take a look at the minimal working example in his Github if you get stuck.

# Focus on rank at graduation
# Ensure there's no missing values/typos
unique(airmen$rank_at_graduation)

# Remove unknowns and NAs
airmen$rank_at_graduation <- gsub("N/A", NA, airmen$rank_at_graduation)
airmen$rank_at_graduation <- gsub("Unk", NA, airmen$rank_at_graduation)
airmen$rank_at_graduation <- gsub("Captain", "Capt", airmen$rank_at_graduation)

# Produce data frame with relevant information
rank <- airmen %>%
  drop_na(rank_at_graduation) %>%
  group_by(rank_at_graduation) %>%
  summarise(number = n()) %>%
  arrange(desc(number))
  
# Colours based on DuBois palette
bcgrnd <- "seashell1"
gold <- "gold2"
red <- "red3"
pink <- "pink"
blue <- "slategray2"


# Range of x-axis or value at which a revolution is completed (more-or-less midway in max(rank$number))
rev_val <- 350

# Create data frame with x and y values to use in spiral graph
rank_spiral <- rank %>% 
  group_by_all() %>% 
  summarize(rev = 1:ceiling(number / rev_val)) %>%   # The revolution number in which the variable's line will end
  group_by_all() %>% 
  summarize(x = c(0, number)) %>%   # Length of line for each variable
  ungroup() %>% 
  mutate(
    x = case_when(    # The length of the line in the final revolution in which the line appears
      x == 0 ~ 0,
      rev == 1 & x < rev_val ~ x,
      rev == 1 & x > rev_val ~ rev_val,
      rev == 2 & x > rev_val ~ x - rev_val
    ),                
    y = case_when(     # Set the default y value to 2 for the start position; the y value drops with 1 for each full revolution
      rev == 1 & x == 0 ~ 2,
      rev == 1 & x != 0 ~ 2 - x / rev_val,
      rev == 2 & x == 0 ~ 1,
      rev == 2 & x != 0 ~ 1 - x / rev_val
    )
  )

# Ensure data is arranged in ascending number value
rank_spiral <- rank_spiral %>% arrange(number)

# Add mock data to adjust y-values, so they lie below each other at x=0
rank_spiral <- rank_spiral %>%
  group_by(rank_at_graduation) %>%
  mutate(mockID = case_when(rank_at_graduation == "Capt" ~ 1,
         rank_at_graduation == "1st Lt" ~ 2,
         rank_at_graduation == "Flight Officer" ~ 3,
         rank_at_graduation == "2nd Lt" ~ 4)
  )

# Adjust Y values as a fixed proportion of whole rev (based on x value/max x)
# I tweaked these values until all the adjusted y values were positive; adjust for class using mockID and divide by n())
rank_spiral <- rank_spiral %>%
  mutate(y = y + (2.5-mockID)/4)


# Labels for graph (Each value appears only once)
ranktext <- arrange(rank_spiral, number) %>% 
  mutate(rank_at_graduation = case_when(rank_at_graduation == "Capt" ~ "CAPTAIN",
            rank_at_graduation == "1st Lt" ~ "1st LIEUTENANT",
            rank_at_graduation == "Flight Officer" ~ "FLIGHT OFFICER",
            rank_at_graduation == "2nd Lt" ~ "2nd LIEUTENANT")) %>%
  filter(x == 0, rev == 1) %>% 
  mutate(text = paste0(rank_at_graduation, " - ", number))

p1 <- ggplot() + 
  geom_line(data = rank_spiral, aes(x = x, y = y, group = interaction(number, rev),
                            color = factor(rank_at_graduation)), size = 4) + 
  geom_text(data = ranktext, aes(x = rev_val - 1, y = y, label = text),
            hjust = 1, size = 3, family = 'Tahoma') + 
  labs(
    title = "TUSKEGEE AIRMEN GRADUATES",
    subtitle = "RANK AT GRADUATION",
    caption = "Data: Commemorative Air Force | #TuskegeeAirmenChallenge | #DuBoisChallenge2022\n
    Analysis: @PlantsGenesBugs | Acknowledgement: @charliegallaghr"
  ) + 
  coord_polar() + 
  scale_y_continuous(expand = c(0,0), limits = c(-3, 2.61)) +
  scale_color_manual(values = c(blue, red, pink, gold)) + 
  guides(color = "none") +
  theme_void() + 
  theme(
    plot.margin = margin(5, 0, 10, 0),
    plot.background = element_rect(color = NA, fill = bcgrnd),
    plot.title = element_text(family = "Tahoma", size = 15, hjust = 0.5),
    plot.subtitle=element_text(family = "Tahoma", size = 12, hjust = 0.5),
    plot.caption = element_text(family = 'Tahoma', size = 8)
  )

