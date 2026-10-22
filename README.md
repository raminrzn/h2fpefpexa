# h2fpefpexa

The **continuous H₂FPEF model** as a ModelsCloud service: the probability that
a patient with unexplained dyspnoea and ejection fraction ≥50% has heart
failure with preserved ejection fraction (HFpEF).

Reddy YNV, Carter RE, Obokata M, Redfield MM, Borlaug BA. A simple,
evidence-based approach to help guide diagnosis of heart failure with
preserved ejection fraction. *Circulation.* 2018;138(9):861–870.
[doi:10.1161/CIRCULATIONAHA.118.034646](https://doi.org/10.1161/CIRCULATIONAHA.118.034646)

## Which version

This uses the authors' continuous logistic model, as given in their online
calculator workbook (`NIHMS970899-supplement-Online_Calculator.xlsx`, sheet
"Continuous variable HFpEF score"). It is **not** the 0–9 point H₂FPEF score,
HFA-PEFF or HFpEF-ABA. The continuous model drops the "two or more
antihypertensives" item used in the point score.

log odds = −9.19174463966566 + 0.0451129471272832·age + 0.130730156015681·BMI
+ 0.0858634402456586·E/e′ + 0.051963758732548·PASP + 1.69968057294513·AF

## Inputs

| Field | Coding |
|---|---|
| `age` | years |
| `bmi` | kg/m² |
| `ee` | echocardiographic E/e′ ratio (septal e′, as in the paper) |
| `pasp` | echocardiographic pulmonary artery systolic pressure, mmHg |
| `af` | yes / no: atrial fibrillation (history or ECG) |

Returns `probability` (0–1) and `log_odds`.

## Validation

Matches the authors' workbook, recalculated in LibreOffice, for 12 patients to
12 significant digits. One is the workbook's own saved default, whose stored
result (87.2984032973488%) is reproduced exactly; the other 11 are generated
test cases. The coefficients could not also be checked against the paper's
Supplemental Table 3: that PDF sits behind a reCAPTCHA check.

## Source and reuse

The article is copyrighted by the American Heart Association. The paper and
workbook are freely readable on PubMed Central under the NIH public access
policy; that is not an open licence. This package reimplements the published
equation with citation. The workbook itself is not redistributed.

## Use

```r
remotes::install_git("https://github.com/raminrzn/h2fpefpexa", ref = "main")
h2fpefpexa::model_run(list(age = 51, bmi = 30, ee = 10, pasp = 45, af = "yes"))
```

For research use. Not a medical device.

## License

GPL-3 for this code.
