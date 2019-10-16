\name{VarCovMatrix}
\alias{VarCovMatrix}
\title{Compute variance-covariance matrix}
\description{The function computes the variance-covariance matrix from the hessian matrix. Parameters that have a hessian = 0 (in sensitive parameters) area removed from the matrix before calculating the variance-covariance matrix.}
\usage{VarCovMatrix(hessian, nms = paste("P", 1:n, sep = ""))}
\arguments{
  \item{hessian}{Hessian matrix}
  \item{nms}{names of the parameters (rows and columns in the matrix}
}
\details{No details.}

\references{No reference.		}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}





