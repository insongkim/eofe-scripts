## Example
ptm <- proc.time() # Start-time

## =============================================================================
## Preamble
setwd("~/projects/demo")

packages <- c("doMPI", "doParallel", "snow", "MASS")
sapply(packages, require, character.only=TRUE)
args <- commandArgs(trailingOnly = TRUE)
use.method <- args[1]
np <- as.numeric(args[2])

## =============================================================================
## Functions
### Bootstrap
dobootstrap <- function(...) {
    ids <- sample(unique(d$ccode), length(unique(d$ccode)), replace=TRUE)
    D <- do.call(rbind, lapply(ids, function(id) d[which(d$ccode==id),]))
    fit <- polr(polr.formula, data=D)
    c(fit$coefficients, fit$zeta)
}

## =============================================================================
## Analysis
d <- read.csv("mydata.csv")
polr.formula <- factor(redist) ~ finan + incbins + female + age + partyid + educ

if (use.method=="foreach") {
    cl <- makeCluster(np, type="MPI")   # Init MPI backend
    registerDoParallel(cl)
    polr.out <- foreach(i=1:1000, .combine='cbind', .packages="MASS") %dopar% dobootstrap()
    stopCluster(cl)                     # Clean up
}

if (use.method=="snow") {
    cl <- makeCluster(np, type="MPI")   # Init MPI backend
    clusterEvalQ(cl, require(MASS))     # same as clusterEvalQ(cl, library(MASS))
    clusterExport(cl=cl, list=ls())
    polr.out <- do.call(cbind, parLapply(cl, 1:1000, dobootstrap))
    stopCluster(cl)                     # Clean up
}

save(polr.out, file="polr_output.RData")
print(proc.time() - ptm)
mpi.quit()
