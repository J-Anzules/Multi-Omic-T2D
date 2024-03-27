library(dplyr)
library(pheatmap)
library(RColorBrewer)

# Load data
sigGenes_padj <- read.csv("../Data/DGE_sig_genes_adjp.csv")

#Removing duplicate row names
dfnorm <- read.csv("../Data/normalized_gene_expression_data.csv", check.names = FALSE)
rownames(dfnorm) <- make.names(dfnorm[,1], unique=TRUE)
dfnorm <- dfnorm[, -1] # Remove the first column

dfhm <- dfnorm[rownames(dfnorm) %in% sigGenes_padj$GeneName, ]

# Convert to matrix if not already
dfhm_matrix <- as.matrix(dfhm)

# Assuming you have a dataframe named 'sample_table' with sample conditions
# Create a simple group annotation based on your sample data
# This part needs actual sample condition data
# Example if 'sample_table' has columns 'sampleName' and 'diabetes_status':
groups <- sample_table$diabetes_status
names(groups) <- sample_table$sampleName

# Assuming 'groups' vector has your samples' conditions
grpann <- data.frame(Group = groups)

# Check the unique levels in your 'Group' annotation
unique_groups <- unique(grpann$Group)
print(unique_groups)

rownames(grpann) <- names(groups)

# Prepare annotation colors
# # annCol <- list(Group = c("Non-Diabetic" = "blue", "Diabetic" = "red"))
# # Adjusting annCol to match the actual group names in grpann
# annCol <- list(Group = c("No" = "blue", "Yes" = "red"))

# Map "No" to "Non-diabetic" and "Yes" to "Diabetic" for display in the heatmap
grpann$DisplayGroup <- ifelse(grpann$Group == "No", "Non-diabetic", "Diabetic")

# Update annCol to use the new labels
annCol <- list(DisplayGroup = c("Non-diabetic" = "blue", "Diabetic" = "red"))

#Removing the control and diabetic labels
colnames(dfhm_matrix) <- gsub("_[CD]$", "", colnames(dfhm_matrix))

# Generate heatmap
pheatmap(dfhm_matrix, 
         color=colorRampPalette(rev(brewer.pal(n=11, name="RdBu")))(100), 
         scale="row", 
         clustering_method="ward.D2", 
         annotation_col=grpann["DisplayGroup"],  # Use only the DisplayGroup column for annotations
         annotation_colors=annCol,  
         filename="../Figures/heatmap_FDR.png", 
         width=6, height=7, dpi=300)
dev.off()
