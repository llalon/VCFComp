#!/bin/sh

# USAGE: run_mpileup_queuesub.sh reference bam_dir output_dir

#SBATCH --account=def-emandevi
#SBATCH --time=0-03:00:00 ## days-hours:minutes:seconds
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4 # number of threads
#SBATCH --mem=16000 # requested memory (in MB)

module load bcftools

REF=$1
BAM_DIR=$2
OUT_DIR=$3

echo "Running mpileup for all bams in $BAM_DIR with $REF"

mkdir -p $OUT_DIR

bcftools mpileup -a DP,AD -f $REF $BAM_DIR/*.sorted.bam \
| bcftools call -m --variants-only \
> $OUT_DIR'/mpileup_all.vcf'

echo "All done now"