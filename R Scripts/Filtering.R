library(ggplot2)


#Filter 1
system(command = "vcftools --vcf final_geno.vcf --maf 0.01 --min-meanDP 100 --minQ 1e+03 --max-missing 1 --012 --out ./Filtered/filter1")
# After filtering, kept 1748 out of a possible 4697 Sites

f <- read.table(file = "Filtered/filter1.012.pos", header = FALSE)[,2]
y <- rep(1, length(f))
df <- data.frame(f, y)

p<-ggplot(data=df, aes(x=f, y=y)) +
  geom_bar(stat="identity", fill= "black", color= "black", size = 0.05) +
  theme_classic()
p




#Filter 2
system(command = "vcftools --vcf final_geno.vcf --maf 0.01 --min-meanDP 100 --minQ 30 --max-missing 1 --012 --out ./Filtered/filter2")
# After filtering, kept 1754 out of a possible 4697 Sites


#Filter 3
system(command = "vcftools --vcf final_geno.vcf --maf 0.01 --min-meanDP 100 --minQ 30 --max-missing 0.5 --012 --out ./Filtered/filter3")
# After filtering, kept 1773 out of a possible 4697 Sites


#Filter 4
system(command = "vcftools --vcf final_geno.vcf --maf 0.01 --min-meanDP 50 --minQ 30 --max-missing 0.5 --012 --out ./Filtered/filter4")
# After filtering, kept 1837 out of a possible 4697 Sites


f <- read.table(file = "Filtered/filter4.012.pos", header = FALSE)[,2]
y <- rep(1, length(f))
df <- data.frame(f, y)

p<-ggplot(data=df, aes(x=f, y=y)) +
  geom_bar(stat="identity", fill= "black", color= "black", size = 0.05) +
  theme_classic()
p