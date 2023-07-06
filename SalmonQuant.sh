#!/bin/bash

############################################
#
# Aligning and quantifying with salmon
# 
# Transcript to gene needs to be made for import with tximport
# zcat file.gtf.gz | awk -F '\t' '$3 == "transcript" { split($9, a, "\""); print a[2] "," a[10] }' > tx2gene.csv
# I have to test that code to see if it works


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
    #Run Salmon to align and quantify the reads
    salmon quant \
        -i hg19/hg19_salmon/ \
        -l A \
        --gcBias \
        -r "${file}" \
        -p 25 \
        -o "${output_dir}"

    echo "Copying quant.sf file for ${basename}"
    # Copy the quant.sf file to the "quantALL" directory with a new name
    cp "${output_dir}/quant.sf" "SalmonQuant/quantALL/${basename}_quant.sf"

done