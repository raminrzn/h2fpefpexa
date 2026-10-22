.h2f_vars <- c("age", "bmi", "ee", "pasp", "af")
.h2f_alias <- c(e_e_prime = "ee", e_over_e = "ee", e_e = "ee",
                pa_systolic_pressure = "pasp", atrial_fibrillation = "af")

#' H2FPEF continuous model (ModelsCloud entry point)
#' @param model_input Named list with `age`, `bmi`, `ee`, `pasp`, `af`; see
#'   [h2fpef()].
#' @param ... The same fields as named arguments.
#' @return See [h2fpef()].
#' @export
model_run <- function(model_input = NULL, ...) {
  args <- .h2f_normalize(model_input, list(...), .h2f_vars, .h2f_alias)
  if (is.null(args) || length(args) == 0) args <- get_default_input()
  missing <- setdiff(.h2f_vars, names(args))
  if (length(missing) > 0) {
    stop("Missing required variable(s): ", paste(missing, collapse = ", "), ".",
         call. = FALSE)
  }
  do.call(h2fpef, args)
}

#' Example H2FPEF inputs
#'
#' Row 1 is the workbook's own default patient; row 2 is a generated example.
#' @param n Optional number of rows.
#' @param ... Ignored.
#' @export
get_sample_input <- function(n = NULL, ...) {
  df <- data.frame(age = c(51, 60), bmi = c(30, 25), ee = c(10, 8),
                   pasp = c(45, 30), af = c("yes", "no"),
                   stringsAsFactors = FALSE)
  if (!is.null(n)) df <- utils::head(df, n)
  df
}

#' Default H2FPEF input (the authors' workbook default)
#' @param ... Ignored.
#' @export
get_default_input <- function(...) {
  list(age = 51, bmi = 30, ee = 10, pasp = 45, af = "yes")
}
