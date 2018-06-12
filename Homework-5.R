
setwd("F:\\My_Docs\\univer\\DataScience\\unit5\\HW")
df = read.delim("yob2016.txt",header = FALSE,sep = ";",col.names=c("Name","Gender","Amount"))
head(df)
summary(df)
str(df)
find_abn=df$Name[grep(".*yyy.*",df$Name)]
find_abn
y2016 =df[!rownames(df) %in% grep(".*yyy.*",df$Name),]


y2015 = read.delim("yob2015.txt",header = FALSE,sep = ",",col.names=c("Name","Gender","Amount"))
head(y2015)
summary(y2015)
str(y2015)
tail(y2015,10)

#apply(df, 2, function(x) any(is.na(x))) #check if any NA
y2015=y2015[order(y2015$Name),]
y2016=y2016[order(y2016$Name),]

final=merge(y2015,y2016,by="Name")
final$Total=final$Amount.x+final$Amount.y
final=final[order(final$Total),]
Popular_names=tail(final,10)

mix_names=subset(final, Gender.x=="M" & Gender.y=="F" | Gender.x=="F" & Gender.y=="M")
nrow(mix_names)

if (nrow(mix_names)>0) {
   female_names=subset(final, Gender.x=="F" | Gender.y=="F")
   Popular_girls_names=tail(female_names[order(female_names$Total),],10)   
}

Popular_girls_names

barplot(Popular_girls_names$Total,names.arg=Popular_girls_names$Name,
        xlab = "Count",
        main = "Popular Girls Names 2015-2016",
        horiz=FALSE,col='darkblue')

write.csv(subset(Popular_girls_names, select=c("Name","Total")),file = "Popular_Girls_Names_2015-2016.csv",row.names = FALSE)

#apply(df, 2, function(x) any(is.na(x))) #check if any NA

