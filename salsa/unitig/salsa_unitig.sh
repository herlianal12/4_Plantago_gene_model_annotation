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
UNITIGS='/fast/users/a1697274/snakemake/bioinformatics/salsa/unitig/Po.unitigs.fasta'
UNITIGS_LENGTH='/fast/users/a1697274/snakemake/bioinformatics/salsa/unitig/Po.unitigs.fasta.fai'
UNITIGS_BAM='/fast/users/a1697274/snakemake/bioinformatics/salsa/unitig/paired/Povata-HiC_combined.bam'
UNITIGS_BED='/fast/users/a1697274/snakemake/bioinformatics/salsa/unitig/paired/Povata-HiC_combined.bed'
UNITIGS_SORTED_BED='/fast/users/a1697274/snakemake/bioinformatics/salsa/unitig/paired/Povata-HiC_combined_sorted.bed'
UNITIGS_SCAFFOLDS='/fast/users/a1697274/snakemake/bioinformatics/salsa/unitig/scaffold'
UNITIGS_GRAPH='/fast/users/a1697274/snakemake/bioinformatics/salsa/unitig/Po.unitigs.gfa'
TMP='/fast/users/a1697274/snakemake/bioinformatics/salsa/unitig/tmp'

### Creating and sorting bed file

#$BAMtoBED -i $UNITIGS_BAM  > $UNITIGS_BED
#sort -k 4 -T $TMP $UNITIGS_BED > $UNITIGS_SORTED_BED

### Getting unitig length

$SAMTOOLS faidx $UNITIGS > $UNITIGS_LENGTH

### Scaffolding using unitig

$PYTHON $SALSA -a $UNITIGS -l $UNITIGS_LENGTH -b $UNITIGS_SORTED_BED -e $ENZYME -o $UNITIGS_SCAFFOLDS -m yes -g $UNITIGS_GRAPH



