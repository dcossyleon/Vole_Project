#Kate MCMC

# read.csv(file="mergeddata.pruned2.csv")

#Creating merged pruned data
# str(merged.data)
# md <- merged.data[!is.na(merged.data[,14]),] #remove animals who weren't genotyped
# md2 <- md[!is.na(md[,5]),] #remove animals who weren't sliced
# str(md2)
# colnames(md2)[14:1638] <- substring(colnames(md2)[14:1638],2)
# md3 <- md2[ ,c("Animal","Sex", "Gender", "Type", "AON", "IN", "NAcc", "OLF", "PFC", ps2)]
# colnames(md3) [1] <- "animal"
# str(md3)
# #write.csv(x = md3, file = "mergeddata.pruned2.csv", quote = FALSE, row.names = FALSE)
# 

md3 <- read.csv(file="mergeddata.pruned2.csv")
pedigree4 <- read.csv(file="pedigree4.csv")

pedigree4 <- pedigree4[,-1]


##MCMCglmm w/ Sex Interaction
prior <- list(R=list(V=1, nu=0.002), G=list(G1=list(V=1, nu=0.002)))
snpsp2 <- colnames(md3[10:105]) #create object of SNP names



#One SNP Attempt
mcmcp.1 <- MCMCglmm(NAcc~X200289*Sex, random=~animal, family= "gaussian", data= md3, pedigree= pedigree4, nitt= 3000, burnin= 2000, thin= 500, prior= prior) 


#Loop
start.time <- Sys.time()
mcmcp <- mclapply(snpsp2, FUN=function(x) MCMCglmm(as.formula(paste0("NAcc~Sex*", x)), random=~animal, data=md3, family="gaussian", prior= prior, pedigree= pedigree4, nitt=75, burnin=10, thin=1), mc.cores=4)
end.time <- Sys.time()
end.time-start.time #tells you how long it took

#unlist(snpsp2)
#d <- unlist(snpsp2, recursive = TRUE, use.names=TRUE)
