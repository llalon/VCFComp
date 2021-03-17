#!/bin/sh

# USAGE: run_filter_queuesub.sh vcf_dir

#SBATCH --account=def-emandevi
#SBATCH --time=0-03:00:00 ## days-hours:minutes:seconds
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4 # number of threads
#SBATCH --mem=16000 # requested memory (in MB)

## Load modules (including "helper" modules)
module load nixpkgs/16.09  gcc/7.3.0 freebayes/1.2.0

VCF_DIR=$1

echo "Filtering VCFs.."

for vcf in $VCF_DIR/*.vcf; do
    echo $vcf
    fout=$vcf.filtrd

    vcffilter -f "QUAL > 20" $vcf > $fout

done

echo "All done now"