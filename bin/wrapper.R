# R script to run author supplied code, typically used to install additional R packages
# contains placeholders which are inserted by the compile script
# NOTE: this script is executed in the chroot context; check paths!

r <- getOption("repos")
r["CRAN"] <- "CRAN_MIRROR"
options(repos=r)

# check if /app directory exists and set it as working directory if so
if (dir.exists("/tmp/app"))
  setwd("/tmp/app")

# ======================================================================

INIT_FILE_CONTENT

# ======================================================================

# write a file to indicate success
fileConn<-file("/app/status")
writeLines(c("1"), fileConn)
close(fileConn)
