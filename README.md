# Genome Assembly and RNAseq Analysis Workflows in Plantago ovata

This repository is aimed to document, develop, and test genome assembly and RNAseq pipelines. The pipelines are written in Snakemake workflow management. Information about rules in snakemake can be obtained in this website https://snakemake.readthedocs.io/en/stable/. Snakefile templates and other files required for running snakemake in High Performance Computer (HPC) can be downloaded from https://github.com/UofABioinformaticsHub/snakemake_template.

There are 9 Snakefiles. Snakefile_assembly contains rules for genome assembly. Snakefile_paired_stranded_illumina, Snakefile_single_stranded_illumina, Snakefile_single_unstranded_illumina, Snakefile_single_unstranded_454 and Snakefile_paired_unstranded_illumina are rules for generating transcript from 5 different groups of RNAseq data. These five Snakefile need to be executed first before running Snakefile_gene_model_RNA and Snakefile_gene_model_protein. Since there are differences between two gene models, Snakefile_gene_model_compared are created to get information about non coding RNA.

All softwares or modules to execute Snakefiles are listed in envs/envs.yaml, while config.yaml stores information about sample names, file and directory paths that can be accessed by Snakefiles.


## Setup Required Input Data

We don't want to store massive files in git repositories, so here are instructions on where to obtain the input files required for running the Snakemake workflows.

```bash 

## Make directories to store downloaded files

mkdir references
mkdir -p assembly/index_HiC
mkdir -p assembly/plantago_genome_sequences/sequel
mkdir -p assembly/plantago_genome_sequences/HiC
mkdir -p paired_stranded_illumina/raw_reads
mkdir -p single_stranded_illumina/raw_reads
mkdir -p single_unstranded_illumina/raw_reads
mkdir -p single_unstranded_454/raw_reads
mkdir -p paired_unstranded_illumina/raw_reads
mkdir database_rrna
mkdir references
mkdir -p gene_model_RNA/gene_model
mkdir -p gene_model_protein/annotation/pfam
mkdir -p gene_model_protein/annotation/uniprot
mkdir -p gene_model_compared/gene_model/rnacentral

```

```bash

# Get genome assembly

wget "https://universityofadelaide.box.com/shared/static/vva52f3ysxqaxbcfowo9xjjy2wstosws.gz" \
-O references/Plantago.fasta.gz &&
cp references/Plantago.fasta.gz assembly/index_HiC/Plantago.fasta.gz

# Get genome sequences

wget "https://universityofadelaide.box.com/shared/static/oy61tcbe1rn46m2nlul7cuyiskp5izcb.bam" \
-O assembly/plantago_genome_sequences/sequel/m54078_170831_060817.subreads.bam

wget "https://universityofadelaide.box.com/shared/static/1nauyrqqbk92xeepq17nofcjm860htk7.bam" \
-O assembly/plantago_genome_sequences/sequel/m54078_170831_160707.subreads.bam

wget "https://universityofadelaide.box.com/shared/static/rzlij5h1rspberz2tecvh6na1bjuxq2e.bam" \
-O assembly/plantago_genome_sequences/sequel/m54078_170901_080645.subreads.bam

wget "https://universityofadelaide.box.com/shared/static/6ymddvhf232jfuu1zbsudx2z12jjshyn.bam" \
-O assembly/plantago_genome_sequences/sequel/m54078_170901_180552.subreads.bam

wget "https://universityofadelaide.box.com/shared/static/lcwt93wzmykc991iotnfu83vn4dve7m7.bam" \
-O assembly/plantago_genome_sequences/sequel/m54078_170902_041524.subreads.bam

wget "https://universityofadelaide.box.com/shared/static/k0hdaa9ht1tvvbp1sbgi16y4p9qj05z7.bam" \
-O assembly/plantago_genome_sequences/sequel/m54078_170902_142504.subreads.bam

wget "https://universityofadelaide.box.com/shared/static/sjdbp3m57p8su7t832gfdghiqk1befjy.bam" \
-O assembly/plantago_genome_sequences/sequel/m54078_170903_003441.subreads.bam

wget "https://universityofadelaide.box.com/shared/static/of44p9lrpmp0xgyba69rw1fzkilqx06g.gz" \
-O assembly/plantago_genome_sequences/HiC/Povata-HiC_combined_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/e11r2dbvm8t6ii95wl1x9x1mo5lltvlt.gz" \
-O assembly/plantago_genome_sequences/HiC/Povata-HiC_combined_R2.fastq.gz

```

```bash

# Get RNAseq data for paired_stranded_illumina group

## You may want to download one big file containing 48 files then extract them

wget "https://universityofadelaide.box.com/shared/static/bnq0ej5d7pjqk4ppcbblawsh330wzsdm.tar" \
-O paired_stranded_illumina/FAC6568.tar

## Or you can download 48 files separately (Sorry, I have not put the links)

```

```bash

# Get RNAseq data for single_stranded_illumina group

wget "https://universityofadelaide.box.com/shared/static/bwnfazo4gxyx7xppx9i17l8ggud6w74r.gz" \
-O single_stranded_illumina/raw_reads/7_C7N8UANXX_GAGTGG_L006_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/eoesy8a5fd45fj6i4dhrksifbplrwg2v.gz" \
-O single_stranded_illumina/raw_reads/8_C7N8UANXX_ACTGAT_L006_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/5savieljgrhwjbier6xrksivblb6f94w.gz" \
-O single_stranded_illumina/raw_reads/9_C7N8UANXX_ATTCCT_L006_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/gakcmehfkdkbeukalagvnzh7qqqra16l.gz" \
-O single_stranded_illumina/raw_reads/10_C7N8UANXX_ATCACG_L006_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/lpgcovcy2qzj1glofinxcyruqbyqzbah.gz" \
-O single_stranded_illumina/raw_reads/7_C7N8UANXX_GAGTGG_L007_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/1bh68ztio03dwves2ghvd52l5wj2dimm.gz" \
-O single_stranded_illumina/raw_reads/8_C7N8UANXX_ACTGAT_L007_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/mqxr6cz15v092eqv98xcohsoh4oqdjtk.gz" \
-O single_stranded_illumina/raw_reads/9_C7N8UANXX_ATTCCT_L007_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/162aswgrxd7ei8739ovvfo7gaqy8cbqr.gz" \
-O single_stranded_illumina/raw_reads/10_C7N8UANXX_ATCACG_L007_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/5uyawuuufwp512uc2la7127qwkowron1.gz" \
-O single_stranded_illumina/raw_reads/SRR5434206_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/02bbkgrfzr5eow45tvw2p05j7wggyvjl.gz" \
-O single_stranded_illumina/raw_reads/SRR5434207_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/vaevlvanvk1jrl7w823yx2armttljquy.gz" \
-O single_stranded_illumina/raw_reads/SRR5434208_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/zcy00je59620ioyardkajjxnwarxgvi7.gz" \
-O single_stranded_illumina/raw_reads/SRR5434209_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/ft7u4rhg0vwcrac83bxyrddlom17bqhb.gz" \
-O single_stranded_illumina/raw_reads/SRR5434210_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/krey6rrvw0pb9maye2rqwk5u5xcbbylw.gz" \
-O single_stranded_illumina/raw_reads/SRR5434211_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/4wigny9oh7lmoo2euoz0cbzc03qkuno2.gz" \
-O single_stranded_illumina/raw_reads/SRR5434212_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/lly63u555y89d5ioqfw5qlqv7q6sge0d.gz" \
-O single_stranded_illumina/raw_reads/SRR5434213_R1.fastq.gz

```

```bash

# Get RNAseq data for single_unstranded_illumina group

wget "https://universityofadelaide.box.com/shared/static/9s7rt8gayw769it6fvye379wzs68sxh5.gz" \
-O single_unstranded_illumina/raw_reads/JPo_1_C5697ACXX_CCGTCC_L005_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/4d0cv176k1bsjn6j5a41r6mvlzmhi2zc.gz" \
-O single_unstranded_illumina/raw_reads/JPo_2_C5697ACXX_GTCCGC_L005_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/q5qy8468pjtxp9uumgs7ebvuy6gqpc3e.gz" \
-O single_unstranded_illumina/raw_reads/JPo_3_C5697ACXX_GTGAAA_L005_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/2cud24aaduzaztsimt1yj8tbx6bm32r7.gz" \
-O single_unstranded_illumina/raw_reads/JPo_4_C5697ACXX_GTGGCC_L005_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/9swfx36x74dykpd61e14v23wucovwhns.gz" \
-O single_unstranded_illumina/raw_reads/SRR3883619_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/jjng70a8z8c61m6v4dk2xp2ytb6fk249.gz" \
-O single_unstranded_illumina/raw_reads/SRR3883620_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/j10vwc2vfqff13of6lakf7clilnesi6a.gz" \
-O single_unstranded_illumina/raw_reads/SRR3883621_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/r1r4bjqyzv05hfjhiocsrr0a8iu9sj4a.gz" \
-O single_unstranded_illumina/raw_reads/SRR3883622_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/r1r4bjqyzv05hfjhiocsrr0a8iu9sj4a.gz" \
-O single_unstranded_illumina/raw_reads/SRR3885726_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/a4wwoy2ano10r09twjofqgx51p5wy1fh.gz" \
-O single_unstranded_illumina/raw_reads/SRR3885727_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/k37jlio6laev8y2lubwepwwzcgn1qhau.gz" \
-O single_unstranded_illumina/raw_reads/SRR3885728_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/jjng70a8z8c61m6v4dk2xp2ytb6fk249.gz" \
-O single_unstranded_illumina/raw_reads/SRR3883618_R1.fastq.gz

```

```bash

# Get RNAseq data for single_unstranded_454 group

wget "https://universityofadelaide.box.com/shared/static/qcshvdyugkclb1atl85svhj01pj1bzg7.gz" \
-O single_unstranded_454/raw_reads/SRR066373_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/z5ynghb70x68ybivanbxnvxcvdz3s4ts.gz" \
-O single_unstranded_454/raw_reads/SRR1311174_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/ne2d5v2zjgcxv3scpuddrgmpyt0oebxv.gz" \
-O single_unstranded_454/raw_reads/SRR066374_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/usmwei8tq4sb0wnylyofrkzqv2o945ql.gz" \
-O single_unstranded_454/raw_reads/SRR1311175_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/v79gpmotx1wa6hanxioe466z1rq5tkr9.gz" \
-O single_unstranded_454/raw_reads/SRR342350_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/yv8zuyngjr0nkyiekg9vy8zwk6ojy2ms.gz" \
-O single_unstranded_454/raw_reads/SRR342351_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/fprv6brw1i4ao4snowyc3e7kqpuj78tl.gz" \
-O single_unstranded_454/raw_reads/SRR066375_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/e7km4dn3g22hmpk1pjdaxyxu3v4zb5sg.gz" \
-O single_unstranded_454/raw_reads/SRR1311176_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/vx6qzoq0bptu5odek06ad62zxnhcb7ik.gz" \
-O single_unstranded_454/raw_reads/SRR066376_R1.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/bt8tsjfkmyna6b0jdy0lcsnswuq5rnm4.gz" \
-O single_unstranded_454/raw_reads/SRR1311177_R1.fastq.gz

```

```bash

# Get RNAseq data for paired_stranded_illumina group

wget "https://universityofadelaide.box.com/shared/static/obhco9tq57wxwht6oglktlvzz5ps5b9v.gz" \
-O paired_unstranded_illumina/raw_reads/SRR629688_R1_001.fastq.gz

wget "https://universityofadelaide.box.com/shared/static/bsn5h8yr8p6k6d078ufn7txhwxp9g5gd.gz" \
-O paired_unstranded_illumina/raw_reads/SRR629688_R2_001.fastq.gz

```

```bash

# Get Plantago mitocondria and chloroplast genome sequences

## These sequences below are originally downloaded from NCBI website

wget "https://universityofadelaide.box.com/shared/static/j6of5tq8vo30mz7c0g75pw7c4wdww9cd.gz" \
-O references/NC_041421.1.fasta.gz && gunzip references/NC_041421.1.fasta.gz

wget "https://universityofadelaide.box.com/shared/static/om4z5jaibgzbc3o3eqw6d6ht8fj8vyn2.gz" \
-O references/plantago_chloroplast.fasta.gz && gunzip references/plantago_chloroplast.fasta.gz

wget "https://universityofadelaide.box.com/shared/static/02djpb8akzrkbb5ohmi3nfq4pabkco9s.gz" \
-O references/plantago_mitocondria.fasta.gz && gunzip references/plantago_mitocondria.fasta.gz

wget "https://universityofadelaide.box.com/shared/static/blby2wll8fj3dsi3xrgzwxjvf2jw4mq4.gz" \
-O references/MH165324.fasta.gz && gunzip references/MH165324.fasta.gz

```

```bash

# Get rrRNA sequences

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

```
```bash
# Get a list of transcript paths from different RNAseq groups

wget "https://universityofadelaide.box.com/shared/static/eek5fbz0uzpa6yl2wbe4diqumq0oprag.txt" \
-O gene_model_RNA/gene_model/assemblies.txt

```

```bash

# Get uniprot and pfam databases and trinotate template

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
```

```bash

# Get non-coding RNA sequences

wget "ftp://ftp.ebi.ac.uk/pub/databases/RNAcentral/releases/9.0/sequences/rnacentral_species_specific_ids.fasta.gz" \
-O gene_model_compared/gene_model/rnacentral/rnacentral_species_specific_ids.fasta.gz &&
gunzip gene_model_compared/gene_model/rnacentral/rnacentral_species_specific_ids.fasta.gz

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
snakemake --dryrun --snakefile Snakefile_paired_stranded_illumina
snakemake --dryrun --snakefile Snakefile_single_stranded_illumina
snakemake --dryrun --snakefile Snakefile_single_unstranded_illumina
snakemake --dryrun --snakefile Snakefile_single_unstranded_454
snakemake --dryrun --snakefile Snakefile_paired_unstranded_illumina

snakemake --profile profiles/slurm --use-singularity --snakefile Snakefile_paired_stranded_illumina
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
