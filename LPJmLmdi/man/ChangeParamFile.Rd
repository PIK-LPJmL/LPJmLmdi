\name{ChangeParamFile}
\alias{ChangeParamFile}
\title{Change parameters in a parameter file}
\description{The function writes values to a parameter file. It requires a 'file.template' in which the positions of the new parameter values are marked with a flag. For example, instead of a parameter of 0.5 for alphaa in a parameter file the flag ALPHAA is written. The function substitutes this flag with the new parameter value in a new file 'file.new'.}
\usage{ChangeParamFile(newpar, file.template, file.new, wait = FALSE, 
    ...)}
\arguments{
  \item{newpar}{a named vector with new parameter values}
  \item{file.template}{file name of the template parameter with flagged parameters}
  \item{file.new}{file name of the new parameter file}
  \item{wait}{If TRUE wait 1 second to check if file.template exists in order to relax slow file writting.}
  \item{\dots}{further arguments (currently not used)}
}
\details{The function works only on Unix systems because it is based on 'sed'}

\references{No reference.}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}




\examples{

# newpar <- c(ALPHAA_BoNE=0.8)
# LPJChangeParamFile(newpar, file.template="pft_template.par", file.new="pft.par")

}
