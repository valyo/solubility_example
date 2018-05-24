# read CSV file with solubility data and explore the dataset
solu <- read.csv("solubility.csv", stringsAsFactors = F)
head(solu)

#rename columns 2 and 3
names(solu)[2] <- "measured"
names(solu)[3] <- "predicted"

head(solu)

#check the correlation between predicted and measured solubility
plot(solu$measured, solu$predicted)
abline(lm(solu$predicted ~ solu$measured))
cor(solu$measured,solu$predicted)


#load solu.Rdata and explore the object solu.300.descr
load("solu.Rdata")
head(solu.300.descr)

pairs(solu.300.descr,gap = 0.3, cex = 0.5)
round(cor(solu.300.descr),2)
pca <- prcomp(solu.300.descr, scale. = F)
names(pca)
print(pca)
summary(pca)
plot(pca)
plot(pca$x[,1:2])
str(pca)
# labels <- rep(".",nrow(solu))
# biplot(pca, xlabs = labels)
biplot(pca, scale=0)
pca$rotation
pca$rotation[,1]
pca$rotation[,2]

