# Use TidyTuesday package this week (inspired by @mitsuoxv).
# Explore features of {tidytuesdayR}

library(tidyverse)
library(readxl)
library(geofacet)
library(tidytuesdayR)

# tt_load allows download of several dataframes in a single object (a list in this case)
pollutionMain <- tt_load("2022-04-12")

# the object/list, when viewed, gives details about the available datasets and supporting information
pollutionMain

# Look at data (glimpse)
pollutionMain %>%
  map(glimpse)

# Split into individual data sets that will be used here

fuel_gdp <- pollutionMain$fuel_gdp
indoor_pollution <- pollutionMain$indoor_pollution

# AIM: Compare access to fuels (fuel_gdp) vs deaths from air poll (indoor_pollution) by country
# Map with geofacet

# Remove extraneous years
fuel_gdp_years <- fuel_gdp %>%
  filter(between(Year, 2000,2019))

indoor_pollution_years <- indoor_pollution %>%
  filter(between(Year, 2000,2019))

# Filter data so that they can be merged by country (they have the same number of obs)
filter1 <- fuel_gdp_years %>%
  filter(Entity %in% indoor_pollution_years$Entity)
filter2 <- indoor_pollution_years %>%
  filter(Entity %in% filter1$Entity)

# Join above two data frames to prepare for graphing
df <- left_join(filter1, filter2, by=c("Entity", "Year"))

# Select relevant variables
df <- df %>%
  select(Entity, Code.x, Year, starts_with("Access to clean fuels"), starts_with("Deaths"))

# Rename columns that have long names
df <- df %>%
  rename(Code = 2) %>%
  rename(Access = 4) %>%
  rename(Deaths = 5) 

df <- df %>%
  pivot_longer(cols=Access:Deaths, names_to="Variable", values_to = "Value")

# Focus on countries in Africa and the Indian Ocean
# AFRINIC country codes from here: https://www.nro.net/list-of-country-codes-in-the-afrinic-region/
# Import csv sheet with country codes to use as filter from main DB

Africa <- read_excel("country_code_web.xls", sheet="Africa",
                     col_names=c("Country", "Two_code", "Three_code", "Region"),skip=1)

# Filter data frame for countries in Africa
AfricaPollution <- df %>%
  filter(Code %in% Africa$Three_code)

# Countries showing errors in code (after experimental plotting):
# Cape Verde, Congo, Cote d'Ivoire, Democratic Republic of Congo, Sao Tome and Principe
# Cape Verde - should be Cabo Verde
# Congo - should be Republic of the Congo
# Cote d'Ivoire - should be Côte d'Ivoire
# Democratic Republic of Congo - should be Democratic Republic of the Congo
# Sao Tome and Principe - should be São Tomé and Principe 

AfricaPollution$Entity <- AfricaPollution$Entity %>%
  str_replace_all(c("Cape Verde" = "Cabo Verde",
                    "Cote d'Ivoire" = "Côte d'Ivoire",
                    "Democratic Republic of Congo" = "Democratic Republic of the Congo",
                    "Sao Tome and Principe" = "São Tomé and Principe"))

# Change Congo's name separately to avoid errors occurring with other similarly named country (no tidyverse functions seemed to work here! Back to base R)
AfricaPollution["Entity"][AfricaPollution["Entity"] == "Congo"] <- "Republic of the Congo"

# Draw graph (using favourite palette)
library(viridis)
ggplot(AfricaPollution, aes(x=Year, y=Value, fill=Variable)) +
  geom_area(size=0.5, colour="white") +
  scale_fill_viridis(discrete=TRUE, direction=-1) +
  labs(
    title = "Africa: Acess to clean indoor fuels vs deaths from indoor air pollution (2000 - 2019)",
    subtitle = "Each graph shows the percentage of the population that has access to clean fuels for cooking and the percentage of deaths caused by household air pollution from solid fuels.\n",
    caption = "\nData: Our World in Data | Graph: @PlantsGenesBugs | #TidyTuesday",
    fill = "Percentage") +
  theme(
    plot.title = element_text(size = 15, face="bold"),
    plot.subtitle = element_text(size=12),
    axis.text.x = element_text(angle=90),
    axis.title.y = element_blank(),
    axis.title.x = element_blank(),
    panel.background = element_rect(fill="#89bebd"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    legend.title = element_text(size=13),
    legend.text = element_text(size=12)
    ) +
  facet_geo(~ Entity, grid = "africa_countries_grid1", scales="free_y")

# Save plot
ggsave("indoorPollution.png", width = 40, height = 40, units = "cm")


