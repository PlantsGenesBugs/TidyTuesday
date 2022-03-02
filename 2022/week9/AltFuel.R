# Load all required packacges (tidying, mapping data to a geomap of the USA, drawing treemaps for each state and an accessible colour palette)

library(tidyverse)
install.packages("geofacet")
library(geofacet)
library(viridis)
library(treemapify)

# Get the data
stations <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-01/stations.csv')

# Subset the data to just state and fuel type for analysis
data <- stations %>%
  group_by(STATE, FUEL_TYPE_CODE) %>%
  summarise(count = n())

# Draw basic geo-facetted plot
p <- ggplot(data, aes(area = count, fill = FUEL_TYPE_CODE)) +
  geom_treemap() +
 facet_geo(~STATE)

# Format plot and add title, description etc
p + scale_fill_viridis(discrete=TRUE,
                       labels=c("Biodiesel", "Compressed natural gas", "Ethanol", "Electric", "Hydrogen", "Liquefied natural gas", "Propane")) +
  labs(title = "Alternative Fuels by State (USA)",
       subtitle = "Electricity is the dominant alternative fuel in the USA, with ethanol and propane second\n",
       caption = "\nData: US Dept of Transportation | Analysis: @PlantsGenesBugs | #TidyTuesday") +
  theme(legend.title = element_blank(),
        legend.position = "right",
        legend.text = element_text(size=12, family="Bell MT"),
        legend.key.size = unit(1,"cm"),
        legend.background = element_rect(fill="#F5F5F5"), 
        plot.background = element_rect(fill = "#F5F5F5"),
        plot.title = element_text(family="Bell MT", size=20, hjust=0.5),
        plot.subtitle = element_text(family="Bell MT", size=14, hjust=0.5),
        plot.caption = element_text(family="Bell MT", size="10", hjust=0)) 

# Save plot
ggsave("altfuels.png", width = 30, height = 20, units = "cm")

