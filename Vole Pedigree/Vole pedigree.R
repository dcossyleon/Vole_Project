#8/23/2017
#6/08/2018
#Vole Pedigree

library(kinship2)
setwd("~/Documents/Vole Pedigree/")


vole <- read.csv("R_vole_pedigree_20180705.csv")
vole1 <- vole[!duplicated(vole$Animal),]

vole1$sex <- (ifelse(vole1$Gender=="male", 1, 2))

#write.csv(vole1, file="R_vole_pedigree_20180705.csv", quote=FALSE)
#vole1 <- read.csv("R_vole_pedigree_20171030.csv")
#vole1 <- read.csv("R_vole_pedigree_20171030_geno.csv")

ped <- pedigree(id=vole1$Animal, dadid=vole1$Father.Id, momid=vole1$Mother.Id, sex=vole1$sex)
plot(ped, cex = .3, col=vole1$Vendor+1, symbolsize = .75, width=100)

m <- kinship(ped)
mm <- m*2
#sort(diag(mm))

gb <- c("200b", "201b", "202b", "203b", "204b", "205b", "206b","207b", "208b", "209b", "210b","211b", "212b", "213b") #gb=Yerkes-Cornell offspring
gb_matrix <- round(mm[gb,gb], 3)  #matrix: relatedness of gb's
gb_matrix[lower.tri(gb_matrix, diag=TRUE)] <- NA 
#write.csv(gb_matrix, file="gb_matrix.csv", quote=FALSE)


baby <- c("151b", "152b", "143b", "149b", "b1b", "b2b", "b3b", "139b", "147b", "148b", "150b", "153b", "c3b", "c1b", "t1bb", "t2bb")
b <- mm[baby,baby]


mm["148b", "b1b"] #two hypothetical siblings


breed_f <- c("8285", "143f", "148f", "149f", "151f", "152f", "153f", "b1f", "b2f", "b3f")
breed_m <- c("8332", "143m","148m", "149m","151m", "152m", "153m", "b1m", "b2m", "b3m")

poss<- mm[breed_f, breed_m] #best case scenario for setting up breeders


#Get inbreeding coeffs for the babies (diagonal) + kinship values
b=as.data.frame(as.table(b))  #Turn into a 3-column table
b=b[order(b$Freq, decreasing=F),]


b1 <- mm[baby,baby]


147 &148 --> gives us hets and TTs or just TTs (0.07)
150 & 143  --> gives us hets and CCs  (0.139)
 b1b & c1b <-  hets only
 150& c1b or c3b <- only CCs (0.17)
 
 
#____ genotype ideals
only TTs: 147 & 148     OR  t1bb & 148 
only CCs: 150b & c1b
hets/ TTs: 					 OR  151 &147 (0.22)
hets/ CCs: 143 & c3b

#2018.06.08 Pairing Yerkes-Cornell offspring with our old colony animals

old <- c("139b2", "139b3", "150b3", "150b4", "c3b2", "b1b3") #Voles lorra saved to make new breeders with Yerk-Corn offpsring

breeder_matrix <- round(mm[old,gb], 3)
#breeder_matrix[lower.tri(breeder_matrix, diag=TRUE)] <- NA #WHY DID I REMOVE LOWER TRIANGLE?!
write.csv(breeder_matrix, file="breeder_matrix_YerkesOphir_Colony.csv", quote=FALSE)


#Get inbreeding coeffs for the babies (diagonal) + kinship values
d=as.data.frame(as.table(breeder_matrix))  #Turn into a 3-column table
d=d[order(d$Freq, decreasing=F),]
write.csv(d, file="Possible breeders 2018.06.18.csv", quote=FALSE)

 
