# PLINK LD pruning

# Install plink by downloading files: http://zzz.bwh.harvard.edu/plink/download.shtml
# Place file in working directory or other path

# Need file with family ID, individual ID, father ID, mother ID, sex with the extension .ped. This file has NO header.

# File with marker information: extension. .map
# 


#Filter 1 with plink output
system(command = "vcftools --vcf final_geno.vcf --maf 0.01 --min-meanDP 100 --minQ 1e+03 --max-missing 1 --012 --out ./Filtered/filter1")
# After filtering, kept 1748 out of a possible 4697 Sites
# Most aggressive filtering





# Linkage Disequilibrium based SNP pruning

