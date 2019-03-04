
#Feb, 28, 2019
#LD heatmap of Vole SNPs

#install package SnpStats in bioConductor
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# BiocManager::install("snpStats", version = "3.8")

install.packages("LDheatmap")
library(LDheatmap)

str(data(CEUData))

str(CEUSNP)

CEUData



g # df of SNP data from geno.R --> says it is not a genotype object

LDheatmap(g, genetic.distances=NULL, distances="physical",
          LDmeasure="r", title="Pairwise LD", add.map=TRUE, add.key=TRUE,
          geneMapLocation=0.15, geneMapLabelX=NULL, geneMapLabelY=NULL,
          SNP.name=NULL, color=NULL, newpage=TRUE,
          name="ldheatmap", vp.name=NULL, pop=FALSE, flip=NULL, text=FALSE)

head(g)
