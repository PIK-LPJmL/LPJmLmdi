\name{Rescue2Df}
\alias{Rescue2Df}
\title{Convert a 'rescue' list to a data.frame}
\description{The function takes an object of class 'rescue' (see \code{\link{CombineRescueFiles}}) and converts it to a data.frame including the total cost value (1st column), the parameter values (next columns), and the log-likelihood, Akaike's Information Criterion (AIC) and AIC differences (last columns). If 'lpjpar' it not specified the function returns just the scaled parameters (e.g. dpar = par / prior) otherwise it returns the parameters in the original units (e.g. par = dpar * prior).}
\usage{Rescue2Df(rescue.l, lpjpar = NULL, ...)}
\arguments{
  \item{rescue.l}{a list of class "rescue", see \code{\link{CombineRescueFiles}}}
  \item{lpjpar}{a list of class "LPJpar" (see \code{\link{LPJpar}}) to convert the scaled parameters in rescue.l back to the original units (optional)}
  \item{\dots}{further arguments (currently not used)}
}
\details{No details.}
\value{The function returns a data.frame.}
\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{CombineRescueFiles}}}
\examples{
# files <- c(list.files(pattern="rescue.RData", recursive=TRUE), list.files(pattern="rescue0.RData", recursive=TRUE))
# rescue.l <- CombineRescueFiles(files, remove=FALSE)
# optim.df <- Rescue2Df(rescue.l)
# summary(optim.df)
}
