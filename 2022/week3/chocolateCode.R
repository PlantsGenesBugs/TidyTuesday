# Get the data from the repository
chocolate <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-01-18/chocolate.csv')

# Load standard required pacakges and libraries
library(dplyr)
library(ggplot2)
library(forcats)
library(tidyverse)

# Install package 'rworldmap' for mapping
install.packages("rworldmap")
library(rworldmap)

# Install package 'countrycode' to convert country names to ISO code
install.packages("countrycode")
library(countrycode)

# I have two questions:
# 1. Where do most of the cocoa beans used in chocolate, come from?
# 2. Does a high % cocoa always reflect a high rating?

# Subset data pertaining to origin of beans to simplify answering Q1
origin <- as.data.frame(table(chocolate$country_of_bean_origin))

# Change factor to character for analysis
origin$Var1 <- as.character(origin$Var1)

# Draw a simple bar plot for fine visualisation
origin %>%
  mutate(country = fct_reorder(Var1, Freq)) %>%
  ggplot(aes(x=country, y=Freq)) +
  geom_bar(stat="identity", colour="white", fill="#00AFBB", alpha=0.5) +
  coord_flip() +
  xlab("") +
  ylab("Number of times country is source of cocoa beans")

# There are 5 countries that dominate in the supply of cocoa beans, namely Venezuela, Peru, Dom Rep, Ecuador and Madagascar

# Where are these countries geographically located?
# Get map
worldmap <- getMap(resolution="coarse")

# Include country code column to prevent data loss when using rworldmap
origin$iso3c <- countrycode(origin$Var1, origin="country.name", destination="iso3c")

# Add missing country values
origin$iso3c[origin$Var1 == "Principe"] <- "STP" #part of Sao Tome and Principe
origin$iso3c[origin$Var1 == "Sulawesi"] <- "IDN" #Indonesian island
origin$iso3c[origin$Var1 == "Sumatra"] <- "IDN" #Indonesian island


# Join data to map
dataMap <- joinCountryData2Map(origin,
                             joinCode = "ISO3",
                             nameJoinColumn = "iso3c",
                             verbose=TRUE)

# Blend and Martinique not included

# Plot map showing number of times beans are obtained from a country
par(mai=c(0,0,0.2,0),xaxs="i",yaxs="i")

mapParams <- mapCountryData(dataMap,
                            nameColumnToPlot="Freq",
                            numCats=100,
                            catMethod="fixedWidth",
                            mapTitle="Where do the cocoa beans come from?",
                            oceanCol="lightblue",
                            missingCountryCol="white",
                            addLegend=FALSE)

#shrink legend a bit for clearer visualisation
do.call(addMapLegend, c(mapParams, legendWidth=0.7, legendMar=2))


#To answer Q2, a simple plot will suffice
#tidy data by removing % sign from column and turning into numeric value
chocolate$cocoa_percent <- gsub(pattern="%",replacement="",chocolate$cocoa_percent)
chocolate$cocoa_percent <- as.numeric(chocolate$cocoa_percent)

#plot rating vs cocoa %
ggplot(chocolate, aes(x=cocoa_percent, y=rating)) +
  geom_point() +
  theme_bw() +
  labs(title="Cocoa content vs rating of chocolate",
       x="Cocoa (%)",
       y="Rating (1-5)")

#And it appears there's no link between % cocoa and rating of chocolate!



