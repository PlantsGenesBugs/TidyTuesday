## Week 7

This week we continue the #DuBoisChallenge2022 theme! The challenge rolls out over 10 weeks, with the aim of recreating 10 iconic visualisations created by W.E.B. DuBois for the 1900 Paris Exposition. You can read more about it on the [#TidyTuesday github page](https://github.com/rfordatascience/tidytuesday/blob/master/data/2022/2022-02-15/readme.md).

We were also given the option to BYOD (Bring Your Own Data), so I decided to do just that. I collected data from the Higher Education Statistics Agency (HESA) on the ethnicity of students enrolled at university/other higher ed for the past academic year. The data include students domiciled anywhere, in universities in any part of the UK, and at any level of study (undergrad or postgrad). HESA's own analysis of these numbers can be seen on the [source page](https://www.hesa.ac.uk/news/25-01-2022/sb262-higher-education-student-statistics/numbers).

The relative proportions are sort of reflective of the population make-up of the UK (in 2011, ethnicity in the UK was 87.2% white, 3% black, 4.2% Asian and 2% mixed), but I think there are deeper questions to be asked (are certain universities showing a bias? what about staff representation?)

In terms of preparing this graph, I had to hack it quite a bit. There are 2 graphs plotted over each other. One provides the background and annotations, the other provides the rotated bar. 

Original:

![Original data visualisation by W.E.B. Dubois showing a bar tilted at 40 degrees, separated into 5 sections depicting the types of crimes committed by African American prisoners, as well as the number of crimes as a function of the size of the section. The different sections are Property (approximately 55% of the total size), Persons (approximately 25%), Society(approximately 10%), Miscellaneous (approx. 9%) and Government (approx. 1%). The number of prisoners is 3250 per million of the African American population.](https://github.com/PlantsGenesBugs/TidyTuesday/blob/main/2022/week7/DuBois_original.png)


My effort:

![Graph created on the template of W.E.B. DuBois' graph on "Crime among African Americans". Shows a stacked bar graph with a single bar, tilted at 40 degrees, separated into 5 sections depicting the ethnic makeup of students at higer education institutions in the UK for the academic year 2020/21. The largest section represents "White" (approx 74%), followed by "Asian"(12%), "Black" (8%), "Mixed"(4%) and "Other" (2%). The total number of black students is 166880 out of a total of over 2 million students.](https://github.com/PlantsGenesBugs/TidyTuesday/blob/main/2022/week7/DuBois_student_enrolment.png)
