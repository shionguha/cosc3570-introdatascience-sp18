install.packages("data.tree")

#load tree package
library(data.tree)

#Load movies by country
hierarchy <- read.csv("Hierarchical_data.csv")

#CREATE A TREE DIAGRAM

#Create a tree path column (Just like path to a file in a file system)
hierarchy$Path <- paste(
  "All",
  hierarchy$Continent,
  hierarchy$Country,
  sep = "/")

head(hierarchy$Path)

#Create a tree from a dataframe
tree <- as.Node(
  x = hierarchy,
  pathName = "Path")

#Print the tree
print(tree, limit = 10)

#Plot the tree
plot(tree)

#CREATE A TREE GRAPH

library(igraph)

treeGraph <- as.igraph(tree)

#Plot tree graph
plot(
  x= treeGraph,
  main = "Geographic Distribution Hierarchy")

#Add row names for dendro labels
row.names(hierarchy) <- hierarchy$Country
head(hierarchy)

#Create a distance matrix
distance <- dist(hierarchy[,c(3,4)])
round(distance, 0)

#Create hierarchical clusters
clusters <- hclust(distance)

#Create dendrogram
plot(
  x = clusters,
  main = "Hierarchical Clusters of Countries")

library(treemap)

#Create a TreeMap
treemap(
  dtf = hierarchy,
  index = c("Continent", "Country"),
  vSize = "Count",
  vColor = "Continent",
  type = "categorical",
  title = "Count of Movies by Continent and Country",
  position.legend = "none")


treemap(
  dtf = hierarchy,
  index = c("Continent", "Country"),
  vSize = "Count",
  vColor = "Box.Office",
  type = "value",
  palette = c("#FF681D", "#FFE1D2"),
  title = "Count of Movies and Average Box Office Revenue\nby Continent and Country",
  title.legend = "Average Box Office Revenue ($M)")