#!/bin/bash

############################################
#
#
# Iterates through all of the data files, asks information from the users (core use, and 
# folder target), and aligs each file GRCh37.hg19



# move to where the data will  handled
cd /mnt/c/Users/jonan/Documents/Tyseq/Data

# Prompt user for the name of the folder with data that needs to be aligned
echo "Enter the name of the folder containing the files to be aligned:"
read input_folder
# Prompt the user for the number of cores
echo "Enter the number of cores to use:"
read cores


# Create a new folder name with "_aligned" suffix
output_folder="${input_folder}_aligned"

# Create ht enew folder
mkdir "$output_folder"

# Iteraate over input files and perform alignment for each file
for file in "${input_folder}"/*.fastq.gz; do
    
    # Get the base filename without extension
    base_name=$(basename "${file}" .fastq.gz)

    echo "Aligning $base_name"

    # perform the alignment
    hisat2  -p "$cores" \
            -x hg19/GRCh37_gencodesgenes_hg19/GRCh37.hg19 \
            -U "${file}" \
            -S "${output_folder}/${base_name}_alignment.sam"
done

# Finished!
echo "Alignment complete. Results saved in ${output_folder}