# Repeated Measures ANOVA
# simple

library('rcompanion')
library('fastR2')
library('car')
library('ggplot2')
library('dplyr')

#Load dataset:
df <- read.csv("~/GitRepository/final_project_women_in_eng/geo_quad_df_ALL.csv")

#Question:
#Regardless of Quadrent, does the Ratio of Women to Men change over time?

#DV - Ratio W/M - continuous
#IV - YEAR (categorical, 11 levels)

#Data Wrangling:

#No reshaping needed, data is in the required format

#Remove schools with no men and/or no women
new_df1 <- df[df$MEN != 0, ]
new_df2 <- new_df1[new_df1$WOMEN != 0, ]

#view how each variable is being read
str(new_df2)

#set UNITID as factor
new_df2$UNITID <- as.factor(new_df2$UNITID)
#set Year as factor
new_df2$YEAR <- as.factor(new_df2$YEAR)

#Lets also remove unneeded columns
new_df3 <- select(new_df2, UNITID, MEN, WOMEN, W.M_Ratio, YEAR, Quadrant)

#Assumptions

#Test for Normality of the DV at each timepoint

ggplot(new_df3, aes(x = YEAR, y = W.M_Ratio))+
  geom_boxplot(aes(group=YEAR))

#subset data based on year

year2000 <- subset(new_df3, subset = YEAR == '2000')
year2002 <- subset(new_df3, subset = YEAR == '2002')
year2004 <- subset(new_df3, subset = YEAR == '2004')
year2006 <- subset(new_df3, subset = YEAR == '2006')
year2008 <- subset(new_df3, subset = YEAR == '2008')
year2010 <- subset(new_df3, subset = YEAR == '2010')
year2012 <- subset(new_df3, subset = YEAR == '2012')
year2014 <- subset(new_df3, subset = YEAR == '2014')
year2016 <- subset(new_df3, subset = YEAR == '2016')
year2018 <- subset(new_df3, subset = YEAR == '2018')
year2020 <- subset(new_df3, subset = YEAR == '2020')

join1 <- left_join(year2000, year2002, by='UNITID')
join2 <- left_join(join1, year2004, by='UNITID')
join3 <- left_join(join2, year2006, by='UNITID')
join4 <- left_join(join3, year2008, by='UNITID')
join5 <- left_join(join4, year2010, by='UNITID')
join6 <- left_join(join5, year2012, by='UNITID')
join7 <- left_join(join6, year2014, by='UNITID')
join8 <- left_join(join7, year2016, by='UNITID')
join9 <- left_join(join8, year2018, by='UNITID')
join10 <- left_join(join9, year2020, by='UNITID')

uniq_df <- na.omit(join10)

useable_df <- new_df3[! new_df3$UNITID %in% c(uniq_df$UNITID), ]


ggplot(useable_df, aes(x = YEAR, y = W.M_Ratio))+
  geom_boxplot(aes(group=YEAR))

#Use the Shapiro Wilk test for each timepoint
#if normally distributed, the test should not be significant

as



