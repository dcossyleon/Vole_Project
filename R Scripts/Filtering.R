# Filtering Vole sequencing data, Filter 1.
# Feb 27, 2019

library(ggplot2)

#Filter 1
system(command = "vcftools --vcf final_geno.vcf --maf 0.01 --min-meanDP 100 --minQ 1e+03 --max-missing 1 --012 --out ./Filtered/filter1")
# After filtering, kept 1748 out of a possible 4697 Sites
# Most aggressive filtering

f <- read.table(file = "Filtered/filter1.012.pos", header = FALSE)[,2]
y <- rep(1, length(f))
df <- data.frame(f, y)

p<-ggplot(data= df, aes(x=f, y=y)) +
  geom_bar(stat="identity", fill= "black", color= "black", size = 0.05) +
  theme_classic()
p



#Filtering and output new .vcf

system(command = "vcftools --vcf final_geno.vcf --maf 0.01 --min-meanDP 100 --minQ 1e+03 --max-missing 1 --recode --out filter1")

# kept 1748 out of 4697 sites







#Filter 2
system(command = "vcftools --vcf final_geno.vcf --maf 0.01 --min-meanDP 100 --minQ 30 --max-missing 1 --012 --out ./Filtered/filter2")
# After filtering, kept 1754 out of a possible 4697 Sites
# Relaxes minQ from 1000 to 30 (which is still high)

#Filter 3
system(command = "vcftools --vcf final_geno.vcf --maf 0.01 --min-meanDP 100 --minQ 30 --max-missing 0.5 --012 --out ./Filtered/filter3")
# After filtering, kept 1773 out of a possible 4697 Sites
# In addition to above, relaxes max-missing to 0.5


#Filter 4
system(command = "vcftools --vcf final_geno.vcf --maf 0.01 --min-meanDP 50 --minQ 30 --max-missing 0.5 --012 --out ./Filtered/filter4")
# After filtering, kept 1837 out of a possible 4697 Sites
# In addition to above, relaxes min-meanDP to 50.


f <- read.table(file = "Filtered/filter4.012.pos", header = FALSE)[,2]
y <- rep(1, length(f))
df <- data.frame(f, y)

p<-ggplot(data=df, aes(x=f, y=y)) +
  geom_bar(stat="identity", fill= "black", color= "black", size = 0.05) +
  theme_classic()
p