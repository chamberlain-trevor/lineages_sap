#!/bin/bash

cat mtdna.$1.refseq.fasta | sed -e "/^>/s/$/?/" -e "s/^>/@/" | tr -d "\n" | sed -e 's/?/\'$'\n/g' | sed -e 's/@/\'$'\n>/g' | tail -n 2 > 1mtdna.$1.refseq.fasta
rm mtdna.$1.refseq.fasta
mv 1mtdna.$1.refseq.fasta mtdna.$1.refseq.fasta
echo "" >> mtdna.$1.refseq.fasta
