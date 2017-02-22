## RFoptions(seed=0) ## *ANY* simulation will have the random seed 0; set
library("RandomFields")
library("R.matlab")
RFoptions(seed=NA) ##to make them all random again
#############################################################
## ##
## ONLY TWO VERY BASIC EXAMPLES ARE GIVEN HERE ##
## see ##
## ?RMsimulate.more.examples ##
## and ##
## ?RFsimulateAdvanced ##
## for more examples ##
## ##
#############################################################
#############################################################
## ##
## Unconditional simulation ##
## ##
#############################################################
## first let us look at the list of implemented models
RFgetModelNames(type="positive definite", domain="single variable",
iso="isotropic")
## our choice is the exponential model;
## the model includes nugget effect and the mean:
## scale is decorrelation distance
## run: source("filename");
## save to .mat: writeMat("filename", B = simu);

arrayId <- Sys.getenv('PBS_ARRAYID')
if(nchar(arrayId)==0) {
    arrayId <- '0'
}

FieldId <- as.numeric(arrayId)
DeCorr <- 20
model <- RMstable(alpha=1, scale=DeCorr)
#RMnugget(var=1) + # nugget
#RMtrend(mean=0.5) # and mean

## define the locations:
from <- 0
to <- 5000
x.seq <- seq(from, to, length=5000)
y.seq <- seq(from, to, length=5000)
simu <- RFsimulate(model, x=x.seq, y=y.seq)
filename <- paste("dat/ShadowField/ExpSF", FieldId, "DeCorr", DeCorr, ".mat", sep="");
writeMat(filename, B = simu)
# plot(simu)
# #############################################################
# ## ##
# ## Conditional simulation ##
# ## ##
# #############################################################
# # first we simulate some random values at a
# # 100 random locations:
# n <- 100
# x <- runif(n=n, min=-1, max=1)
# y <- runif(n=n, min=-1, max=1)
# data <- RFsimulate(model = RMexp(), x=x, y=y, grid=FALSE)
# plot(data)
# # let simulate a field conditional on the above data
# x.seq.cond <- y.seq.cond <- seq(-1.5, 1.5, length=n)
# model <- RMexp()
# cond <- RFsimulate(model, x=x.seq.cond, y=y.seq.cond, data=data)
# plot(cond, data)
