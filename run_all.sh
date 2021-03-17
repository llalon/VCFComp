#!/bin/sh

# Runs pipeline

source ./env.sh

mkdir -p $VCF_DIR
mkdir -p $WORK_DIR
mkdir -p $OUT_DIR

cd $WORK_DIR

# Add readgroups
#echo "running $SCR_DIR/run_gen_rq_queuesub.sh $BAM_DIR"
#sbatch $SCR_DIR/run_gen_rq_queuesub.sh $BAM_DIR

# Mpileup
#echo "running $SCR_DIR/run_mpileup_queuesub.sh $REF $BAM_DIR $VCF_DIR"
#sbatch $SCR_DIR/run_mpileup_queuesub.sh $REF $BAM_DIR $VCF_DIR

# Freebayes
#echo "running $SCR_DIR/run_freebayes_queuesub.sh $REF $BAM_DIR $VCF_DIR"
#sbatch $SCR_DIR/run_freebayes_queuesub.sh $REF $BAM_DIR $VCF_DIR

# Filter
#echo "running $SCR_DIR/run_filter_queuesub.sh $VCF_DIR"
#sbatch $SCR_DIR/run_filter_queuesub.sh $VCF_DIR

# Analyze
#echo "running $SCR_DIR/run_analyze_queuesub.sh $VCF_DIR/freebayes_all.vcf.filtrd $VCF_DIR/mpileup_all.vcf.filtrd $OUT_DIR/snp_stats.txt"
#sbatch $SCR_DIR/run_analyze_queuesub.sh $VCF_DIR/freebayes_all.vcf.filtrd $VCF_DIR/mpileup_all.vcf.filtrd $OUT_DIR/snp_stats.txt
$SCR_DIR/run_analyze_queuesub.sh $VCF_DIR/freebayes_all.vcf.filtrd $VCF_DIR/mpileup_all.vcf.filtrd $OUT_DIR/snp_stats.txt