# Gene model and functional annotation workflows for *Plantago ovata*

This repository is aimed to document, develop, and test pipelines for generating gene models and annotation for *Plantago ovata*. The pipelines are written in Snakemake workflow management. Information about rules in snakemake can be obtained on this website https://snakemake.readthedocs.io/en/stable/. Snakefile templates and other files required for running snakemake in High Performance Computer (HPC) can be downloaded from https://github.com/UofABioinformaticsHub/snakemake_template.

There are 8 Snakefiles. Snakefile_paired_stranded_illumina_1, Snakefile_paired_stranded_illumina_2, Snakefile_single_stranded_illumina, Snakefile_single_unstranded_illumina, Snakefile_single_unstranded_454 and Snakefile_paired_unstranded_illumina are rules for generating transcript from 6 different groups of RNAseq data. These six Snakefiles need to be executed first before running Snakefile_gene_model.

All tools or modules to execute Snakefiles are stored in folder envs, while config.yaml stores information about sample names, file and directory paths that can be accessed by Snakefiles.


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

![dag](https://user-images.githubusercontent.com/57382343/214975083-ba582a19-0938-49dd-a601-7ca964b602ca.png)

## Setup Required Input Data

We do not want to store massive files in git repositories, so here are instructions on obtaining the input files required for running the Snakemake workflows.

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
mkdir -p gene_model/gene_model
mkdir -p gene_model/annotation/pfam
mkdir -p gene_model/annotation/uniprot

```

```bash

# Get raw data

Publicly available datasets:
SRA:SRR14643399; SRA:SRR14643400; SRA:SRR14643401; SRA:SRR14643402; SRA:SRR14643403; SRA:SRR14643404; SRA:SRR14643405; SRA:SRR14643406; SRA:SRR14643407; SRA:SRR14643408; SRA:SRR14643409; SRA:SRR14643410; SRA:SRR14643411; SRA:SRR14643412; SRA:SRR14643413; SRA:SRR14643414; SRA:SRR14643415; SRA:SRR14643416; SRA:SRR14643417; SRA:SRR14643418; SRA:SRR14643419; SRA:SRR14643420; SRA:SRR14643421; SRA:SRR14643422; SRA:SRR14643423; SRA:SRR14643424; SRA:SRR14643425; SRA:SRR14643426; SRA:SRR14643427; SRA:SRR14643428; SRA:SRR14643429; SRA:SRR14643430; SRA:SRR14643431; SRA:SRR14643432; SRA:SRR14643433; SRA:SRR14643434; SRA:SRR14643435; SRA:SRR14643436

Data generated from this study (link) and uploaded to SRA NCBI:
SRA:SRR06637; SRA:SRR066374; SRA:SRR066375; SRA:SRR066376; SRA:SRR342350; SRA:SRR342351; SRA:SRR629688; SRA:SRR1311174; SRA:SRR1311175; SRA:SRR1311176; SRA:SRR1311177; SRA:SRR3883622 SRA:SRR3883620; SRA:SRR3883621; SRA:SRR3883618; SRA:SRR3883619; SRA:SRR3885726; SRA:SRR3885727; SRA:SRR3885728; SRA:SRR5434206; SRA:SRR5434207; SRA:SRR5434208; SRA:SRR5434209; SRA:SRR5434211; SRA:SRR5434210; SRA:SRR5434213; SRA:SRR5434212

# RNAseq data mining
Several ways to download SRA:
1.	Downloading from the website (https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=search_seq_name)
2.	Downloading from terminal using curl or wget
3.	Downloading from terminal using SRA toolkits (https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=software)
4.	Downloading with the help ascp-path (download Aspera connect)
5.	Using this script (https://github.com/UofABioinformaticsHub/nathan_sysadmin_scripts/blob/master/general_script/sra_downloader.sh)
Copy the script then use nano to create file SRA_Nathan, making the script executable chmod tx SRA_Nathan, inside the directory where we save the script, run it by typing ./SRA_Nathan –a SRR10076762 –o SRR10076762 

# Extract fastq files from downloaded SRR files

an example:

./fastq-dump --skip-technical --split-3 --origfmt  --gzip SRRXXX

# How to upload raw data to SRA NCBI

Follow this guideline from NCBI (https://submit.ncbi.nlm.nih.gov/about/sra/)
```

```bash

# Get Plantago mitochondrial gene and chloroplast genome sequences
Plantago chloroplast genome can be found at https://www.ncbi.nlm.nih.gov/nuccore/MH205737.1/ and a mitochondrial gene is in here https://www.ncbi.nlm.nih.gov/nuccore/EU069524.1/.

# Get rRNA sequences

   
wget "https://www.arb-silva.de/fileadmin/silva_databases/release_128/Exports/SILVA_128_LSURef_tax_silva.fasta.gz" \
-O database_rrna/SILVA_128_LSURef_tax_silva.fasta.gz && gunzip database_rrna/SILVA_128_LSURef_tax_silva.fasta.gz

wget "https://www.arb-silva.de/fileadmin/silva_databases/release_138/Exports/SILVA_138_SSURef_NR99_tax_silva.fasta.gz" \
-O database_rrna/SILVA_138_SSURef_NR99_tax_silva.fasta.gz && gunzip database_rrna/SILVA_138_SSURef_NR99_tax_silva.fasta.gz

wget "https://www.arb-silva.de/fileadmin/silva_databases/release_138/Exports/SILVA_138_SSURef_tax_silva.fasta.gz" \
-O database_rrna/SILVA_138_SSURef_tax_silva.fasta.gz && gunzip database_rrna/SILVA_138_SSURef_tax_silva.fasta.gz

wget "https://www.arb-silva.de/fileadmin/silva_databases/release_138/Exports/SILVA_138_SSURef_tax_silva.fasta.gz" \
-O database/SILVA_138_SSURef_tax_silva.fasta.gz && gunzip database/SILVA_138_SSURef_tax_silva.fasta.gz

wget "http://combio.pl/rrna/static/download/Archaea.fasta" \
-O database_rrna/Archaea.fasta

wget "http://combio.pl/rrna/static/download/Bacteria.fasta" \
-O database_rrna/Bacteria.fasta

wget "http://combio.pl/rrna/static/download/Mitochondria.fasta" \
-O database_rrna/Mitochondria.fasta

wget "http://combio.pl/rrna/static/download/Plastids.fasta" \
-O database_rrna/Plastids.fasta

wget "http://combio.pl/rrna/static/download/Eukaryota.fasta" \
-O database_rrna/Eukaryota.fasta


# Get Uniprot and Pfam databases and trinotate template

## If you have installed Trinotate software, you can run this script below:

Build_Trinotate_Boilerplate_SQLite_db.pl  Trinotate # may not be working as they update the databases

## Or you can download directly from the website

wget "https://data.broadinstitute.org/Trinity/Trinotate_v3_RESOURCES/Trinotate_v3.sqlite.gz" \
-O gene_model_protein/annotation/Trinotate.sqlite.gz &&
gunzip gene_model_protein/annotation/Trinotate.sqlite.gz

wget "https://data.broadinstitute.org/Trinity/Trinotate_v3_RESOURCES/Pfam-A.hmm.gz" \
-O gene_model_protein/annotation/pfam/Pfam-A.hmm.gz &&
gunzip gene_model_protein/annotation/pfam/Pfam-A.hmm.gz

wget "https://data.broadinstitute.org/Trinity/Trinotate_v3_RESOURCES/uniprot_sprot.pep.gz" \
-O gene_model_protein/annotation/uniprot/uniprot_sprot.pep.gz &&
gunzip gene_model_protein/annotation/uniprot/uniprot_sprot.pep.gz

## STAR index

STAR \
  --runMode genomeGenerate \
  --runThreadN 2 \
  --genomeDir references/STAR \
  --genomeSAindexNbases 12 \
  --genomeFastaFiles Plantago_ovata_ncbi.fasta

```

```bash

## Run snakemake

conda activate snakemake
module load Anaconda3 Singularity

## Run these workflows in order and use dry-run mode first to detect any problem related to snakemake rules

### 1st workflow 
snakemake --dry-run --snakefile Snakefile_paired_stranded_illumina_1
snakemake --dry-run --snakefile Snakefile_paired_stranded_illumina_2
snakemake --dry-run --snakefile Snakefile_single_stranded_illumina
snakemake --dry-run --snakefile Snakefile_single_unstranded_illumina
snakemake --dry-run --snakefile Snakefile_single_unstranded_454
snakemake --dry-run --snakefile Snakefile_paired_unstranded_illumina

snakemake --profile profiles/slurm --use-singularity --use-conda --snakefile Snakefile_paired_stranded_illumina_1
snakemake --profile profiles/slurm --use-singularity --use-conda --snakefile Snakefile_paired_stranded_illumina_2
snakemake --profile profiles/slurm --use-singularity --use-conda --snakefile Snakefile_single_stranded_illumina
snakemake --profile profiles/slurm --use-singularity --use-conda --snakefile Snakefile_single_unstranded_illumina
snakemake --profile profiles/slurm --use-singularity --use-conda --snakefile Snakefile_single_unstranded_454
snakemake --profile profiles/slurm --use-singularity --use-conda --snakefile Snakefile_paired_unstranded_illumina

### 2nd workflow
snakemake --dryrun --snakefile Snakefile_gene_model
snakemake --profile profiles/slurm --use-singularity --use-conda --snakefile Snakefile_gene_model

```

