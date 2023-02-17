# load required packages
library(tidyverse)
library(ggrepel)
library(ggpubr)

# get data
age_gaps <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-14/age_gaps.csv')


# when the older character is a man, what is the trend for the other partner in the couple's age?
older_men <- age_gaps |>
  filter(character_1_gender=="man")

# descriptive stats
older_men |>
  summarise(mean_age_ch1 = mean(actor_1_age),
            age_range_ch1 = range(actor_1_age),
            mean_age_ch2 = mean(actor_2_age),
            age_range_ch2 = range(actor_2_age),
            mean_diff = mean(age_difference))
table(older_men$character_1_gender)
table(older_men$character_2_gender)

# plot features
men <- ggplot(older_men, aes(x=actor_1_age , y=age_difference, colour=character_2_gender)) +
  geom_vline(xintercept = mean(older_men$actor_1_age),
             linetype = "dashed",
             colour="#293352") +
  geom_hline(yintercept = mean(older_men$age_difference),
             linetype = "dashed",
             colour="#D55E00") +
  geom_point() +
  geom_label_repel(data=subset(older_men, actor_1_age>60 & age_difference>30),
            aes(label=movie_name), show.legend=F,
            max.overlaps=Inf, box.padding=1) +
  labs(x = "Older actor's age (character is a man)",
       y = "Age difference between actors",
       colour = "Younger actor's character",
       title = "Romantic couples where the older character is a man") +
  theme_bw() +
  theme(legend.position = c(0.13, 0.9),
        text=element_text(size=13),
        legend.title = element_text(size=11),
        title = element_text(size=12)) +
  annotate("text", x=19, y=14, label="average\ndifference") +
  annotate("text", x=46, y=-1.8, label="average age")
  


# when older char is woman, what is the trend for the other partner in the couple's age?
older_women <- age_gaps |>
  filter(character_1_gender=="woman")

# descriptive stats
older_women |>
  summarise(mean_age_ch1 = mean(actor_1_age),
            age_range_ch1 = range(actor_1_age),
            mean_age_ch2 = mean(actor_2_age),
            age_range_ch2 = range(actor_2_age),
            mean_diff = mean(age_difference))
table(older_women$character_1_gender)
table(older_women$character_2_gender)

women <- ggplot(older_women, aes(x=actor_1_age , y=age_difference, colour=character_2_gender)) +
  geom_vline(xintercept = mean(older_women$actor_1_age),
             linetype = "dashed",
             colour="#293352") +
  geom_hline(yintercept = mean(older_women$age_difference),
             linetype = "dashed",
             colour="#D55E00") +
  geom_point()+
  geom_label_repel(data=subset(older_women, actor_1_age>60 & age_difference>30),
                  aes(label=movie_name), show.legend=F) +
  labs(x = "Older actor's age (character is a woman)",
       y = "Age difference between actors",
       colour = "Younger actor's character",
       title = "Romantic couples where the older character is a woman") +
  theme_bw()+
  theme(legend.position = c(0.13, 0.9),
        text=element_text(size=13),
        legend.title = element_text(size=11),
        title = element_text(size=12)) +
  annotate("text", x=20, y=10, label="average\ndifference") +
  annotate("text", x=41, y=-1.8, label="average age") +
  scale_y_continuous(breaks=c(0, 10, 20, 30, 40, 50))


plot <- ggarrange(men, women,
          ncol = 2, nrow = 1)

annotate_figure(plot,
                top = text_grob("Hollywood Age Gaps: The age gap between movie love interests",
                                color = "black", face="bold", size = 16, hjust=0.5),
                bottom = text_grob("Data: Hollywood Age Gap via Data is Plural | #TidyTuesday | Graph: @PlantsGenesBugs",
                                   color = "black",
                                   hjust = 1, x = 1, size = 12)
)

ggsave("AgeGap.png", width=42, height=16, units="cm", dpi=300)




