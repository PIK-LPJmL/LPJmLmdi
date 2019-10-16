\name{FileExistsWait}
\alias{FileExistsWait}
\title{Iterative checking and waiting for a file.}
\description{The function repeately checks if a file exists and returns TRUE if the file is existing.}
\usage{FileExistsWait(file, waitmin = 0, waitinterval = 0.5, waitmax = 2, 
    ...)}
\arguments{
  \item{file}{file for which checking and waiting should be applied}
  \item{waitmin}{minimum waiting time (seconds) }
  \item{waitinterval}{interval after which the existence of the file should be checked again (seconds)}
  \item{waitmax}{maximum waiting time (seconds)}
  \item{\dots}{further arguments (currently not used)}
}
\details{No details.}

\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}




\examples{

FileExistsWait(system.file("external/rlogo.grd", package="raster"))
FileExistsWait("nofile.txt")

}
