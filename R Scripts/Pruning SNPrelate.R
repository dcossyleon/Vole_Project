#SNPRelate for LD Pruning

#To install gdsfmt package:
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# BiocManager::install("gdsfmt", version = "3.8")

#Intall biocLite("SNPRelate")
source("http://bioconductor.org/biocLite.R")
biocLite("SNPRelate")


# Load the R packages: gdsfmt and SNPRelate
library(gdsfmt)
library(SNPRelate)



#Filtering and output new .vcf to use for pruning

system(command = "vcftools --vcf final_geno.vcf --maf 0.01 --min-meanDP 100 --minQ 1e+03 --max-missing 1 --recode --out filter1")

# kept 1748 out of 4697 sites



# Convert vcf to GDS: https://www.rdocumentation.org/packages/SNPRelate/versions/1.6.2/topics/snpgdsVCF2GDS

library(GWASTools)

vcf.fn <- system.file("extdata", "/Users/desiree/Documents/New R Projects/Vole_Project/filter1.recode.vcf", package="SNPRelate")
cat(readLines(vcf.fn), sep="")


#Does not work
snpgdsVCF2GDS(vcf.fn, out.fn = "final_geno.gds", method="biallelic.only", snpfirstdim=FALSE, ref.allele=NULL, verbose=TRUE)


#Works if I replace vcf.fn (?)
snpgdsVCF2GDS("/Users/desiree/Documents/New R Projects/Vole_Project/filter1.recode.vcf", out.fn = "final_geno.gds", method="biallelic.only", snpfirstdim=FALSE, ref.allele=NULL, verbose=TRUE)

  # 1464 SNP sites.....why so low?
snpgdsSummary("final_geno.gds")

#Pruning


