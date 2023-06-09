# install.packages("BiocManager") # needed to install Genomic Features
# BiocManager::install("GenomicFeatures") #Used for importing and makign the tx2gene mapping
# BiocManager::install("tximport") #needed to prepare the data for deseq
# BiocManager::install("DESeq2") #for differential gene expression analysis



#######################################
# Generating the tx2gene 
library(GenomicFeatures)
#You have to set the working dyrectory to where the code is at

txdb <- makeTxDbFromGFF("../Data/hg19/gencode.v19.chr_patch_hapl_scaff.annotation.gtf")
keytypes(txdb)
k <- keys(txdb, keytype = "TXNAME")
tx2gene <- select(txdb, k, "GENEID", "TXNAME")

