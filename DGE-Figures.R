library(dplyr)
library(pheatmap)
library(RColorBrewer)
library(ggplot2)
setwd("/Users/jonan/Documents/Tyseq/Code/")
results = read.csv("../Data/DGE_Results_No_ABDG032.csv") # Results  from DGE analysis
# results = read.csv("../Data/DGE_Results.csv") # Results  from DGE analysis

fig_width= 10
fig_height = 10

#####
#-----------------------------------------------------------------------------#
#                            VOLCANO UNLABELED P-VALUES
#-----------------------------------------------------------------------------#


volcano_pvalue <- ggplot(results, aes(x = log2FoldChange, y = neg_log10_pvalue)) +
  geom_point(color = "grey", alpha = 0.6) +
  geom_point(data = subset(results, pvalue < 0.05 & abs(log2FoldChange) > 1),
             color = "red", alpha = 0.6) +
  geom_vline(xintercept = c(-1, 1), linetype = "dashed", color = "blue") +
  geom_hline(yintercept = -log10(0.05), linetype = "dashed", color = "blue") +
  labs(x = "log2 Fold Change", y = "-log10(p-value)",
       title = "Volcano Plot") +
  theme_bw()



# ggsave(filename = "../Figures//volcano_pvalue.png", 
ggsave(filename = "../Figures/ForReviewer/volcano_pvalue.png", 
       plot = volcano_pvalue,
       width = fig_width, height = fig_height, dpi = 600)

# ggsave(filename = "../Figures/volcano_pvalue.pdf", 
ggsave(filename = "../Figures/ForReviewer/volcano_pvalue.pdf", 
       plot = volcano_pvalue,
       width = fig_width, height = fig_height, dpi = 600)




#####
#-----------------------------------------------------------------------------#
#                        VOLCANO LABELED ADJUSTED P-VALUES
#-----------------------------------------------------------------------------#

#Subset top up/down regulated genes
Upregulated_Genes <- subset(results, log2FoldChange > 0 )
Downregualted_Genes <- subset(results, log2FoldChange < 0)

# Choosing the number of top/down
# Number_of_TopnDown = 6


# Select the top 10 upregulated and top 10 downregulated genes
top_upregulated <- Upregulated_Genes[order(Upregulated_Genes$padj, na.last = NA)[1:10],]
top_downregulated <- Downregualted_Genes[order(Downregualted_Genes$padj, na.last = NA)[1:1],]

# Combine the two dataframes
selection <- rbind(top_upregulated, top_downregulated)

# Create a volcano plot
volcano_plot_adjusted <-  ggplot(results, aes(x = log2FoldChange, y = -log10(padj))) +
  geom_point(color = "grey", alpha = 0.6) +
  geom_point(data = subset(results, padj < 0.05 & abs(log2FoldChange) > 1),
             color = "red", alpha = 0.6) +
  geom_vline(xintercept = c(-1, 1), linetype = "dashed", color = "blue") +
  geom_hline(yintercept = -log10(0.05), linetype = "dashed", color = "blue") +
  # Adding the text labels for the top genes
  geom_text(data = selection, aes(label = GeneName), 
            vjust = -1, hjust = 1) +
  labs(x = "log2 Fold Change", y = "-log10(adjusted p-value)",
       title = "Volcano Plot") +
  theme_bw()

ggsave(filename = "../Figures/ForReviewer/volcano_adj_labeled.png", plot = volcano_plot_adjusted,
       width = fig_width, height = fig_height, dpi = 600)
ggsave(filename = "../Figures/ForReviewer/volcano_adj_labeled.pdf", plot = volcano_plot_adjusted,
       width = fig_width, height = fig_height, dpi = 600)












#####
#-----------------------------------------------------------------------------#
#                               HEAT MAP
#-----------------------------------------------------------------------------#
# Load data
sigGenes_padj <- read.csv("../Data/DGE_sig_genes_adjp_No_ABDG032.csv")

#Removing duplicate row names
dfnorm <- read.csv("../Data/normalized_gene_expression_data_No_ABDG032.csv", check.names = FALSE)
rownames(dfnorm) <- make.names(dfnorm[,1], unique=TRUE)
dfnorm <- dfnorm[, -1] # Remove the first column

dfhm <- dfnorm[rownames(dfnorm) %in% sigGenes_padj$GeneName, ]

# Convert to matrix if not already
dfhm_matrix <- as.matrix(dfhm)

#Sample table from DGE_Analysis
# "../Data/SalmonQuant/quantALL/"
control_files = c("../Data/SalmonQuant/quantALL/1_XIN460_NHI_ATTACT_L005_R1_001_quant.sf", 
                  "../Data/SalmonQuant/quantALL/2_XGM061_NHI_TCCGGA_L005_R1_001_quant.sf",
                  "../Data/SalmonQuant/quantALL/3_XJL334_NHI_CGCTCA_L005_R1_001_quant.sf",
                  "../Data/SalmonQuant/quantALL/4_ZCA126_NHI_GAGATT_L005_R1_001_quant.sf",
                  "../Data/SalmonQuant/quantALL/5_XGZ492_NHI_ATTCAG_L005_R1_001_quant.sf")

T1D_files = c("../Data/SalmonQuant/quantALL/6_AAFS251_T2DHI_GAATTC_L005_R1_001_quant.sf",
              "../Data/SalmonQuant/quantALL/7_AAJ2482_T2DHI_CTGAAG_L005_R1_001_quant.sf",
              "../Data/SalmonQuant/quantALL/8_AABW178_T2DHI_TAATGC_L005_R1_001_quant.sf",
              "../Data/SalmonQuant/quantALL/9_XIX456_T2DHI_CGGCTA_L005_R1_001_quant.sf")
              # "../Data/SalmonQuant/quantALL/10_ABDG032_T2DHI_TCCGCG_L005_R1_001_quant.sf")

# Creating a sample table that maps each sample to its corresponding quant.sf file
# _C = control
# _D = Diabetic
sample_table <- data.frame(
  sampleName = c("XIN460_C", "XGM061_C", "XJL334_C", "ZCA126_C", "XGZ492_C",
                 "AAFS251_D", "AAJ2482_D", "AABW178_D", "XIX456_D"),# "ABDG032_D"),
  fileName = c(control_files, T1D_files),
  diabetes_status = c(rep("No", 5), rep("Yes",4))) #, 5)))

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
         filename="../Figures/ForReviewer/heatmap_FDR.png", #png
         # filename="../Figures/heatmap_FDR.pdf", #pdf
         width=10, height=8, dpi=600)
