\name{AllEqual}
\alias{AllEqual}
\title{Check if all values in a vector are the same}
\description{This function is used to check if all values in a vector are equal. It can be used for example to check if a time series contains only 0 or NA values.}
\usage{AllEqual(x)}
\arguments{
  \item{x}{numeric, character vector, or time series of type ts}
}

\value{The function returns TRUE if all values are equal and FALSE if it contains different values.}

\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}




\examples{
# check if all values are equal in the following vectors:
AllEqual(1:10)
AllEqual(rep(0, 10))
AllEqual(letters)
AllEqual(rep(NA, 10))
}
