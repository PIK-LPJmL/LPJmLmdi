\name{WriteLPJpar}
\alias{WriteLPJpar}
\title{Writes an object of class 'LPJpar' as parameter file or table.}
\description{The function takes a 'LPJpar' object and writes 1) LPJ parameter files and 2) write *.txt files with parameter values in a table format.}
\usage{WriteLPJpar(x, file = "LPJpar", pft.par = NULL, param.par = NULL, 
    param.only = TRUE, ...)}
\arguments{
  \item{x}{object of class 'LPJpar'}
  \item{file}{basic file name for all output files, e.g. name of the optimization experiment}
  \item{pft.par}{template file for PFT-specific parameters (create a template from pft.par). If NULL, parameter files will be not written but only parameter tables.}
  \item{param.par}{template file for global parameters (create a template from param.par). If NULL, parameter files will be not written but only parameter tables.}
  \item{param.only}{write only parameters to table (TRUE) or also parameter prior ranges (FALSE)?}
  \item{\dots}{further arguments for CheckLPJpar}
}
\details{No details.}
\value{The function returns a data.frame with an overview of the written files}
\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{LPJpar}}, \code{\link{CheckLPJpar}}	}

