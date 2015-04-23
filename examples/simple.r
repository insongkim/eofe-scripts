## Simple example

library(doParallel)

sayhello <- function() {
    info <- Sys.info()[c("nodename", "machine")]
    Sys.sleep(runif(1, 0, 50)/10)
    paste("Hello from", info[1], "with CPU type", info[2], "at", Sys.time())
}

cl <- makeCluster(24, type="MPI")   # Init MPI backend
registerDoParallel(cl)
hello.out <- foreach(i=1:24, .combine='c') %dopar% sayhello()
stopCluster(cl)                     # Clean up
print(hello.out)
mpi.quit()
