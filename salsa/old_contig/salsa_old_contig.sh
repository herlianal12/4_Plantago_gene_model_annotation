#!/bin/bash
#SBATCH --partition batch
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 10
#SBATCH --time 72:00:00
#SBATCH --mem 10G

# Notification configuration
#SBATCH --mail-type=FAIL, END
#SBATCH --mail-user=lina.herliana@adelaide.edu.au

#'Sau3AI' : ['GATC', 'CTAG']
#https://github.com/marbl/SALSA

SALSA='/fast/users/a1697274/snakemake/bioinformatics/salsa/SALSA/run_pipeline.py'
PYTHON='/fast/users/a1697274/snakemake/.conda/envs/salsa2/bin/python2.7'
BAMtoBED='/fast/users/a1697274/snakemake/.conda/envs/assembly/bin/bamToBed'
SAMTOOLS='/fast/users/a1697274/snakemake/.conda/envs/assembly/bin/samtools'
ENZYME='GATC'
CONTIGS='/fast/users/a1697274/snakemake/bioinformatics/salsa/old_contig/Plantago.fasta'
CONTIGS_LENGTH='/fast/users/a1697274/snakemake/bioinformatics/salsa/old_contig/Plantago.fasta.fai'
CONTIGS_BAM='/fast/users/a1697274/snakemake/bioinformatics/salsa/old_contig/paired/Povata-HiC_combined.bam'
CONTIGS_BED='/fast/users/a1697274/snakemake/bioinformatics/salsa/old_contig/paired/Povata-HiC_combined.bed'
CONTIGS_SORTED_BED='/fast/users/a1697274/snakemake/bioinformatics/salsa/old_contig/paired/Povata-HiC_combined_sorted.bed'
CONTIGS_SCAFFOLDS='/fast/users/a1697274/snakemake/bioinformatics/salsa/old_contig/scaffold'
TMP='/fast/users/a1697274/snakemake/bioinformatics/salsa/old_contig/tmp'


### Creating and sorting bed file

#$BAMtoBED -i $CONTIGS_BAM  > $CONTIGS_BED
#sort -k 4 -T $TMP $CONTIGS_BED > $CONTIGS_SORTED_BED

### Getting unitig length

#$SAMTOOLS faidx $CONTIGS > $CONTIGS_LENGTH

### Option 2
$PYTHON $SALSA -a $CONTIGS -l $CONTIGS_LENGTH -b $CONTIGS_SORTED_BED -e $ENZYME -o $CONTIGS_SCAFFOLDS -m yes



