% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/round_spec.R
\name{round_half_up}
\alias{round_half_up}
\alias{round_half_even}
\title{Set rules for rounding ties}
\usage{
round_half_up(rspec)

round_half_even(rspec)
}
\arguments{
\item{rspec}{a \code{rounding_specification} object (see \link{round_spec}).}
}
\value{
an object of class \code{rounding_specification}.
}
\description{
Rounding a number x to the nearest integer requires some tie-breaking
rule for those cases when x is exactly half-way between two integers,
that is, when the fraction part of x is exactly 0.5. The
\code{round_half_up()} function implements a tie-breaking rule that
consistently rounds half units upward. Although this creates a slight
bias toward larger rounded outputs, it is widely used in many disciplines.
The \code{round_half_even()} function breaks ties by rounding to the nearest
even unit.
}
\examples{

# note base R behavior rounds to even:
round(0.5) # --> 0
round(1.5) # --> 2
round(2.5) # --> 2

# make rspec that rounds up
rspec <- round_half_up(round_spec())
rspec <- round_using_decimal(rspec, digits = 0)

# check
table_value(0.5, rspec) # --> 1
table_value(1.5, rspec) # --> 2
table_value(2.5, rspec) # --> 3

# make rspec that rounds even
rspec <- round_half_even(round_spec())
rspec <- round_using_decimal(rspec, digits = 0)

# check
table_value(0.5, rspec) # --> 0
table_value(1.5, rspec) # --> 2
table_value(2.5, rspec) # --> 2
}
\seealso{
Other rounding helpers: 
\code{\link{round_using_magnitude}()}
}
\concept{rounding helpers}
