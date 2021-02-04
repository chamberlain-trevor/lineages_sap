#!/bin/bash

# $1=species list that matches input file (3-letter names)
# $2=main species to compare. i.e. Homo_sapiens or Mus_Musculus

#If absent, make circos folder
dir_check=$(ls -d circos)
if [ "$dir_check" == "" ]
then
	echo "Creating folder circos"
	mkdir circos
fi

#If absent, make circos/sav folder
dir_check=$(ls -d circos/sav)
if [ "$dir_check" == "" ]
then
	echo "Creating folder circos/sav"
	mkdir circos/sav
fi

#Clear file.
echo "" | tr -d "\n" > circos/sav/$1.sav.highlights.txt

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
	#Need each corresponding chromosome for circos

	if [ "$gene" == "nd1" ]
	then
		chr=$(( 7 ))
	fi
	if [ "$gene" == "nd2" ]
	then
		chr=$(( 11 ))
	fi
	if [ "$gene" == "cox1" ]
	then
		chr=$(( 18 ))
	fi
	if [ "$gene" == "cox2" ]
	then
		chr=$(( 21 ))
	fi
	if [ "$gene" == "atp8" ]
	then
		chr=$(( 23 ))
	fi
	if [ "$gene" == "atp6" ]
	then
		chr=$(( 24 ))
	fi
	if [ "$gene" == "cox3" ]
	then
		chr=$(( 25 ))
	fi
	if [ "$gene" == "nd3" ]
	then
		chr=$(( 27 ))
	fi
	if [ "$gene" == "nd4l" ]
	then
		chr=$(( 29 ))
	fi
	if [ "$gene" == "nd4" ]
	then
		chr=$(( 30 ))
	fi
	if [ "$gene" == "nd5" ]
	then
		chr=$(( 34 ))
	fi
	if [ "$gene" == "nd6" ]
	then
		chr=$(( 35 ))
	fi
	if [ "$gene" == "cytb" ]
	then
		chr=$(( 37 ))
	fi


	#$total=total number of AAs in the alignment
	#aa=amino acid position in the sequence
	total=$(cat aln/aa/$gene.$1.aln.aa.txt | grep "$2 " | grep -o "[A-Z-]*$" | sed s/"-"/""/g | tr -d "\n" | wc -c)
	total=$(( $total ))

	#start a FOR loop and do each species.
	for species in $names
	do
		echo "	$species to $2"
		aa=$(( 1 ))
		aareport=$(( 1 ))
		#start loop to read each amino acid, compare to reference
		while [ $aareport -le $total ]
		do
			ref_aa=$(cat aln/aa/$gene.$1.aln.aa.txt | grep "$2 " | grep -o "[A-Z-]*$" | tr -d "\n" | head -c $aa | tail -c 1)
			seq_aa=$(cat aln/aa/$gene.$1.aln.aa.txt | grep "$species " | grep -o "[A-Z-]*$" | tr -d "\n" | head -c $aa | tail -c 1)

		#######LEAVING INSERTIONS AND DELsETIONS OUT FOR NOW######
			#insertion (green circos)
			#if [ $ref_aa == "-" ] && [ $seq_aa != "-" ]
			#then
				
			#fi

			#deletion (orange circos)
			#if [ $ref_aa != "-" ] && [ $seq_aa == "-" ]
			#then

			#fi

			if [ $ref_aa != "-" ] && [ $seq_aa != "-" ] && [ $ref_aa != $seq_aa ]
			then
			#   echo "zf${chr} ${aa} ${aa}" >> circos/sav/${2}.sav.highlights.txt
				echo "zf${chr} ${aareport} ${aareport}" >> circos/sav/$1.sav.highlights.txt
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
