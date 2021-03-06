% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ecdfdist.R
\name{ecdfdist}
\alias{ecdfdist}
\title{Distance Measures between Multiple Empirical Cumulative Distribution Functions}
\usage{
ecdfdist(elist, method = c("KS", "Lp", "Wasserstein"), p = 2, as.dist = FALSE)
}
\arguments{
\item{elist}{a length \eqn{N} list of \code{ecdf} objects.}

\item{method}{name of the distance/dissimilarity measure. Case insensitive.}

\item{p}{exponent for \code{Lp} or \code{Wasserstein} distance.}

\item{as.dist}{a logical; \code{TRUE} to return \code{dist} object, \code{FALSE} to return an \eqn{(N\times N)} symmetric matrix of pairwise distances.}
}
\value{
either \code{dist} object of an \eqn{(N\times N)} symmetric matrix of pairwise distances by \code{as.dist} argument.
}
\description{
We measure distance between two empirical cumulative distribution functions (ECDF). For 
simplicity, we only take an input of \code{\link[stats]{ecdf}} objects from \pkg{stats} package.
}
\examples{
## toy example : 10 of random and uniform distributions
mylist = list()
for (i in 1:10){
  mylist[[i]] = stats::ecdf(stats::rnorm(50, sd=2))
}
for (i in 11:20){
  mylist[[i]] = stats::ecdf(stats::runif(50, min=-5))
}

## compute Kolmogorov-Smirnov distance
dm = ecdfdist(mylist, method="KS")

## visualize
mks  =" KS distances of 2 Types"
opar = par(pty="s")
image(dm[,nrow(dm):1], axes=FALSE, main=mks)
par(opar)

}
\seealso{
\code{\link[stats]{ecdf}}
}
