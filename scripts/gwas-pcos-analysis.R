
# Read GWAS summary statistics
pcos <- read.delim(file.choose(), header = TRUE)

# Inspect the dataset
head(pcos)
colnames(pcos)
dim(pcos)

# Data Quality Check
# Check data structure
str(pcos)

# Check for missing values
colSums(is.na(pcos))

# Check for duplicate SNPs
sum(duplicated(pcos$MarkerName))

# summary statistics
summary(pcos)

# Examine p-value distribution
summary(pcos$Pvalue)

# Smallest p-values
head(pcos[order(pcos$Pvalue), ])

# Identify genome-wide significant SNPs
# Genome-wide significance threshold
significant_snps <- subset(pcos, Pvalue < 5e-8)
significant_snps

# Number of significant SNPs
nrow(significant_snps)

# View the first significant SNPs
head(significant_snps)

# Save results
dir.create("results")
write.csv(significant_snps, 
          "results/significant_snps.csv",
          row.names = FALSE)


# Create a Manhattan plot
install.packages("qqman")
library(qqman)

png("GWAS_Manhattan_Plot_PCOS.png",
    width = 1800,
    height = 1000,
    res = 200)

manhattan(pcos,
          chr = "chr",
          bp = "pos",
          p = "Pvalue",
          snp = "MarkerName",
          main = "GWAS Manhattan Plot for PCOS",
          genomewideline = -log10(5e-8))
dev.off()

# Top 20 most significant SNPs
top_snps <- pcos[order(pcos$Pvalue), ]
top20_snps <- top_snps[1:20, ]
View(top20_snps)

# Save results
write.csv(top20_snps, 
          "results/top20_significant_snps.csv",
          row.names = FALSE)
