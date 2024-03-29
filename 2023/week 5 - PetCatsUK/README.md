## Week 5 - Pet Cats in the UK

This week's data looks at cat movement and ecological impact, particularly in the UK. The database comes from the [Movebank for Animal Tracking Data](https://www.datarepository.movebank.org/handle/10255/move.882) (McDonald and Cole, 2020).

Data was obtained from volunteers who allowed their cats to be tracked using GPS devices between 2013 and 2017, and includes additional data including number of prey caught by the cat per month. A full description can be found on the [Tidy Tuesday Github page](https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-01-31/readme.md). This experiment was run in the USA, UK, Australia and New Zealand, but the data set in usage here is restricted to the UK only. The original paper is unfortunately not open access but the abstract can be seen at [the publisher's website](https://zslpublications.onlinelibrary.wiley.com/doi/10.1111/acv.12563) (Kays et al, 2020). It is a great example of the contribution of citizen science to academic research.

Below is my quick analysis of the data. I wanted to do a bit more data tidying and refresh my memory about plotting using maps. The graph shows the prey per month as captured by every cat in the UK cohort (largely restricted to the county of Cornwall). The numbers seem fairly evenly distributed geographically, with many cats capturing 10-15 prey per month. A [similar study in Australia](https://www.publish.csiro.au/wr/Fulltext/WR19174) (open access) found a severe and significant impact of pet cats on wildlife (moreso than feral cats). The authors also assess the effectiveness and cost of proposed management strategies (keeping cats indoors seem to be the most effective).

![A map of Cornwall showing major roads only and no towns. There are several red dots scattered over the map indicating the position of a cat that took part in the Animal Tracking study. The size of the dot represents the number of prey per month captured by that cat. The dots are quite even in size between them - most are between 10 and 15, although there are also a few that are zero or 5.](https://github.com/PlantsGenesBugs/TidyTuesday/blob/main/2023/week%205%20-%20PetCatsUK/PetCatsUK.png)

### References

- Kays R, Dunn RR, Parsons AW, Mcdonald B, Perkins T, Powers S, Shell L, McDonald JL, Cole H, Kikillus H, Woods L, Tindle H, Roetman P (2020) The small home ranges and large local ecological impacts of pet cats. Animal Conservation. doi:10.1111/acv.12563
- McDonald JL and Cole H (2020) Data from: The small home ranges and large local ecological impacts of pet cats [United Kingdom]. Movebank Data Repository. doi:10.5441/001/1.pf315732

