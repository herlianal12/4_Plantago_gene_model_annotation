#!/bin/bash
#SBATCH --partition batch
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --time 05:00:00
#SBATCH --mem 1G

# Notification configuration
#SBATCH --mail-type=FAIL, END
#SBATCH --mail-user=lina.herliana@adelaide.edu.au

module load Java/11.0.6

#/fast/users/a1697274/snakemake/.conda/envs/assembly/bin/bam2fastq -c 9 /fast/users/a1697274/snakemake/tutorial/assembly/plantago_genome_sequences/sequel/m54078_170831_060817.subreads.bam -o /fast/users/a1697274/snakemake/tutorial/assembly/m54078_170831_060817.subreads

/fast/users/a1697274/snakemake/.conda/envs/assembly/bin/cramtools cram --input-bam-file /fast/users/a1697274/snakemake/tutorial/assembly/mapped_reads/m54078_170831_060817.subreads.bam --output-cram-file /fast/users/a1697274/snakemake/tutorial/assembly/mapped_reads/m54078_170831_060817.subreads.cram
