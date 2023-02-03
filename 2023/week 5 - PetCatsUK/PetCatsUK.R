# get data
cats_uk <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-01-31/cats_uk.csv')
cats_uk_reference <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-01-31/cats_uk_reference.csv')

# load required packages (tidy data, draw map)
library(tidyverse)
library(dplyr)
#install.packages("ggmap")
library(ggmap)
#install.packages('osmdata')
library(osmdata)


# remove outliers (as per data field description at Tidy Tuesday github)
data <- cats_uk %>%
  filter(visible == TRUE)

# get mean geographical long/lat for each cat; long/lat isn't unique for each cat, but an arithmetic
# mean should be accurate enough over a short distance (see https://bit.ly/3wSoy3I )
loc <- data %>%
  group_by(tag_id) %>%
  summarise(long = mean(location_long),
            lat = mean(location_lat))


dataLocPrey <- left_join(loc, cats_uk_reference, by="tag_id")

# get map from stamen; usage of getbb sidesteps requirement for Google API
myMap <-get_map(getbb("cornwall"),
                 maptype="watercolor",
                source="stamen")

# create map
ggmap(myMap) +
  geom_point(data = dataLocPrey, aes(x = long, y = lat, size = prey_p_month),
             alpha = 0.5,
             colour="red") +
  scale_size_continuous(name='Number',
                        range=c(1,12)) +
  annotate("text", x = -5.7, y=50.845, label = "Number of prey caught by cats\nin Cornwall (2013-2017).", size=7, hjust=0) +
  annotate("text", x = -5.7, y=50.68, label = "Each dot is a cat. The size of the dot\nrepresents the number of prey\nper month.", size=5, hjust=0) +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    legend.position = c(0.9, 0.175),
    legend.background = element_rect(fill = "#faf1d7", color = "white", size=1),
    legend.key = element_rect(fill = "#faf1d7", color = NA),
    legend.key.size = unit(0.1, "cm"), 
    legend.key.height = unit(0., "cm"), 
    legend.key.width = unit(0.1, 'cm'), 
    legend.title = element_text(size=10), 
    legend.text = element_text(size=8),
    plot.caption = element_text(size=8)
  ) +
  labs(
    caption = "Data: Movebank Data Repository doi:10.5441/001/1.pf315732  |  #TidyTuesday  | Analysis: @PlantsGenesBugs"
  )

ggsave("PetCatsUK.png", height = 15, width = 15, units = "cm", dpi=300)





