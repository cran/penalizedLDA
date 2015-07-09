\name{PenalizedLDA.cv}
\alias{PenalizedLDA.cv}
\title{
Perform cross-validation for penalized linear discriminant analysis.
}
\description{
Performs cross-validation for PenalizedLDA function.
}
\usage{
PenalizedLDA.cv(x, y, lambdas = NULL, K = NULL, nfold = 6, folds = NULL,
    type = "standard", chrom = NULL, lambda2 = NULL)
}
\arguments{
  \item{x}{
A nxp data matrix; n is the number of observations and p is the number of features.
}
  \item{y}{
A n-vector y containing class labels, represented as 1, 2, . . . , nclasses.
}
  \item{lambdas}{
A vector of lambda values to be considered. 
}
  \item{K}{
The number of discriminant vectors to be used. If K is not specified,
then cross-validation will be performed in order to choose the number of
discriminant vectors to use.
}
  \item{nfold}{
Number of cross-validation folds.
}
  \item{folds}{
Optional - one can pass in a list containing the observations that
should be used as the test set in each cross-validation fold.
}
  \item{type}{
    Either "standard" or "ordered".  The former will result in the use
    of lasso penalties, and the latter will result in fused lasso
    penalties. "Ordered" is appropriate if the features are ordered and it
    makes sense for the discriminant vector(s) to preserve that
    ordering.
}
\item{chrom}{
  Only applies to type="ordered". Should be used only if the p features
  correspond to chromosomal locations. In this case, a numeric vector of
  length p indicating which "chromosome" each feature belongs to. The
  purpose is to avoid imposing smoothness between chromosomes.
}
\item{lambda2}{If type is "ordered", enter the value of lambda2 to be
  used.
  Note that cross-validation is performed over lambda (and possibly over
  K) but not over lambda2.}
}
\value{
  \item{errs}{The mean cross-validation error rates obtained. Either a
    vector of length equal to length(lambdas) or a
    length(lambdas)x(length(unique(y))-1) matrix. The former will occur
    if K is specified and the latter will occur otherwise, in which case
  cross-validation occurred over K as well as over lambda.}
  \item{nnonzero}{A vector or matrix of the same dimension as
    "errs". Entries indicate the number of nonzero features involved in
    the corresponding classifier.}
  \item{bestK}{Value of K(= number of discriminant vectors) that
    minimizes the cross-validation error.}
  \item{bestlambda}{Value of "lambdas" that minimizes the
    cross-validation error.}
    \item{bestlambda.1se}{Given that K equals bestK, this is the largest value of lambda such that the
      corresponding error is within 1 standard error of the
      minimum. This is the "one standard error" rule for selecting the
      tuning parameter.}
  \item{lambdas}{Values of lambda considered.}
  \item{Ks}{Values of K considered - only output if K=NULL was input.}
  \item{folds}{Folds used in cross-validation.}
}
\references{
D Witten and R Tibshirani (2011) Penalized classification using Fisher's
linear discriminant. To appear in JRSSB.
}
\author{
Daniela M. Witten
}
\examples{
# Generate data #
set.seed(1)
n <- 20 # number of training obs
m <- 40 # number of test obs
p <- 100 # number of features
x <- matrix(rnorm(n*p), ncol=p)
xte <- matrix(rnorm(m*p), ncol=p)
y <- c(rep(1,5),rep(2,5),rep(3,6), rep(4,4))
yte <- rep(1:4, each=10) 
x[y==1,1:10] <- x[y==1,1:10] + 2
x[y==2,11:20] <- x[y==2,11:20] - 2
x[y==3,21:30] <- x[y==3,21:30] - 2.5
xte[yte==1,1:10] <- xte[yte==1,1:10] + 2
xte[yte==2,11:20] <- xte[yte==2,11:20] - 2
xte[yte==3,21:30] <- xte[yte==3,21:30] - 2.5


# Perform cross-validation #
# Use type="ordered" -- that is, we are assuming that the features have
# some sort of spatial structure
cv.out <-
PenalizedLDA.cv(x,y,type="ordered",lambdas=c(1e-4,1e-3,1e-2,.1,1,10),lambda2=.3)
print(cv.out)
plot(cv.out)
# Perform penalized LDA #
out <- PenalizedLDA(x,y,xte=xte,type="ordered", lambda=cv.out$bestlambda,
K=cv.out$bestK, lambda2=.3)
print(out)
plot(out)
print(table(out$ypred[,out$K],yte))




# Now repeat penalized LDA computations but this time use
# type="standard"  - i.e. don't exploit spatial structure
# Perform cross-validation #
cv.out <-
PenalizedLDA.cv(x,y,lambdas=c(1e-4,1e-3,1e-2,.1,1,10))
print(cv.out)
plot(cv.out)
# Perform penalized LDA #
out <- PenalizedLDA(x,y,xte=xte,lambda=cv.out$bestlambda,K=cv.out$bestK)
print(out)
plot(out)
print(table(out$ypred[,out$K],yte))
}
