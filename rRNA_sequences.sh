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
