#!/bin/sh

# Generates readgroups for freebayes and GATK and reindexes
# USAGE: run_gen_rq_queuesub.sh bam_directory

#SBATCH --account=def-emandevi
#SBATCH --time=0-03:00:00 ## days-hours:minutes:seconds
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4 # number of threads
#SBATCH --mem=16000 # requested memory (in MB)

module load samtools
module load picard

BAM_DIR=$1

echo "Generating read groups..."

i=0
for bam in $BAM_DIR/*.sorted.bam; do
    [ -e "$bam" ] || continue
    
    (( i += 1 ))
    
    echo "For $bam..."
    
    # Check for completion
    if samtools view -H $bam | grep -q '@RG'; then
        echo "Read group exists. Skipping..."
        continue
    fi
    
    # RG info
    ID=$i
    LB="lib1"
    PU="unit1"
    SM="bb$i"
    FOUT="$(echo $bam | cut -f1 -d'.').sorted.rg.bam"
    
    # Generate RG
    java -jar $EBROOTPICARD/picard.jar AddOrReplaceReadGroups \
    I=$bam \
    O=$FOUT \
    RGID=$ID RGLB=$LB RGPL=illumina \
    RGPU=$PU \
    RGSM=$SM
    
    # Re index
    samtools index $FOUT
    
done

echo "All done now"
