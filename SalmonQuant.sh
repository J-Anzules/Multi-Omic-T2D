#!/bin/bash

############################################
#
# Aligning and quantifying with salmon
# 


cd ../Data

# mkdir SalmonQuant

for file in trimmed_fastq/*.fastq.gz
    do 
    
    basename=$(basename "${file}" _trimmed.fastq.gz)

    echo "$basename"
    # Run Salmon to align and quantify the reads
    # salmon quant \
    #     -i hg19/hg19_salmon/ \
    #     -l A \
    #     -r "${file}" \
    #     -p 25 \
    #     -o SalmonQuant
done