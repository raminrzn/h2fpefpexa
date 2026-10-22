# Continuous H2FPEF model (Reddy YNV, et al. Circulation 2018;138:861-870),
# as given in the authors' calculator NIHMS970899-supplement-Online_Calculator.xlsx,
# sheet "Continuous variable HFpEF score", cell F2:
# log odds = -9.19174463966566 + 0.0451129471272832*age + 0.130730156015681*BMI
#            + 0.0858634402456586*E/e' + 0.051963758732548*PASP
#            + 1.69968057294513*AF
# probability = odds / (1 + odds).

.h2f_coef <- c(intercept = -9.19174463966566, age = 0.0451129471272832,
               bmi = 0.130730156015681, ee = 0.0858634402456586,
               pasp = 0.051963758732548, af = 1.69968057294513)

#' Probability of HFpEF (continuous H2FPEF model)
#'
#' For patients with unexplained dyspnoea and ejection fraction of 50% or more.
#' This is the continuous model from the authors' calculator, not the 0-9 point
#' H2FPEF score.
#'
#' @param age Age, years.
#' @param bmi Body mass index, kg/m^2.
#' @param ee Echocardiographic E/e' ratio (septal e').
#' @param pasp Echocardiographic pulmonary artery systolic pressure, mmHg.
#' @param af Atrial fibrillation (history or ECG): yes/no.
#' @return A data frame with `probability` (0-1) and `log_odds`.
#' @references Reddy YNV, Carter RE, Obokata M, Redfield MM, Borlaug BA.
#'   *Circulation.* 2018;138(9):861-870. \doi{10.1161/CIRCULATIONAHA.118.034646}
#' @examples
#' h2fpef(age = 51, bmi = 30, ee = 10, pasp = 45, af = "yes")
#' @export
h2fpef <- function(age, bmi, ee, pasp, af) {
  age  <- .h2f_num(age, "age", 18, 110)
  bmi  <- .h2f_num(bmi, "bmi", 10, 80)
  ee   <- .h2f_num(ee, "ee", 1, 60)
  pasp <- .h2f_num(pasp, "pasp", 5, 150)
  b <- .h2f_coef
  lo <- b[["intercept"]] + b[["age"]] * age + b[["bmi"]] * bmi +
    b[["ee"]] * ee + b[["pasp"]] * pasp + b[["af"]] * .h2f_yesno(af, "af")
  data.frame(probability = stats::plogis(lo), log_odds = lo)
}
