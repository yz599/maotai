# Generated by using Rcpp::compileAttributes() -> do not edit by hand
# Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

aux_shortestpath <- function(wmat) {
    .Call('_maotai_aux_shortestpath', PACKAGE = 'maotai', wmat)
}

cppsub_2007Wang <- function(V0, mm, d, Spu, Stu, maxiter, eps) {
    .Call('_maotai_cppsub_2007Wang', PACKAGE = 'maotai', V0, mm, d, Spu, Stu, maxiter, eps)
}

gradF <- function(func, xnow, h) {
    .Call('_maotai_gradF', PACKAGE = 'maotai', func, xnow, h)
}

dat2centers <- function(data, centers) {
    .Call('_maotai_dat2centers', PACKAGE = 'maotai', data, centers)
}

cpp_sylvester <- function(A, B, C) {
    .Call('_maotai_cpp_sylvester', PACKAGE = 'maotai', A, B, C)
}

solve_lyapunov <- function(A, B, C) {
    .Call('_maotai_solve_lyapunov', PACKAGE = 'maotai', A, B, C)
}

cpp_pairwise_L2 <- function(muA, muB, covA, covB) {
    .Call('_maotai_cpp_pairwise_L2', PACKAGE = 'maotai', muA, muB, covA, covB)
}

integrate_1d <- function(tseq, fval) {
    .Call('_maotai_integrate_1d', PACKAGE = 'maotai', tseq, fval)
}

cpp_kmeans <- function(data, k) {
    .Call('_maotai_cpp_kmeans', PACKAGE = 'maotai', data, k)
}

eval_gaussian <- function(x, mu, cov) {
    .Call('_maotai_eval_gaussian', PACKAGE = 'maotai', x, mu, cov)
}

eval_gaussian_data <- function(X, mu, cov) {
    .Call('_maotai_eval_gaussian_data', PACKAGE = 'maotai', X, mu, cov)
}

eval_gmm_data <- function(X, mus, covs, weight) {
    .Call('_maotai_eval_gmm_data', PACKAGE = 'maotai', X, mus, covs, weight)
}

eval_gmm <- function(x, mus, covs, weight) {
    .Call('_maotai_eval_gmm', PACKAGE = 'maotai', x, mus, covs, weight)
}

