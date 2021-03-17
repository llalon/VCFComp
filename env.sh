#!/bin/sh

# This script contains global variables for the project

# Root project dir
#ROOT_DIR='/scratch/llalon02/Project3/pthree'
ROOT_DIR='/scratch-deleted-2021-mar-20/llalon02/P3/pthree'

# The directory everything will be run out of
WORK_DIR=$ROOT_DIR'/work_dir'

# Data dir
DATA_DIR=$ROOT_DIR'/data'

# Directory for bam files
BAM_DIR=$DATA_DIR'/sorted_bams'

# VCF Folder
VCF_DIR=$DATA_DIR'/vcf'

# Stats outputs
OUT_DIR=$ROOT_DIR'/out'

# Reference genomes
REF=$DATA_DIR'/burbot_reference_genome/GCA_900302385.1_ASM90030238v1_genomic.fna'

# sbatch scripts
SCR_DIR=$ROOT_DIR'/sbatch_scripts'
