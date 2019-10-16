#--------------------------------------------
# Building and installation of an R package:
# Matthias Forkel, 2017-08-02
#--------------------------------------------

# package development is based on inlinedocs (for in-line documentation)
library(inlinedocs)
library(here)

# name and directory of package
pkg.name <- "LPJmLmdi"
path <- paste(here::here(), sep="/")


# BUILDING
#---------

# Building is only required if you further develop the package, i.e. if you want to newly 
# create help files and perform tests. Continue with the next section if you just downloaded 
# the package and you want to install it.

# build package structure and Rd files
setwd(path)
package.skeleton.dx(pkg.name)

# check package
cmd <- sprintf(paste("%s CMD check --as-cran", pkg.name), file.path(R.home("bin"), "R"))
system(cmd, intern=TRUE)

# build package
cmd <- sprintf(paste("%s CMD build --resave-data", pkg.name), file.path(R.home("bin"), "R"))
system(cmd, intern=TRUE)


# INSTALLATION
#-------------

# installation
cmd <- paste("R CMD INSTALL --html", pkg.name, "--resave-data")
tryCatch(system(cmd), finally=setwd(path))

# load package
library(pkg.name, character.only=TRUE)

# check package help files:
?OptimizeLPJgenoud


