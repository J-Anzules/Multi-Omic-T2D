library(ggplot2)

top_go = read.csv("C:/Users/jonan/Documents/Tyseq/Data/ForReview/Top_GSEA_Pathways_GO_filtered.csv")
top_kegg = read.csv("C:/Users/jonan/Documents/Tyseq/Data/ForReview/Top_GSEA_Pathways_KEGG.csv")

fig_width= 10
fig_height = 7

#####
#-----------------------------------------------------------------------------#
#                               HEAT MAP - GO 
#-----------------------------------------------------------------------------#

# Summarize pathway information and create negative log p value variable for graphing
path_go <- top_go %>% filter(pval <= 0.1) 
path_go <- path_go %>% mutate(neglogpvalue = -log10(pval))


# Graph pathways by p value
pathfig_go <- ggplot(path_go, aes(x = reorder(pathway, neglogpvalue), y = neglogpvalue)) +
  # Conditionally set fill color based on the "ES" value
  geom_bar(aes(fill = ifelse(ES < 0, "red", "black")), stat = "identity") +
  coord_flip() +
  scale_x_discrete(name = "GO Biological Processes Associated with Diabetes") +
  scale_fill_identity() +  # Ensure the colors are applied as specified
  ylab("-log(p value)") +
  theme(axis.text.x = element_text(face = "bold", size = 10, angle = 0),
        axis.text.y = element_text(face = "bold", size = 10, angle = 0))


# Save the figure with increased width (e.g., width = fig_width inches)
# ggsave("C:/Users/jonan/Documents/Tyseq/Figures/Up-Down_GO_pathways.png", width = 12)
ggsave("../Figures/Up-Down_GO_pathways.png",
       plot = pathfig_go,
       width = fig_width, 
       height = fig_height, 
       dpi = 600)

ggsave("../Figures/Up-Down_GO_pathways.pdf",
       plot = pathfig_go,
       width = fig_width, 
       height = fig_height, 
       dpi = 600)

#####
#-----------------------------------------------------------------------------#
#                               HEAT MAP - KEGG 
#-----------------------------------------------------------------------------#


# Summarize pathway information and create negative log p value variable for graphing
path_go <- top_kegg %>% filter(pval <= 0.1) 
path_go <- path_go %>% mutate(neglogpvalue = -log10(pval))


# Graph pathways by p value
pathfig_kegg <- ggplot(path_go, aes(x = reorder(pathway, neglogpvalue), y = neglogpvalue)) +
  # Conditionally set fill color based on the "ES" value
  geom_bar(aes(fill = ifelse(ES < 0, "red", "black")), stat = "identity") +
  coord_flip() +
  scale_x_discrete(name = "KEGG Biological Processes Associated with Diabetes") +
  scale_fill_identity() +  # Ensure the colors are applied as specified
  ylab("-log(p value)") +
  theme(axis.text.x = element_text(face = "bold", size = 10, angle = 0),
        axis.text.y = element_text(face = "bold", size = 10, angle = 0))



# Save the figure with increased width (e.g., width = fig_width inches)
ggsave("C:/Users/jonan/Documents/Tyseq/Figures/Up-Down_KEGG_pathways.png", 
       plot = pathfig_kegg,
       width = fig_width, 
       height = fig_height, 
       dpi = 600)
ggsave("C:/Users/jonan/Documents/Tyseq/Figures/Up-Down_KEGG_pathways.pdf", 
       plot = pathfig_kegg,
       width = fig_width, 
       height = fig_height, 
       dpi = 600)

