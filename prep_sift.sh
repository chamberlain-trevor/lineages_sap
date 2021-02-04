#!/bin/bash

# $1=species list that matches input file (3-letter names)
# $2=main species to compare. i.e. Homo_sapiens or Mus_Musculus

#If absent, make sift folder
dir_check=$(ls -d sift)
if [ "$dir_check" == "" ]
then
	echo "Creating folder sift"
	mkdir sift
fi

dir_check=$(ls -d sift/subst)
if [ "$dir_check" == "" ]
then
	echo "Creating folder sift/subst"
	mkdir sift/subst
fi

#Need the name of each species
list=$(echo $1 | sed s/"_"/" "/g)

#Species count:
count=$(echo $1 | sed s/"_"/" "/g | wc -w)
count=$(( $count ))

#Get species full names.
names=$(cat aln/aa/nd1.$1.aln.aa.txt | grep -o "^nd1|[A-Z][a-z_]*" | grep -o "[A-Za-z_]*$" | head -n $count | grep -v $2)

#Start a FOR loop for each gene 

for gene in nd1 nd2 cox1 cox2 atp8 atp6 cox3 nd3 nd4l nd4 nd5 nd6 cytb
do
	echo "Processing $gene"

	#$total=total number of AAs in the alignment
	#aa=amino acid position in the sequence
	total=$(cat aln/aa/$gene.$1.aln.aa.txt | grep "$2 " | grep -o "[A-Z-]*$" | sed s/"-"/""/g | tr -d "\n" | wc -c)
	total=$(( $total ))

	#start a FOR loop and do each species.
	for species in $names
	do
        #If absent, make sift/subst/$species folder
        dir_check=$(ls -d sift/subst/$species)
        if [ "$dir_check" == "" ]
        then
	        echo "Creating folder sift/subst/$species"
	        mkdir sift/subst/$species
        fi

        #Clear file.
        echo "" | tr -d "\n" > sift/subst/$species/$gene.$species.sift.subst

		echo "	$species to $2"
		aa=$(( 1 ))
		aareport=$(( 1 ))

		#start loop to read each amino acid, compare to reference
		while [ $aareport -le $total ]
		do
			ref_aa=$(cat aln/aa/$gene.$1.aln.aa.txt | grep "$2 " | grep -o "[A-Z-]*$" | tr -d "\n" | head -c $aa | tail -c 1)
			seq_aa=$(cat aln/aa/$gene.$1.aln.aa.txt | grep "$species " | grep -o "[A-Z-]*$" | tr -d "\n" | head -c $aa | tail -c 1)


			if [ $ref_aa != "-" ] && [ $seq_aa != "-" ] && [ $ref_aa != $seq_aa ]
			then
				echo "${ref_aa}${aareport}${seq_aa}" >> sift/subst/$species/$gene.$species.sift.subst
			fi

			if [ $ref_aa != "-" ]
			then
				aareport=$(( $aareport + 1 ))
			fi
			aa=$(( $aa + 1 ))
		done
	done
done

echo "Fin."
