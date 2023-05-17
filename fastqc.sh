#!/bin/bash

# move to where the data will  handled
cd /mnt/c/Users/jonan/Documents/Tyseq/Data

# Prompt the user for the folder name
echo "Number for folder fastqc_{}?"
read folder_name

echo "Which folder is being analyzed?"
read trimmed_folder

# Create the output directory based on user input
output_dir="fastqc_${folder_name}"
mkdir "$output_dir"

# iterate through each fastq.gz file

for file in  "$trimmed_folder"/*fastq.gz 
	do

	# extract the file name without the .fastq.gz extension
	filename=$(basename "$file" .fastq.gz)

	# updating my progress
	echo "Processing file: $filename"

	# create a subdirectory for the sample in the output directory
	mkdir -p "$output_dir/$filename"

	# run samples and save in sample subdirectory
	fastqc "$file" -o "$output_dir/$filename"

done




