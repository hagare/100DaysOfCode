# Hierarchical Clustering Algorithm Example
# June 7, 2020

###########################################################
#  Hierarchical Clustering Analysis Choices
## 1. dissimilarity measure (aglomerative, divisive)
## 2. type of linkage (complete, single, average, ward)
## 3. where to cut dendrograms (cluster optimization)

###########################################################

# Required R Libraries
# install all required libraries. ex: install tidyverse package
# install.packages("tidyverse")
library(tidyverse) # data manipulation
library(cluster) # clustering algorithms
library(stats) # hclust in stats package
library(factoextra) # clustering visualizations
library(dendextend) # comparing 2 dendograms
library(ggplot2) # visualization libary


# Import data into R
## Option: CSV
#> data = read.csv("file.csv", header=TRUE) # import data from csv
## Option: Excel
#> library(readxl)
#> data = read_excel("file.xlsx", sheet = 1 )
## Convert data to data frame
#> df.orig = data.frame(data)
# Option: R dataset (In this tutorial we will use R dataset)
df.orig <- USArrests

# Hierarchical Clustering Algorithms
## Agglomerative Nesting (single element to single cluster better for small clusters)
### hclust in stats; agnes in cluster
## Divisive hierarchical clustering ( single cluster to single elements better for large clusters)
### diana in cluster

# Measure of dissimilarity between linkages
## Measure dissimilarity either max/complete (compact clusters), min/single (loose clusters), mean/average, centroid linkage clustering or ward's/ ward.D minimum variance method (minimizes total wi cluster variance)

# Prepare/ Preprocess Data
## rows observations, columns variables
## remove any missing values
df <- na.omit(df.orig)
## standardize data (scale ie mean=0;sd=1)
df <-scale(df)
## look at data
head(df)

# Agglomerative Hierarchical Clustering
## Dissimilarity Matrix
## euclidean dist: root sum of squares diff; manhattan dist: sum of absolute diff; gower dist: sum of all variable specifc dist
distance <- dist(df, method = "euclidean")

## Hierarchical clustering using complete linage
### hclust
hc1 <- hclust(distance, method = "complete") # using hclust
hc1b <- hclust(distance, method="ward.D2") # using hclust and ward.D emthod

#### Plot dendrogram
plot(hc1, cex =0.6, hang = -1)
plot(hc1b, cex =0.6, hang = -1)

# Compare dendrograms using tangelgram
tanglegram(as.dendrogram(hc1),as.dendrogram(hc1b))  # Compare dendrograms using tangelgram
entanglement(as.dendrogram(hc1),as.dendrogram(hc1b))  # entanglement provides a measure of well the two trees align, 1 full, 0 no entanglement

### agnes (create function to test agnes with 3 methods)
agnes.method <- c("complete", "single", "average","ward") # list of agglomertive coefficient methods (measures amount of clustering structure)
names(agnes.method) <-  c("complete", "single", "average","ward") 

agnes.ac <- function(x) { # create function to calculate aggolomertive coefficient ac
  agnes(df, method =x)$ac} 
(ac <- map_dbl(agnes.method, agnes.ac)) # apply a fuction to each element of a list

# ac closer to 1 means stronger clustering
hc2 <- agnes(df, method="complete")
pltree(hc2, cex = 0.6, hang = -1, main = paste("Dendrogram using agnes, method complete, ac = ",round(ac["complete"],2)))

hc3 <- agnes(df, method="ward")
pltree(hc3, cex = 0.6, hang = -1, main = paste("Dendrogram using agnes, method ward, ac= ",round(ac["ward"],2)))

# Divisive Hierarchical Clustering
hc4 <- diana(df)
hc4$dc # divise coefficient describes amount of clustering structure
## Plot dendrogram
pltree(hc4,cex=0.6, hang=-1, main= paste("Dendrogram of diana method, dc =", round(hc4$dc,2)))

# Optimizing Hierarchical Clustesr
## Elbow method
fviz_nbclust(df, FUN=hcut, method="wss") # determine optimal number or clusters

## Average Silhouette Method
fviz_nbclust(df, FUN=hcut, method="silhouette") # determine optimal number or clusters

## Gap Statistic Method
gap_stat <- clusGap(df, FUN = hcut, nstart = 25, K.max = 10, B=10)
print(gap_stat, method ="firstmax")
fviz_gap_stat(gap_stat)


# Cutting Dendrograms
## height of fusion on the vertical axis indicates the dissimlarity of two observations (higher less similar)
## height of the cut to the dendrogram controls the number of clusters obtained (similar to k in k-mean clustering)
## cut dendrogram with cutree using hclust
### Create hierarchical cluster based on distances and chosed method
#### Using hclust
hc5 <- hclust (distance, method="ward.D2")
## Cut tree into specificed groups
num_clusters = 4 # specify desired number of clusters based on optimization analyses see lines 84-94
subgrp <- cutree(hc5, k=num_clusters)
subgrp_count <- table(subgrp) # add cluster information to the data using cutree method
df.orig %>%   mutate(cluster=subgrp) %>% head # add cluster information to the data using cutree method
plot(hc5,cex=0.6) # plot dendrogram
rect.hclust(hc5,k=num_clusters,border=2) # Add box around clusters using hclust

#### using agnes()
hc6 <- agnes(df,method="ward")
cutree(as.hclust(hc6), k= num_clusters)

#### using diana()
hc7 <- diana(df)
cutree(as.hclust(hc7),k=num_clusters)
plot(as.hclust(hc7), cex=0.6)
rect.hclust(as.hclust(hc7),k=num_clusters,border=2)

# Create scatterplot using fviz_cluster function in factoextra package
fviz_cluster(list(data=df, cluster=subgrp)) # !!! Creates nice visualizations with specified clusters

# Visualize Hierarchical Clustering (using hcut and fviz functions)
hc.cut <- hcut(df, k=num_clusters, hc_func="hclust", hc_method="complete") #hcut computes hierarchical clustering and cut the tree # can specify desire function hclust, agnes, diana
fviz_dend(hc.cut,show_labels=TRUE,rect=TRUE)
fviz_cluster(hc.cut,frame.type="convex")


# Plot variables by cluster using ggplot
## This example uses original data set and hc4 hclust, ward method with cluster=4
df.orig %>% mutate(Cluster = subgrp) %>% ggplot(aes(x=UrbanPop,y=Murder,color=factor(Cluster)))+geom_line()+ggtitle("Murder by Population") 
df.orig %>% mutate(Cluster = subgrp) %>% ggplot(aes(x=UrbanPop,y=Assault,color=factor(Cluster)))+geom_line()+ggtitle("Murder by Population")
