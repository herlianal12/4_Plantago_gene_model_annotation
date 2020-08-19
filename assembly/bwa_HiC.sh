#!/bin/bash
#SBATCH --partition batch
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --time 05:00:00
#SBATCH --mem 1G

# Notification configuration
#SBATCH --mail-type=FAIL, END
#SBATCH --mail-user=lina.herliana@adelaide.edu.au



#/fast/users/a1697274/snakemake/.conda/envs/assembly/bin/bwa mem -5SP /fast/users/a1697274/snakemake/tutorial/assembly/index_HiC/Plantago.fasta /fast/users/a1697274/snakemake/tutorial/assembly/plantago_genome_sequences/HiC/Povata-HiC_combined_R1.fastq.gz /fast/users/a1697274/snakemake/tutorial/assembly/plantago_genome_sequences/HiC/Povata-HiC_combined_R2.fastq.gz | /fast/users/a1697274/snakemake/.conda/envs/assembly/bin/samtools view -S -h -b -F 2316 | /fast/users/a1697274/snakemake/.conda/envs/assembly/bin/samtools sort --threads 2 -l 7 -o /fast/users/a1697274/snakemake/tutorial/assembly/mapped_reads_HiC/Povata-HiC_combined.bam

/fast/users/a1697274/snakemake/.conda/envs/assembly/bin/bwa index -a bwtsw -p Plantago /fast/users/a1697274/snakemake/tutorial/assembly/index_HiC/Plantago.fasta
