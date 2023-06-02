#!/bin/bash

############################################
#
# Aligning and quantifying with salmon
# 


cd ../Data

mkdir SalmonQuant
mkdir SalmonQuant/quantALL

for file in trimmed_fastq/*.fastq.gz
    do 
    
    #Grabbing the name of the fastq file
    basename=$(basename "${file}" _trimmed.fastq.gz)

    #directory to save 
    output_dir=SalmonQuant/${basename}
    mkdir ${output_dir}

    echo "$basename"
    Run Salmon to align and quantify the reads
    salmon quant \
        -i hg19/hg19_salmon/ \
        -l A \
        -r "${file}" \
        -p 25 \
        -o "${output_dir}"

    echo "Copying quant.sf file for ${basename}"
    # Copy the quant.sf file to the "quantALL" directory with a new name
    cp "${output_dir}/quant.sf" "SalmonQuant/quantALL/${basename}_quant.sf"

done