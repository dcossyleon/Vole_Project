#Df with positions


ind <-  read.table(file= "final_geno.txt.012.indv")
pos <-  read.table (file= "final_geno.txt.012.pos")
g <- read.table(file= "final_geno.012", sep = "\t", header= FALSE)
g <- g[,-1]
colnames(g) <- as.character(pos[,2])
rownames(g) <- as.character(ind[,1])


Lani <- c("201501", "203254", "209958", "210858", "211385", "211980", "212087", "212570", "213026", "213106", "213739", "225727", "225814", "234447") #14 Lani Snps

wild_caught <- c("947_S24", "982_S36", "929_S12", "901_S94", "711_S82", "617_S70", "562_S58", "289_S47", "2600_S95", "2559_S83", "2556_S71", "250_S35", "231_S23", "1107_S59") #ind names of wild caught animals

w <- g[wild_caught,Lani]


s <- g[,Lani] 







l <- lapply(s, function(x) table(x))

par(mfrow=c(3,5))
h <- lapply( s, function(x) hist(as.numeric(x), ylim=c(0,65)))

par(mfrow=c(3,5))
wh <- lapply( w, function(x) hist(as.numeric(x), ylim=c(0, 14)))



