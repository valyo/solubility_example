# read data from CSV file
solu <- read.csv("solubility.csv", stringsAsFactors=F)

# take a sample of 300 molecules
set.seed(321)
solu.300 <- solu[sample(1:nrow(solu),300),]

# install rcdk package and load it
install.packages("rcdk")
library(rcdk)

# create rcdk molecules from the SMILES
solu.300.mols <- parse.smiles(solu.300$SMILES)
lapply(solu.300.mols, convert.implicit.to.explicit)

# get a list of all available rcdk descriptors
allDescr <- unique(unlist(sapply(get.desc.categories(), get.desc.names)))

# since the list of descriptors in rcdk changes with versions updates
# you need to pick by visual inspection the indexes 
# of the following descriptors from the vector allDescr:
# "TopoPSA", "nHBDon", "nHBAcc","XLogP","MW","ALogP",and "AMR"
# and use them in the following line to calculate the descriptors
solu.300.descr <- eval.desc(solu.mols, allDescr[c(2,3,4,29,36,37,47)])

# combine the descriptors and the solubility measured values in one dataframe
solu.300.descr <- cbind(solu.300$measured, solu.300.descr)
names(solu.300.descr)[1] <- "measured"
rownames(solu.300.descr) <- NULL

# save the resulting object to .Rdata file
save(solu.300.descr, file = "solu.Rdata")