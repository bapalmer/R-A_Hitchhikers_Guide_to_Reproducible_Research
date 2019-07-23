###########################################################################
# 3-day R workshop 
# Day 1
# Afternoon
# 05_bad_habits.R
###########################################################################
# The code below is from one of my early R scripts only three years ago!

# install.packages("igraph")

# Load the required package
library(igraph)
library(tidyverse)

# Import the data
df<-read_csv("Day_1/data/bad_habits_data.csv")

RL1.2<-subset(df,Time=="RL1-2")
RL2.3<-subset(df,Time=="RL2-3")
RL3.4<-subset(df,Time=="RL3-4")
RL4.5<-subset(df,Time=="RL4-5")
RL5.6<-subset(df,Time=="RL5-6")
RL6.7<-subset(df,Time=="RL6-7")

sites1<-as.list(unique(RL6.7$Var1))
sites2<-as.list(unique(RL6.7$Var2))

sites<-as.data.frame(t(merge(sites1,sites2)))
colnames(sites)[1]<-"Position"

for(i in 1:nrow(sites)){
ans<-(sites$Position[i]<=65)
sites$E1[i]<-ans
}

# Start building network
RL6.7_topology<-subset(RL6.7[2:3])
g2<-graph.data.frame(RL6.7_topology,vertices=sites,directed=FALSE)
V(g2)$color<-ifelse(V(g2)$E1==TRUE,"white","grey")
V(g2)$color<-ifelse(V(g2)$E1==TRUE,"white","grey")
plot(g2,vertex.label.color="black",vertex.size=20,edge.color="black",edge.width=1.5)

length(ls())

# Clean up the Global Environment before continuing
