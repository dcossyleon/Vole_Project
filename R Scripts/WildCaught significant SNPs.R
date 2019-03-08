md4 <- read.csv(file="~/Documents/New R Projects/Vole_Project/mergeddata4.csv")
md4[1:10,1:18]


pedigree4 <- read.csv(file="~/Documents/New R Projects/Vole_Project/pedigree4.csv")
pedigree4 <- pedigree4[,-1]


d <- subset(md4, Type=="WC") # Create data frame with just WC



#P values from wildcaught
wc <- apply(d[,12:1636], MARGIN=2, function(x) summary(lm(NAcc~x, data=d))$coefficient[8])

#R squared from wildcaught
wc.r <- apply(d[,12:1636], MARGIN=2, function(x) summary(lm(NAcc~x, data=d))$r.squared)


df.wc <- data.frame(wc.r, wc)
answers <- df.wc[order(wc),] # Orders WC SNPs by p-value
head(answers, 20) # Show top 20 WC p-values

# Plot an individual SNP from WC top 20
plot(NAcc~X221163, data=d)
abline(lm(NAcc~X221163, data=d))

# Check: Are these top SNPs also significant in EC group?

# Test individual SNP
summary(lm(NAcc~X221163, data=md4[md4$Type=="EC",]))

plot(NAcc~X221163, data=md4, col=c("black", "green")[md4$Type])
abline(lm(NAcc~X221163, data=md4[md4$Type=="WC",]), col="green")
abline(lm(NAcc~X221163, data=md4[md4$Type=="EC",]), col="gold")
abline(lm(NAcc~X221163, data=md4), col="black")