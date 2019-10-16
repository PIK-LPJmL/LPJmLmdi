\name{LPJfiles}
\alias{LPJfiles}
\title{Create an object of class 'LPJfiles'}
\description{The function creates a list of class 'LPJfiles' that defines all paths, input files, and configurations files for a LPJ run.}
\usage{LPJfiles(path.lpj, path.tmp, path.out, sim.start.year, sim.end.year = NA, 
    lpj.conf, param.conf, pft.par, param.par, input.conf, input, 
    ...)}
\arguments{
  \item{path.lpj}{path where LPJ is installed}
  \item{path.tmp}{path for temporary outputs }
  \item{path.out}{path for results}
  \item{sim.start.year}{start year of the LPJ simulation as defined in lpjml.conf}
  \item{sim.end.year}{last year of the LPJ simulation as defined in lpjml.conf}
  \item{lpj.conf}{template for LPJ configuration file (create a template from lpjml.conf)}
  \item{param.conf}{template for parameter configuration file (create a template from param.conf)}
  \item{pft.par}{template file for PFT-specific parameters (create a template from pft.par)}
  \item{param.par}{template file for global parameters (create a template from param.par)}
  \item{input.conf}{template file for input data (create a template from input.conf)}
  \item{input}{a data.frame of LPJ input files with 2 columns. The first coumn defines the flag as in written in the input.conf template file and the second column the file name, e.g. data.frame(name=c("GRID_FILE", "TMP_FILE"), file=c("cru.grid", "temp.bin"))}
  \item{\dots}{further arguments (currently not used)}
}
\details{No details.}

\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}





