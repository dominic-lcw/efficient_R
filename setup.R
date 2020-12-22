
# install.packages("benchmarkme")
library(benchmarkme)

Sys.info()


#
# Syntax to install packages
#

# Install
pkgs = c("raster", "rgeos")
install.packages(pkgs)
lapply(pkgs, library, character.only = TRUE)

# Update
update.packages(ask = FALSE)

#
# Setting options
#
options(prompt = "> ", digits = 3)
get_linear_algebra()