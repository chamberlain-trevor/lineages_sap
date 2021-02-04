#!/bin/bash

# $1=species 3-letter name.

#If absent, make dna folder
dir_check=$(ls -d dna)
if [ "$dir_check" == "" ]
then
    echo "Creating folder dna"
    mkdir dna
fi

#If absent, make species directory in dna folder
dir_check=$(ls -d dna/$1)
if [ "$dir_check" == "" ]
then
    echo "Creating folder dna/$1"
    mkdir dna/$1
fi

echo "Sorting protein sequences into new files..."

for gene in ND1 ND2 COI COII ATPase_8 ATPase_6 COIII ND3 ND4L ND4 ND5 ND6 Cyt_b
do
    #define the gene name (gn) that will go into resulting filenames.

    if [ "$gene" == "ND1" ]
    then
        gn=$(echo "nd1")
    fi

    if [ "$gene" == "ND2" ]
    then
        gn=$(echo "nd2")
    fi

    if [ "$gene" == "COI" ]
    then
        gn=$(echo "cox1")
    fi

    if [ "$gene" == "COII" ]
    then
        gn=$(echo "cox2")
    fi

    if [ "$gene" == "ATPase_8" ]
    then
        gn=$(echo "atp8")
    fi

    if [ "$gene" == "ATPase_6" ]
    then
        gn=$(echo "atp6")
    fi

    if [ "$gene" == "COIII" ]
    then
        gn=$(echo "cox3")
    fi

    if [ "$gene" == "ND3" ]
    then
        gn=$(echo "nd3")
    fi

    if [ "$gene" == "ND4L" ]
    then
        gn=$(echo "nd4l")
    fi

    if [ "$gene" == "ND4" ]
    then
        gn=$(echo "nd4")
    fi

    if [ "$gene" == "ND5" ]
    then
        gn=$(echo "nd5")
    fi

    if [ "$gene" == "ND6" ]
    then
        gn=$(echo "nd6")
    fi

    if [ "$gene" == "Cyt_b" ]
    then
        gn=$(echo "cytb")
    fi

    #the underscore needs to be removed from each gene name.
    name=$(echo $gene | sed s/"_"/" "/g)

    #To cut out genes, it requires linearizing the file, searching, cutting out.
    #cat mtdna.$1.refseq_genes.fa | sed -e "/^>/s/$/?/" -e "s/^>/@/" | tr -d "\n" | sed -e 's/?/\'$'\n/g' | sed -e 's/@/\'$'\n>/g' | grep -A 1 "^>${name}" | head -n 2 | sed s/"^>.*$"/">${gn}\|${2}"/g > dna/$1/$gn.$1.dna.fasta
    cat mitoannotator/*.$1.*.fa | sed -e "/^>/s/$/?/" -e "s/^>/@/" | tr -d "\n" | sed -e 's/?/\'$'\n/g' | sed -e 's/@/\'$'\n>/g' | grep -A 1 "^>${name} " | head -n 2 | sed s/"^>.*$"/">${gn}\|${2}"/g > dna/$1/$gn.$1.dna.fasta

done
echo "Fin."
