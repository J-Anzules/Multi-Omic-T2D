install.packages("GenomicFeatures")

install.packages("BiocManager")
install.packages("Rtools")

BiocManager::install("GenomicFeatures")

install.Rtools(check = TRUE, check_r_update = TRUE, GUI = TRUE)
install("installr")
