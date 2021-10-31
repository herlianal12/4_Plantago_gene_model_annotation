# Gene model and functional annotation workflows for *Plantago ovata*

This repository is aimed to document, develop, and test pipelines for generating gene model and annotation for Plantago ovata. The pipelines are written in Snakemake workflow management. Information about rules in snakemake can be obtained in this website https://snakemake.readthedocs.io/en/stable/. Snakefile templates and other files required for running snakemake in High Performance Computer (HPC) can be downloaded from https://github.com/UofABioinformaticsHub/snakemake_template.

There are 9 Snakefiles. Snakefile_paired_stranded_illumina_1, Snakefile_paired_stranded_illumina_2, Snakefile_single_stranded_illumina, Snakefile_single_unstranded_illumina, Snakefile_single_unstranded_454 and Snakefile_paired_unstranded_illumina are rules for generating transcript from 6 different groups of RNAseq data. These six Snakefiles need to be executed first before running Snakefile_gene_model_RNA and Snakefile_gene_model_protein.

All softwares or modules to execute Snakefiles are stored in folder envs, while config.yaml stores information about sample names, file and directory paths that can be accessed by Snakefiles.

RNAseq data were collected from Burton Lab, The University of Adelaide and public data in Sequence Read Archive (SRA) NCBI website.


## Overall workflow for generating gene model

1.	Quality control (fastqc and multiqc)
2.	Trimming reads (trimmomatic)
3.	Cleaning reads (bbmap)
4.	Aligning reads (star)
5.	Generating transcripts (cufflink)
6.	Merging transcripts to generate gene model (cufflink)
7.	Evaluating gene model using IGV

![Picture 1](https://user-images.githubusercontent.com/57382343/102685534-4f86d800-4231-11eb-8f43-cc7cc62d1f57.png)

## Overall workflow for generating gene annotation

![Picture 2](https://user-images.githubusercontent.com/57382343/102685569-aee4e800-4231-11eb-8d10-a161b88540e7.png)

## Setup Required Input Data

We don't want to store massive files in git repositories, so here are instructions on where to obtain the input files required for running the Snakemake workflows.

```bash 

## Make directories to store downloaded files

mkdir references
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

### 2nd workflow
snakemake --dryrun --snakefile Snakefile_gene_model_RNA
snakemake --profile profiles/slurm --use-singularity --snakefile Snakefile_gene_model_RNA

### 3rd workflow
snakemake --dryrun --snakefile Snakefile_gene_model_protein
snakemake --profile profiles/slurm --use-singularity --snakefile Snakefile_gene_model_protein

```

