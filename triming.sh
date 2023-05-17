#!/bin/bash

# move to where the data will  handled
cd /mnt/c/Users/jonan/Documents/Tyseq/Data
# create an output directory
# mkdir trimmed_fastq

# iterate through each fastq.gz file
#
for file in  ./RNA_samples/*fastq.gz 
	do

	# # extract the file name without the .fastq.gz extension
	filename=$(basename "$file" .fastq.gz)

	# updating my progress
	echo "Processing file: $filename"

	cutadapt -u 7 \
		-a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
		--cores=20 \
		-o "trimmed_fastq/${filename}_trimmed.fastq.gz" "$file"

	echo "Finished file: $filename"

done




