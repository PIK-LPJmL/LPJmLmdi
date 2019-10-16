\name{LPJ2NCDF}
\alias{LPJ2NCDF}
\title{Convert binary LPJmL model output files to NetCDF}
\description{The function converts a binary LPJmL output file to NetCDF }
\usage{LPJ2NCDF(file, var.name, var.unit, start = 1982, end = 2011, 
    sim.start.year = 1901, var.longname = var.name, run.name = "LPJmL", 
    run.description = "LPJmL run", provider = "M. Forkel, matthias.forkel@geo.tuwien.ac.at", 
    creator = provider, reference = "Sitch et al. 2003 GCB, Gerten et al. 2004 J. Hydrol., Thonicke et al. 2010 BG, Schaphoff et al. 2013 ERL, Forkel et al. 2014 BG", 
    ...)}
\arguments{
  \item{file}{file name of LPJmL model output, e.g. "mgpp.bin"}
  \item{var.name}{variable name, e.g. "GPP"}
  \item{var.unit}{variable unit, e.g. "gC m-2 mon-1"}
  \item{start}{first year for which the data should be converted to NetCDF}
  \item{end}{last year for which the data should be converted to NetCDF}
  \item{sim.start.year}{first year of the simulation}
  \item{var.longname}{long variable name, e.g. "gross primary production"}
  \item{run.name}{name of the LPJmL run (will be part of the file names)}
  \item{run.description}{description of the LPJmL run}
  \item{provider}{name of the provider}
  \item{creator}{name of the creator}
  \item{reference}{
}
  \item{\dots}{further arguments (currently not used)}
}
\details{No details.}

\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}





