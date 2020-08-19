#!/bin/bash
#SBATCH --partition batch
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 5
#SBATCH --time 24:00:00
#SBATCH --mem 5G

# Notification configuration
#SBATCH --mail-type=FAIL, END
#SBATCH --mail-user=lina.herliana@adelaide.edu.au


#gunzip Povata-HiC_combined_R1.fastq.gz

#gunzip Povata-HiC_combined_R2.fastq.gz

/fast/users/a1697274/snakemake/.conda/envs/snakemake/bin/bgzip -c -l 9 Povata-HiC_combined_R1.fastq > Povata-HiC_combined_R1.fastq.gz

/fast/users/a1697274/snakemake/.conda/envs/snakemake/bin/bgzip -c -l 9 Povata-HiC_combined_R2.fastq > Povata-HiC_combined_R2.fastq.gz



