# Ehrmagerd DERGS!

# Load required packages
library(tidyverse)
library(janitor)
library(ggplot2)
library(gganimate)
library(ggimage)

# Get the data
breed_traits <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-02-01/breed_traits.csv')
breed_rank_all <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-02-01/breed_rank.csv')

# Fix colnames in both DFs
breed_rank_all <- clean_names(breed_rank_all)
breed_traits <- clean_names(breed_traits)

# Find top 5 breeds in 2020
df_top_5<-breed_rank_all %>%
  select(breed:x2020_rank) %>%
  filter(x2020_rank<=5) 

# Add indexing column to use for merging later (the breed column doesn't work)
df_top_5$Y20rank <- 1:5
df_top_5 <- df_top_5 %>%
  relocate(Y20rank, .before=breed)

# Find traits of top 5 breeds in 2020
df_top_traits <- breed_traits %>%
  slice(1:5) #returns only bulldog if filtered any other logical programmatic way so done manually

# Add indexing column to use for merging later (the breed column doesn't work)
df_top_traits$Y20rank <- 1:5
df_top_traits <- df_top_traits %>%
  relocate(Y20rank, .before=breed)

# Remove coat type and length as not important for analysis
# Pivot data for analysis and filter for traits that rate >=4 for each dog
df_top_traits <- df_top_traits %>%
  select(!(coat_type:coat_length)) %>%
  pivot_longer(-c("Y20rank", "breed"),  names_to="trait", values_to="rating") %>%
  filter(rating>=4) 

# Capture the top traits for each breed as a list and store in DF row
trait_list <- df_top_traits %>%
  group_by(Y20rank, breed) %>%
             summarise(traits = list(trait))

# Join the top 5 breeds to their traits
# Pivot data for analysis and graphing; simplify year column to only year number value
rank_and_trait <- left_join(df_top_5, trait_list, by="Y20rank") %>%
  pivot_longer(x2013_rank:x2020_rank,
               names_to = "year",
               values_to = "yearRank") %>%
  mutate(year = parse_number(year),
         image="https://github.com/PlantsGenesBugs/TidyTuesday/blob/main/2022/week5/images/paw.png") 


# Plot
options(ggimage.keytype = "point")
plot <- ggplot(data=rank_and_trait, aes(x=year, y=yearRank, group=breed.x, color=breed.x)) +
  geom_line() +
  geom_point() +
  labs(title = "French Bulldogs are the success story of the past\n9 years but no breed challenges the Labrador\nfor overall popularity!\n",
       caption = "\n\nData: American Kennel Club | Analysis: @PlantsGenesBugs") +
  ylab("Rank") +
  theme_minimal() +
  scale_color_brewer(palette = "Set2") +
  theme(legend.title=element_blank(),
        legend.position=c(0.8,0.2),
        legend.text = element_text(size=12),
        text=element_text(size=16,  family="Arial"),
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size=12),
        axis.text.y = element_text(size=12),
        axis.title.x = element_blank()) +
  scale_fill_discrete(limits=c(
    "Retrievers (Labrador)",
    "German Shepherd Dogs",
    "Retrievers (Golden)",
    "Bulldogs",
    "French Bulldogs")
  ) +
  scale_y_reverse(breaks = seq(from = 1, to = 11)) +
  scale_x_continuous(breaks = seq(from = 2013, to = 2020),
                     limits = c(2012.7, 2021.2))+
  geom_image(aes(image = image), size = 0.06)

plot +
  transition_reveal(year)

# Save as gif:
anim_save("dogs.gif")

# Not done:
# 1. Using top traits in some way - table or boxes of text next to legend
# 2. Using the rank and trait data in a model to see if you can predict popularity
# based on trait rating.
