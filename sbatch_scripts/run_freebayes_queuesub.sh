#!/bin/sh

# USAGE: run_freebayes_queuesub.sh reference bam_dir output_dir

#SBATCH --account=def-emandevi
#SBATCH --time=0-03:00:00 ## days-hours:minutes:seconds
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4 # number of threads
#SBATCH --mem=16000 # requested memory (in MB)

## Load modules (including "helper" modules)
module load nixpkgs/16.09  gcc/7.3.0 freebayes/1.2.0

echo "Running freebayes for $1 and $2..."

REF=$1
BAM_DIR=$2
OUT_DIR=$3
BAM_LIST="/tmp/bams473874.list"

# Generate list of files in dir
rm -f $BAM_LIST
for bam in $BAM_DIR/*.sorted.rg.bam; do
    echo $bam >> $BAM_LIST
done

freebayes -f $REF -L $BAM_LIST > $OUT_DIR'/freebayes_all.vcf'

echo "All done now"