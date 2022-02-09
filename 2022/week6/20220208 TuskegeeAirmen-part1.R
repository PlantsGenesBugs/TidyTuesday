# Goal is to produce two graphs
# 1) using a DuBois-inspired palette to create a dot plot detailing number of aerial victories grouped by date (month/year)
# 2) reproducing the visually appealing swirl of the furniture data using rank at graduation as number values

# Load required packages
library(ggplot2)
#install.packages("ggthemes")
#library(ggthemes)
library(tidyverse)
library(stringr)

# Get the Data
airmen <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-02-08/airmen.csv')

# I initially tidied the data for objective 2, hence the focus on rank
# Ensure there's no missing values/typos
unique(airmen$rank_at_graduation)

# Remove unknowns and NAs
airmen$rank_at_graduation <- gsub("N/A", NA, airmen$rank_at_graduation)
airmen$rank_at_graduation <- gsub("Unk", NA, airmen$rank_at_graduation)
airmen$rank_at_graduation <- gsub("Captain", "Capt", airmen$rank_at_graduation)

# Number of aerial victories grouped by date (month/year)
vic <- airmen[airmen$number_of_aerial_victory_credits>0,]

vic <- vic %>%
  separate(aerial_victory_credits, into=c("Vic1", "Vic2", "Vic3", "Vic4"), sep=";")

# Clean up aerial victory data
tidyVicData <- vic[,c(2:3, 5, 11:14)]

tidyVicData$Vic1 <- gsub(".*on ","",tidyVicData$Vic1)
tidyVicData$Vic2 <- gsub(".*on ","",tidyVicData$Vic2)
tidyVicData$Vic3 <- gsub(".*on ","",tidyVicData$Vic3)
tidyVicData$Vic4 <- gsub(".*on ","",tidyVicData$Vic4)

tidyVicData <- pivot_longer(tidyVicData, cols=4:7, values_drop_na=TRUE) 
tidyVicData <- tidyVicData %>%
  rename(
    vicID = name,
    date = value
  )

# Change date column to date format
tidyVicData$date <- as.Date(tidyVicData$date, format="%B %d, %Y")

# Add a column for total number of victories by airman
tidyVicData <- tidyVicData %>%
  group_by(first_name) %>%
  mutate(count=n())

# Need summary of date and total number of aerial victories
vicCount <- data.frame(table(tidyVicData$date))
colnames(vicCount) <- c("date", "victories")
summary(vicCount$victories)

# Max number of victories is 12 with the mean at 3.6. To use DuBois palette, divide data into 4 and colour each
# group separately using appropriate colour
vicCount <- vicCount %>%
  mutate(colour =
           case_when(victories <= 3 ~ "red3", 
                     victories <= 6 ~ "gold2",
                     victories <= 9 ~ "forestgreen",
                     victories <= 12 ~ "black")
         )

# Set background colour for plot
bcgrnd <- "#f0e1d3"

# PLOT
plot <- ggplot(vicCount, aes(x=date, y=victories)) +
              geom_point(aes(size=1, color=colour)) +
  scale_color_identity() + 
  labs(
    y="Number of aerial victories",
    colour="Legend",
    title = "Tuskegee Airmen - Aerial Victories (1942-1948)\n",
    caption = "\n\nData: Commemorative Air Force | #TuskegeeAirmenChallenge | Analysis: @PlantsGenesBugs") +
  theme(
    plot.title = element_text(family="Tahoma", face="bold"),
    legend.position = "none", 
    plot.background  = element_rect(fill = bcgrnd, colour = NA), 
    panel.background = element_rect(fill=bcgrnd, colour=bcgrnd),
    plot.margin = unit(c(8, 8, 8, 8),"mm"),
    panel.grid.major = element_line(size = 0.3, linetype = 'solid',
                                    colour = "grey"), 
    panel.grid.minor = element_blank(), 
    axis.text.x = element_text( angle = 90, vjust=0.5, hjust=1),
    axis.title.x = element_blank()) +
  scale_y_continuous(breaks=c(2, 4, 6, 8, 10, 12, 14)
  )

plot

# Find airmen responsible for top two days of aerial victory (10 and 12)
topPilots <- filter(tidyVicData,
                  date=="1944-01-27" | date=="1944-07-18" | date=="1945-03-31")

vicLabel <- topPilots %>%
  group_by(date) %>%
  summarise(names = list(str_c(rank_at_graduation, " ", first_name, " ",last_name)))

# Produce tables with this data
Jan44 <- unlist(vicLabel$names[1])
knitr::kable(Jan44, col.names="Pilots of 27 Jan 1944")

Jul44 <- unlist(vicLabel$names[2])
knitr::kable(Jul44, col.names="Pilots of 18 July 1944")

Mar45 <- unlist(vicLabel$names[3])
knitr::kable(Mar45, col.names="Pilots of 31 March 1945")

# Used these tables in Rmd to produce table which will accompany the graph
