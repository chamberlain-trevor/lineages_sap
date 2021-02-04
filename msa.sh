#!/bin/bash

# $1=species list separated by "_"

#If absent, make cat folder
dir_check=$(ls -d cat)
if [ "$dir_check" == "" ]
then
    echo "Creating folder cat"
    mkdir cat
fi

#If absent, make cat/aa folder
dir_check=$(ls -d cat/aa)
if [ "$dir_check" == "" ]
then
    echo "Creating folder cat/aa"
    mkdir cat/aa
fi

#If absent, make aln/aa folder
dir_check=$(ls -d aln)
if [ "$dir_check" == "" ]
then
    echo "Creating folder aln"
    mkdir aln
fi

#If absent, make aln/aa folder
dir_check=$(ls -d aln/aa)
if [ "$dir_check" == "" ]
then
    echo "Creating folder aln/aa"
    mkdir aln/aa
fi


for gene in nd1 nd2 cox1 cox2 atp8 atp6 cox3 nd3 nd4l nd4 nd5 nd6 cytb
do
    #Create output concatenated file, or clear file if it exists.
    echo "" | tr -d "\n" > cat/aa/$gene.$1.cat.aa.fasta

    #Create a list of each species to use in FOR loop.
    list=$(echo $1 | sed s/"_"/" "/g)

    #Create a concatenated file.
    for species in $list
    do
        cat aa/$species/$gene.$species.aa.fasta >> cat/aa/$gene.$1.cat.aa.fasta
    done

    #Run ClustalW2 to create an MSA.
    /mnt/sas0/AD/tjchamberlai/software/clustalw2/clustalw2 -align -type=protein -outorder=input -outfile=aln/aa/$gene.$1.aln.aa.txt -infile=cat/aa/$gene.$1.cat.aa.fasta

done
rm cat/aa/*.dnd
echo "Fin."
