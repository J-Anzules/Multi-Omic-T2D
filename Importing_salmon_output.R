install.packages("GenomicFeatures")

install.packages("BiocManager")
install.packages("Rtools")

BiocManager::install("GenomicFeatures")

install.Rtools(check = TRUE, check_r_update = TRUE, GUI = TRUE)
install("installr")

library(GenomicFeatures)

#You have to set the working dyrectory to where the code is at

txdb <- makeTxDbFromGFF("../Data/hg19/gencode.v19.chr_patch_hapl_scaff.annotation.gtf")
keytypes(txdb)
k <- keys(txdb, keytype = "TXNAME")
tx2gene <- select(txdb, k, "GENEID", "TXNAME")
tx2gene
