% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/round_spec.R
\name{round_spec}
\alias{round_spec}
\title{Make a rounding specification}
\usage{
round_spec(force_default = FALSE)
}
\arguments{
\item{force_default}{a logical value. If \code{TRUE}, then \code{round_spec()}
ignores global options and uses its factory default values.
If \code{FALSE}, \code{round_spec()} will access global options to determine
its settings.}
}
\value{
an object of class \code{rounding_specification}.
}
\description{
\code{round_spec()} creates a rounding specification object with default
settings. The settings of a rounding specification object can be
updated using functions in the \code{round_} (see \link{round_half_up},
\link{round_half_even}, \link{round_using_signif}, \link{round_using_decimal},
and \link{round_using_magnitude}) and \code{format_} (see \link{format_missing},
\link{format_big}, \link{format_small}, and \link{format_decimal}) families.
}
\details{
Rounding specifications are meant to be passed into the \link{table_glue}
and \link{table_value} functions. The specification can also be passed into
\code{table_} functions implicitly by saving a rounding specification into
the global options.

The \code{round_spec()} function intentionally uses no input arguments.
This is to encourage users to develop rounding specifications
using the \code{round_} and \code{format_} families in conjunction with
the pipe (\verb{\%>\%}) operator.
}
\examples{

rspec <- round_spec()

table_value(x = pi, rspec)

}
