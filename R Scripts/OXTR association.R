
#d <- read.csv("~/Documents/Desiree/data desiree .csv")

setwd("Documents/Behavioral Genetics Study/R Projects/Vole/")

dgeno <- read.csv("Vole genotypes final - 7-18-17.csv")[1:81,]
dpheno <- read.csv("NAcc specific field brains.csv")
dpheno2 <- read.csv("Ophir et al 2012 Male Field OTR NAcc.csv")

colnames(dpheno) <- c("ID", "Avg.Nacc", "Spec.Nacc")
dgeno$ID <- toupper(dgeno$Sample.Name)
colnames(dpheno2) <- c("ID", "Spec.Nacc")
  dpheno2$ID <- substring(dpheno2$ID,2) #Removes leading M from ID column

dd <- merge(dpheno2, dgeno, by="ID") #Change to dpheno for original Phelps set; dpheno2 for new Phelps data

dd$sex <- ifelse(grepl("F", dd$ID), "Female", "Male")

dd$SNP201501 <- ifelse(dd$X201501.seq.call=="A/A", 0, ifelse(dd$X201501.seq.call=="G/A", 1, 2))
dd$SNP203254 <- ifelse(dd$X203254.seq=="C/C", 0, ifelse(dd$X203254.seq=="C/T", 1, ifelse(dd$X203254.seq=="T/T", 2, NA)))
dd$SNP209958 <- ifelse(dd$X209958.taq=="C/C", 0, ifelse(dd$X209958.taq=="C/A", 1, ifelse(dd$X209958.taq=="A/A", 2, NA)))
dd$SNP210858 <- ifelse(dd$X210858.taq=="C/C", 0, ifelse(dd$X210858.taq=="C/T", 1, ifelse(dd$X210858.taq=="T/T", 2, NA)))
dd$SNP211385 <- ifelse(dd$X211385.taq=="A/A", 0, ifelse(dd$X211385.taq=="A/G", 1, ifelse(dd$X211385.taq=="G/G", 2, NA)))
dd$SNP211980 <- ifelse(dd$X211980.taq=="A/A", 0, ifelse(dd$X211980.taq=="A/T", 1, ifelse(dd$X211980.taq=="T/T", 2, NA)))
dd$SNP212087 <- ifelse(dd$X212087.taq=="C/C", 0, ifelse(dd$X212087.taq=="C/G", 1, ifelse(dd$X212087.taq=="G/G", 2, NA)))
dd$SNP212570 <- ifelse(dd$X212570.seq=="C/C", 0, ifelse(dd$X212570.seq=="C/T", 1, ifelse(dd$X212570.seq=="T/T", 2, NA)))
dd$SNP213026 <- ifelse(dd$X213026.taq=="A/A", 0, ifelse(dd$X213026.taq=="A/G", 1, ifelse(dd$X213026.taq=="G/G", 2, NA)))
dd$SNP213106 <- ifelse(dd$X213106.taq=="A/A", 0, ifelse(dd$X213106.taq=="A/G", 1, ifelse(dd$X213106.taq=="G/G", 2, NA)))
dd$SNP213739 <- ifelse(dd$X213739.seq=="C/C", 0, ifelse(dd$X213739.seq=="T/C", 1, ifelse(dd$X213739.seq=="T/T", 2, NA)))
dd$SNP225727 <- ifelse(dd$X225727.seq=="G/G", 0, ifelse(dd$X225727.seq=="G/A", 1, ifelse(dd$X225727.seq=="A/A", 2, NA)))
dd$SNP225814 <- ifelse(dd$X225814.taq=="T/T", 0, ifelse(dd$X225814.taq=="T/C", 1, ifelse(dd$X225814.taq=="C/C", 2, NA)))
dd$SNP234447 <- ifelse(dd$X234447.taq=="G/G", 0, ifelse(dd$X234447.taq=="G/C", 1, ifelse(dd$X234447.taq=="C/C", 2, NA)))

ddd <- dd[,c(3, 26)]

ddd <- ddd[!is.na(ddd$X213739.seq),]

plot(ddd$Spec.Nacc~ddd$X213739.seq)

ddd[ddd$X213739.seq=="C/C",] <- NA
summary(lm(ddd$Spec.Nacc~ddd$X213739.seq))



summary(lm(Spec.Nacc~SNP201501, dd))$r.squared
summary(lm(Spec.Nacc~SNP203254, dd))$r.squared
summary(lm(Spec.Nacc~SNP209958, dd))$r.squared
summary(lm(Spec.Nacc~SNP210858, dd))$r.squared
summary(lm(Spec.Nacc~SNP211385, dd))$r.squared
summary(lm(Spec.Nacc~SNP211980, dd))$r.squared
summary(lm(Spec.Nacc~SNP212087, dd))$r.squared
summary(lm(Spec.Nacc~SNP212570, dd))$r.squared
summary(lm(Spec.Nacc~SNP213026, dd))$r.squared
summary(lm(Spec.Nacc~SNP213106, dd))$r.squared
summary(lm(Spec.Nacc~SNP213739, dd))$r.squared
summary(lm(Spec.Nacc~SNP225814, dd))$r.squared
summary(lm(Spec.Nacc~SNP234447, dd))$r.squared

summary(lm(Spec.Nacc~SNP201501*sex, dd))$r.squared
summary(lm(Spec.Nacc~SNP203254*sex, dd))$r.squared
summary(lm(Spec.Nacc~SNP209958*sex, dd))$r.squared
summary(lm(Spec.Nacc~SNP210858*sex, dd))$r.squared
summary(lm(Spec.Nacc~SNP211385*sex, dd))$r.squared
summary(lm(Spec.Nacc~SNP211980*sex, dd))$r.squared
summary(lm(Spec.Nacc~SNP212087*sex, dd))$r.squared
summary(lm(Spec.Nacc~SNP212570*sex, dd))$r.squared
summary(lm(Spec.Nacc~SNP213026*sex, dd))$r.squared
summary(lm(Spec.Nacc~SNP213106*sex, dd))$r.squared
summary(lm(Spec.Nacc~SNP213739*sex, dd))$r.squared
summary(lm(Spec.Nacc~SNP225814*sex, dd))$r.squared
summary(lm(Spec.Nacc~SNP234447*sex, dd))$r.squared

summary(lm(Spec.Nacc~sex, dd))$r.squared

plot(dd$SNP213739,dd$Spec.Nacc)

par(mfrow=c(3, 5))
lapply(34:47, function(x) plot(as.factor(dd[,x]),dd$Spec.Nacc))





hist(dd$Spec.Nacc)


lapply(32:45, function(x) plot((dd[,x]),dd$Spec.Nacc))

plot(dd[,33],dd$Spec.Nacc)
