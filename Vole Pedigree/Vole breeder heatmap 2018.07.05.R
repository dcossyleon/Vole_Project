#July 5, 2018
#ggplot correlation matrix, current breeder heatmap

library(kinship2)
setwd("~/Documents/Vole Pedigree/")
vole <- read.csv("~/Documents/Vole Pedigree/R_vole_pedigree_20180717.csv")
vole1 <- vole[!duplicated(vole$Animal),]
vole1$sex <- (ifelse(vole1$Gender=="male", 1, 2))

ped <- pedigree(id=vole1$Animal, dadid=vole1$Father.Id, momid=vole1$Mother.Id, sex=vole1$sex)
#plot(ped, cex = .3, col=vole1$Vendor+1, symbolsize = .75, width=100)


m <- kinship(ped)
mm <- m*2
#sort(diag(mm))


#2018.07.16 Offspring of existing breeders
oeb <- c("200b", "201b", "202b", "203b", "205b", "206b","207b", "209b", "210b","211b", "212b", "213b", "214b", "215b", "216b", "217b", "150b1", "154b", "155b", "156b") #213b not active breeder, but we still have 18 pups from April/May.

oeb_matrix <- mm[oeb,oeb]

#AVerage kinship from 2 diff litters
kin.values <- oeb_matrix[lower.tri(oeb_matrix, diag=FALSE)]
avg.kin <- mean(kin.values)
hist(kin.values, 15) #Right skewed
quantile.kin <- quantile(kin.values)

#KINSHIP HEATMAP OF CURRENT BREEDERS' OFFSPRING
cormat<-round(oeb_matrix,3)

# Get upper triangle of the correlation matrix
get_upper_tri <- function(cormat){
  cormat[lower.tri(cormat)]<- NA
  return(cormat)
} 

# Get lower triangle of the correlation matrix
get_lower_tri<-function(cormat){
  cormat[upper.tri(cormat)] <- NA
  return(cormat)
}

upper_tri <- get_upper_tri(cormat)
write.csv(upper_tri, file="Vole kinship 2018.07.17.csv", quote=FALSE)


# Melt the correlation matrix
library(reshape2)
melted_cormat <- melt(upper_tri, na.rm = TRUE)
# Heatmap
library(ggplot2)
cormat_plot <-  ggplot(data = melted_cormat, aes(Var2, Var1, fill = value))+
  geom_tile(color = "white")+
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                       midpoint = 0, limit = c(0,1.0), space = "Lab", 
                       name="Kinship\nValues") +
  theme_minimal()+ 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, 
                                   size = 11, hjust = 1))+
  coord_fixed()

cormat_plot+
  geom_text(aes(Var2, Var1, label = value), color = "black", size = 4) +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.grid.major = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank(),
    axis.ticks = element_blank(),
    legend.justification = c(1, 0),
    legend.position = c(0.45, 0.7),
    legend.direction = "horizontal")+
  guides(fill = guide_colorbar(barwidth = 7, barheight = 1,
                               title.position = "top", title.hjust = 0.5))

