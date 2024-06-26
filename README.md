# Multi-Omic Analysis of Type 2 Diabetes

This repository contains code and analysis for multi-omic data related to Type 2 Diabetes (T2D). The project integrates genomic, transcriptomic, and proteomic data to provide a comprehensive understanding of the molecular mechanisms underlying T2D.

## Features

- **Data Processing**: Scripts for processing and normalizing multi-omic data.
- **Differential Gene Expression (DGE)**: Analysis of gene expression differences between diabetic and non-diabetic samples.
- **Gene Set Enrichment Analysis (GSEA)**: Identification of significantly enriched pathways.
- **Proteomics Analysis**: Quantitative analysis of protein expression data.
- **Visualization**: Generation of heatmaps, PCA plots, and other visualizations to represent the data and results.

## Important scripts

 **Alignment.sh**: Script for aligning sequence data with HISAT2 
 **Counting.sh**: Script for counting features  with feature counts
 **DGE-Figures.R**: R script for generating DGE figures  
 **DGE_Analysis.Rmd**: RMarkdown for differential gene expression analysis  
 **GSEA_Analysis.Rmd**: RMarkdown for gene set enrichment analysis  
 **GSEA_Figures.R**: R script for generating GSEA figures  
 **Importing_salmon_output.R**: R script for importing salmon quantification results and saving
 **Part2_Phyloseq_moretrim.Rmd**: RMarkdown for phylogenetic analysis  
 **SalmonQuant.sh**:  Script for quantifying transcripts with Salmon  
 **T2D_Proteomics.Rmd**: RMarkdown for proteomics analysis  
 **T2D_metprotgen_xMWAS.Rmd**: RMarkdown for integrated metabolomics, proteomics, and genomics analysis  
 **fastqc.sh**: Script for quality control of sequence data  
 **phyloseqobject_moretrim.RDS**: RDS file for phyloseq object  
 **trimfirst7.sh**: Script for trimming sequences  
 **triming.sh**: Another script for trimming sequences  


## Data
The analysis uses multi-omic data including genomic, transcriptomic, and proteomic data.

## Results
The project generates various visualizations, including heatmaps, volcano plots, PCA plots, and enrichment plots,for understanding the molecular mechanisms underlying Type 2 Diabetes.

## Acknowledgments
Special thanks to Emory University for the opportunity to work on this project.