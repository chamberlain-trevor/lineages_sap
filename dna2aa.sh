#!/bin/bash

# $1=species 3-letter name.
# $2=Genus_species - only needed if dna files were direct downloads

#If absent, make aa folder
dir_check=$(ls -d aa)
if [ "$dir_check" == "" ]
then
    echo "Creating folder aa"
    mkdir aa
fi

#If absent, make species directory in aa folder
dir_check=$(ls -d aa/$1)
if [ "$dir_check" == "" ]
then
    echo "Creating folder aa/$1"
    mkdir aa/$1
fi

for gene in nd1 nd2 cox1 cox2 atp8 atp6 cox3 nd3 nd4l nd4 nd5 nd6 cytb
do
    if [ "$2" != "" ]
    then
        echo ">$gene|${2}" > dna/$1/1$gene.$1.dna.fasta
        cat dna/$1/$gene.$1.dna.fasta | grep -v "^>" | tr -d "\n" >> dna/$1/1$gene.$1.dna.fasta
        echo "" >> dna/$1/1$gene.$1.dna.fasta
        rm dna/$1/$gene.$1.dna.fasta
        mv dna/$1/1$gene.$1.dna.fasta dna/$1/$gene.$1.dna.fasta
    fi

    echo "Translating ${gene}..."

    #bp=total length of nucleotide sequence
    bp=$(cat dna/$1/$gene.$1.dna.fasta | grep -v "^>" | tr -d "\n" | wc -c)
    bp=$(( ${bp} ))
    #set the nucleotide interval to a variable
    e=$(( 3 ))

    #create a fasta header, also blanks the file       
    cat dna/$1/$gene.$1.dna.fasta | head -n 1 > aa/$1/$gene.$1.aa.fasta

    #Start loop translating each codon.
    while [ $e -le ${bp} ]
    do
        codon=$(cat dna/$1/$gene.$1.dna.fasta | grep -v "^>" | tr -d "\n" | head -c $e | tail -c 3)

        if [[ $codon == "TTT" ]] || [[ $codon == "TTC" ]]
        then
            echo "F" | tr -d "\n" >> aa/$1/$gene.$1.aa.fasta
        fi


        if [[ $codon == "TTA" ]] || [[ $codon == "TTG" ]] || [[ $codon == "CTT" ]] || [[ $codon == "CTC" ]] || [[ $codon == "CTA" ]] || [[ $codon == "CTG" ]]
        then
            echo "L" | tr -d "\n" >> aa/$1/$gene.$1.aa.fasta
        fi


        if [[ $codon == "ATT" ]] || [[ $codon == "ATC" ]]
        then
            echo "I" | tr -d "\n" >> aa/$1/$gene.$1.aa.fasta
        fi


        if [[ $codon == "ATA" ]] || [[ $codon == "ATG" ]]
        then
            echo "M" | tr -d "\n" >> aa/$1/$gene.$1.aa.fasta
        fi


        if [[ $codon == "GTT" ]] || [[ $codon == "GTC" ]] || [[ $codon == "GTA" ]] || [[ $codon == "GTG" ]]
        then
            echo "V" | tr -d "\n" >> aa/$1/$gene.$1.aa.fasta
        fi


        if [[ $codon == "TCT" ]] || [[ $codon == "TCC" ]] || [[ $codon == "TCA" ]] || [[ $codon == "TCG" ]] || [[ $codon == "AGT" ]] || [[ $codon == "AGC" ]]
        then
            echo "S" | tr -d "\n" >> aa/$1/$gene.$1.aa.fasta
        fi


        if [[ $codon == "CCT" ]] || [[ $codon == "CCC" ]] || [[ $codon == "CCA" ]] || [[ $codon == "CCG" ]]
        then
            echo "P" | tr -d "\n" >> aa/$1/$gene.$1.aa.fasta
        fi


        if [[ $codon == "ACT" ]] || [[ $codon == "ACC" ]] || [[ $codon == "ACA" ]] || [[ $codon == "ACG" ]]
        then
            echo "T" | tr -d "\n" >> aa/$1/$gene.$1.aa.fasta
        fi


        if [[ $codon == "GCT" ]] || [[ $codon == "GCC" ]] || [[ $codon == "GCA" ]] || [[ $codon == "GCG" ]]
        then
            echo "A" | tr -d "\n" >> aa/$1/$gene.$1.aa.fasta
        fi


        if [[ $codon == "TAT" ]] || [[ $codon == "TAC" ]]
        then
            echo "Y" | tr -d "\n" >> aa/$1/$gene.$1.aa.fasta
        fi


        if [[ $codon == "TAA" ]] || [[ $codon == "TAG" ]] || [[ $codon == "AGA" ]] || [[ $codon == "AGG" ]]
        then
            echo "*" | tr -d "\n" >> aa/$1/$gene.$1.aa.fasta
        fi


        if [[ $codon == "CAT" ]] || [[ $codon == "CAC" ]]
        then
            echo "H" | tr -d "\n" >> aa/$1/$gene.$1.aa.fasta
        fi


        if [[ $codon == "CAA" ]] || [[ $codon == "CAG" ]]
        then
            echo "Q" | tr -d "\n" >> aa/$1/$gene.$1.aa.fasta
        fi


        if [[ $codon == "AAT" ]] || [[ $codon == "AAC" ]]
        then
            echo "N" | tr -d "\n" >> aa/$1/$gene.$1.aa.fasta
        fi


        if [[ $codon == "AAA" ]] || [[ $codon == "AAG" ]]
        then
            echo "K" | tr -d "\n" >> aa/$1/$gene.$1.aa.fasta
        fi


        if [[ $codon == "GAT" ]] || [[ $codon == "GAC" ]]
        then
            echo "D" | tr -d "\n" >> aa/$1/$gene.$1.aa.fasta
        fi


        if [[ $codon == "GAA" ]] || [[ $codon == "GAG" ]]
        then
            echo "E" | tr -d "\n" >> aa/$1/$gene.$1.aa.fasta
        fi


        if [[ $codon == "TGT" ]] || [[ $codon == "TGC" ]]
        then
            echo "C" | tr -d "\n" >> aa/$1/$gene.$1.aa.fasta
        fi


        if [[ $codon == "TGA" ]] || [[ $codon == "TGG" ]]
        then
            echo "W" | tr -d "\n" >> aa/$1/$gene.$1.aa.fasta
        fi


        if [[ $codon == "CGT" ]] || [[ $codon == "CGC" ]] || [[ $codon == "CGA" ]] || [[ $codon == "CGG" ]]
        then
            echo "R" | tr -d "\n" >> aa/$1/$gene.$1.aa.fasta
        fi


        if [[ $codon == "GGT" ]] || [[ $codon == "GGC" ]] || [[ $codon == "GGA" ]] || [[ $codon == "GGG" ]]
        then
            echo "G" | tr -d "\n" >> aa/$1/$gene.$1.aa.fasta
        fi

        e=$(( $e + 3 ))
    done
    cat aa/$1/$gene.$1.aa.fasta | sed s/"\*$"/""/g > aa/$1/1$gene.$1.aa.fasta 
    rm aa/$1/$gene.$1.aa.fasta
    mv aa/$1/1$gene.$1.aa.fasta aa/$1/$gene.$1.aa.fasta
    echo "" >> aa/$1/$gene.$1.aa.fasta
done
echo "Fin."
