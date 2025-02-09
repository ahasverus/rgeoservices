#' Check is a required argument is provided and not empty
#' 
#' @note **For internal purposes only**
#' 
#' @noRd

check_required_arg <- function(x) {

  if (missing(x)) {
    stop("The argument '", deparse(substitute(x)), "' is required", 
         call. = FALSE)
  }
  
  if (is.null(x)) {
    stop("The argument '", deparse(substitute(x)), "' is required", 
         call. = FALSE)
  }

  if (length(x) == 0) {
    stop("The argument '", deparse(substitute(x)), "' is required", 
         call. = FALSE)
  }

  if (all(is.na(x))) {
    stop("The argument '", deparse(substitute(x)), "' is required", 
         call. = FALSE)
  }

  if (all(x == "")) {
    stop("The argument '", deparse(substitute(x)), "' is required", 
         call. = FALSE)
  }
    
  invisible(NULL)
}


#' Check is an argument is a numeric
#' 
#' @note **For internal purposes only**
#' 
#' @noRd

check_numeric_arg <- function(x) {

  check_required_arg(x)
  
  if (!is.numeric(x)) {
    stop("The argument '", deparse(substitute(x)), "' must be a numeric", 
         call. = FALSE)
  }

  invisible(NULL)
}


#' Check is an argument is a character
#' 
#' @note **For internal purposes only**
#' 
#' @noRd

check_character_arg <- function(x) {

  check_required_arg(x)

  if (!is.character(x)) {
    stop("The argument '", deparse(substitute(x)), "' must be a character", 
         call. = FALSE)
  }

  invisible(NULL)
}


#' Check the length of an argument
#' 
#' @note **For internal purposes only**
#' 
#' @noRd

check_arg_length <- function(x, len = 1) {

  check_required_arg(x)

  if (length(x) != len) {
    stop("The argument '", deparse(substitute(x)), "' must be of length ", len, 
         call. = FALSE)
  }

  invisible(NULL)
}


#' Check if an argument contains NA
#' 
#' @note **For internal purposes only**
#' 
#' @noRd

check_if_na <- function(x) {

  check_required_arg(x)

  if (any(is.na(x))) {
    stop("The argument '", deparse(substitute(x)), 
         "' cannot contain missing value", 
         call. = FALSE)
  }

  invisible(NULL)
}


#' Check if a numeric is strictly positive
#' 
#' @note **For internal purposes only**
#' 
#' @noRd

check_positive_arg <- function(x) {

  check_required_arg(x)
  check_numeric_arg(x)
  check_if_na(x)

  if (any(x <= 0)) {
    stop("The argument '", deparse(substitute(x)), "' must be strictly positive", 
         call. = FALSE)
  }

  invisible(NULL)
}


#' Check if a argument matches a vector of candidate values
#' 
#' @note **For internal purposes only**
#' 
#' @noRd

match_arg <- function(x, values) {

  check_required_arg(x)
  check_arg_length(x, 1L)

  check_required_arg(values)
  check_if_na(values)

  if (!(tolower(x) %in% tolower(values))) {
    stop(
      sprintf("The argument '%s' should be one of %s", 
              deparse(substitute(x)), 
              paste(dQuote(values), collapse = ", ")), 
      call. = FALSE)
  }
  
  invisible(NULL)
}

