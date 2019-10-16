\name{LPJpar}
\alias{LPJpar}
\title{Create an object of class 'LPJpar'}
\description{The function creates a data.frame of class 'LPJpar' that defines the parameters for LPJ runs.}
\usage{LPJpar(par.prior, par.lower, par.upper, par.pftspecif, par.names, 
    is.int = rep(FALSE, length(par.prior)), ...)}
\arguments{
  \item{par.prior}{parameter vector (prior)}
  \item{par.lower}{lower boundaries for parameters}
  \item{par.upper}{upper boundaries for parameters}
  \item{par.pftspecif}{Which parameter is PFT specific (TRUE) or global (FALSE)?}
  \item{par.names}{parameter name}
  \item{is.int}{is parameter a integer?}
  \item{\dots}{further arguments for CheckLPJpar}
}
\details{No details.}
\value{The function returns a list of class 'LPJpar'}
\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{CheckLPJpar}}	}

