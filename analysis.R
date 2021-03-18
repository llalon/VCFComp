### Read in the data

# SNP counts - see readme.txt in isec folder for information on files
snp.stats <- read.delim("snp_stats.txt")
snp.stats$file <- sapply(strsplit(snp.stats$number.of.SNPS., "\\s+"), `[`, 1)
snp.stats$count <- as.numeric(sapply(strsplit(snp.stats$number.of.SNPS., "\\s+"), `[`, 2))

# Depth
locusdepth.fb <- read.delim("freebayes_all.vcf.filtrd.locusdepth.txt")
locusdepth.mp <- read.delim("mpileup_all.vcf.filtrd.locusdepth.txt")

depth.fb <- read.delim("freebayes_all.vcf.filtrd.inddepth.txt")
depth.mp <- read.delim("mpileup_all.vcf.filtrd.inddepth.txt")

# Frequency data
freq.fb <- read.delim("freebayes_all.vcf.filtrd.freq.txt", row.names = NULL)
freq.mp <- read.delim("mpileup_all.vcf.filtrd.freq.txt", row.names = NULL)

names(freq.fb) <- c("CHROM", "POS", "N_ALLELES", " N_CHR", "AF1", "AF2")
names(freq.mp) <- c("CHROM", "POS", "N_ALLELES", " N_CHR", "AF1", "AF2")

freq.fb$FREQ <- as.numeric(sapply(strsplit(freq.fb$AF2, ":"), `[`, 2))
freq.mp$FREQ <- as.numeric(sapply(strsplit(freq.mp$AF2, ":"), `[`, 2))

### Calculate

# MAF 
freq.fb$FREQ <- ifelse(freq.fb$FREQ > 0.5, 1 - freq.fb$FREQ, freq.fb$FREQ)
freq.mp$FREQ <- ifelse(freq.mp$FREQ > 0.5, 1 - freq.mp$FREQ, freq.mp$FREQ)

# Sample size
n <- nrow(depth.fb)

### Generate plots

# Stacked histograms for MAF and mean depth
hist1 <- stack_hists(locusdepth.fb$SUM_DEPTH / n, locusdepth.mp$SUM_DEPTH / n) + xlab("Mean Depth per SNP") + xlim(0, 200) + ylim(0, 45000)
hist2 <- stack_hists(freq.fb$FREQ, freq.mp$FREQ) + xlab("Minor Allele Frequency")

# Venn diagram showing SNPs between each method. See readme.txt in isec folder for information on files
venn1 <- venn_by_counts(snp.stats[3, 3], snp.stats[4, 3], snp.stats[6, 3]) + ggtitle("Differences in SNPs between 2 variant calling methods")

# Mean depth across individuals for each method
barplot1 <- barplot_by_indiv(depth.fb, depth.mp) + xlab("Individual") + ylab("Mean Depth") + labs(fill = "Method")





# NOTES

# 0 = all different, 1 = all same
# DONT KNOW TRUTH LIKE WITH GOLD STANDARD THING


