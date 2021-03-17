#!/bin/sh

module load vcftools

source ./env.sh

cd $VCF_DIR

for v in *.filtrd; do
    vcftools --vcf $(basename $v) --site-depth -c > $(basename $v).locusdepth.txt
    vcftools --vcf $(basename $v) --depth -c > $(basename $v).inddepth.txt
    vcftools --vcf $(basename $v) --freq -c > $(basename $v).freq.txt
done

cp *.txt $OUT_DIR

cd $OUT_DIR

# Replace file names with bb1-10 in mpileup to match with freebayes. File name expansion in bash is ALPHABETICALLY
i=0
for bam in $BAM_DIR/*.sorted.bam; do
    [ -e "$bam" ] || continue
    (( i += 1 ))

    for file in *.inddepth.txt; do
        sed -i "s+$bam+bb$i+g" $file
    done

done