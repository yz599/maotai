#' Tools for Matrix Algebra, Optimization and Inference
#' 
#' Matrix is an universal and sometimes primary object/unit in applied mathematics and statistics. We provide a number of algorithms for selected problems in optimization and statistical inference.
#' This package contains following functions, 
#' \tabular{ll}{
#' FUNCTION \tab DESCRIPTION \cr
#' \code{\link{boot.mblock}} \tab Generate Index for Moving Block Bootstrapping \cr
#' \code{\link{boot.stationary}} \tab Generate Index for Stationary Bootstrapping \cr
#' \code{\link{distgmm}} \tab Distance Measures between Multisets using Gaussian Mixture Models \cr
#' \code{\link{dpmeans}} \tab DP-means Algorithm for Clustering Euclidean Data \cr
#' \code{\link{ecdfdist}} \tab Distance Measures between Multiple Empirical CDFs \cr
#' \code{\link{ecdfdist2}} \tab Pairwise Measures for Two Sets of Empirical CDFs \cr
#' \code{\link{epmeans}} \tab EP-means Algorithm for Clustering Empirical Distributions \cr
#' \code{\link{lgpa}} \tab Large-scale Generalized Procrustes Analysis \cr
#' \code{\link{lyapunov}} \tab Solve Lyapunov Equation \cr
#' \code{\link{matderiv}} \tab Numerical Approximation to Gradient of a Function with Matrix Argument \cr
#' \code{\link{mmd2test}} \tab Kernel Two-sample Test with Maximum Mean Discrepancy \cr
#' \code{\link{pdeterminant}} \tab Calculate the Pseudo-Determinant of a Matrix \cr
#' \code{\link{shortestpath}} \tab Find Shortest Path using Floyd-Warshall Algorithm \cr
#' \code{\link{sylvester}} \tab Solve Sylvester Equation \cr
#' \code{\link{trio}} \tab Trace Ratio Optimation
#' }
#'
#' @docType package
#' @name maotai
#' @aliases maotai-package
#' @import Rdpack
#' @importFrom stats as.dist knots ecdf rnorm runif quantile dist rgamma rgeom var
#' @importFrom shapes procGPA
#' @importFrom mclust Mclust mclustBIC
#' @importFrom utils packageVersion
#' @importFrom RSpectra eigs
#' @importFrom Matrix rankMatrix
#' @importFrom Rcpp evalCpp
#' @useDynLib maotai
NULL