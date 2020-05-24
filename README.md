# Genome Assembly and RNAseq Analysis Workflows in Plantago ovata

This repository is aimed to document, develop, and test pipelines for genome assembly and RNAseq analysis. The pipelines are written in Snakemake workflow management. Information about rules in snakemake can be obtained in this website https://snakemake.readthedocs.io/en/stable/. Snakefile templates and other files required for running snakemake in High Performance Computer (HPC) can be downloaded from https://github.com/UofABioinformaticsHub/snakemake_template.

There are 10 Snakefiles. Snakefile_assembly contains rules for genome assembly. Snakefile_paired_stranded_illumina_1, Snakefile_paired_stranded_illumina_2, Snakefile_single_stranded_illumina, Snakefile_single_unstranded_illumina, Snakefile_single_unstranded_454 and Snakefile_paired_unstranded_illumina are rules for generating transcript from 6 different groups of RNAseq data. These six Snakefiles need to be executed first before running Snakefile_gene_model_RNA and Snakefile_gene_model_protein. Since there are differences between two gene models, Snakefile_gene_model_compared are created to get information about non coding RNA.

All softwares or modules to execute Snakefiles are listed in envs/envs.yaml, while config.yaml stores information about sample names, file and directory paths that can be accessed by Snakefiles.

RNAseq data were collected from Burton Lab, The University of Adelaide and public data in Sequence Read Archive (SRA) NCBI website. All detail information can be seen in Plantago data summary.xlsx (https://universityofadelaide.box.com/shared/static/b9ik8rg9z5u5wttlaiq30kq1xck2kssb.xlsx).


## Setup Required Input Data

We don't want to store massive files in git repositories, so here are instructions on where to obtain the input files required for running the Snakemake workflows.

```bash 

## Make directories to store downloaded files

mkdir references
mkdir -p assembly/index_HiC
mkdir -p assembly/plantago_genome_sequences/sequel
mkdir -p assembly/plantago_genome_sequences/HiC
mkdir -p paired_stranded_illumina_1/raw_reads
mkdir -p paired_strande_illumina_2/raw_reads
mkdir -p single_stranded_illumina/raw_reads
mkdir -p single_unstranded_illumina/raw_reads
mkdir -p single_unstranded_454/raw_reads
mkdir -p paired_unstranded_illumina/raw_reads
mkdir database_rrna
mkdir -p gene_model_RNA/gene_model
mkdir -p gene_model_protein/annotation/pfam
mkdir -p gene_model_protein/annotation/uniprot
mkdir -p gene_model_compared/gene_model/rnacentral

```

```bash

# Get raw data

bash genome_assembly.sh
bash genome_sequences.sh
bash paired_stranded_illumina_1.sh
bash paired_stranded_illumina_2.sh
bash single_stranded_illumina.sh
bash single_unstranded_illumina.sh
bash single_unstranded_454.sh
bash paired_unstranded_illumina.sh

```

```bash

# Get Plantago mitocondria and chloroplast genome sequences (originally downloaded from NCBI website)
bash mito_chlro_genome.sh

# Get rRNA sequences
bash rRNA_sequences.sh

# Get a list of transcript paths from different RNAseq groups
bash assemblies.sh

# Get uniprot and pfam databases and trinotate template

## If you have installed Trinotate software, you can run this script below:

Build_Trinotate_Boilerplate_SQLite_db.pl  Trinotate # may not be working as they update the databases

## Or you can download directly from the website

bash trinotate.sh

# Get non-coding RNA sequences

bash non_coding_RNA.sh

```

```bash

## Run snakemake

conda activate snakemake
module load Anaconda3 Singularity

## Run these workflows in order and use dryrun mode first to detect any problem related to snakemake rules

### 1st workflow
snakemake --dryrun --snakefile Snakefile_assembly
snakemake --profile profiles/slurm --use-singularity --snakefile Snakefile_assembly

### 2nd workflow 
snakemake --dryrun --snakefile Snakefile_paired_stranded_illumina_1
snakemake --dryrun --snakefile Snakefile_paired_stranded_illumina_2
snakemake --dryrun --snakefile Snakefile_single_stranded_illumina
snakemake --dryrun --snakefile Snakefile_single_unstranded_illumina
snakemake --dryrun --snakefile Snakefile_single_unstranded_454
snakemake --dryrun --snakefile Snakefile_paired_unstranded_illumina

snakemake --profile profiles/slurm --use-singularity --snakefile Snakefile_paired_stranded_illumina_1
snakemake --profile profiles/slurm --use-singularity --snakefile Snakefile_paired_stranded_illumina_2
snakemake --profile profiles/slurm --use-singularity --snakefile Snakefile_single_stranded_illumina
snakemake --profile profiles/slurm --use-singularity --snakefile Snakefile_single_unstranded_illumina
snakemake --profile profiles/slurm --use-singularity --snakefile Snakefile_single_unstranded_454
snakemake --profile profiles/slurm --use-singularity --snakefile Snakefile_paired_unstranded_illumina

### 3rd workflow
snakemake --dryrun --snakefile Snakefile_gene_model_RNA
snakemake --profile profiles/slurm --use-singularity --snakefile Snakefile_gene_model_RNA

### 4th workflow
snakemake --dryrun --snakefile Snakefile_gene_model_protein
snakemake --profile profiles/slurm --use-singularity --snakefile Snakefile_gene_model_protein

### 5th workflow
snakemake --dryrun --snakefile Snakefile_gene_model_compared
snakemake --profile profiles/slurm --use-singularity --snakefile Snakefile_gene_model_compared
```
