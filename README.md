---
title: "ReadMe"
author: "Vitaly Briker"
date: "June 12, 2018"
output: Codebook
---

## MSDS 6306 Doing Data Science HomeWork Unit5

R-filename : HomeWork-5.R

## Purpose : 

The program analyzes most popular girl names in 2015 and 2016 years.

## Code explanation 

```Setup worikng directory
```
setwd("F:\\My_Docs\\univer\\DataScience\\git\\Home_Work5\\HW5")

-- Read the raw 2016 file into csv format --
df = read.delim("yob2016.txt",header = FALSE,sep = ";",col.names=c("Name","Gender","Amount"))

-- Output details regarding 2015 table
head(df)
summary(df)
str(df)

-- Remove abnormal names  --
find_abn=df$Name[grep(".*yyy.*",df$Name)]
find_abn
y2016 =df[!rownames(df) %in% grep(".*yyy.*",df$Name),]

-- Read the raw 2015 file into csv format --
y2015 = read.delim("yob2015.txt",header = FALSE,sep = ",",col.names=c("Name","Gender","Amount"))

-- Output details regarding 2015 table --
head(y2015)
summary(y2015)
str(y2015)
tail(y2015,10)

-- Merge 2015 and 2016 data and creat new column of total count names --
final=merge(y2015,y2016,by="Name")
final$Total=final$Amount.x+final$Amount.y
nrow(final)
final=final[order(final$Total),]

-- Show top 10 names --
TOP10_Popular_names=tail(final,10)
TOP10_Popular_names

-- Show top 10 girls names
female_names=subset(final, Gender.x=="F" | Gender.y=="F")
Popular_girls_names=tail(female_names[order(female_names$Total),],10)   
Popular_girls_names

-- Show top 10 girls names by barplot --
par(las=2)
barplot(Popular_girls_names$Total,names.arg=Popular_girls_names$Name,
        main = "TOP10 Most Popular Girls Names 2015-2016",
        horiz=FALSE,col='darkblue')

-- Output data into csv file --
write.csv(subset(Popular_girls_names, select=c("Name","Total")),file = "Popular_Girls_Names_2015-2016.csv",row.names = FALSE)

## GitHub Link
https://github.com/vbriker/HW5

## Contact Information
vbriker@mail.smu.edu
