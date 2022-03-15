library(tidyverse)
install.packages("gghighlight")
library(gghighlight)
install.packages("ggdark")
library(ggdark)

# Get data 
bioc <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-15/bioc.csv')

# Group by package and find max number of vignettes (regardless of creation method)
data <- bioc %>%
  group_by(package) %>%
  summarise(maxrnw = max(rnw),
            maxrmd = max(rmd),
            days = as.numeric(difftime(max(date), min(date), units="days"))) %>%
  mutate(total=maxrnw+maxrmd,
         years = days/365)

# Plot data
plot <- ggplot(data, aes(x=years, y=total))
plot + dark_theme_gray() +
  geom_point(size=3, stroke=1, colour="yellow", shape=1) +
  gghighlight(total>15, label_key=package) +
  labs(title="Which package in Bioconductor has/had the most vignettes?",
       subtitle="The microbiome package had the most vignettes at ~37 in the 10 years since its first commit.\n ELMER, pRoloc and biodb all have/had more than 15 vignettes since their first commit/update",
       caption="The packages 'flowDensity' and STATegRa' are reported to have been submitted >50 years ago, which seems curious\nData: https://github.com/rmflight/vignette_analysis | Graph: @PlantsGenesBugs | #TidyTuesday\n",
       x="Years from first to most recent package upload/update",
       y="Maximum number of vignettes\n(sweave and markdown)") +
  theme(
    text = element_text(family = "American Typewriter"),
    plot.title = element_text(size=15, face="bold"),
    plot.caption = element_text(hjust=0),
    axis.title.y = element_text(margin=margin(r=10)),
    axis.title.x = element_text(margin=margin(t=10))
  ) +
  ylim(0,40)
