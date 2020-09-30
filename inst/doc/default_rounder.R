## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(table.glue)

## -----------------------------------------------------------------------------

rspec <- round_spec() 
rspec <- round_using_decimal(rspec, digits = 5)


## -----------------------------------------------------------------------------

names(rspec) <- paste('table.glue', names(rspec), sep = '.')


## -----------------------------------------------------------------------------

options(rspec)

table_value(pi)


## -----------------------------------------------------------------------------

back_to_normal <- round_spec(force_default = TRUE)

names(back_to_normal) <- paste('table.glue', names(back_to_normal), sep = '.')

options(back_to_normal)

table_value(pi)


