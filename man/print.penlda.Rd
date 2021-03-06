\name{print.penlda}
\alias{print.penlda}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Print PenalizedLDA output.
}
\description{
A nice way to display the results of PenalizedLDA.
}
\usage{
\method{print}{penlda}(x,...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
A "penlda" object; this is the output of the PenalizedLDA function.
}
\item{\dots}{...}
}
\references{
D Witten and R Tibshirani (2011) Penalized classification using Fisher's
linear discriminant. To appear in JRSSB.
}
\author{
Daniela M. Witten
}
\examples{
set.seed(1)
n <- 20
p <- 100
x <- matrix(rnorm(n*p), ncol=p)
xte <- matrix(rnorm(n*p), ncol=p)
y <- c(rep(1,5),rep(2,5),rep(3,10))
x[y==1,1:10] <- x[y==1,1:10] + 2
x[y==2,11:20] <- x[y==2,11:20] - 2
xte[y==1,1:10] <- xte[y==1,1:10] + 2
xte[y==2,11:20] <- xte[y==2,11:20] - 2
out <- PenalizedLDA(x,y,xte,lambda=.14,K=2)
print(out)
plot(out)
pred.out <- predict(out,xte=xte)
cat("Predictions obtained using PenalizedLDA function and using
predict.penlda function are the same.")
print(cor(pred.out$ypred,out$ypred))
}
