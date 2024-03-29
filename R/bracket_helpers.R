


#' @title Bracket helpers
#'
#' @description If you have table values that take the form
#'   _point estimate (uncertainty estimate)_, you can use these
#'   functions to access specific parts of the table value.
#'
#' @param x a character vector where each value contains a point
#'   estimate and confidence limits.
#' @param string a character value of a string that will be inserted
#'   into the left or right side of the bracket.
#' @param bracket_left a character value specifying what symbol is
#'   used to bracket the left hand side of the confidence interval
#' @param separator a character value specifying what symbol is used
#'   to separate the lower and upper bounds of the interval.
#' @param bracket_right a character value specifying what symbol is
#'   used to bracket the right hand side of the confidence interval
#' @param drop_bracket a logical value (`TRUE` or `FALSE`). If `TRUE`,
#'   then the symbols on the left and right hand side of the interval
#'   will not be included in the returned value. If `FALSE`, these symbols
#'   will be included.
#'
#' @return a character value with length equal to the length of `x`.
#'
#' @export
#'
#' @examples
#'
#' tbl_value <- "12.1 (95% CI: 9.1, 15.1)"
#' bracket_drop(tbl_value)
#' bracket_point_estimate(tbl_value)
#' bracket_extract(tbl_value, drop_bracket = TRUE)
#' bracket_lower_bound(tbl_value)
#' bracket_upper_bound(tbl_value)
#'
bracket_drop <- function(x,
                         bracket_left = '(',
                         bracket_right = ')'){

  bracket_dissect(x = x,
                  return = 'point',
                  bracket_left = bracket_left,
                  bracket_right = bracket_right)

}

#' @rdname bracket_drop
#' @export
bracket_extract <- function(x,
                            bracket_left = '(',
                            bracket_right = ')',
                            drop_bracket = FALSE){

  bracket_dissect(x = x,
                  return = 'interval',
                  bracket_left = bracket_left,
                  bracket_right = bracket_right,
                  drop_bracket = drop_bracket)

}

#' @rdname bracket_drop
#' @export
bracket_insert_left <- function(x,
                                string,
                                bracket_left = '(',
                                bracket_right = ')'){

  bracket_insert(
    x = x,
    string = string,
    where = 'left',
    bracket_left = bracket_left,
    bracket_right = bracket_right
  )


}

#' @rdname bracket_drop
#' @export
bracket_insert_right <- function(x,
                                string,
                                bracket_left = '(',
                                bracket_right = ')'){

  bracket_insert(
    x = x,
    string = string,
    where = 'right',
    bracket_left = bracket_left,
    bracket_right = bracket_right
  )


}

bracket_insert <- function(x,
                           string,
                           where,
                           bracket_left,
                           bracket_right){

  check_call(
    match.call(),
    expected = list(
      'x' = list(type = 'character'),
      'where' = list(
        type = 'character',
        length = 1,
        expected_options = c(
          'left',
          'right'
        )
      ),
      'bracket_left' = list(type = 'character', length = 1),
      'bracket_right' = list(type = 'character', length = 1)
    )
  )

  if(where == 'left'){
    pattern = bracket_left
    replacement = paste0(bracket_left, string)
  }

  if(where == 'right'){
    pattern = bracket_right
    replacement = paste0(string, bracket_right)
  }

  stringi::stri_replace_all_fixed(str = x,
                                  pattern = pattern,
                                  replacement = replacement)

}


#' @rdname bracket_drop
#' @export
bracket_point_estimate <- function(x,
                                   bracket_left = '(',
                                   bracket_right = ')'){

  bracket_drop(x = x,
               bracket_left = bracket_left,
               bracket_right = bracket_right)

}

#' @rdname bracket_drop
#' @export
bracket_lower_bound <- function(x,
                                bracket_left = '(',
                                separator = ',',
                                bracket_right = ')'){

  bracket_dissect(x = x,
                  return = 'lower_bound',
                  bracket_left = bracket_left,
                  separator = separator,
                  bracket_right = bracket_right)

}

#' @rdname bracket_drop
#' @export
bracket_upper_bound <- function(x,
                                bracket_left = '(',
                                separator = ',',
                                bracket_right = ')'){

  bracket_dissect(x = x,
                  return = 'upper_bound',
                  bracket_left = bracket_left,
                  separator = separator,
                  bracket_right = bracket_right)

}

bracket_dissect <- function(x,
                            return,
                            bracket_left = '(',
                            separator = ',',
                            bracket_right = ')',
                            drop_bracket = FALSE){

  check_call(
    match.call(),
    expected = list(
      'x' = list(type = 'character'),
      'return' = list(
        type = 'character',
        length = 1,
        expected_options = c(
          'point',
          'interval',
          'lower_bound',
          'upper_bound'
        )
      ),
      'bracket_left' = list(type = 'character', length = 1),
      'separator' = list(type = 'character', length = 1),
      'bracket_right' = list(type = 'character', length = 1),
      'drop_bracket' = list(type = 'logical', length = 1)
    )
  )

  interval_regex <- paste0("\\", bracket_left,
                           ".+",
                           "\\", bracket_right)

  point <- trimws(
    stringi::stri_replace(x, replacement = '', regex = interval_regex)
  )

  if(return == 'point') return(
    unlist(
      stringi::stri_extract_all(
        str = point,
        regex = "[[:digit:]]+\\.*[[:digit:]]*"
      )
    )
  )

  interval <- stringi::stri_extract(x, regex = interval_regex)

  if(return == 'interval' && !drop_bracket) return(interval)

  interval_symbols <- paste0("\\", bracket_left, "|\\", bracket_right)

  interval_no_bracket <- stringi::stri_replace_all(interval,
                                                   replacement = '',
                                                   regex = interval_symbols)

  if(return == 'interval' && drop_bracket) return(interval_no_bracket)

  interval_values <- trimws(
    stringi::stri_split_fixed(str = interval_no_bracket,
                              pattern = separator,
                              simplify = TRUE)
  )

  interval_values_numbers_only <- stringi::stri_extract_all(
    str = interval_values,
    regex = "[[:digit:]]+\\.*[[:digit:]]*"
  )

  interval_bounds <- vapply(
    X = interval_values_numbers_only,
    FUN = function(x) x[length(x)], # in case 95% is in there...
    FUN.VALUE = vector(mode = 'character', length = 1)
  )

  if(return == 'lower_bound') return(interval_bounds[1])

  if(return == 'upper_bound') return(interval_bounds[2])

  # stop("unable to find the component you were looking for.",
  #      "\nPlease file an issue on Github with a reproducible example:",
  #      "\nhttps://github.com/bcjaeger/table.glue/issues",
  #      call. = FALSE)

}

