\name{RegridLPJinput}
\alias{RegridLPJinput}
\title{Regrid or subset LPJmL input }
\description{Subsets grid cells or regrids LPJmL input files.}
\usage{RegridLPJinput(files, grid.clm, grid, path.out, overwrite = TRUE, 
    ...)}
\arguments{
  \item{files}{character vector of CLM or binary file names}
  \item{grid.clm}{old grid *.clm file}
  \item{grid}{Matrix of new grid cells with 2 columns: longitude and latitude (optional). If NULL the data is returned for the grid of the first CLM file. If a grid is provided the data is subesetted for the specified grid cells.}
  \item{path.out}{directory where the new files should be saved}
  \item{overwrite}{overwrite existing files?}
  \item{\dots}{further arguments (currently not used)}
}
\details{No details.}
\value{The function returns TRUE if the CLM file was created.}
\references{No reference.}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{WriteLPJinput}}}
\examples{
# no example
}
