wget "https://data.broadinstitute.org/Trinity/Trinotate_v3_RESOURCES/Trinotate_v3.sqlite.gz" \
-O gene_model_protein/annotation/Trinotate.sqlite.gz &&
gunzip gene_model_protein/annotation/Trinotate.sqlite.gz

wget "https://data.broadinstitute.org/Trinity/Trinotate_v3_RESOURCES/Pfam-A.hmm.gz" \
-O gene_model_protein/annotation/pfam/Pfam-A.hmm.gz &&
gunzip gene_model_protein/annotation/pfam/Pfam-A.hmm.gz

wget "https://data.broadinstitute.org/Trinity/Trinotate_v3_RESOURCES/uniprot_sprot.pep.gz" \
-O gene_model_protein/annotation/uniprot/uniprot_sprot.pep.gz &&
gunzip gene_model_protein/annotation/uniprot/uniprot_sprot.pep.gz
