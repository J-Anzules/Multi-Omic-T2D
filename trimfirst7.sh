#!/bin/bash

# move to where the data will  handled
cd /mnt/c/Users/jonan/Documents/Tyseq/Data
# Prompt the user for the number of cores
echo "Enter the number of cores to use:"
read cores

# Check if trimmed_fastq folder exists and create it if it doesn't
if [ ! -d "trimmed_fastq" ]; then
    mkdir "trimmed_fastq"
fi

# Find the highest numbered folder (e.g., trimmed_fastq_1, trimmed_fastq_2, etc.)
last_folder=$(find . -maxdepth 1 -type d -name "trimmed_fastq_*" | sort -r | head -n 1)

# If there are no folders matching the pattern "trimmed_fastq_*" last_folder will be empty
if [ -z "$last_folder" ]; then
    new_folder="trimmed_fastq"
else
    # Extract the number from the last folder name and increment it
    last_number=$(echo "$last_folder" | sed 's/[^0-9]*//g')
    new_number=$((last_number + 1))
    new_folder="trimmed_fastq_$new_number"
fi

mkdir "$new_folder"
# iterate through each fastq.gz file

for file in  ./RNA_samples/*fastq.gz 
	do

	# # extract the file name without the .fastq.gz extension
	filename=$(basename "$file" .fastq.gz)
	output_path="$new_folder/${filename}_trimmed.fastq.gz"

	# updating my progress
	echo "Processing file: $filename"

	cutadapt -u 7 \
		-a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
		--cores="$cores" \
		--minimum-length=81 \
		-o "$output_path" \
		"$file"

	echo "Finished file: $filename"

done

echo "Trimming completed!"

