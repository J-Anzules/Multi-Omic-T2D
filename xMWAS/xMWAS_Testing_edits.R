#Please see user manual for description of arguments:
#https://github.com/kuppal2/xMWAS/blob/master/example_manual_tutorial/xMWAS-manual.pdf


library(devtools)
install_github("J-Anzules/xMWAS") # Select option 3 to not update
library(xMWAS)

# Uninstall a package
remove.packages("xMWAS")
detach("package:xMWAS", unload = TRUE)
ls()
xMWAS

#example dataset that includes metabolome, transcriptome, and cytokine data from the H1N1 mice study (Chandler 2016)
data(exh1n1)

load("../xMWAS/Cloned_xMWAS/xMWAS/data/exh1n1.rda")

xMat<-exh1n1$metabolome
yMat<-exh1n1$transcriptome
zMat<-exh1n1$cytokine
classlabels<-exh1n1$classlabels

#Code for reading tab-delimited text files as input data
#currently turned off:
# if(FALSE)
# {
#   fname1<-"/Users/karanuppal/Downloads/OneDrive_1_11-3-2017/gene.txt"
#   fname2<-"/Users/karanuppal/Downloads/OneDrive_1_11-3-2017/clinical.txt"
#   fname3<-"/Users/karanuppal/Downloads/OneDrive_1_11-3-2017/metabolomics.txt"
#   class_fname<-"/Users/karanuppal/Downloads/OneDrive_1_11-3-2017/Classfile.txt"
#   xMat<-read.table(fname1,sep="\t",header=TRUE,row.names=1)
#   yMat<-read.table(fname2,sep="\t",header=TRUE,row.names=1)
#   zMat<-read.table(fname3,sep="\t",header=TRUE,row.names=1)
#   classlabels<-read.table(class_fname,sep="\t",header=TRUE)
#   xMat<-as.data.frame(xMat)
#   yMat<-as.data.frame(yMat)
#   zMat<-as.data.frame(zMat)
#   wMat<-NA
# }
###################



output <- "C:/Users/jonan/Documents/Tyseq/Data/xMWAS_data/T2D_xMWAS_outputLOG_mettran/"



# # Step 1: Track existing objects before sourcing
# objects_before <- ls()
# 
# 
# #Scripts Directory
# scripts_dir <- "C:/Users/jonan/Documents/Tyseq/Code/xMWAS/Cloned_xMWAS/xMWAS/R/"
# 
# script_files <- list.files(path = scripts_dir, pattern = "\\.[Rr]$", full.names = TRUE)
# 
# 
# for (script in script_files) {
#   tryCatch({
#     source(script)
#     cat(paste("Successfully sourced:", script, "\n"))
#   }, error = function(e) {
#     cat(paste("Error sourcing:", script, "\n"))
#   })
# }
# 
# # Step 3: Identify new objects created by sourcing the files
# objects_after <- ls()
# new_objects <- setdiff(objects_after, objects_before)
# 
# # Step 4: Remove the new objects
# rm(list = new_objects)


#call the run_xmwas() function:
xmwas_res<-run_xmwas(Xome_data=xMat,Yome_data=yMat,Zome_data=zMat,Wome_data=NA,outloc=output,
                     classlabels=NA,class_fname=NA,xmwasmethod="pls",plsmode="regression",
                     max_xvar=10000, #e.g. select top 10000 of the variabels in X dataset based on relative standard deviation; change according to your dataset; you can also use proportion such as round(nrow(xMat)*0.3) to select top 30% of the variables.
                     max_yvar=10000, #select top 10000 of the variabels in Y dataset based on relative standard deviation;  change according to your dataset; you can also use proportion such as round(nrow(yMat)*0.3) to select top 30% of the variables.
                     max_zvar=10000, #select top 10000 variabels in Z dataset based on relative standard deviation;  change according to your dataset; you can also use proportion such as round(nrow(zMat)*0.3) to select top 30% of the variables.
                     max_wvar=10000, #select top 10000 variabels in W dataset based on relative standard deviation;  change according to your dataset; you can also use proportion such as round(nrow(wMat)*0.3) to select top 30% of the variables.
                     rsd.filt.thresh=1,
                     corthresh=0.4, #absolute correlation threshold
                     keepX=1000, #select up to top 1000 variables in the sPLS model; change according to your dataset
                     keepY=1000, #select up to top 1000 variables in the sPLS model; change according to your dataset
                     keepZ=1000, #select up to top 1000 variables in the sPLS model; change according to your dataset
                     keepW=1000, #select up to top 1000 variables in the sPLS model; change according to your dataset
                     pairedanalysis=FALSE, #set to TRUE if repeated measures study design
                     optselect=FALSE, #perform optimal PLS componenet selection; TRUE or FALSE; set to FALSE for exact Pearson correlation calculation using PLS regression
                     rawPthresh=0.05, #p-value threshold for correlation based on Student's t-test
                     numcomps=5, #max number of PLS components to use; set to N-1 (N: number of samples) for exact Pearson correlation calculation using PLS regression
                     net_edge_colors=c("blue","red"),
                     net_node_colors=c("orange", "green","cyan","pink"),
                     Xname="Metab", #change the name of dataset X
                     Yname="Gene", #change the name of dataset Y
                     Zname="Cytokine", #change the name of dataset Z
                     Wname="W", #change the name of dataset W
                     net_node_shape=c("square","circle","triangle","star"),
                     all.missing.thresh=0, #filter based on missing values: set to NA to turn it OFF; otherwise specify a value between: 0 to 1 (e.g. 0.8 to require that at least 80% of the samples have a non-missing value)
                     missing.val=0,
                     seednum=100,label.cex=0.2,vertex.size=6,
                     interactive=FALSE,max_connections=NA,
                     centrality_method="eigenvector", #centrality evaluation method
                     use.X.reference=FALSE,removeRda=TRUE,
                     compare.classes=FALSE, #compare classes: TRUE or FALSE
                     class.comparison.allvar=TRUE,
                     modularity.weighted=TRUE,
                     globalcomparison=TRUE,
                     plot.pairwise=FALSE, #plot results for pairwise comparisons: TRUE or FALSE
                     apply.sparse.class.comparison=FALSE, #perform variable selection in sPLS during class-wise comparison (default: FALSE)
                     layout.type="fr1")

suppressWarnings(try(sink(file=NULL),silent=TRUE))



# - Fixing class labes
#################################
classlabels = NA
classlabels<-exh1n1$classlabels
is.na(classlabels)

# This is checking that if class labels has an NA value, it will take the 
# labels from Xome_data

if(is.na(classlabels)[1]==TRUE){
  print("it ran")
  
  classlabels<-rep("A",dim(Xome_data)[2])
  
  classlabels<-as.data.frame(classlabels)
  
  colnames(classlabels)<-c("class")
  
}

cnames_class<-colnames(classlabels)
cnames_class<-tolower(cnames_class)

colnames(classlabels)<-cnames_class

# FIXED What's up with the dataframe that is triggering my edit?
########## 

xMat_xMWAS = read.csv("C:/Users/jonan/Documents/Tyseq/Data/xMWAS_data/T2D_xMWAS_outputLOG_mettran/Xome_data.csv")

typeof(xMwas_Xome)
typeof(xMat)
head(xMwas_Xome)
head(xMat_xMWAS, n = 5)
xMWAS_x

is.na(xMwas_Xome)[1]
!is.data.frame(xMwas_Xome)
suppressWarnings(
  if(is.na(xMwas_Xome)[1] || !is.data.frame(xMwas_Xome)){
    #Original
    #if(is.na(Xome_data)==TRUE){
    
    
    stop("X data matrix is required.")
  })

is.double(xMwas_Xome)

if(is.na(xMwas_Xome)==TRUE){
  
  
  stop("X data matrix is required.")
}

#################### Testing edits

#After first edits:
######
suppressWarnings(
  if(is.na(xMat)[1] || !is.data.frame(xMat)){
    #Original
    #if(is.na(Xome_data)==TRUE){
    
    
    stop("X data matrix is required.")
  })

# Before first edits
######

suppressWarnings(
  if (is.na(yMat) && length(yMat) == 1) {
    stop("X data matrix is required.")
  })

is.na(yMat)
yMat<-exh1n1$transcriptome
yMat <- NA

is.null(yMat)
is.data.frame(yMat)
all(is.na(yMat))


suppressWarnings(
  if (is.null(yMat) || (is.data.frame(yMat) && all(is.na(yMat)))) {
    stop("X data matrix is required.")
  })

yMat <- NA

is.null(yMat) || (is.data.frame(yMat) && all(is.na(yMat)))

if (is.null(yMat) || (is.data.frame(yMat) && all(is.na(yMat)))) {
  print("Did this work?")
  stop("X data matrix is required.")
}
yMat <- NA
yMat<-exh1n1$transcriptome
is.na(yMat)[1]
is.data.frame(yMat)

if(is.na(yMat)[1] || ){
  print("No Matrix")
  stop("X data matrix is required.")
}

# Figuring out to add a check if there are any NA's in the dataset
#####

#Checking na again
yMat <- NA
yMat<-exh1n1$transcriptome
yMat <- 23

all(is.na(zMat))
is.null(zMat)

is.na(yMat)
!is.data.frame(yMat)


# Check if there is an NA from the function
# Also if there is a dataframe, but need it to return false, so the script continues
if (is.na(yMat)[1] || !is.data.frame(yMat) ){
  print("We needa dataframe")
} else{
  print("We have a dataframe")
}

if (is.data.frame(zMat) ){
  print("?")
}


# Where is the package
system.file(package = "xMWAS")
package_dir <- system.file(package = "xMWAS")

# Construct the full path to the run_xmwas.R script
script_path <- file.path(package_dir, "R", "run_xmwas.R")

# Print the script path
print(script_path)




###### trying alternatives

# Ensure the data is a data frame and numeric
Xome_data <- as.data.frame(apply(tran, 2, as.numeric))
Yome_data <- as.data.frame(apply(logmet, 2, as.numeric))
Zome_data <- as.data.frame(apply(prot, 2, as.numeric))

# Print the first few rows of each data frame to confirm
print(head(Xome_data))
print(head(Yome_data))
print(head(Zome_data))

# Check for any NA values again to be absolutely sure
print(any(is.na(Xome_data)))
print(any(is.na(Yome_data)))
print(any(is.na(Zome_data)))
