\name{PenalizedLDA}
\alias{PenalizedLDA}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Perform penalized linear discriminant analysis using L1 or fused lasso penalties.
}
\description{
Solve Fisher's discriminant problem in high-dimensions using
  (a) a diagonal estimate of the within-class covariance matrix, and
  (b) lasso or fused lasso penalties on the discriminant vectors.
}
\usage{
PenalizedLDA(x, y, xte=NULL, type = "standard", lambda, K = 2, chrom =
NULL, lambda2 = NULL, standardized = FALSE, wcsd.x = NULL, ymat = NULL,
maxiter = 20, trace=FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
A nxp data matrix; n observations on the rows and p features on the columns.
}
  \item{y}{
A n-vector containing the class labels. Should be coded as 1, 2, . . . ,
nclasses, where nclasses is the number of classes.
}
  \item{xte}{
    A mxp data matrix; m test observations on the rows and p features on
    the columns.
    Predictions will be made at these test observations. If NULL then no
    predictions will be output.
  }
    \item{type}{
Either "standard" or "ordered". The former will result in the use of
lasso penalties, and the latter will result in fused lasso
penalties. "Ordered" is appropriate if the features are ordered and it
makes sense for the discriminant vector(s) to preserve that ordering.
}
  \item{lambda}{
If type="standard" then this is the lasso penalty tuning parameter.  If
type="ordered" then this is the tuning parameter for the sparsity
component of the fused lasso penalty term.
}
  \item{K}{
The number of discriminant vectors desired. Must be no greater than
(number of classes - 1).
}
  \item{chrom}{
Only applies to type="ordered". Should be used only if the p features
correspond to chromosomal locations. In this case, a numeric vector of
length p indicating which "chromosome" each feature belongs to. The
purpose is to avoid imposing smoothness between chromosomes.
}
  \item{lambda2}{
If type="ordered", then this penalty controls the smoothness term in the
fused lasso penalty. Larger lambda2 will lead to more smoothness.
}
  \item{standardized}{
Have the features on the data already been standardized to have mean zero and
within-class standard deviation 1? In general, set standardized=FALSE.
}
  \item{wcsd.x}{
If the within-class standard deviation for each feature has already been
computed, it can be passed in. Usually will be NULL.
}
  \item{ymat}{
If y has already been converted into a n x nclasses matrix of indicator
variables, it can be passed in. Usually will be NULL.
}
  \item{maxiter}{
    Maximum number of iterations to be performed; default is 20.}
  \item{trace}{
Print out progress through iterations?
 }
}
\details{
Assume that the features (columns) of x have been standardized to have
mean 0 and standard deviation 1. Then, if type="standard", the
optimization problem for the first discriminant vector is


max_b { b' Sigma_bet b  - lambda*d*sum(abs(b)) } s.t. ||b||^2 <= 1

where d is the largest eigenvalue of Sigma_bet.

Alternatively, if type="ordered", the optimization problem for the first
discriminant vector is

max_b { b' Sigma_bet b - lambda*d*sum(abs(b)) - lambda2*d*sum(abs(bj -
  b(j-1))) } s.t. ||b||^2 <= 1.

For details about the optimization problem for obtaining subsequent
discriminant vectors, see the paper below.
}
\value{
\item{ypred}{A mxK of predicted class labels for the test
  observations; output ONLY if xte was passed in. The kth column
  indicates the test set classifications if the first k discriminant
  vectors are used. If K=1 then simple a m-vector is output.}
\item{discrim}{A pxK matrix of penalized discriminant vectors. Note that
  these discriminant vectors were computed after first scaling each
  feature of the data  to have mean zero and within-class standard
  deviation one.}
\item{xproj}{A nxK matrix of the data projected onto the discriminant
  vectors}
\item{xteproj}{A mxK matrix of the data projected onto the discriminant
  vectors; output ONLY if xte was passed in.}
\item{crits}{The value of the objective at each iteration. If K>1 then
  this is a list with the value of the objective obtained in. }
}
\references{
D Witten and R Tibshirani (2011) Penalized classification using Fisher's
linear discrimint. To appear in JRSSB.
}
\author{
Daniela M. Witten
}
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
plot(out)
# For more examples, try "?PenalizedLDA.cv"
}
