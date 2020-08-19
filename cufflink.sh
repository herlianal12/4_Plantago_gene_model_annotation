#!/bin/bash
#SBATCH --partition batch
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --time 01:00:00
#SBATCH --mem 1G

# Notification configuration
#SBATCH --mail-type=FAIL, END
#SBATCH --mail-user=lina.herliana@adelaide.edu.au


cuffmerge -p 5 -o paired_stranded_illumina_1/cufflink -s references/Plantago.fasta paired_stranded_illumina_1/cufflink/assemblies.txt

