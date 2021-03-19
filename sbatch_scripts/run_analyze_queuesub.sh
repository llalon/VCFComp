#!/bin/sh

# USAGE: run_analyze_queuesub.sh vcf1 vcf2 output

#SBATCH --account=def-emandevi
#SBATCH --time=0-03:00:00 ## days-hours:minutes:seconds
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4 # number of threads
#SBATCH --mem=16000 # requested memory (in MB)

module load bcftools vcftools

VCF1=$1
VCF2=$2
FOUT=$3

rm -f $FOUT

echo "Finding SNPs..."

# get number of SNPs
echo "number of SNPS:" >> $FOUT
echo "$(basename $VCF1)  $(bcftools stats $VCF1 | grep "number of SNPs:" | cut -f 4)" >> $FOUT
echo "$(basename $VCF2)  $(bcftools stats $VCF2 | grep "number of SNPs:" | cut -f 4)" >> $FOUT
cat $FOUT

# Diff
echo "Finding VCF diff..."

# Check if isec was already made
if [ ! -d "isec" ]; then
    bgzip $VCF1 -c > vcf1.gz
    bgzip $VCF2 -c > vcf2.gz
    bcftools index vcf1.gz
    bcftools index vcf2.gz
    bcftools isec -p isec vcf1.gz vcf2.gz
else
    echo "isec already done skipping..."
fi

# For isec files
for i in isec/*.vcf; do
    echo "$(basename $i)  $(bcftools stats $i | grep "number of SNPs:" | cut -f 4)" >> $FOUT
    
done

cat $FOUT

echo "All done now"