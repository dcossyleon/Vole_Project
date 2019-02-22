#Loci of primers and mrna

library(Gviz)
library(biomaRt)

setwd("~/Documents/Behavioral Genetics Study/R Projects/Vole/")

mystart <- 195279
myend <-  238244 # +1000kb 

#ideo <- IdeogramTrack(genome='WHAT is the VOLE GENOME NAME', chromosome='chr6') 
ga <- GenomeAxisTrack(col='dark gray', 
                      littleTicks=FALSE, 
                      add53=TRUE, 
                      exponent=3,
                      cex=1,
                      distFromAxis=1.5,
                      labelPos="above")

#manually create bac model
mrna <- GeneRegionTrack(rstarts=c(206981,
                                218431),
                        rends =c(207228,
                                219454), 
                       fill="dark gray",
                       start=mystart, 
                       end=myend, 
                       strand='-',
                       chromosome="chr6",
                       name="OXTR", 
                       min.height=7,
                       col="black",
                       col.line="black")

cds <- GeneRegionTrack(rstarts=c(206981,
                                   218431),
                       rends =c(207228,
                                219349), 
                       fill="blue",
                       start=mystart, 
                       end=myend, 
                       strand='-',
                       chromosome="chr6",
                       name="OXTR CDS")

#Annotation Track
aTrack <- AnnotationTrack(start=c(199279,206770,213592,222148,229241), 
                          width=c(207175-199279,214000-206770,222950-213592,230038-222148,238244-229241), 
                          chromosome="chr6",
                          id=c("locus 3\n 7.90kb", "locus 4\n 7.23kb", "locus 5\n 9.36kb", "locus 6\n 7.89kb", "locus 7\n 9.00kb"),
                          name="Primer Targets")


plotTracks(aTrack, shape="box", showFeatureId=TRUE, fontcolor="black")

#change color for UTR

#Gene Model: rheMac2


availableDisplayPars(refGenes)

#SNPs
snptrack <- AnnotationTrack(start = c(201501,	
                                      203254,	
                                      209958,	
                                      210858,	
                                      211385,	
                                      211980,	
                                      212087,	
                                      212570,	
                                      213026,	
                                      213106,	
                                      213739,	
                                      225727,	
                                      225814,
                                      234447), 
                            end = c(201502,	
                                    203255,	
                                    209959,	
                                    210859,	
                                    211386,	
                                    211981,	
                                    212088,	
                                    212571,	
                                    213027,	
                                    213107,	
                                    213740,	
                                    225728,	
                                    225815,
                                    234448),	
                            details.size = 0.5, 
                            detailsConnector.cex = 0.5, 
                            name = "SNPs", 
                            chromosome = "chr6", 
                            col='Black', 
                            fill='Black',
                            lwd=.05,
                            stacking="dense") #displays on only one line


#Plots all tracks
displayPars(aTrack) <- list( fill="white", showFeatureId=TRUE, fontcolor.item="black")
plotTracks(aTrack)


plotTracks(list(ga, mrna, snptrack, aTrack), from=mystart, to=myend,
           background.panel='white', 
           col.axis='DarkGray', 
           col.title="black",
           background.title = 'white', 
           reverseStrand = FALSE)

