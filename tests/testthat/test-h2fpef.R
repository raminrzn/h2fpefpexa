# Reference values: the authors' calculator workbook
# (NIHMS970899-supplement-Online_Calculator.xlsx) recalculated in LibreOffice
# with these inputs. pct = cell H2 (probability, %), lo = F2 (log odds).
# Row 1 is the workbook's saved default, whose stored result is
# 87.2984032973488%. The other rows are generated test cases.
wb <- data.frame(
  bmi = c(30, 25, 35, 22, 40, 28, 32, 19, 45, 27, 30.5, 24),
  af = c(1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0),
  pasp = c(45, 30, 50, 25, 40, 35, 55, 20, 60, 30, 37.5, 28),
  age = c(51, 60, 72, 45, 65, 80, 58, 35, 70, 66, 61, 75),
  ee = c(10, 8, 15, 6, 12, 20, 9, 5, 25, 11, 9.6, 14),
  lo = c(1.92760446266259, -0.970893627694935, 4.21776312730497, -2.47132397680528, 2.07871479648481, 3.31341643245355, 1.23894897871962, -3.66032615003356, 6.81311078298928, 1.51851526078223, 0.320344872405757, -0.0136764527925126),
  pct = c(87.2984032973488, 27.470241909257, 98.5482307953875, 7.78930863368605, 88.8817091297176, 96.488621630096, 77.5381015818868, 2.50789865397414, 99.8901939071754, 82.0319741135294, 57.9408297896746, 49.658094009498)
)

test_that("matches the authors' calculator workbook", {
  for (i in seq_len(nrow(wb))) {
    r <- with(wb[i, ], h2fpef(age, bmi, ee, pasp, af))
    expect_equal(r$log_odds, wb$lo[i], tolerance = 1e-12, label = paste("lo", i))
    expect_equal(100 * r$probability, wb$pct[i], tolerance = 1e-12,
                 label = paste("pct", i))
  }
})

test_that("the workbook's stored default result is reproduced", {
  expect_equal(100 * model_run()$probability, 87.2984032973488, tolerance = 1e-12)
})

test_that("bad input fails clearly", {
  expect_error(h2fpef(51, 30, 10, 45, "maybe"), "af")
  expect_error(h2fpef(51, 30, 10, 300, "no"), "pasp")
  expect_error(model_run(list(age = 51)), "Missing")
})
