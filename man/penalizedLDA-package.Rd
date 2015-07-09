\name{penalizedLDA-package}
\alias{penalizedLDA-package}
\alias{penalizedLDA}
\docType{package}
\title{
Penalized linear discriminant analysis using lasso and fused lasso penalties.
}
\description{
This package performs penalized linear discriminant analysis, intended
for the high-dimensional setting in which the number of features p
exceeds the number of observations n. Fisher's discriminant problem is
modified in two ways:
1. A diagonal estimate of the within-class class covariance is used.
2. Lasso or fused lasso penalties are applied to the discriminant
vectors in order to encourage sparsity, or sparsity and smoothness.
}
\details{
\tabular{ll}{
Package: \tab penalizedLDA\cr
Type: \tab Package\cr
Version: \tab 1.1\cr
Date: \tab 2015-07-09\cr
License: \tab GPL (>=2.0) \cr
LazyLoad: \tab yes\cr
}
The main functions are PenalizedLDA, which performs penalized linear
discriminant analysis, and PenalizedLDA.cv, which performs
cross-validation in order to select the optimal tuning parameters for
penalized LDA.
}
\author{
Daniela M. Witten

Maintainer: Daniela M. Witten <dwitten@u.washington.edu>
}
\references{
D Witten and R Tibshirani (2011) Penalized classification using Fisher's
linear discriminant. To appear in Journal of the Royal Statistical Society, Series B.
}
\keyword{ package }
\examples{
set.seed(1)
n <- 20
p <- 100
x <- matrix(rnorm(n*p), ncol=p)
y <- c(rep(1,5),rep(2,5),rep(3,10))
x[y==1,1:10] <- x[y==1,1:10] + 2
x[y==2,11:20] <- x[y==2,11:20] - 2
out <- PenalizedLDA(x,y,lambda=.14,K=2)
print(out)
}
